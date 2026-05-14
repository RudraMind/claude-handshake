#!/usr/bin/env bash
set -e

SKILL_DIR="$HOME/.claude/skills/handshake"
SKILL_URL="https://raw.githubusercontent.com/RudraMind/claude-handshake/master/SKILL.md"

echo "Installing claude-handshake..."
mkdir -p "$SKILL_DIR"
curl -fsSL "$SKILL_URL" -o "$SKILL_DIR/SKILL.md"
echo ""
echo "Installed to: $SKILL_DIR/SKILL.md"
echo ""
echo "Next: restart Claude Code, then run /handshake"
