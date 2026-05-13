---
name: handshake
description: Two-mode session snapshot tool. `/handshake` captures full session state (commands, successes, failures, errors, next steps) to ~/.claude/handshake.md in ≤250 lines. `/handshake upload` restores that state into the current session (works after /clear or in a new session).
---

# Handshake Skill

Two modes detected by argument:
- No argument → **SAVE** mode: capture and write session state
- Argument is `upload` → **LOAD** mode: restore saved state into current session

---

## SAVE MODE (`/handshake`)

### Step 1: Archive existing handshake

Using Bash tool, run: `date "+%Y-%m-%d_%H%M%S"` — capture output as `<TIMESTAMP>`.
Then run: `echo "$HOME"` — capture output as `<HOME>`.

If `<HOME>/.claude/handshake.md` exists:
1. `mkdir -p "<HOME>/.claude/skills/handshake/backups"`
2. `cp "<HOME>/.claude/handshake.md" "<HOME>/.claude/skills/handshake/backups/handshake_<TIMESTAMP>.md"`

### Step 2: Collect everything from conversation context

Extract ALL of the following from this session. Skip sections with nothing to report.

**Commands run** — every shell command, tool call, API call invoked this session. Format: `` `command` → result-summary ``. Max 10 entries. Skip routine reads (ls, cat, Read tool).

**Successes** — what completed without error, confirmed working.

**Failures** — what was attempted and failed. Include exact error message (1 line max each).

**Active errors** — unresolved errors still blocking progress.

**Files created/modified** — list paths with one-line description of change.

**Decisions made** — key choices, rejected alternatives, tradeoffs accepted.

**Current state** — where things stand right now (git branch if in repo, active services, env context).

**User profile context** — if learned this session: name, timezone, preferences, Claude Code model/plugin config.

**Skills created/modified** — any new or updated slash commands, their path and purpose.

**MCP / connector references** — any connector UUIDs, environment IDs, or API references used this session.

**Active routines/crons** — scheduled RemoteTrigger or cron jobs active at end of session (name, ID, next fire time).

**Feedback / corrections** — anything Claude got wrong and was corrected on this session. One line each.

**Errors resolved** — errors fixed this session. Format: `error | root_cause | fix`. Max 6. Omit if none.

**Unanswered question** — one open question that wasn't resolved this session. Omit entirely if none.

**Voice note** — one casual sentence from past-you to future-you. First person, human tone. No "I noticed", "It appears", "Looks like". Write like texting yourself. Example: "The auth flow is almost done — just wire up the token refresh and it ships." Always include.

**Pending tasks** — what is NOT done yet, ordered by priority.

**Next steps** — numbered, immediate, actionable. First step must be executable without additional context.

**Risks / unknowns** — unverified assumptions, suspected issues, things that could break.

### Step 3: Write handshake file

First run `echo "$HOME"` in Bash to resolve home path as `<HOME>`.

Write to `<HOME>/.claude/handshake.md` using the Write tool.

**Before writing:** Replace ALL `<!-- ... -->` placeholder comments with real content. Never output comment markers in the final file.

**Omit-if-none rule:** For sections marked "Omit if none" — skip the entire heading AND content block. Do not output empty sections or comment markers.

Hard cap: **250 lines**. Prune in this order if over limit:
1. Cut What Was Run beyond top 5 entries
2. Cut Decisions beyond top 5, Successes beyond top 3
3. Cut Risks to top 3
4. Never cut: Next Steps, Active Errors, Pending Tasks, Voice Note, Unanswered Question

Use this exact format:

```
# HANDSHAKE — <TIMESTAMP>

## Session Topic
<1-line description of what this session was about>

## What Was Run
<!-- Every command/tool/API call. Format: `cmd` → result -->

## Successes
<!-- Confirmed working. Bullet list. -->

## Failures
<!-- Attempted and failed. Format: thing-tried → error (1 line) -->

## Active Errors (Unresolved)
<!-- Still blocking. Format: ErrorType: message at file:line -->

## Files Created / Modified
<!-- path — what changed -->

## Decisions Made
<!-- Key choices and why. Rejected alternatives noted. -->

## Current State
- Branch: <branch or "not in git repo">
- Modified files: <list or none>
- Active services: <list or none>
- Environment: <session-critical vars, or none>

## User Profile Context
<!-- name, timezone, Claude Code model/plugin config if learned this session. Omit if unchanged. -->

## Skills Created / Modified
<!-- path — what the skill does. Omit if none. -->

## MCP / Connector References
<!-- Connector UUIDs, env IDs, API references used. Omit if none. -->

## Active Routines / Crons
<!-- name | ID | next fire time. Omit if none. -->

## Feedback / Corrections
<!-- Things Claude got wrong and was corrected on. One line each. Omit if none. -->

## Errors Resolved
<!-- error | root_cause | fix — max 6. Omit if none. -->

## Unanswered Question
<!-- One open question left unresolved. Omit section entirely if none. -->

## Voice Note
<!-- One casual sentence from past-you to future-you. Human tone, no AI-isms. Always include. -->

## Pending Tasks
<!-- Priority-ordered. -->

## Next Steps
1. <immediate, specific, executable>
2. <...>
3. <...>

## Risks / Unknowns
<!-- Unverified assumptions, suspected issues, risky areas. -->

## Restore
Run `/handshake upload` after `/clear` or in a new session.
Active file: ~/.claude/handshake.md
Archives: ~/.claude/skills/handshake/backups/
```

### Step 4: Confirm

Report:
- Written to `~/.claude/handshake.md`
- Archived previous to `~/.claude/skills/handshake/backups/` (if existed)
- Line count
- Safe to `/clear` now — restore with `/handshake upload`

---

## LOAD MODE (`/handshake upload`)

### Step 1: Locate file

Run in Bash: `echo "$HOME"` — capture output as `<HOME>`.
Read `<HOME>/.claude/handshake.md`.

If not found, ask:
> "No handshake.md found. Provide path or filename from `~/.claude/skills/handshake/backups/`?"

Wait for input. Read from provided path.

### Step 2: Parse all sections

Extract and hold in active context:
- Session Topic, What Was Run, Successes, Failures, Active Errors
- Files Created/Modified, Decisions Made, Current State
- User Profile Context, Skills Created/Modified, MCP/Connector References
- Active Routines/Crons, Feedback/Corrections, Errors Resolved
- Unanswered Question, Voice Note, Pending Tasks, Next Steps, Risks/Unknowns

### Step 3: Reconstruct and report

Present a clear summary to user. Skip any section that has no content — do not show empty headings.

1. **Topic** — what this session was working on
2. **Where we left off** — current state, branch, modified files
3. **What worked** — confirmed successes
4. **What failed / is broken** — failures + active errors (highest priority)
5. **Errors resolved** — what was fixed and how (don't re-investigate)
6. **Decisions already made** — don't re-debate these
7. **What's next** — pending tasks + exact next steps
8. **Watch out for** — risks and unknowns
9. **Voice note** — past-you's direct message

### Step 4: Confirm

Say:
> "Restored from handshake (<TIMESTAMP>). Next action: <Step 1 from Next Steps>. Ready to continue?"

Wait for user confirmation before taking any action.
