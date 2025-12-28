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
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "You just modified code. Remember to update the relevant expertise file in experts/ with:\n- New patterns or file locations discovered\n- Gotchas or edge cases encountered\n- Update the Change Log section\n\nThis is part of the Agent Expert learning system."
          }
        ]
      }
    ]
  }
}
HOOK_EOF
)

# Function to fix old hook format (object matcher -> string, "hook" -> "hooks" array)
fix_old_hook_format() {
    local file="$1"
    # Check for either old format: object matcher or singular "hook"
    if grep -qE '"matcher":\s*\{|"hook":' "$file" 2>/dev/null; then
        echo "Found old hook format in $file - fixing..."
        # Backup original
        cp "$file" "${file}.backup"

        if command -v python3 &> /dev/null; then
            python3 << 'PYEOF'
import json

with open('.claude/settings.json', 'r') as f:
    data = json.load(f)

modified = False
if 'hooks' in data:
    for event_type, event_hooks in data['hooks'].items():
        if isinstance(event_hooks, list):
            for hook_entry in event_hooks:
                # Fix 1: Convert "hook": {...} to "hooks": [{...}]
                if 'hook' in hook_entry and 'hooks' not in hook_entry:
                    hook_entry['hooks'] = [hook_entry['hook']]
                    del hook_entry['hook']
                    modified = True

                # Fix 2: Convert object matcher to string matcher
                if isinstance(hook_entry.get('matcher'), dict):
                    tools = hook_entry['matcher'].get('tools', [])
                    # Convert ["Edit", "Write"] to "Edit|Write"
                    hook_entry['matcher'] = '|'.join(tools) if tools else '*'
                    modified = True

if modified:
    with open('.claude/settings.json', 'w') as f:
        json.dump(data, f, indent=2)
    print("✓ Fixed old hook format")
else:
    print("No old format found to fix")
PYEOF
        else
            echo "Warning: python3 not found. Please manually fix $file";
            echo "Change matcher from object to string (e.g., \"Edit|Write\")"
        fi
    fi
}

if [ -f "$SETTINGS_FILE" ]; then
    # Check if this is a previous Agent Expert install with old format
    if grep -q 'Agent Expert' "$SETTINGS_FILE" 2>/dev/null; then
        echo "Found existing Agent Expert settings - checking format..."
        fix_old_hook_format "$SETTINGS_FILE"
    else
        echo "Found existing $SETTINGS_FILE - please manually add the Agent Expert hook."
        echo "Hook configuration saved to .claude/agent-expert-hook.json for reference."
        echo "$HOOK_JSON" > .claude/agent-expert-hook.json
    fi
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
