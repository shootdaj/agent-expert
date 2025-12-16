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

echo ""
echo "✓ Agent Expert installed!"
echo ""
echo "Commands available:"
echo "  /init-expert {domain}  - Create expertise for a domain"
echo "  /plan {task}           - Plan a task"
echo "  /build                 - Execute the plan"
echo "  /self-improve          - Update expertise (learning step)"
