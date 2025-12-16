---
description: Create a new expertise file for a domain
arguments:
  - name: domain
    description: The domain to create expertise for (e.g., database, auth, websocket)
    required: true
---

# Initialize New Expert

## Domain: $ARGUMENTS.domain

## Step 1: Check if Expertise Exists

Check if `experts/$ARGUMENTS.domain.md` already exists. If it does, read it and offer to update it instead.

## Step 2: Explore the Domain

Before creating the expertise file, explore the codebase to understand this domain:

1. **Find relevant files**: Search for files related to $ARGUMENTS.domain
2. **Understand structure**: How is this domain organized?
3. **Identify patterns**: What conventions are used?
4. **Find entry points**: Where does code for this domain start?
5. **Map dependencies**: What does this domain depend on?

## Step 3: Create the Expertise File

Create `experts/$ARGUMENTS.domain.md` using the template from `experts/_template.md`.

Fill in what you've learned:

- **Quick Reference**: Key files and common operations
- **Architecture Overview**: How components relate
- **Patterns & Conventions**: Reusable approaches found
- **File Locations**: Where things live
- **Gotchas**: Any surprises encountered during exploration
- **Dependencies**: Internal and external dependencies

## Step 4: Set Initial Expertise Level

Based on exploration depth:
- **novice**: Basic structure understood, gaps remain
- **intermediate**: Good coverage, some areas unexplored
- **expert**: Comprehensive understanding

New expertise files typically start at `novice` and improve through use.

## Step 5: Output Summary

```markdown
## New Expert Created

**File**: `experts/$ARGUMENTS.domain.md`
**Expertise Level**: {level}

### Documented
- {count} key files
- {count} patterns
- {count} common operations

### Gaps to Fill
- {area needing more exploration}
- {area needing more exploration}

The expertise file will improve as you work on $ARGUMENTS.domain tasks and run `/self-improve`.
```
