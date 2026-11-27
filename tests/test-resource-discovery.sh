#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

node <<'EOF'
const assert = require('node:assert/strict');
const { execFileSync } = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');
for (const file of [
  '.gitignore',
  '.release-please-manifest.json',
  'AGENTS.md',
  'README.md',
  'release-please-config.json',
  'Taskfile.yml',
  'version.txt',
]) {
  assert.ok(fs.statSync(file).isFile(), `missing required file: ${file}`);
}
const gitignore = fs.readFileSync('.gitignore', 'utf8').split(/\r?\n/);
assert.ok(gitignore.includes('/tmp/worktree/'), 'worktree directory must be ignored');
const ignoreOutput = execFileSync('git', ['check-ignore', '--no-index', '-v', 'tmp/worktree/__ignore_probe__'], { encoding: 'utf8' });
assert.ok(ignoreOutput.startsWith('.gitignore:'), 'Git must ignore worktree paths through the root .gitignore');
const gitInstructions = fs.readFileSync('instructions/git.md', 'utf8');
assert.match(gitInstructions, /<main-worktree>\/tmp\/worktree\/<task-slug>/);
const contributionAgent = fs.readFileSync('agents/contribution.agent.md', 'utf8');
assert.match(contributionAgent, /Pour les opérations de worktree, utiliser \[dx-worktree\]\(worktree\.agent\.md\)\./);
const releaseConfig = JSON.parse(fs.readFileSync('release-please-config.json', 'utf8'));
const releaseManifest = JSON.parse(fs.readFileSync('.release-please-manifest.json', 'utf8'));
const releasePackage = releaseConfig.packages['.'];
assert.match(releaseConfig['bootstrap-sha'], /^[0-9a-f]{40}$/);
assert.equal(releaseConfig['include-component-in-tag'], false);
assert.equal(releaseConfig['include-v-in-tag'], false);
assert.equal(releasePackage['release-type'], 'simple');
assert.equal(releasePackage['package-name'], 'dx-agents');
assert.equal(releasePackage['version-file'], 'version.txt');
assert.match(releaseManifest['.'], /^\d+\.\d+\.\d+$/);
assert.equal(fs.readFileSync('version.txt', 'utf8').trim(), releaseManifest['.']);
assert.equal(releaseConfig['bootstrap-sha'], '129d5862c29ccdef662d93b41a683f1b1d0925a6');
const validationWorkflow = fs.readFileSync('.github/workflows/validate.yml', 'utf8');
const releaseJob = validationWorkflow.split('\n  release:\n')[1] ?? '';
assert.match(releaseJob, /needs: validate/);
assert.match(releaseJob, /github\.event_name == 'push' && github\.ref == 'refs\/heads\/main'/);
assert.match(releaseJob, /uses: Gildraen\/ci-workflows\/\.github\/workflows\/reusable-release-please\.yml@[0-9a-f]{40} # \d+\.\d+\.\d+/);
assert.match(releaseJob, /expected-sha: \$\{\{ github\.sha \}\}/);
assert.match(releaseJob, /app-client-id: \$\{\{ vars\.RELEASE_PLEASE_APP_CLIENT_ID \}\}/);
assert.match(releaseJob, /app-private-key: \$\{\{ secrets\.RELEASE_PLEASE_APP_PRIVATE_KEY \}\}/);
assert.doesNotMatch(releaseJob, /googleapis\/release-please-action|RELEASE_PLEASE_TOKEN|secrets\.GITHUB_TOKEN/);
for (const directory of ['agents', 'instructions', 'skills']) {
  assert.ok(fs.statSync(directory).isDirectory());
}
const plugin = JSON.parse(fs.readFileSync('plugin.json', 'utf8'));
assert.deepEqual(Object.keys(plugin).sort(), ['$schema', 'description', 'keywords', 'name', 'repository', 'version'].sort());
assert.equal(plugin.$schema, 'https://agent-plugins.org/schemas/1.0.0/plugin.schema.json');
assert.equal(plugin.name, 'dx-agents');
assert.match(plugin.name, /^[a-z0-9]+(?:-[a-z0-9]+)*$/);
assert.equal(typeof plugin.version, 'string');
const semverPattern = /^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[A-Za-z-][0-9A-Za-z-]*)(?:\.(?:0|[1-9]\d*|\d*[A-Za-z-][0-9A-Za-z-]*))*))?(?:\+([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?$/;
assert.match(plugin.version, semverPattern);
assert.match('1.2.3-rc.1+build.7', semverPattern);
assert.doesNotMatch('01.2.3', semverPattern);
assert.equal(plugin.repository, 'https://github.com/Gildraen/dx-agents');
assert.equal(typeof plugin.description, 'string');
assert.ok(Array.isArray(plugin.keywords) && plugin.keywords.every(keyword => typeof keyword === 'string'));
assert.ok(!Object.prototype.hasOwnProperty.call(plugin, 'extensions'), 'portable plugin must not require client-specific extensions');
for (const directory of ['agents', 'instructions']) {
  const files = fs.readdirSync(directory);
  assert.ok(files.length > 0);
  for (const file of files) {
    assert.match(file, directory === 'agents' ? /^[a-z][a-z0-9-]*\.agent\.md$/ : /^[a-z][a-z0-9-]*\.md$/);
    const contents = fs.readFileSync(`${directory}/${file}`, 'utf8');
    assert.doesNotMatch(contents, /^applyTo:/m);
    const metadata = contents.match(/^---\n([\s\S]*?)\n---\n/)?.[1];
    assert.ok(metadata, `missing frontmatter: ${directory}/${file}`);
    if (directory === 'agents') {
      const profileName = metadata.match(/^name:\s*([a-z0-9]+(?:-[a-z0-9]+)*)\s*$/m)?.[1];
      assert.ok(profileName && profileName.length <= 64, `invalid profile name: ${file}`);
      assert.ok(contents.replace(/^---\n[\s\S]*?\n---\n/, '').trim(), `missing profile instructions: ${file}`);
    }
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
