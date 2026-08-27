---
name: ralph-report
description: After a Ralph loop (or any autonomous agent run) finishes, report what actually changed — built from git, not the agent's own claims. Verdict-first: blockers, how-to-test, and deviations from the spec/tickets.
disable-model-invocation: true
---

Report what an autonomous run **actually did**, then how it **diverged from the plan**. Run after a Ralph loop or any batch of agent commits.

**Trust git, not the agent.** Its "done" checklist omits side-effects (broken lockfile, silent-fail path, unhandled case). Every claim must come from the diff, commits, or a check you ran — not from what the agent said. If you can't confirm it, mark it "unverified". Reference artifacts (spec, tickets, diffs) by path, don't restate them. Redact secrets and PII.

## Gather

1. **Range.** Use the base the user names (`git diff <base>...HEAD`, `git log <base>..HEAD`); else infer from merge-base and confirm. Also capture uncommitted changes (`git status --short`, `git diff`) — collateral like rewritten lockfiles hides there.
2. **Spec.** A piece of work lives under `specs/<slug>/` — `spec.md` beside its `tickets/NN-*.md`. Resolve the spec from the tickets' `## Parent` field (each ticket written by `to-tickets` names its parent, typically `../spec.md`); scope to the tickets the diff actually touches. Fall back to matching branch name / diff content against `specs/*/spec.md` only if no Parent field exists. State which spec and tickets you resolved to. If none, skip deviations and say so.
3. **Ledger cross-check.** Three sources should agree: tickets marked `Status: Completed`, the feature's slice commits (subjects matching `<slug> (NN):`), and the diff. Any mismatch is a finding — a `Completed` ticket with no matching commit (ledger lied / work lost), or a slice commit whose ticket is still `Open` (loop crashed after committing, status never flipped). Build the done-set from the **commits**, not the Status fields — the ledger is a cache and can be stale.
4. **Verify.** Run the project's tests and lint; report real numbers. Separate failures this run caused from pre-existing ones.
5. **Uncommitted slice work.** A slice is done only when committed; a run that built code but crashed before committing leaves a ticket `Open` with orphan files in the working tree or a stash. For every `Open` slice, check whether partial code for it already exists (tree or `git stash list`) — flag it, since it is invisible to the commit history and easy to lose or double-build.
6. **Legacy data.** For code reading stored records, find a real old document and state what happens when the fields the new code expects are absent — check it, don't just note it.

## Report — in this order

**Verdict** — 2-4 lines: safe to merge/deploy or not, then the ranked list of blockers to handle. A busy reader stops here.

**Findings** — one table, most-severe first. Tag each `[BLOCKER]` (handle before merge — security hole, risky spec violation, data loss), `[RISK]` (handle or consciously accept — correctness gap, unrequested behavior, dead code), or `[NOTE]` (lint nit, naming drift, benign side-effect). Mark a row `FIXED` if the deviation was already corrected in the working tree, so open items stand out from resolved ones.

| Sev | Finding | Location | Spec ref | Disposition |
|-----|---------|----------|----------|-------------|

Cover deviations (spec said X, code did Y), scope creep, gaps, and cross-cutting concerns no single ticket owns — security (auth/role checks, data access, PII), legacy-data compatibility, shared files touched by multiple slices, dead/inert code, error handling. Flag only; don't fix.

**Implemented as specified** — one line of the ticket IDs that have a matching slice commit. No detail. If the `Status` ledger disagrees with this commit-derived set, note the discrepancy here in one line.

**Summary** — commits (one line each); files touched grouped by area, filenames only with a few words each, no line counts; call out scope-creep files and config/lockfile/dependency changes.

**Data model** — only if the run added/changed stored fields (Firestore doc, DB column, etc.): list each new field, its **type**, and **where it's read/rendered**. Catches type-mismatch bugs (e.g. a Timestamp rendered by a formatter that expected an ISO string).

**UI & where to see it** — new routes, nav entries, pages/dialogs, each with the screen + role a human sees it in.

**How to test** — step-by-step: screen, role, what to click/enter, what to expect.

**Deploy & preconditions** — if the run touched backend/serverless code (`functions/`, migrations, seeds), state what must be deployed/run before anything works, and name the functions/artifacts. Trace frontend→backend calls to find UI that silently depends on undeployed code.

Print the report; offer to save it to a file, kept out of the committed diff unless asked.
