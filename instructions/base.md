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
