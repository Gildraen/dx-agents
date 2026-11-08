# dx-agents

`Gildraen/dx-agents` is the canonical producer of shared, client-neutral
instructions, agents and skills for Gildraen repositories. Resources are
consumed from a local Git checkout at a pinned revision. The repository does
not install tools or require the DX Dev Container Feature.

## Resources

- [AGENTS.md](AGENTS.md) is the shared bootstrap. It loads the baseline and Git
  instructions and defines hierarchy, resource selection and delegation.
- [instructions/base.md](instructions/base.md) and
  [instructions/git.md](instructions/git.md) contain the cross-role rules.
- `agents/*.agent.md` contains roles with client-neutral `name` and
  `description` metadata.
- `skills/*/SKILL.md` contains bounded workflows. Each skill links to its
  owning role, which links back to the skill. See [skills/README.md](skills/README.md).

Project-specific resources remain in the consumer's `.agents/agents/` and
`.agents/skills/`. They are additive to the shared resources, not copies of
them. The `dx-*` role names and relative links are stable within the checkout.

## Git consumption

From the consumer repository root, select a full commit SHA published in
`Gildraen/dx-agents` and record it in the consumer's configuration:

```sh
revision='<full-commit-sha>'
git clone --no-checkout https://github.com/Gildraen/dx-agents.git .devcontainer/dx-agents
git -C .devcontainer/dx-agents checkout --detach "$revision"
export DX_AGENTS_HOME="$(pwd)/.devcontainer/dx-agents"
git -C "$DX_AGENTS_HOME" rev-parse HEAD
```

`DX_AGENTS_HOME` is the absolute path to the checkout root containing
`AGENTS.md`, `instructions/`, `agents/` and `skills/`. Make it available in the
agent process environment; an interactive shell export only affects that
shell and its child processes. In a Dev Container, the consumer can set
`remoteEnv.DX_AGENTS_HOME` to `${containerWorkspaceFolder}/.devcontainer/dx-agents`.
The checkout must already be present when the agent starts.

The consumer's root `AGENTS.md` explicitly loads the shared bootstrap before
selecting a role or workflow. For example:

```md
Before any task, read the shared bootstrap at $DX_AGENTS_HOME/AGENTS.md.
Report a missing environment variable or resource instead of continuing
without the shared rules. Apply this project's constraints alongside them.
```

If the client does not read the consumer's `AGENTS.md`, provide it in the
initial context. Load resources from local files; this contract does not
assume direct URL loading, environment substitution in Markdown links, or
automatic execution of instructions by an editor.

## VS Code discovery

For VS Code Local sessions supporting custom search locations, the consumer
can configure its native location settings with literal workspace-relative
paths to the checkout:

```json
{
  "chat.agentFilesLocations": {
    ".agents/agents": true,
    ".devcontainer/dx-agents/agents": true
  },
  "chat.agentSkillsLocations": {
    ".agents/skills": true,
    ".devcontainer/dx-agents/skills": true
  }
}
```

Keep the complete location objects when overriding existing settings.
`DX_AGENTS_HOME` does not configure these settings, and this example does not
depend on environment variable expansion by VS Code. Agents use `.agent.md`
for custom search locations; skills retain their directory and `SKILL.md`.
The plain Markdown files in `instructions/` are explicitly loaded by the
bootstrap, not automatically discovered as `*.instructions.md` files.

These location settings are deprecated in current VS Code documentation and
depend on the selected harness and version. They are not inherited by
independent clients. Use explicit local loading where custom locations are
unsupported. Picker visibility and actual role selection need verification
in the intended client; filesystem tests alone do not establish them.

See the VS Code documentation for
[custom agents](https://code.visualstudio.com/docs/agent-customization/custom-agents)
and [Agent Skills](https://code.visualstudio.com/docs/agent-customization/agent-skills).

## Checks

Repository checks require Bash, Node.js and Go Task v3 on `PATH`, with no npm
dependencies, container runtime or network access:

```sh
task validate
task test
```

[Taskfile.yml](Taskfile.yml) checks shell and task syntax, then runs the
resource-discovery and hierarchy tests in [tests/test-resource-discovery.sh](tests/test-resource-discovery.sh)
and [tests/test-runtime-hierarchy.sh](tests/test-runtime-hierarchy.sh).
The tests cover metadata, naming, the shared bootstrap, local links, skill
ownership and backlinks, including rejected hierarchy regressions. They do
not invoke an AI client or install resources into a consumer.
