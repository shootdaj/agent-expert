#!/bin/bash
# Agent Expert Installer
# Run: curl -sL https://raw.githubusercontent.com/shootdaj/agent-expert/main/install.sh | bash

set -e

REPO="https://raw.githubusercontent.com/shootdaj/agent-expert/main"

echo "Installing Agent Expert..."

# Create directories (won't fail if they exist)
mkdir -p .claude/commands
mkdir -p experts

# Handle CLAUDE.md - append if exists, create if not
if [ -f "CLAUDE.md" ]; then
    echo ""
    echo "Found existing CLAUDE.md - appending Agent Expert instructions..."
    echo "" >> CLAUDE.md
    echo "---" >> CLAUDE.md
    echo "" >> CLAUDE.md
    curl -sL "$REPO/CLAUDE.md" >> CLAUDE.md
else
    curl -sL "$REPO/CLAUDE.md" -o CLAUDE.md
fi

# Download commands (won't overwrite if they exist)
for cmd in plan build self-improve init-expert; do
    if [ -f ".claude/commands/${cmd}.md" ]; then
        echo "Skipping .claude/commands/${cmd}.md (already exists)"
    else
        curl -sL "$REPO/.claude/commands/${cmd}.md" -o ".claude/commands/${cmd}.md"
    fi
done

# Download template (won't overwrite if exists)
if [ -f "experts/_template.md" ]; then
    echo "Skipping experts/_template.md (already exists)"
else
    curl -sL "$REPO/experts/_template.md" -o experts/_template.md
fi

# Install hook for automatic expertise updates
SETTINGS_FILE=".claude/settings.json"
HOOK_JSON=$(cat << 'HOOK_EOF'
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": {
          "tools": ["Edit", "Write"]
        },
        "hook": {
          "type": "prompt",
          "prompt": "You just modified code. Remember to update the relevant expertise file in experts/ with:\n- New patterns or file locations discovered\n- Gotchas or edge cases encountered\n- Update the Change Log section\n\nThis is part of the Agent Expert learning system."
        }
      }
    ]
  }
}
HOOK_EOF
)

if [ -f "$SETTINGS_FILE" ]; then
    echo "Found existing $SETTINGS_FILE - please manually add the Agent Expert hook."
    echo "Hook configuration saved to .claude/agent-expert-hook.json for reference."
    echo "$HOOK_JSON" > .claude/agent-expert-hook.json
else
    echo "$HOOK_JSON" > "$SETTINGS_FILE"
    echo "✓ Installed PostToolUse hook for automatic expertise updates"
fi

echo ""
echo "✓ Agent Expert installed!"
echo ""
echo "Claude Code will now automatically:"
echo "  • Read expertise files before working"
echo "  • Update expertise files after making changes"
echo "  • Remind you to update expertise via PostToolUse hook"
echo ""
echo "No commands needed - learning happens automatically."
echo ""
echo "Optional commands: /init-expert, /plan, /build"
