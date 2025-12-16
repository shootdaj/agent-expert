---
description: Create a plan for a task, loading expertise first
arguments:
  - name: task
    description: The task to plan
    required: true
---

# Plan Phase - Agent Expert Workflow

## Task: $ARGUMENTS.task

## Step 1: Load Mental Model

First, identify and read the relevant expertise file(s) for this task. Check `experts/` for domain-specific files.

If the relevant expertise file exists, read it now and use it to inform your planning.

If no relevant expertise file exists, note that you'll need to create one during the self-improve phase.

## Step 2: Validate Against Codebase

Before planning, verify your understanding by checking the actual codebase:
- Confirm file locations mentioned in expertise are accurate
- Verify patterns are still in use
- Check for any recent changes that might affect the task

## Step 3: Create the Plan

Now create a detailed plan with this structure:

```markdown
## Plan: {Task Summary}

### Expertise Used
- Read from: {expertise files consulted}
- Key insights applied: {relevant patterns/knowledge used}

### Context
{Current state of relevant parts of the codebase}

### Steps
1. {Step description}
   - Files: {files to create/modify}
   - Validation: {how to verify this step worked}

2. {Continue for each step...}

### Risks & Mitigations
- Risk: {what could go wrong}
  Mitigation: {how to handle it}

### Success Criteria
- [ ] {How we know the task is complete}

### Notes for Self-Improve Phase
- New patterns to document: {any new approaches}
- Expertise gaps found: {things the expertise file was missing}
```

## Step 4: Output

Present the plan and wait for approval before proceeding to `/build`.
