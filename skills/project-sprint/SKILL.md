---
name: project-sprint
description: "Initializes a new ASTRA sprint. Creates sprint prompt maps and retrospective templates."
argument-hint: "[sprint-number]"
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, AskUserQuestion
---

# ASTRA Sprint Initialization

Creates prompt maps and retrospective templates for a new sprint.

## Execution Procedure

### Step 1: Confirm Sprint Number

Parse the sprint number from `$ARGUMENTS`. If not provided, check existing files in the `docs/prompts/` directory to automatically determine the next number.

### Step 2: Create Sprint Prompt Map

Create the `docs/prompts/sprint-{N}.md` file:

```markdown
# Sprint {N} Prompt Map

## Sprint Goal
[Describe the business value to achieve in this sprint]

## Feature 1: {feature-name}

### 1.1 Design Prompt
/feature-dev "Write the design document for {feature description}
to docs/blueprints/{feature-name}.md.
{detailed requirements}
Refer to docs/database/database-design.md for DB schema.
Do not modify any code yet."

### 1.2 DB Design Reflection Prompt
/feature-dev "Add/update the {module-name} tables in
docs/database/database-design.md:
- {table list}
- Also update the ERD and FK relationship summary. Follow standard terminology dictionary.
Do not modify any code yet."

### 1.3 Test Case Prompt
/feature-dev "Based on the feature requirements in docs/blueprints/{feature-name}.md,
write test cases to docs/tests/test-cases/{feature-name}-test-cases.md.
Use Given-When-Then format, include unit/integration/edge cases.
Do not modify any code yet."

### 1.4 Implementation Prompt
/feature-dev "Strictly follow the contents of docs/blueprints/{feature-name}.md and
docs/database/database-design.md to proceed with development.
Write tests referencing docs/tests/test-cases/{feature-name}-test-cases.md,
and once implementation is complete, run all tests and
report results to docs/tests/test-reports/."

## Feature 2: {feature-name}
{Repeat with the same structure as above}
```

### Step 3: Create Retrospective Template

Create the `docs/retrospectives/sprint-{N}-retro.md` file:

```markdown
# Sprint {N} Retrospective

## Date: {YYYY-MM-DD}

## AI Analysis Data
- code-review recurring issues: [auto-collected]
- security-guidance blocked count: [auto-collected]
- standard-enforcer violation frequency: [auto-collected]

## Team Discussion (areas AI cannot catch)

### What went well (Keep)
-

### What to improve (Problem)
-

### What to try (Try)
-

## Automated Improvement Actions
- /hookify [codify recurring mistakes found in this sprint]
- CLAUDE.md update content: [describe added rules]
```

### Step 4: Output Sprint Planning Guide

```
## Sprint {N} Initialization Complete

### Generated Files
- docs/prompts/sprint-{N}.md (prompt map)
- docs/retrospectives/sprint-{N}-retro.md (retrospective template)

### Sprint Planning Procedure (1 hour)
1. (10 min) Review AI analysis report
2. (20 min) Confirm business priorities with DE and agree on sprint goal
3. (20 min) Discuss prompt design direction per item + DSA shares design direction
4. (10 min) Finalize sprint backlog

### Pre-Planning Preparation (day before Planning, executed by VA)
/feature-dev "Analyze the technical complexity of candidate backlog items for this sprint.
Summarize dependencies with the existing codebase, estimated work scope, and risk factors.
Do not modify any code yet."
```

## Notes

- Existing sprint files are not overwritten.
- The prompt map is filled in collaboratively by VA and PE during the Planning meeting.
