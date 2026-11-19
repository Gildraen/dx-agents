---
name: dx-base
description: Baseline agent instructions shared across Gildraen repositories.
---

# DX baseline

## Provenance

These instructions are shared resources, versioned in `Gildraen/dx-agents`
(`instructions/`). They are consumed by other repositories through a local
checkout at a pinned Git revision (`DX_AGENTS_HOME`).
The shared `AGENTS.md` explicitly loads these rules for every task.
Do not fork or copy this content into a consumer repository — extend it with a
short, project-specific `AGENTS.md` instead.

## Shared repository conventions

This baseline is the canonical source for conventions shared by repositories
whose selected `dx-agents` revision contains these rules and that load the DX
runtime. Their root `AGENTS.md` loads `$DX_AGENTS_HOME/AGENTS.md`, which loads
this file. Repositories that do not load the DX runtime do not inherit these
conventions automatically; they must adopt them explicitly.

Apply shared conventions unless a repository-specific tool contract or other
concrete constraint requires an exception. Record the reason in the
repository's own `AGENTS.md` or next to the affected configuration; do not
copy the shared rule into the repository.

### YAML filenames

Use `.yaml` for new YAML files unless a tool requires a specific filename or
extension. Migrate existing `.yml` files in repository-scoped changes rather
than as a fleet-wide rename. Each change must rename the file, update
path-based references and patterns, and validate the tools that consume those
paths. Keep filenames required by a tool unchanged.

GitHub Actions discovers workflow files with either `.yml` or `.yaml` under
`.github/workflows`. Go Task 3.53.1 discovers both `Taskfile.yml` and
`Taskfile.yaml`. During a migration, update Task includes and remote paths,
workflow references, configuration patterns, documentation, scripts, and
tests as applicable. Run the repository's validation and test contracts and
verify native tool discovery; YAML parsing alone does not verify a renamed
path.

## Working agreements

- Prefer small, reviewable changes over large rewrites.
- State assumptions explicitly when requirements are ambiguous instead of
  guessing silently.
- Respect the contracts a repository exposes (for example `task validate`,
  `task test`, `task lint`) rather than assuming a specific implementation.
- Treat a command as available from the DX tool baseline only when the exact
  released DX Feature used by the repository guarantees it. Add project-
  specific tools in the consumer configuration, not by copying DX logic.
- Keep secrets, tokens, and authentication state out of versioned files.

The shared Git workflow instructions apply alongside this baseline. Use the
on-demand `dx-review` agent for focused code reviews and corrections.
