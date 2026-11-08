#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

node <<'EOF'
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path').posix;
const root = '.';
const resources = new Map();
for (const file of fs.readdirSync(`${root}/agents`)) {
  resources.set(`agents/${file}`, fs.readFileSync(`${root}/agents/${file}`, 'utf8'));
}
for (const entry of fs.readdirSync(`${root}/skills`, { withFileTypes: true })) {
  if (!entry.isDirectory()) continue;
  const file = `skills/${entry.name}/SKILL.md`;
  resources.set(file, fs.readFileSync(`${root}/${file}`, 'utf8'));
}

function validateHierarchy(files) {
  const roleNames = new Set();
  const owners = new Map();
  const bootstrap = /\bAGENTS\.md\b|\b(?:base|git)(?:\.instructions)?\.md\b|instructions?\s+partag[eé]es?/i;
  for (const [file, contents] of files) {
    const metadata = contents.match(/^---\n([\s\S]*?)\n---\n/);
    assert.ok(metadata, `missing frontmatter: ${file}`);
    assert.match(metadata[1], /^description: .+/m, `missing description: ${file}`);
    const name = metadata[1].match(/^name: ([a-z][a-z0-9-]*)$/m)?.[1];
    assert.ok(name, `missing name: ${file}`);
    assert.doesNotMatch(contents, bootstrap, `repeated bootstrap: ${file}`);
    for (const match of contents.matchAll(/\[[^\]]+\]\(([^)]+)\)/g)) {
      const target = match[1];
      if (/^[a-z][a-z0-9+.-]*:|^#/i.test(target)) continue;
      const resolved = path.normalize(path.join(path.dirname(file), target.split('#')[0]));
      assert.ok(files.has(resolved) || fs.existsSync(path.join(root, resolved)),
        `missing relative resource: ${file} -> ${target}`);
    }
    if (file.startsWith('agents/')) {
      assert.ok(!roleNames.has(name), `duplicate role name: ${name}`);
      roleNames.add(name);
      continue;
    }
    assert.equal(name, file.split('/')[1], `skill name mismatch: ${file}`);
    const declarations = [...contents.matchAll(/^Role propri[eé]taire : \[[^\]]+\]\(([^)]+)\)\.$/gm)];
    assert.equal(declarations.length, 1, `expected one owner: ${file}`);
    const owner = path.normalize(path.join(path.dirname(file), declarations[0][1]));
    assert.ok(owner.startsWith('agents/') && files.has(owner), `invalid owner: ${file}`);
    const backlinks = [...files.get(owner).matchAll(/\[[^\]]+\]\(([^)]+)\)/g)];
    assert.ok(backlinks.some(match => path.normalize(path.join(path.dirname(owner), match[1])) === file),
      `owner missing backlink: ${file}`);
    owners.set(file, owner);
  }
  assert.ok(roleNames.size > 0 && owners.size > 0, 'empty role or skill inventory');
  return owners;
}

const owners = validateHierarchy(resources);
const [skill, owner] = owners.entries().next().value;
const ownerLine = /^Role propri[eé]taire : .+\n/m;
const skillContents = resources.get(skill);
validateHierarchy(new Map(resources).set(skill, `${skillContents}\n[skills](../../skills/README.md)\n`));
assert.throws(() => validateHierarchy(new Map(resources).set(skill, skillContents.replace(ownerLine, ''))),
  /expected one owner/);
assert.throws(() => validateHierarchy(new Map(resources).set(skill, skillContents + skillContents.match(ownerLine)[0])),
  /expected one owner/);
const backlink = path.relative(path.dirname(owner), skill);
assert.throws(() => validateHierarchy(new Map(resources).set(owner, resources.get(owner).split(`](${backlink})`).join(']'))),
  /owner missing backlink/);
assert.throws(() => validateHierarchy(new Map(resources).set(skill, `${skillContents}\n[missing](missing.md)\n`)),
  /missing relative resource/);
assert.throws(() => validateHierarchy(new Map(resources).set(skill, `${skillContents}\nRead AGENTS.md again.\n`)),
  /repeated bootstrap/);
console.log(`Runtime hierarchy passed: ${new Set(owners.values()).size} owners, ${owners.size} skills, linked resource accepted, 5 rejected regressions`);
EOF
