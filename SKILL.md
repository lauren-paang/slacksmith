---
name: slacksmith
description: Forge a Slack message in the user's natural tone — short personal draft by default, or a full update package (Slack summary + Mermaid diagram + PNG export + doc updates + worklog refresh + optional git push) when the user asks for the wider deliverable. Handles audience tuning (boss vs technical), multiple draft versions, @mention resolution via the Slack plugin, and reusable update bundles from recent work.
---

# Slacksmith

## Purpose

One skill, two modes, same voice rules.

This is a Slack writing skill — it should always feel like a real teammate sending a message, never a release bot or AI assistant.

## Two Modes

Decide which mode to run based on what the user asked for. If unclear, default to **Draft Mode** and offer to upgrade.

### Draft Mode (default)
A short Slack message written as the user — for project updates, check-ins, follow-ups, or status notes.

Run this when the user says things like:
- `draft a slack message`
- `write this for slack`
- `help me message him`
- `give me 3 versions`
- `boss-facing version`

### Package Mode (on request)
A full update bundle: Slack summary + Mermaid diagram (+ optional PNG) + selected document updates + optional worklog refresh + optional git push.

Run this when the user says things like:
- `slack update package`
- `summary plus diagram`
- `update the docs and post to slack`
- `refresh the work log too`
- `push the changes after`

---

## Shared Rules (Both Modes)

### Use The Slack Plugin First (When Available)

When the Slack plugin is installed:
- read recent Slack context to learn the user's real tone
- resolve @mentions through the plugin
- use plugin tools again if the user wants the final message posted or saved as draft

If the plugin is unavailable, say so briefly and continue from session/codebase context alone.

### Tone Rules

Write like the user is speaking as a person.

Avoid:
- release-note voice
- robotic bullet dumps unless explicitly asked
- fake certainty
- exaggerated language
- "AI assistant" framing
- mention of Codex or Claude Code unless the user wants that

Prefer:
- one natural opener
- 2 to 5 short numbered points for product/status updates
- one clear next step or ask
- numbered points (`1.` `2.`) over markdown dashes (`-`) — dashes paste poorly into Slack

### Content First, Tone Second

If both session context and Slack context are available:
1. use the **session** to understand content
2. use **Slack** to understand tone

Don't let Slack tone override the actual content goals.

### Mentions

- ask for the person/group name if missing
- if the Slack plugin can resolve them, use real Slack mention syntax
- if not, leave a placeholder like `@Name` and tell the user it was not resolved
- never invent a Slack user id

---

## Draft Mode Workflow

### Phase 1: Context Read

Read in this order before asking the user to repeat anything:
1. current session history
2. relevant project / codebase context (when the message is about a feature or bugfix)
3. recent Slack tone via the Slack plugin
4. recent GitHub/repo updates *only* if the user wants a broader status summary — and ask the time window first

Don't silently summarize an arbitrary chunk of git history.

### Phase 2: Lock Topic And Scope

Before drafting, lock these down if not clear:
1. **topic** of the message
2. **scope** of the message

Ask in one short plain-language prompt. Examples:
- `What should this Slack message focus on, and how broad do you want it?`
- `Library feature only, or the wider task/report flow too?`

Good scope options:
- `library feature only`
- `one specific bug / fix only`
- `product-facing summary of all recent changes`
- `engineering summary of all recent changes`
- `full summary with product + engineering`
- `this session only`
- `include recent GitHub updates too`

### Phase 3: Lock Audience

Default audience buckets:
- `non-technical colleagues / boss`
- `technical teammates`

Expand if useful:
- `boss / leadership`
- `non-technical team`
- `technical team`
- `client-facing internal update`

Also worth locking when relevant:
- time range: `today only` / `this week` / `after a specific date` / `all activity so far`
- confidence level: `only what we can prove` / `include likely interpretation` / `include risks / unknowns`
- version style: `very short` / `balanced` / `warmer / softer`
- delivery mode: `draft only` / `ready to send`

### Defaults When User Says "You Choose"
- scope: `one short update`
- audience: `non-technical colleagues / boss`
- version style: `balanced`
- delivery mode: `draft only`
- confidence level: `only what we can prove`

### Minimal-Prompt Mode

If the user gives a very short request (`draft slack update`, `write this for slack`):
- don't stop to ask broad questions
- use the current conversation as the main source of truth
- make reasonable assumptions and state them briefly after the draft
- only ask follow-up if topic, scope, or audience is genuinely unclear

### Audience-Specific Style

**For non-technical / boss audiences:**
- avoid backend/internal implementation detail unless it changes the meaning
- translate product usage into simple language (`they uploaded audio`, `they generated reports`)
- prefer plain words like `we can confirm` / `we can't tell yet`
- skip IDs, table names, endpoint names, storage-layer details
- center on: what the feature does, how it should feel, what to test, edge cases to notice
- write feature behavior as clear statements, not open questions
- when a current boundary matters, fold it into the relevant point — don't make a separate `limitation` section

**For technical teammates:**
- what changed in behavior
- what bug was fixed
- what architecture / guard / flag changed
- what risks remain
- what still needs monitoring or follow-up
- include feature flags, state-split decisions, race-condition handling, known sharp edges when useful

### Output Format (Draft Mode)

By default, return:
1. `Version 1` — safest / most natural
2. `Version 2` — slightly warmer or shorter
3. `Version 3` — more direct or polished, if useful
4. `Suggested scope` — one line saying what was included

If the user wants different audiences, default output becomes:
1. `Boss / Non-Technical Version`
2. `Technical Team Version`
3. `Suggested scope`

Cap at 3 versions unless the user explicitly wants more.

### Good Message Shapes

**Short update**
```text
Quick update on this:

1. ...
2. ...

Next step is ...
```

**Soft follow-up**
```text
Just a quick follow-up on this.

...
```

**Asking for input**
```text
Quick check on this before I move ahead:

...

Would you prefer A or B?
```

**Boss / Non-Technical Feature Update**
```text
Quick update on [feature]:

1. what users can do now
2. what feels better or clearer now
3. what changed in the workflow
4. any important boundary, folded naturally into the relevant point
```

**Technical Team Update**
```text
Quick update on [feature / fix]:

1. main behavior change
2. key fix or guard / flag change
3. any technical risk or boundary, written as part of the update
4. anything still worth keeping an eye on
```

---

## Package Mode Workflow

Use this when the user wants a full update bundle, not just a message.

### What To Ask First

If the user did not already specify them, ask for:
1. **update range** — `from the last session` / `from <date> to <date>` / `from commit X to now`
2. **diagram type** — `flowchart` / `timeline` / `state diagram` / `data flow`
3. **document scope** — project `docs/` / repo root markdown (`CLAUDE.md`, `AGENTS.md`, planning notes) / personal memory or handoff files (only if explicitly asked)

If the user says "you choose": `flowchart`, current session range, project `docs/` plus directly-related repo root markdown.

### Step 1: Build The Source Set

Read only what's needed for the chosen range and scope:
- current conversation context
- git history / diff if the range is commit-based
- selected docs from the repo
- selected root markdown files
- handoff / memory files only if asked

For source selection guidance see [references/document-scope.md](references/document-scope.md).

### Step 2: Write The Slack Summary

Apply Draft Mode tone rules. Default structure:

```text
Quick update on <topic>:

<2-4 short sentences about what changed and why>

<optional final sentence about next step, risk, or what is still local only>
```

### Step 3: Create The Diagram

Write the diagram in Mermaid first. Vertical layout by default unless the user asks otherwise.

- `flowchart TD` for process flow
- `timeline` for date-based rollups
- `stateDiagram-v2` for status changes

Keep node labels plain and readable.

If the user wants a PNG export:
1. save the Mermaid source near the target doc or in a `diagrams/` folder
2. export with Mermaid CLI
3. save the PNG next to the Mermaid file
4. mention both file paths in the response

### Step 4: Update The Documents

Update only docs that match the selected scope.

- keep wording plain
- make the workflow consistent with the code or agreed plan
- add Mermaid only where it helps
- do not silently rewrite unrelated sections

### Step 5: Refresh The Work Log (If Requested)

If the user says to "call the work log again", use the shared `worklog` skill if one is installed (look for it by name, e.g. `~/.claude/skills/worklog/SKILL.md`). If no worklog skill is available, say so briefly and continue without the work log step.

Before calling it, confirm which material should feed the work log:
- `docs/` only
- repo root markdown files
- both
- handoff or memory markdown files too

### Step 6: Push Repo Changes (If Requested)

If the user asks to push:
1. check which repo actually owns the changed files
2. stage only the intended files
3. commit with a plain message
4. push the right branch
5. delete the branch only after the target branch is updated

If a folder has no Git remote, say that clearly and keep the changes local.

### Output Checklist (Package Mode)

When this mode runs well, the final answer includes:
- the Slack message
- the Mermaid diagram
- the exported PNG path (if created)
- the updated document paths
- the Git result (if a push happened)
- any limit such as "local only because no remote exists"

---

## How The User Should Call This Skill

Plain requests work:
- `use slacksmith to draft a short update for my tech colleague`
- `slacksmith — give me 3 versions`
- `slacksmith, use my recent Slack tone, keep it warm`
- `slacksmith, scope only the database workflow part`
- `slacksmith with @Name if possible`
- `slacksmith package mode — summary plus flowchart, update the docs, push the repo`
- `slacksmith full update from the last session, flowchart, refresh the work log`

## Final Reminder

This skill writes as the user. Whether it's a one-line check-in or a full package, the message itself should always feel like a human Slack message — not a project artifact, not a changelog, not an AI summary.
