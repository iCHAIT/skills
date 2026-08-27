---
name: ranger
description: Use once, on first touching an existing codebase that has no docs/. Surveys the repo with parallel subagents and writes the standard docs/ set - mapping verifiable structure only, leaving judgment calls as empty headings for a human. One-time bootstrap; /refine maintains from there and ranger is not run again.
disable-model-invocation: true
---

# /ranger — codebase survey

**Runs once**, when first picking up a codebase with no `docs/`. From then on
`/refine` owns these files. Do not re-run to refresh a stale folder — that would
overwrite human-written judgment with a structure-only pass.

## The governing rule

**Map the wiring. Never infer the reasoning.** Every claim carries a `file:line`.
Cannot cite it → cannot write it; leave the heading empty and report it.

Docs record current state. No chronology, no dated updates.

| Write it | Leave empty |
|---|---|
| Where durable state lives, and its declared shape | Why a module exists, what it is "responsible for" |
| Scheduled work: name, schedule, entry point | Architectural stance, trade-offs, rationale |
| Event handlers: what fires them, what they watch | Gotchas, footguns, "what bites" |
| Entry points, and the auth check on each | Everything in `master-issue-list.md` |
| Environments, build/run commands, env switches | Deploy guardrails and rollback |
| Duplicated state and who writes it | Which of two paths is the "right" one |

**Never infer a guardrail.** Which environment is safe to deploy to, what must never
be touched, what is destructive — these are consequences, not code facts. Leave them
empty **even when a config file makes the answer look obvious**; that is exactly when
the guess is wrong, and a wrong guardrail carrying a `file:line` reads as verified.

No prose descriptions of behavior. Tables over paragraphs.

## 1. Scope

- **Identify the stack** from the dependency manifest, lockfile, and build/CI config:
  languages, frameworks, how state persists, how background work runs, how it serves.
  Read, don't assume — every agent below depends on this.
- **Read the repo's own instructions** (`CLAUDE.md`, `AGENTS.md`, `README.md`). They
  outrank this skill.
- **Derive this repo's not-a-module list.** Not a module if named for a code role
  rather than a domain: shared helpers, UI primitives, routing, config, generated
  code, migrations, build output, fixtures.
- **List candidate modules.** The test: name the business rule it owns. Cannot →
  not a module, however large.
- **`docs/` non-empty → stop and ask** before overwriting.

Report the stack summary and module list before proceeding.

## 2. Fan out

Spawn `Explore` agents in a **single message**. Each gets one question, the stack
summary from step 1, and the template to fill. Never an open brief.

Every prompt carries verbatim:

> Return only what you can cite with `file:line`. If you cannot cite a claim, omit it.
> Do not describe what code does in prose; fill the template's tables. Do not infer
> intent, rationale, or safety. Return the filled template and nothing else.

The questions below, phrased in the stack's own terms. **Skip any the stack lacks**,
and scale the count to the repo — a small codebase may warrant two agents or one.

| Agent | Returns | Lands in |
|---|---|---|
| Persistence | Where durable state lives, declared shape, duplicated state + writers | `data-model.md` |
| Scheduled work | Name, schedule, entry point, configured resource limits | `deployment.md` |
| Event handlers | Name, what fires it, what it watches, entry point | `architecture.md` |
| Entry points | Externally reachable surface, auth check on each, `file:line` | `architecture.md` |
| Build & env | Environments, switch mechanism, build/run/test/lint commands | `deployment.md` |
| Conventions | Only what tooling enforces — linter, formatter, type checker, hooks | `conventions.md` |
| Model & prompt surface | Model identifiers and where pinned, prompt/template locations, tool and function definitions, eval sets, retrieval indexes | `architecture.md` |

Plus one per business module: its paths, entry points, and which persistence
locations it reads and writes. A module may span languages — a domain with a
backend and a frontend half is one module and one agent, not two.

## 3. Assemble

The core 6 — don't rename, don't add:

| File | Owns |
|---|---|
| `README.md` | Router: one line per doc |
| `architecture.md` | System map, boundaries, modeling stance |
| `data-model.md` | Persistence: schema, access rules, denorm, query traps |
| `conventions.md` | Code bar: aliases, boundaries, validation, lint, repeated traps |
| `deployment.md` | Envs, deploy steps, guardrails, rollback |
| `master-issue-list.md` | Open debt, prioritized |

Plus at most one doc per module that earns one — most don't.

- Agent output goes in **as returned**; re-summarizing reintroduces prose.
- `master-issue-list.md` gets one `## From the survey` section: what the agents
  observed, cited, **unranked and unlabelled** — no severity, no ordering. Leave the
  rest of the file empty for the user's own entries.
- `architecture.md`'s stance section stays empty.
- **~120 lines per doc.** Over → cut, don't split. One module, one doc.
- `README.md` matches the folder exactly.

## 4. Report

Files written with line counts; **every empty heading, by file** (the human's to-do
list); anything agents flagged as uncitable or contradictory; modules rejected, one
line each.

## Rules

- Follow the repo's `CLAUDE.md`.
- Read-only against source. Writes `docs/` and nothing else.
- Unsure whether something is structure or judgment? It's judgment. Leave it.
