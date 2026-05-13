<p align="center">
  <img src="https://em-content.zobj.net/source/apple/391/handshake_1f91d.png" width="100" />
</p>

<h1 align="center">claude-handshake</h1>

<p align="center">
  <strong>Handshake before the blackout.</strong>
</p>

<p align="center">
  <a href="https://github.com/rudrafuture/claude-handshake/stargazers"><img src="https://img.shields.io/github/stars/rudrafuture/claude-handshake?style=flat&color=blue" alt="Stars"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/rudrafuture/claude-handshake?style=flat" alt="License"></a>
  <img src="https://img.shields.io/badge/version-1.0.0-green?style=flat" alt="Version">
  <img src="https://img.shields.io/badge/Claude_Code-skill-orange?style=flat" alt="Claude Code">
  <img src="https://img.shields.io/badge/Windows-native-brightgreen?style=flat" alt="Windows Native">
</p>

<p align="center">
  <a href="#the-problem">Problem</a> •
  <a href="#install-claude-code">Install</a> •
  <a href="#how-it-works">How It Works</a> •
  <a href="#usage">Usage</a> •
  <a href="#what-gets-saved">What Gets Saved</a> •
  <a href="#roadmap">Roadmap</a>
</p>

---

## The Problem

🟢 Two hours in. Architecture solved. Bugs fixed. Claude knows your codebase cold.

🟡 Context hits 90%.
&nbsp;&nbsp;&nbsp;`/compact` fires (auto or manual) — remembers decisions existed, not *why* they were made.
&nbsp;&nbsp;&nbsp;Blurry photo of a dying session.

&nbsp;&nbsp;&nbsp;— or —

🔴 `/clear` — lose the failed approaches, hidden constraints, exact next step.

*"Okay Claude, let me explain everything again…"*

That's **context rot** — the silent productivity tax of AI coding workflows.

`/handshake` fixes it.

---

## Snapshot. Reset. Resume.

```
/handshake          ← snapshot everything Claude knows right now
/clear              ← wipe context (configs reload, conversation doesn't)
/handshake upload   ← fully restored in 15 seconds
```

## Before vs After claude-handshake

| | Without claude-handshake<br>🔴 `/compact` | With claude-handshake<br>🟢 `/handshake` |
|---|---|---|
| When context fills | `/compact` auto-fires — you don't choose | You snapshot when *you* decide |
| Summarization | Auto-compressed by Claude Code | YOU control 17 explicit sections |
| Quality | <span style="color:red">Drops decisions, reasoning, failed approaches</span> | Captures what survives |
| Voice note | None | Always saved — past-you to future-you |
| Failed approaches | Lost in compression | Explicit section — never re-investigated |
| Restart time | 20 min re-explaining | 15 seconds. Exactly where you left off. |
| Control | Auto-compaction decides | You decide |

> `/compact` is a blurry photo. `/handshake` is a briefing you wrote yourself, handed to a fresh Claude.

---

## How It Works

<div align="center">
<pre>
┌─────────────────────────────────────────────────────────────────┐
│                      WORKING SESSION                            │
│                                                                 │
│                   Context reaches ~70%                          │
│                            │                                    │
│                            ▼                                    │
│                   /handshake  (SAVE)                            │
│                            │                                    │
│            ┌───────────────┴───────────────────┐               │
│            ▼                                   ▼               │
│  Archive old snapshot              Claude extracts              │
│  → skills/handshake/               17 sections from            │
│    backups/&lt;timestamp&gt;.md          conversation context         │
│                                                │               │
│                                                ▼               │
│                             Write handshake.md (≤250 lines)    │
│                                                │               │
│                                                ▼               │
│                                   ✅ "Safe to /clear"           │
└─────────────────────────────────────────────────────────────────┘
                               │
                           /clear
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                      CONTEXT WIPED                              │
│  CLAUDE.md · settings.json · hooks · plugins — reload          │
│  Conversation — gone. That's the point.                         │
└─────────────────────────────────────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                      FRESH SESSION                              │
│                                                                 │
│                   /handshake upload  (RESTORE)                  │
│                            │                                    │
│            ┌───────────────┴───────────────────┐               │
│            ▼                                   ▼               │
│  Read handshake.md                 Parse all 17 sections        │
│                                                │               │
│                                                ▼               │
│                             "Restored from &lt;timestamp&gt;.         │
│                              Next: &lt;Step 1&gt;. Ready?"            │
│                                                │               │
│                                                ▼               │
│                       ✅ Session continues. Zero context lost.  │
└─────────────────────────────────────────────────────────────────┘
</pre>
</div>

### File Architecture

<div align="center">
<pre>
~/.claude/
├── handshake.md                      ← active snapshot (≤250 lines)
└── skills/
    └── handshake/                    ← everything in ONE place
        ├── SKILL.md                  ← skill Claude reads
        └── backups/
            └── handshake_&lt;TS&gt;.md    ← auto-archived on every save
</pre>
</div>

**No database. No daemon. No background process. One skill file.**

> 🎁 **Bonus Skill — Time Travel:**
> Every `/handshake` save auto-archives to `backups/`. Missed something from 3 days ago? Run `/handshake upload`, provide the backup filename, and Claude resurrects that exact session — decisions, failures, voice note and all.
> ```
> /handshake upload
> → "No handshake.md found. Provide path or filename from backups/?"
> → handshake_2026-05-10_143201.md
> → Restored. Ready to continue?
> ```

---

## Install (Claude Code)

**Never restart from zero again.**

```bash
curl -fsSL https://raw.githubusercontent.com/rudrafuture/claude-handshake/master/install.sh | bash
```

Restart Claude Code. Done.

**Manual install:**
```bash
mkdir -p ~/.claude/skills/handshake
curl -fsSL https://raw.githubusercontent.com/rudrafuture/claude-handshake/master/SKILL.md \
  -o ~/.claude/skills/handshake/SKILL.md
```

---

## Usage

**Step 1 — Save the vibe before the wipe:**
```
/handshake
```
Claude snapshots 17 sections. Archives the previous handshake automatically. Tells you it's safe to clear.

**Step 2 — Wipe:**
```
/clear
```
Context gone. CLAUDE.md, settings, hooks all reload fresh.

**Step 3 — Restore:**
```
/handshake upload
```
Claude reads the snapshot, reconstructs everything, gives you the exact next action. Confirm and continue.

---

## What Gets Saved

17 structured sections, hard-capped at ≤250 lines:

| Section | What it captures |
|---------|-----------------|
| Session Topic | One line: what this session was |
| What Was Run | Commands, tool calls, API calls (max 10) |
| Successes | Confirmed working (max 3 after prune) |
| Failures | Attempted and failed — exact error |
| Active Errors | Still blocking right now — never pruned |
| Files Created/Modified | Paths + what changed |
| Decisions Made | Choices + reasoning + what was rejected |
| Current State | Branch, services, env vars |
| User Profile Context | Name, timezone, Claude config |
| Skills Created/Modified | New slash commands and paths |
| MCP/Connector References | UUIDs, env IDs used this session |
| Active Routines/Crons | Scheduled jobs + next fire time |
| Feedback/Corrections | Things Claude got wrong this session |
| Errors Resolved | Fixed bugs: error → cause → fix |
| Unanswered Question | One open question (omitted if none) |
| **Voice Note** | **Casual message from past-you to future-you — always saved** |
| Pending Tasks + Next Steps | Priority-ordered, immediately actionable |

**Prune order when over 250 lines:** Commands → Decisions → Risks
**Never pruned:** Next Steps · Active Errors · Voice Note · Unanswered Question

---

## Comparison

| | claude-handshake | claude-keepalive |
|--|:---:|:---:|
| Trigger | Manual (`/handshake`) | Auto (hooks fire on compaction) |
| Restore | Manual (`/handshake upload`) | Auto (SessionStart hook) |
| Windows native | ✅ Yes — pure LLM | ❌ WSL needed |
| Global scope | ✅ All projects | Per-project only |
| Secret scrubbing | Manual awareness | ✅ Auto (14 patterns) |
| Setup complexity | One file copy | Full hook installer |
| Control | You choose when | Fires automatically |

Use **claude-handshake** for full control + Windows.
Use **claude-keepalive** for zero manual steps on Unix/WSL.

---

## Roadmap

### v1.0 — Manual Control ✅ (current)
Three commands. Full continuity. Zero deps. Works everywhere.

### v1.1 — Time Travel (coming)

```
/handshake upload backups/handshake_2026-05-10_143201.md
```

Restore from any archived snapshot — not just the latest. Every `/handshake` save auto-archives. Pick any point in your history and resume from there.

### v2.0 — Fully Automated (coming)

```
/handshake auto
```

One command activates full automation:
- Auto-snapshot when context crosses 60%
- Auto-archive previous state
- Auto-restore on every new session start
- Zero manual steps. Zero context-rot. Ever.

---

## License

MIT — Rudrafuture 2026
