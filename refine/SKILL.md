---
name: refine
description: "Use at the end of a work session, or when the user says \"refine\". Keeps docs/ short and current: deletes finished or superseded content, folds this session's durable knowledge into its owning doc, and holds the folder to its file budget. Maintains the docs/ set that /ranger creates; run /ranger first if there is no docs/ yet."
---

<!-- Runs INLINE in the main conversation (no `context: fork`) — it needs this
     session's history to know what changed. Do not convert to a forked skill. -->

# /refine — session-end docs refresh

`docs/` is a wiki someone chooses to read, not a project log. Do the steps in order.
Only touch a doc whose knowledge changed this session.

## The governing rule

**Docs record current state, not how you got there.** Rewrite entries in place —
never append a status line, a dated update, or a "previously we…" paragraph. Delete
the sequence of intermediate states; keep, as one line, any constraint that stops
someone redoing a dead end. Git holds the history: no strikethrough, no tombstones.

## 1. Retire what is finished

Remove what no longer earns its place, before adding anything.

- **Issue fixed or won't-build → delete the row.** Partly done → narrow to what's
  left, and fix any count the TL;DR quoted.
- **Plan or spec shipped → delete the file**; same for a PRD's `issues/`.
- **Superseded doc → delete or merge** into the doc that replaced it. Two docs on
  one subject is the smell.
- **Work-in-flight notes** (findings dumps, handover notes, code-reading scratch)
  → fold, then delete. Biggest source of unread bulk.

Before deleting, check each line: **could someone do the wrong thing without it?**
Re-attempt a rejected approach, violate a settled constraint, reintroduce a fixed
bug. Yes → keep one line, filed under what it *constrains*, not where it was
decided. Don't ask "is this important" — everything reads as important.

## 2. Promote durable knowledge

For this session's newly-mapped behavior, changed features, and gotchas:

- Write into the **owning** doc, rewriting the affected section rather than
  appending. Prefer editing over creating.
- Terse: what it does now, what bites, what to do. No chronology, no restating
  what the code plainly says.
- Mark inferred claims `(unverified)` inline, not as a doc banner.

## 3. Enforce the budget

**`docs/` = the core 6, plus at most one doc per business module.** The ceiling is
derived from the codebase, not chosen — but it is a ceiling, never a quota. Most
modules need no doc at all.

A module earns a doc only if someone would **get it wrong without one**: non-obvious
rules, external contracts, hard-won gotchas. Code organization never earns one — a
directory named for a code role rather than a domain: shared helpers, UI primitives,
routing, config, generated code, migrations, build output, fixtures — however large.
If you can't name the trap the doc prevents, don't write it.

The core 6 are identical in every project — don't rename them, don't add to the set:

| File | Owns |
|---|---|
| `README.md` | Router: one line per doc. No status column, no dates |
| `architecture.md` | System map, boundaries, modeling stance |
| `data-model.md` | Persistence: schema, access rules, denorm, query traps |
| `conventions.md` | Code bar: aliases, boundaries, validation, lint, repeated traps |
| `deployment.md` | Envs, deploy steps, guardrails, rollback |
| `master-issue-list.md` | Open debt, prioritized |

Domain docs are named for their module, and **deleted when that module is** —
migration finishes, migration docs go. A doc with no module is a doc with no owner.

- **Over ~120 lines** → split, cut, or link out. Report any still over, and why.
- **Sections before files.** Two docs for one module is the smell: merge them.
  Over budget → merge or delete first, and say which.
- **Splitting a module's doc is not a workaround.** One module, one doc; if it
  won't fit in ~120 lines, cut content, don't add a file.
- **Nothing time-bound in `docs/`** — in-flight work lives in `specs/` at the root.
- **Added or deleted a doc?** Update `README.md` so the router matches the folder.

## Rules

- Follow the repo's `CLAUDE.md` (validation/write discipline).
- Deleting is the point, not a risk — git is the backup. But confirm before
  deleting a whole file, and list what you're removing.
- Finish with 3–5 lines: what was deleted, what moved, net line change.
