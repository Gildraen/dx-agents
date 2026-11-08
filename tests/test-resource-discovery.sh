#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

node <<'EOF'
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
for (const file of ['AGENTS.md', 'README.md', 'Taskfile.yml']) {
  assert.ok(fs.statSync(file).isFile(), `missing required file: ${file}`);
}
for (const directory of ['agents', 'instructions', 'skills']) {
  assert.ok(fs.statSync(directory).isDirectory());
}
for (const directory of ['agents', 'instructions']) {
  const files = fs.readdirSync(directory);
  assert.ok(files.length > 0);
  for (const file of files) {
    assert.match(file, directory === 'agents' ? /^[a-z][a-z0-9-]*\.agent\.md$/ : /^[a-z][a-z0-9-]*\.md$/);
    const contents = fs.readFileSync(`${directory}/${file}`, 'utf8');
    assert.doesNotMatch(contents, /^applyTo:/m);
    const metadata = contents.match(/^---\n([\s\S]*?)\n---\n/)?.[1];
    assert.ok(metadata, `missing frontmatter: ${directory}/${file}`);
    assert.deepEqual(metadata.split('\n').map(line => line.split(':')[0]).sort(), ['description', 'name']);
  }
}
const roleNames = new Set();
for (const file of fs.readdirSync('agents')) {
  const contents = fs.readFileSync(`agents/${file}`, 'utf8');
  const roleName = contents.match(/^name:\s*(.+)$/m)?.[1]?.trim();
  assert.ok(roleName, `missing role name: ${file}`);
  assert.ok(!roleNames.has(roleName), `duplicate role name: ${roleName}`);
  roleNames.add(roleName);
  for (const match of contents.matchAll(/`([a-z][a-z0-9]*(?:-[a-z0-9]+)+)`/g)) {
    const skillPath = path.join('skills', match[1], 'SKILL.md');
    assert.ok(fs.existsSync(skillPath), `missing referenced skill: ${match[1]}`);
  }
}
const bootstrap = fs.readFileSync('AGENTS.md', 'utf8');
assert.ok(bootstrap.includes('(instructions/base.md)'));
assert.ok(bootstrap.includes('(instructions/git.md)'));
assert.ok(bootstrap.includes('`agents/*.agent.md`'));
assert.ok(bootstrap.includes('skills/*/SKILL.md'));
assert.ok(bootstrap.includes('`.agents/agents/*.agent.md`'));
assert.ok(bootstrap.includes('`.agents/skills/*/SKILL.md`'));
assert.ok(bootstrap.includes('the sole canonical locations for'));
assert.ok(bootstrap.includes('Do not keep duplicate copies in client-specific'));
assert.ok(bootstrap.includes('If the client cannot run a subagent'));
assert.match(bootstrap, /At the start of every substantial task/i);
assert.match(bootstrap, /configured reusable agent/i);
assert.match(bootstrap, /temporary specialist/i);
assert.ok(bootstrap.includes('## Instruction hierarchy'));
assert.ok(bootstrap.includes('$DX_AGENTS_HOME/AGENTS.md'));
assert.doesNotMatch(bootstrap, /\bDX_HOME\b|\/opt\/dx\b|Feature sets/);
const inheritedReminder = /\bAGENTS\.md\b|\b(?:base|git)(?:\.instructions)?\.md\b|instructions?\s+partag[eé]es?/i;
for (const directory of ['agents', 'skills']) {
  for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
    if (directory === 'skills' && !entry.isDirectory()) continue;
    const resource = entry.isDirectory() ? `${directory}/${entry.name}/SKILL.md` : `${directory}/${entry.name}`;
    assert.doesNotMatch(fs.readFileSync(resource, 'utf8'), inheritedReminder, resource);
  }
}
function validateLinks(directory) {
  for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
    if (entry.name === '.git') continue;
    const resource = path.join(directory, entry.name);
    if (entry.isDirectory()) {
      validateLinks(resource);
    } else if (entry.name.endsWith('.md')) {
      const contents = fs.readFileSync(resource, 'utf8');
      assert.doesNotMatch(contents, /\bDX_HOME\b|Gildraen\/dx`|\.devcontainer\/src\/dx\/runtime/, resource);
      for (const match of contents.matchAll(/\[[^\]]+\]\(([^)]+)\)/g)) {
        const target = match[1];
        if (/^[a-z][a-z0-9+.-]*:|^#/i.test(target)) continue;
        const resolved = path.resolve(path.dirname(resource), target.split('#')[0]);
        assert.ok(fs.existsSync(resolved), `missing relative resource: ${resource} -> ${target}`);
      }
    }
  }
}
validateLinks('.');
console.log(`Resource discovery passed: ${roleNames.size} roles, shared bootstrap, metadata and relative links`);
EOF
