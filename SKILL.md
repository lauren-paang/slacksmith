---
name: slacksmith
description: Forge a Slack message in the user's natural tone — short personal drafts for project updates, check-ins, follow-ups, or status notes. Handles audience tuning (boss vs technical), multiple draft versions, @mention resolution via the Slack plugin when available, and tone learning from recent Slack context.
---

# Slacksmith

## Purpose

Use this skill when the user wants help writing a Slack message as themselves.

This is not a code-review skill and not a release-note generator. Write like a real teammate or founder sending a message in Slack — short, specific, human.

## Use The Slack Plugin First (When Available)

When the Slack plugin is installed:

- read recent Slack context to learn the user's real tone
- resolve @mentions through the plugin
- use plugin tools again if the user wants the final message posted or saved as draft

If the plugin is unavailable, say so briefly and continue from session/codebase context alone.

## Tone Rules

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

## Content First, Tone Second

If both session context and Slack context are available:

1. use the **session** to understand content
2. use **Slack** to understand tone

Don't let Slack tone override the actual content goals.

## Mentions

- ask for the person/group name if missing
- if the Slack plugin can resolve them, use real Slack mention syntax
- if not, leave a placeholder like `@Name` and tell the user it was not resolved
- never invent a Slack user id

---

## Workflow

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

### Output Format

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

## How The User Should Call This Skill

Plain requests work:

- `use slacksmith to draft a short update for my tech colleague`
- `slacksmith — give me 3 versions`
- `slacksmith, use my recent Slack tone, keep it warm`
- `slacksmith, scope only the database workflow part`
- `slacksmith with @Name if possible`

## Final Reminder

This skill writes as the user. The message itself should always feel like a human Slack message — not a project artifact, not a changelog, not an AI summary.
