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

## Usage Example

```
You: /init-expert database

Claude: [Explores codebase, creates experts/database.md]

You: /plan Add a session-based counter to track user visits

Claude: [Reads experts/database.md, creates detailed plan]

You: /build

Claude: [Executes plan, tracks all changes]

You: /self-improve

Claude: [Updates experts/database.md with new knowledge]
```

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
