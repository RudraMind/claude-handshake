<p align="center">
  <img src="https://em-content.zobj.net/source/apple/391/handshake_1f91d.png" width="100" />
</p>

<h1 align="center">claude-handshake</h1>

<p align="center">
  <strong>context dies every session. this is the cure.</strong>
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
  <a href="#install">Install</a> •
  <a href="#how-it-works">How It Works</a> •
  <a href="#usage">Usage</a> •
  <a href="#what-gets-saved">What Gets Saved</a> •
  <a href="#roadmap">Roadmap</a>
</p>

---

## The Problem

You're two hours into a Claude Code session.

Architecture decided. Dead ends mapped. Three bugs fixed. That weird edge case in the auth flow — understood, documented in your head. Claude knows everything.

Then context hits 90%. You `/clear`.

**Everything evaporates.**

The decision you made an hour ago. The three approaches you ruled out and why. The half-finished feature with the exact next step queued. The subtle constraint that would have saved you 45 minutes. Gone.

Next session: 20 minutes re-explaining what Claude already knew. Every session. Every time.

This is **context-rot** — the hidden tax that costs Claude Code users half their productive time. Not because the tool is broken. Because context is mortal and nothing saves it.

Until now.

---

## Three Commands. Full Continuity.

```
/handshake          ← snapshot everything Claude knows right now
/clear              ← wipe context (configs reload, conversation doesn't)
/handshake upload   ← fully restored in 15 seconds
```

### Before / After

<table>
<tr>
<td width="50%">

**Without claude-handshake**
```
Session at 95%...
/clear

New session.
"Hey Claude, so we were
 building an auth flow,
 we tried JWT but it broke
 on token refresh because..."

→ 20 minutes re-explaining.
→ Wrong assumptions made.
→ Context never fully recovers.
```

</td>
<td width="50%">

**With claude-handshake**
```
Session at 65%...
/handshake   ← 17 sections saved
/clear

New session.
/handshake upload

"Restored from 14:23:01.
 Next: wire the token
 refresh endpoint — the
 /api/auth/refresh stub
 is ready. Ready?"

→ 15 seconds. Full context.
→ Zero re-explaining.
→ Exactly where you left off.
```

</td>
</tr>
</table>

---

## How It Works

```
┌─────────────────────────────────────────────────────────────────┐
│                      WORKING SESSION                            │
│                                                                 │
│   Context reaches ~60%                                          │
│            │                                                    │
│            ▼                                                    │
│       /handshake  (SAVE)                                        │
│            │                                                    │
│     ┌──────┴──────────────────────┐                             │
│     ▼                             ▼                             │
│  Archive old snapshot       Claude extracts                     │
│  → skills/handshake/        17 sections from                    │
│    backups/<timestamp>.md   conversation context                │
│                                   │                             │
│                                   ▼                             │
│                       Write handshake.md (≤250 lines)           │
│                                   │                             │
│                                   ▼                             │
│                    "Safe to /clear"                             │
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
│       /handshake upload  (RESTORE)                              │
│            │                                                    │
│     ┌──────┴──────────────────────┐                             │
│     ▼                             ▼                             │
│  Read handshake.md          Parse all 17 sections               │
│                                   │                             │
│                                   ▼                             │
│  "Restored from <timestamp>.                                    │
│   Next: <Step 1 from your saved Next Steps>.                    │
│   Ready to continue?"                                           │
│                                   │                             │
│                                   ▼                             │
│              Session continues. Zero context lost.              │
└─────────────────────────────────────────────────────────────────┘
```

### File Architecture

```
~/.claude/
├── handshake.md                      ← active snapshot (≤250 lines)
└── skills/
    └── handshake/                    ← everything in ONE place
        ├── SKILL.md                  ← skill Claude reads
        └── backups/
            └── handshake_<TS>.md    ← auto-archived on every save
```

**No database. No daemon. No background process. One skill file.**

---

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/rudrafuture/claude-handshake/main/install.sh | bash
```

Restart Claude Code. Done.

**Manual install:**
```bash
mkdir -p ~/.claude/skills/handshake
curl -fsSL https://raw.githubusercontent.com/rudrafuture/claude-handshake/main/SKILL.md \
  -o ~/.claude/skills/handshake/SKILL.md
```

---

## Usage

**Step 1 — Context hits ~60%. Run:**
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
