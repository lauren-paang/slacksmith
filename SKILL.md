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

## Load The User's Tone Profile (If It Exists)

Before drafting, check for `references/my-tone.md` inside this skill's folder.

- **If it exists:** read it and treat it as the primary tone reference. Its `Voice Signature`, `Vocabulary Fingerprint`, `Punctuation & Formatting`, `Tone Knobs`, and `Verbatim Samples` sections override generic tone rules. The `Things I Do That Most Drafts Get Wrong` list is a hard deny-list — never write those phrases.
- **If it does not exist:** draft from the generic tone rules below. Don't ask the user to create one mid-request; just mention after the draft that they can run Tone Study Mode if they want future drafts calibrated to their voice.

The profile is **a reference, not a cage** — still obey per-message instructions (audience, scope, length) from the user, but apply the voice on top.

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
- **skip deploy / infra / pipeline status lines** — e.g. `backend allowlist updated, deployed to dev`, `CodePipeline ran`, `ECS task restarted`, `pushed to main`, `schema migration applied`, `backend + frontend both deployed`. These feel like progress but are implementation detail to a boss. If the boss genuinely needs to know something shipped, say it in user-facing terms (`the new fields are live for users now`), not in deploy terms.
- skip commit counts, branch names, PR numbers, file names, lint/CI results
- center on: what the feature does, how it should feel, what to test, edge cases to notice
- write feature behavior as clear statements, not open questions
- when a current boundary matters, fold it into the relevant point — don't make a separate `limitation` section

**Self-check before returning a boss draft:** re-read each numbered point and ask "would this sentence make sense to someone who doesn't know our stack?" If a point names a backend, a deploy tool, a pipeline, a commit, or a file, rewrite it in user-facing terms or delete it.

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

---

## Tone Study Mode — Building A Voice Profile

This mode is used **occasionally**, not on every message. Its job is to distill the user's own writing voice from their real Slack history into a persistent profile (`references/my-tone.md`) that every future draft will load.

### When To Enter Tone Study Mode

The user asks for it explicitly:

- `slacksmith, build my tone profile`
- `slacksmith, study how I write in slack`
- `slacksmith, learn my voice`
- `slacksmith tone study mode`

Do **not** enter this mode silently mid-draft. It's a separate, one-time (or occasional re-run) exercise.

### Preconditions

Tone Study Mode requires a Slack plugin/MCP with message-read capability. If no Slack plugin is available:

- say so plainly
- offer the alternative: the user pastes 10–20 real messages they've sent, and the skill distills the profile from those pasted samples instead

### Workflow

**Step 1 — Scope the study**

Ask the user these in one short message:

- **Time window** — `last 30 days` / `last 3 months` / `specific date range`
- **Channels/DMs to include** — `all` / `only DMs` / `specific channels` / `skip #random and #memes`
- **Minimum sample size** — default: at least 30 messages the user sent

If the plugin can't reach enough messages, ask for paste-in samples to supplement.

**Step 2 — Read only the user's sent messages**

Use the Slack plugin to pull messages **authored by the user**. Ignore messages from others in the same threads unless they establish context for the user's reply.

Stay inside the time window. Don't silently expand.

**Step 3 — Distill into the six captured dimensions**

Fill in each section of `references/my-tone-template.md` with concrete observed evidence:

1. **Voice Signature** — one sentence summarizing how they sound
2. **Rhythm & Length** — typical message length, paragraph behavior
3. **Opening / Closing Patterns** — top 3–5 of each, actually observed
4. **Vocabulary Fingerprint** — words they use, words they never use, swap-outs
5. **Punctuation & Formatting** — em-dashes, lowercase starts, emoji frequency, which emoji
6. **Tone Knobs** — warmth, formality, confidence, humor (each on a 4-point scale)

For each claim, cite at least one real message fragment as evidence. Don't invent patterns not actually visible in the sample.

**Step 4 — Capture the deny list**

Identify 3–6 AI-drafting habits that clearly DON'T match this user. Examples:

- "I hope this message finds you well"
- over-parallel bullet structure
- formal sign-offs like "Best regards"

These go into `Things I Do That Most Drafts Get Wrong` and become a hard deny-list for all future drafts.

**Step 5 — Extract verbatim samples**

Pick 3–5 of the user's actual messages that are most representative, covering:

- a short update
- a follow-up ping
- asking for input
- disagreeing / pushing back
- celebratory / gratitude

Paste verbatim into the template.

**Step 6 — Save to `references/my-tone.md`**

Write the completed profile to `references/my-tone.md` (not the template file — leave `my-tone-template.md` as a blank template).

Show the user a preview before saving. Confirm before overwriting an existing `my-tone.md`.

**Step 7 — Offer a calibration test**

After saving, offer: *"Want me to draft a sample message using this profile so you can tell me what feels off?"*

If the user points out what's wrong, update the profile and re-save. This loop is how the profile gets sharper.

### What Tone Study Mode Does NOT Do

- does not read other people's messages to imitate them (that's outside this skill's scope)
- does not upload messages anywhere — the profile stays local
- does not run on every draft — only on explicit request
- does not override per-message instructions like audience or length

### Regeneration

The profile can drift over time as voice evolves. Suggest re-running Tone Study Mode if:

- the user says "this doesn't sound like me anymore"
- it's been 6+ months since the last profile build
- the user has joined a new team / changed role / switched communication style

---

## How The User Should Call This Skill

Plain requests work:

- `use slacksmith to draft a short update for my tech colleague`
- `slacksmith — give me 3 versions`
- `slacksmith, use my recent Slack tone, keep it warm`
- `slacksmith, scope only the database workflow part`
- `slacksmith with @Name if possible`
- `slacksmith, build my tone profile` *(enters Tone Study Mode)*
- `slacksmith, study how I write` *(enters Tone Study Mode)*

## Final Reminder

This skill writes as the user. The message itself should always feel like a human Slack message — not a project artifact, not a changelog, not an AI summary.
