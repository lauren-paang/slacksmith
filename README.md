# 🔨 slacksmith

> **Forge Slack messages that sound like *you* — not a release bot.**

Your teammate is waiting. Your commit history is a mess. Your draft reads like a LinkedIn post written by a toaster.

**Slacksmith** is a Claude Code / Codex skill that writes Slack updates in your real voice — short, personal, and believable. For project updates, check-ins, follow-ups, or status notes.

```
"use slacksmith to message my boss about the auth fix"
         ↓
Quick update on the auth fix:

1. Login now survives the token refresh race I mentioned Monday.
2. Nothing user-visible changed — same screens, same clicks.
3. Rolling out behind a flag tonight, watching error rates in the morning.

Let me know if anything looks off on your end.
```

No robot voice. No bullet vomit. No "I am an AI assistant and I have completed the following tasks."

---

## ✨ What it actually does

| You say | Slacksmith gives you |
|---|---|
| `draft a slack message about X` | A clean 2–5 line draft in your tone |
| `give me 3 versions` | Safe • warmer • more direct |
| `boss-facing vs tech-facing` | Two audience-tuned versions of the same update |
| `use my recent Slack tone` | Reads your recent Slack via the Slack plugin and matches it |
| `@Alex` | Resolves the real Slack mention if a Slack plugin is connected; falls back to plain `@Name` otherwise |

### 🎯 Audience-aware by design

Slacksmith asks *who the message is for* before it drafts:

- **Boss / non-technical** — product behavior, user-visible outcomes, what to test. No IDs, no endpoint names, no internals.
- **Technical teammate** — what changed in behavior, what flag / guard flipped, what risks remain, what to watch.

Same update, two very different drafts.

---

## 📦 Install

### 🧠 Easiest — let your agent install it (copy-paste prompt)

If you're already inside **Claude Code** or **Codex**, just paste this message and the agent does everything:

> Install the **slacksmith** skill from `https://github.com/lauren-paang/slacksmith` for me. Clone the repo to a temp folder, run its `install.sh`, then delete the temp clone. After it's installed, tell me to restart this session so the new skill appears. Don't modify any of my other skills.

That's it — the agent will clone, run the installer (which handles Claude Code + Codex detection), confirm success, and tell you when to `/clear`.

---

### 🖥️ Claude Code

**Option A — one-liner:**

```bash
git clone https://github.com/lauren-paang/slacksmith.git /tmp/slacksmith && bash /tmp/slacksmith/install.sh && rm -rf /tmp/slacksmith
```

**Option B — manual symlink (so `git pull` in one place updates the skill):**

```bash
git clone https://github.com/lauren-paang/slacksmith.git ~/code/slacksmith
ln -s ~/code/slacksmith ~/.claude/skills/slacksmith
```

**After install:** quit and relaunch Claude Code, or run `/clear`. You'll see `slacksmith` in the skills list. Invoke with `/slacksmith` or "use slacksmith to draft a slack message about …".

---

### 🤖 Codex (OpenAI CLI)

**Option A — one-liner:**

```bash
git clone https://github.com/lauren-paang/slacksmith.git /tmp/slacksmith && bash /tmp/slacksmith/install.sh && rm -rf /tmp/slacksmith
```

The installer auto-detects `~/.codex/` and drops the skill into `~/.codex/skills/slacksmith`.

**Option B — manual symlink:**

```bash
git clone https://github.com/lauren-paang/slacksmith.git ~/code/slacksmith
ln -s ~/code/slacksmith ~/.codex/skills/slacksmith
```

**After install:** restart your Codex session. Codex will surface slacksmith via its skill discovery (the `agents/openai.yaml` file provides the display metadata).

---

### 📥 Zero-git option (any platform)

1. Go to **https://github.com/lauren-paang/slacksmith**
2. Click the green **Code** button → **Download ZIP**
3. Unzip and move the folder to:
   - `~/.claude/skills/slacksmith` (for Claude Code)
   - `~/.codex/skills/slacksmith` (for Codex)
4. Restart your session.

---

## 🗣️ How to call it

Plain English works. All of these are valid:

```
use slacksmith to draft a short update for my tech colleague
slacksmith — give me 3 versions
slacksmith, use my recent Slack tone, keep it warm
slacksmith, scope only the database workflow part
slacksmith with @Alex if possible
```

Or just `/slacksmith` and tell it what you want.

---

## 🧭 Good fit if...

- You write a lot of Slack updates and they all start feeling like changelogs
- You want boss-version and tech-version of the same message on demand
- You want mentions actually resolved to real Slack user IDs (when the Slack plugin is installed)
- You like your tools with personality

## 🚫 Not the right tool if...

- You want a formal changelog generator → try a release-notes bot
- You want AI to autonomously post to Slack without review → slacksmith always returns drafts
- You want it to invent information → it reads your session / codebase / Slack context and is deliberately conservative about "what we can prove"

---

## 🛠️ Under the hood

```
slacksmith/
├── SKILL.md              ← the brain (tone rules + workflow)
└── agents/
    └── openai.yaml       ← Codex display metadata
```

- **Harness-agnostic**: works in Claude Code, Codex CLI, and any tool that reads the standard `SKILL.md` frontmatter.
- **No network calls of its own** — it uses whatever Slack / git / filesystem tools your harness already has.
- **Tone-first**: the skill is deliberately opinionated about *not* sounding like AI. See the "Tone Rules" section in `SKILL.md`.

---

## 💡 Philosophy

> Good Slack messages are **short, specific, and sound like a human typed them.**

Most AI writing tools optimize for impressive. Slacksmith optimizes for *believable*. A 3-line message your boss actually reads beats a 12-bullet summary they skim.

Content comes from the session. Tone comes from your Slack history. Nothing is invented.

---

## ♻️ Updating

Already installed via `git clone`? Pull the latest:

```bash
cd ~/.claude/skills/slacksmith && git pull
# and if you installed for Codex too:
cd ~/.codex/skills/slacksmith && git pull
```

Then restart Claude Code (or `/clear`) so it picks up the new version.

---

## 🤝 Contributing

PRs welcome — especially new message shapes, audience buckets, or tone rules that have worked for you in real teams. Open an issue first if you're planning something big.

## 📜 License

MIT. Forge freely.

---

<sub>Built with Claude Code • Drop a ⭐ if slacksmith saved you from one more robotic Slack message.</sub>
