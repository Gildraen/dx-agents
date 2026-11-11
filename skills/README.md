# Shared skills

This directory is the canonical home for reusable Gildraen skills that are
versioned with `dx-agents` and consumed from a local checkout at a pinned Git
revision under `$DX_AGENTS_HOME/skills/`.

Keep only cross-repository workflows here. Project-specific skills have one
canonical source in the consumer repository under `.agents/skills/`; do not
duplicate them in client-specific directories. Shared skills remain under
`$DX_AGENTS_HOME/skills/` and are loaded through the shared bootstrap. The
producer does not copy or link them into client-specific directories.

## Selection and composition

Follow the [shared guide](../AGENTS.md#select-a-role-or-workflow) to select
resources by their metadata; directory contents are authoritative, not a
central catalogue. Each skill links to its owning role, which links back to
its workflows. Even when a skill is requested directly, read its owning role
to establish the workflow context.

The role selects and composes only the skills needed for the task, deciding
their order and how to integrate their results; do not load every skill.
Shared execution rules are inherited from the shared guide and instructions,
domain rules from the role. A skill contains one bounded procedure, its
specific checks, and its result, without repeating inherited rules.

For bounded subagent assignments and the fallback when the client cannot run
subagents, follow the [delegation policy](../AGENTS.md#delegate-focused-work).
These are explicit loading instructions, not a native client discovery
mechanism.
