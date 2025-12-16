# Agent Expert

A self-improving agent architecture for **Claude Code** that executes and learns, automatically storing and reusing expertise at runtime.

> **This repo is a template.** Copy these files into your actual projects to make Claude Code learn and become expert at your codebase.

## How to Use

### Step 1: Install in Your Project

Run this in your project directory:

```bash
curl -sL https://raw.githubusercontent.com/shootdaj/agent-expert/main/install.sh | bash
```

This adds the Agent Expert files to your project. Works whether or not Claude Code is already initialized.

Then start Claude Code:

```bash
claude
```

### Step 2: Initialize Expertise (Once Per Domain)

Before working on a domain, create an expertise file:

```
/init-expert database
/init-expert auth
/init-expert websocket
```

Claude explores the codebase and creates `experts/{domain}.md` with:
- Key file locations
- Patterns and conventions found
- Architecture overview
- Dependencies

### Step 3: The Task Workflow

For every code change:

```
┌────────────────────────────────────────────────────────────┐
│ 1. PLAN                                                    │
│                                                            │
│    /plan Add rate limiting to the login endpoint           │
│                                                            │
│    Claude reads the relevant expertise file FIRST,         │
│    then creates a plan using accumulated knowledge.        │
└────────────────────────────────────────────────────────────┘
                            ↓
┌────────────────────────────────────────────────────────────┐
│ 2. BUILD & LEARN                                           │
│                                                            │
│    /build                                                  │
│                                                            │
│    Claude executes the plan, then AUTOMATICALLY            │
│    updates the expertise file with what was learned.       │
│    No separate command needed - learning is built in.      │
└────────────────────────────────────────────────────────────┘
```

### Example Session

```
You: /init-expert api

Claude: I'll explore the API domain in this codebase...

        Found:
        - Routes in src/api/routes/
        - Middleware in src/api/middleware/
        - Auth handling in src/api/routes/auth.ts

        Created experts/api.md with this knowledge.

You: /plan Add rate limiting to the login endpoint

Claude: I've read experts/api.md. Based on my knowledge:
        - Routes are in src/api/routes/
        - Middleware pattern: create in middleware/, import in route
        - Auth routes are in src/api/routes/auth.ts

        ## Plan: Add Rate Limiting to Login

        ### Steps
        1. Create src/api/middleware/rate-limiter.ts
        2. Import and apply to login route in auth.ts
        3. Add tests for rate limit behavior

        Ready to proceed?

You: /build

Claude: Executing plan...

        ✓ Created src/api/middleware/rate-limiter.ts
        ✓ Modified src/api/routes/auth.ts - added rate limiter
        ✓ Added tests in src/api/__tests__/rate-limit.test.ts

        ## Build & Learn Complete

        ### Built
        - Rate limiting middleware for login endpoint

        ### Learned (updated experts/api.md)
        - Added rate-limiter.ts to middleware section
        - Added rate limiting pattern with code example
        - Added gotcha: "Redis required for distributed rate limiting"
```

That's it. Two commands: `/plan` then `/build`. Learning happens automatically.

### The Learning Loop

Each `/build` enriches the expertise file. Over time:

```
Session 1: experts/api.md has basic structure
Session 5: experts/api.md knows all routes, middleware patterns
Session 10: experts/api.md is comprehensive - gotchas, edge cases, examples
```

The agent becomes genuinely expert at your codebase.

---

## Why Agent Expert?

### The Problem

Generic agents execute and forget. Every session starts fresh, leading to:
- Repeated mistakes
- Loss of accumulated knowledge
- Inability to become truly expert at a domain

### The Solution

An Agent Expert maintains persistent **expertise files** - its mental model of the problem space. These evolve through use, making the agent genuinely better over time.

### Why This Works

1. **Persistent Memory**: Knowledge survives across sessions
2. **Validated Learning**: Every update is checked against actual code
3. **Forced Reflection**: The self-improve step makes learning explicit
4. **Compounding Expertise**: Each task makes the agent more capable

> **Key Insight**: The expertise file is NOT the source of truth - the code is. The expertise file is a validated mental model that helps the agent navigate efficiently.

---

## Commands

| Command | Purpose |
|---------|---------|
| `/plan {task}` | Create a plan, loading expertise first |
| `/build` | Execute plan AND auto-update expertise (learning built-in) |
| `/init-expert {domain}` | Create a new expertise file |

---

## Project Structure

```
agent-expert/
├── CLAUDE.md                 # Core Agent Expert instructions
├── .claude/
│   └── commands/
│       ├── plan.md           # /plan command
│       ├── build.md          # /build command
│       ├── self-improve.md   # /self-improve command
│       └── init-expert.md    # /init-expert command
├── experts/
│   ├── _template.md          # Template for new expertise files
│   └── _example-database.md  # Example expertise file
└── README.md
```

---

## The Expertise File

Expertise files are markdown documents that serve as the agent's mental model:

- **Quick Reference** - Key files and common operations
- **Architecture Overview** - How components relate
- **Patterns & Conventions** - Reusable approaches
- **File Locations** - Where things live
- **Gotchas** - Surprises and edge cases
- **Change Log** - History of updates

See `experts/_template.md` for the full structure.

---

## License

MIT
