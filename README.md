# skills

My Claude Code Agent skills.

## Setup

```sh
./setup.sh            # symlink into ~/.claude/skills (edits are live)
./setup.sh --copy     # copy instead
```

Safe to re-run. Leaves skills it doesn't own alone.

## The skills

| Skill | What it does |
|---|---|
| `grill-me` | Adversarial interview to sharpen a plan. |
| `to-spec` | Conversation -> `docs/specs/<slug>/spec.md`. |
| `to-tickets` | Spec -> vertical-slice tickets at `docs/specs/<slug>/tickets/NN-*.md`. |
| `implement` | Build a ticket: TDD, lint, tests, review, commit. |
| `tdd` | The red/green method: seams, good tests, anti-patterns. |
| `ralph-report` | Post-run report built from git, not the agent's claims. |
| `pr-review` | Review a GitHub PR; real blockers only. Needs `gh`. |

Flow: `/to-spec` -> `/to-tickets` -> build -> `/ralph-report`. Build is either
`/implement` by hand or an autonomous loop over the tickets (see ralph-loop,
which reads the `docs/specs/` layout but doesn't need these installed).


## Adding a skill

Add `<name>/SKILL.md`, re-run `./setup.sh`.

## Thanks

Thanks to Matt for creating and sharing his awesome set of skills.
Inspired by [Matt Pocock's skills repo](https://github.com/mattpocock/skills).
