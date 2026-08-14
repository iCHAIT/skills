# skills

Claude Code skills, versioned to stay in sync across machines. Each directory is
one skill (`SKILL.md` with `name`/`description` frontmatter), invoked as
`/<name>`.

## Setup

```sh
./setup.sh            # symlink into ~/.claude/skills (edits are live)
./setup.sh --copy     # copy instead
```

Safe to re-run. Leaves skills it doesn't own alone.

## The skills

| Skill | What it does |
|---|---|
| `to-spec` | Conversation -> `docs/specs/<slug>/spec.md`. |
| `to-tickets` | Spec -> vertical-slice tickets at `docs/specs/<slug>/tickets/NN-*.md`. |
| `implement` | Build a ticket: TDD, lint, tests, review, commit. |
| `tdd` | The red/green method: seams, good tests, anti-patterns. |
| `ralph-report` | Post-run report built from git, not the agent's claims. |
| `grill-me` | Adversarial interview to sharpen a plan. |
| `pr-review` | Review a GitHub PR; real blockers only. |

Flow: `/to-spec` -> `/to-tickets` -> build -> `/ralph-report`. Build is either
`/implement` by hand or an autonomous loop over the tickets (see ralph-loop,
which reads the `docs/specs/` layout but doesn't need these installed).

## Ticket contract

```markdown
## Parent

../spec.md

- **Type**: AFK
- **Status**: Open
```

`AFK` = an agent can finish it unattended; `HITL` = needs a human. `Status` is
the ledger, maintained by whoever runs the build - the implementing agent never
edits it. Full format spec: ralph-loop README.

## Adding a skill

Add `<name>/SKILL.md`, re-run `./setup.sh`. Set
`disable-model-invocation: true` to make it `/<name>`-only.
