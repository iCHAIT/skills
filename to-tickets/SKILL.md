---
name: to-tickets
description: Break a plan, spec, or the current conversation into independently-grabbable tickets using tracer-bullet vertical slices.
disable-model-invocation: true
---

# To Tickets

Break a plan, spec, or conversation into independently-grabbable tickets using vertical slices (tracer bullets).

## Process

### 1. Gather context

Work from whatever is already in the conversation context. If the user passes a reference (a spec file path, issue number, or URL) as an argument, read its full body first.

### 2. Explore the codebase (optional)

If you have not already explored the codebase, do so to understand the current state of the code. Issue titles and descriptions should use the project's domain vocabulary, and respect ADRs in the area you're touching.

Look for opportunities to prefactor the code to make the implementation easier. "Make the change easy, then make the easy change."

### 3. Draft vertical slices

Break the plan into **tracer bullet** tickets. Each issue is a thin vertical slice that cuts through ALL integration layers end-to-end, NOT a horizontal slice of one layer.

<vertical-slice-rules>

- Each slice delivers a narrow but COMPLETE path through every layer (schema, API, UI, tests)
- A completed slice is demoable or verifiable on its own
- Any prefactoring should be done first

</vertical-slice-rules>

### 4. Quiz the user

Present the proposed breakdown as a numbered list. For each slice, show:

- **Title**: short descriptive name
- **Type**: `AFK` (an autonomous agent can complete it end-to-end unattended) or `HITL` (needs a human in the loop — ambiguous requirements, risky/irreversible steps, or a judgement call). Default to `AFK`; mark `HITL` only when a human genuinely must intervene.
- **Blocked by**: which other slices (if any) must complete first
- **User stories covered**: which user stories this addresses (if the source material has them)

Ask the user:

- Does the granularity feel right? (too coarse / too fine)
- Are the dependency relationships correct?
- Should any slices be merged or split further?

Iterate until the user approves the breakdown.

### 5. Write the tickets to local files

Co-locate the tickets with their spec. If the source was a spec at `specs/<slug>/spec.md`, write the tickets to `specs/<slug>/tickets/NN-<issue-slug>.md`, reusing that same `<slug>` folder (ask if a different location is wanted). If there is no parent spec, ask the user for a `<slug>` for this piece of work and use `specs/<slug>/tickets/`. Number `NN` in dependency order. Use the ticket body template below.

Write tickets in dependency order (blockers first) so the "Blocked by" field can reference the real file names / numbers.

The `Type` line is what a Ralph loop keys on: an AFK loop works only `Type: AFK` tickets and skips `Type: HITL` ones. Every issue starts `Status: Open`; the loop flips it to `Completed` once it observes the slice's commit land (the loop maintains this from git — the implementing agent must never edit it).

<issue-template>
## Parent

A reference to the parent spec or issue. When tickets are co-located under `specs/<slug>/tickets/`, this is the relative path `../spec.md`. Omit this section only if there was no source file/issue.

- **Type**: AFK or HITL
- **Status**: Open

## What to build

A concise description of this vertical slice. Describe the end-to-end behavior, not layer-by-layer implementation.

Avoid specific file paths or code snippets — they go stale fast. Exception: if a prototype produced a snippet that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape), inline it here and note briefly that it came from a prototype. Trim to the decision-rich parts — not a working demo, just the important bits.

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2

## Blocked by

- A reference to the blocking issue (if any)

Or "None - can start immediately" if no blockers.

</issue-template>

Do NOT close or modify any parent issue or spec.
