# Agent Expert

A self-improving agent architecture for **Claude Code** that executes and learns, automatically storing and reusing expertise at runtime.

## The Problem

Generic agents execute and forget. Every session starts fresh, leading to:
- Repeated mistakes
- Loss of accumulated knowledge
- Inability to become truly expert at a domain

## The Solution

An Agent Expert maintains persistent **expertise files** - its mental model of the problem space. These evolve through use, making the agent genuinely better over time.

## How It Works

### The Three-Step Workflow

Every code change task follows this mandatory workflow:

```
┌─────────┐    ┌─────────┐    ┌──────────────┐
│  PLAN   │ -> │  BUILD  │ -> │ SELF-IMPROVE │
└─────────┘    └─────────┘    └──────────────┘
     │              │                │
     v              v                v
  Load mental    Execute &      Update mental
  model first    track work     model after
```

### Commands

| Command | Purpose |
|---------|---------|
| `/plan {task}` | Create a plan, loading expertise first |
| `/build` | Execute the plan, tracking changes |
| `/self-improve` | Update expertise based on what was built |
| `/init-expert {domain}` | Create a new expertise file |

## Installation

1. Clone this repo into your project or use it as a template
2. Claude Code will automatically read `CLAUDE.md` and gain Agent Expert behavior
3. Start using the commands

```bash
# Clone as a submodule
git submodule add https://github.com/yourusername/agent-expert .agent-expert

# Or copy the files directly
cp -r agent-expert/{CLAUDE.md,.claude,experts} your-project/
```

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

## How to Use

### Step 1: Setup

**Option A: Use in this repo directly**
```bash
cd agent-expert
claude  # Start Claude Code here
```

**Option B: Add to an existing project**
```bash
cp -r agent-expert/{CLAUDE.md,.claude,experts} your-project/
cd your-project
claude
```

Claude Code automatically reads `CLAUDE.md` on startup, gaining Agent Expert behavior.

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

For every code change, follow the three-step workflow:

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
│ 2. BUILD                                                   │
│                                                            │
│    /build                                                  │
│                                                            │
│    Claude executes the plan, tracking all changes,         │
│    decisions made, and patterns used.                      │
└────────────────────────────────────────────────────────────┘
                            ↓
┌────────────────────────────────────────────────────────────┐
│ 3. SELF-IMPROVE                                            │
│                                                            │
│    /self-improve                                           │
│                                                            │
│    Claude updates the expertise file with:                 │
│    - New patterns discovered                               │
│    - New file locations                                    │
│    - Gotchas encountered                                   │
│    - Corrections to outdated info                          │
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

        Build complete. Run /self-improve to update expertise.

You: /self-improve

Claude: Updating experts/api.md...

        ## Self-Improvement Complete

        ### Knowledge Added
        - rate-limiter.ts added to middleware section
        - Rate limiting pattern with code example
        - New gotcha: "Redis required for distributed rate limiting"

        ### Change Log Updated
        | 2024-12-16 | Added rate limiting pattern | Login security task |
```

### The Learning Loop

Each `/self-improve` enriches the expertise file. Over time:

```
Session 1: experts/api.md has basic structure
Session 5: experts/api.md knows all routes, middleware patterns
Session 10: experts/api.md is comprehensive - gotchas, edge cases, examples
```

The agent becomes genuinely expert at your codebase.

## The Expertise File

Expertise files are markdown documents that serve as the agent's mental model:

- **Quick Reference** - Key files and common operations
- **Architecture Overview** - How components relate
- **Patterns & Conventions** - Reusable approaches
- **File Locations** - Where things live
- **Gotchas** - Surprises and edge cases
- **Change Log** - History of updates

See `experts/_template.md` for the full structure.

## Key Insight

> The expertise file is NOT the source of truth - the code is. The expertise file is a validated mental model that helps the agent navigate efficiently.

## Why This Works

1. **Persistent Memory**: Knowledge survives across sessions
2. **Validated Learning**: Every update is checked against actual code
3. **Forced Reflection**: The self-improve step makes learning explicit
4. **Compounding Expertise**: Each task makes the agent more capable

## License

MIT
