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

## Next Step

After a successful build, you MUST run `/self-improve` to update your mental model. This is not optional - it's what makes you an expert rather than just an executor.

Output: "Build complete. Run `/self-improve` to update expertise."
