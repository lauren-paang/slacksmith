# Document Scope Guide

Use this file when the user wants a Slack update package and there are many possible source documents.

## Common Scope Choices

### 1. Project Docs Folder

Use this when the user says:

- "update the docs"
- "use the planning docs"
- "use the future plans"

Typical targets:

- `docs/`
- `docs/future-plans/`
- `docs/diagrams/`

### 2. Repo Root Markdown Files

Use this when the user says:

- "include the root docs"
- "include CLAUDE docs"
- "include AGENTS and planning notes"

Typical targets:

- `CLAUDE.md`
- `AGENTS.md`
- root-level `*.md`

### 3. Personal Memory Or Handoff Files

Only use this when the user explicitly asks for:

- agent memory
- Claude memory
- Codex memory
- handoff notes
- work log context

Typical targets:

- `~/Desktop/work_projects/work-log/...`
- tool-specific memory markdown files
- explicitly named handoff notes

## Safe Default

If the user does not care about the exact source set, use:

- project `docs/`
- repo root markdown files that clearly relate to the update

Do not include personal memory or handoff files unless the user asked for them.
