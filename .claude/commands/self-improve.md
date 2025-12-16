---
description: Update expertise based on recent changes (the learning step)
arguments:
  - name: domain
    description: The domain expertise file to update (optional, will auto-detect)
    required: false
---

# Self-Improve Phase - Agent Expert Workflow

## Purpose

This step prevents forgetting. You are syncing your mental model with what was just built.

## Step 1: Gather Changes

Get the git diff to see exactly what changed:

```bash
git diff HEAD~1  # or git diff if uncommitted
```

Review the changes and your build notes from the previous phase.

## Step 2: Identify the Target Expertise File

Domain: $ARGUMENTS.domain (or auto-detect from the files changed)

Read the current expertise file: `experts/{domain}.md`

If no expertise file exists for this domain, create one using `experts/_template.md`.

## Step 3: Analyze What Was Learned

From the changes, extract learnings in these categories:

| Category | Questions to Answer |
|----------|---------------------|
| **File Locations** | Any new files the expert should know about? |
| **Patterns** | Any reusable patterns worth documenting? |
| **Gotchas** | Any surprises or edge cases encountered? |
| **Relationships** | New dependencies between components? |
| **Corrections** | Anything in the expertise file that was wrong? |

## Step 4: Update the Expertise File

Apply updates to `experts/{domain}.md`:

### Adding New Knowledge

Add to the appropriate section with this format:

```markdown
### {Topic}
**Added**: {today's date}
**Source**: {brief description of task}

{Description}

**Example**:
```{language}
{concrete code example from what was just built}
```

**When to Use**: {guidance}
**Pitfalls**: {common mistakes to avoid}
```

### Updating Existing Knowledge

If something in the expertise file was inaccurate, fix it and note the change.

### Removing Obsolete Knowledge

If code was deleted or patterns changed, remove or update the outdated information.

### Update the Change Log

Add an entry to the Change Log section:

```markdown
| {date} | {what changed} | {task name} |
```

## Step 5: Output Summary

```markdown
## Self-Improvement Complete

### Expertise File Updated
`experts/{domain}.md`

### Knowledge Added
- {New item 1}
- {New item 2}

### Knowledge Updated
- {Updated item}: {what changed}

### Knowledge Removed
- {Removed item}: {why obsolete}

### Expertise Health
- Sections: {count}
- Last updated: {today}
- Confidence: {low/medium/high based on coverage}
```

## Remember

> The goal is to make the next task easier. Every update should help future-you navigate the codebase faster and make better decisions.
