---
description: Execute the current plan and track changes for learning
---

# Build Phase - Agent Expert Workflow

## Prerequisites

A plan must exist from the `/plan` phase. If no plan exists, run `/plan {task}` first.

## Execution

Execute the plan step by step, tracking everything for the self-improve phase.

### For Each Step:

1. **Read** relevant files to confirm current state
2. **Execute** the change
3. **Verify** the change works as expected
4. **Log** what was done

### Track Changes

As you build, maintain a mental log of:

**Files Changed:**
- File: {path}
- Action: created / modified / deleted
- Summary: {what changed and why}

**Decisions Made:**
- Decision: {what you decided}
- Rationale: {why this approach}
- Alternatives: {other options considered}

**Patterns Applied:**
- Pattern: {name from expertise file}
- Location: {where applied}

**New Patterns Discovered:**
- Pattern: {description of reusable approach}
- Worth documenting: yes/no
- Rationale: {why this is valuable}

**Expertise File Issues Found:**
- Issue: {inaccuracy or gap in expertise file}
- Correction: {what should be updated}

## Completion

When the build is complete:

1. Verify all success criteria from the plan are met
2. Run tests if applicable
3. Summarize what was built

## Auto Self-Improve (Mandatory)

**Do not stop here.** Immediately proceed to update your expertise:

1. Get the git diff: `git diff` (or `git diff HEAD~1` if committed)
2. Identify the relevant expertise file in `experts/`
3. Update it with:
   - New file locations discovered
   - Patterns used or discovered
   - Gotchas encountered
   - Corrections to outdated information
   - Add entry to Change Log

4. Output a summary:
```
## Build & Learn Complete

### Built
- {summary of what was built}

### Learned (updated experts/{domain}.md)
- {what was added/updated in expertise file}
```

This learning step is automatic - never skip it.
