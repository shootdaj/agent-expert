# Agent Expert

A self-improving agent architecture for **Claude Code** that executes and learns automatically.

> **This repo is a template.** Add these files to your project and Claude Code automatically learns as it works.

## Install

Run this in your project:

```bash
curl -sL https://raw.githubusercontent.com/shootdaj/agent-expert/main/install.sh | bash
```

Already have a `CLAUDE.md`? No problem - it appends to your existing file.

That's it. Start Claude Code and it will automatically:

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

## What Gets Created

```
your-project/
├── CLAUDE.md                 # Makes Claude behave as an Agent Expert
├── .claude/commands/         # Optional explicit commands
│   ├── plan.md
│   ├── build.md
│   └── init-expert.md
└── experts/
    ├── _template.md          # Template for new expertise files
    └── {domain}.md           # Expertise files (created as you work)
```

## Optional Commands

Normal conversation handles everything, but these exist for explicit control:

| Command | Purpose |
|---------|---------|
| `/init-expert {domain}` | Create expertise file for a new domain |
| `/plan {task}` | Explicitly plan before building |
| `/build` | Explicitly build with auto-learning |

## Why This Works

**Generic agents**: Execute → Forget → Repeat mistakes

**Agent Expert**: Execute → Learn → Get better

The expertise files persist across sessions. Knowledge compounds. Claude becomes genuinely expert at your codebase.

## License

MIT
