# Agent Expert

A self-improving agent architecture for **Claude Code** that executes and learns automatically.

> **This repo is a template.** Add these files to your project and Claude Code automatically learns as it works.

## Install

Run this in your project:

```bash
curl -sL https://raw.githubusercontent.com/shootdaj/agent-expert/main/install.sh | bash
```

**Restart Claude Code** (or start a new session) to load the new instructions.

### What Gets Installed

```
your-project/
├── CLAUDE.md                      # Instructions that make Claude an Agent Expert
├── .claude/
│   ├── settings.json              # PostToolUse hook for automatic updates
│   └── commands/                  # Optional slash commands
│       ├── plan.md                #   /plan - explicit planning
│       ├── build.md               #   /build - explicit build with learning
│       └── init-expert.md         #   /init-expert - create new expertise file
└── experts/
    └── _template.md               # Template for expertise files
```

| File | What It Does |
|------|--------------|
| `CLAUDE.md` | Tells Claude to read expertise before tasks and update it after changes. This is what makes the automatic learning work. |
| `.claude/settings.json` | **PostToolUse hook** that reminds Claude to update expertise after every Edit/Write operation. This makes the "automatic" part truly automatic. |
| `.claude/commands/*.md` | Optional slash commands for explicit control. Not required - normal conversation works. |
| `experts/_template.md` | Template used when creating new expertise files. |
| `experts/{domain}.md` | Created automatically as you work. These store the learned knowledge. |

- **Already have a `CLAUDE.md`?** The install appends to it instead of overwriting.
- **Files already exist?** They're skipped (won't overwrite your customizations).
- **Already have `.claude/settings.json`?** The hook config is saved to `.claude/agent-expert-hook.json` for manual merging.

### What Happens After Install

Claude will now automatically:

1. **Read expertise** before working on any domain
2. **Update expertise** after making changes

No commands needed. Learning is built into normal conversation.

## How It Works

```
┌─────────────────────────────────────────────────────────────┐
│  You: "Add rate limiting to the login endpoint"             │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│  Claude automatically:                                       │
│  1. Checks experts/api.md for existing knowledge            │
│  2. Uses that knowledge while working                        │
│  3. Makes the changes                                        │
│  4. Updates experts/api.md with what was learned            │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│  Next time you ask about the API, Claude already knows:     │
│  - Where the rate limiter lives                             │
│  - The middleware pattern used                               │
│  - Any gotchas encountered                                   │
└─────────────────────────────────────────────────────────────┘
```

## Example

```
You: Add a caching layer to the database queries

Claude: I'll check my expertise first...

        [reads experts/database.md]

        Based on my knowledge of this codebase:
        - Queries go through src/db/repositories/
        - You're using Knex as the query builder

        I'll add Redis caching to the repository layer...

        [makes changes]

        Done. I've updated experts/database.md with:
        - Added cache.ts to the file locations
        - Documented the caching pattern with example
        - Added gotcha: "Cache invalidation on writes"
```

Over time, the expertise files become comprehensive - Claude genuinely becomes an expert at your codebase.

## Optional Commands

Normal conversation handles everything, but these exist for explicit control:

| Command | Purpose |
|---------|---------|
| `/init-expert {domain}` | Create expertise file for a new domain |
| `/plan {task}` | Explicitly plan before building |
| `/build` | Explicitly build with auto-learning |

## The PostToolUse Hook

The install includes a **PostToolUse hook** in `.claude/settings.json` that triggers after every file Edit or Write operation:

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": { "tools": ["Edit", "Write"] },
      "hook": {
        "type": "prompt",
        "prompt": "You just modified code. Remember to update the relevant expertise file..."
      }
    }]
  }
}
```

This makes the "automatic update" behavior truly automatic—Claude is reminded after every code change, not just when it naturally thinks to update.

**Already have hooks?** Merge the Agent Expert hook into your existing `settings.json`, or copy from `.claude/agent-expert-hook.json`.

## Why This Works

**Generic agents**: Execute → Forget → Repeat mistakes

**Agent Expert**: Execute → Learn → Get better

The expertise files persist across sessions. Knowledge compounds. Claude becomes genuinely expert at your codebase.

## Tested

See [docs/test-report.md](docs/test-report.md) for a detailed test showing the learning loop in action.

**Summary**: After two code changes, the expertise file contained documented patterns that made the second change faster than the first. The learning loop works.

## License

MIT
