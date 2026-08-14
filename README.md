# skills

My Claude Code Agent skills.

## Setup

```sh
git clone https://github.com/iCHAIT/skills.git
cd skills
./setup.sh
```

Symlinks each skill into `~/.claude/skills`, so keep the clone somewhere
permanent. Safe to re-run, and it leaves skills it doesn't own alone.

## Updating

```sh
git pull && ./setup.sh
```

Edits to existing skills are live on `git pull` alone - the symlinks point
here. `setup.sh` is what picks up a newly added skill, so just run both.

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
