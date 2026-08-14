#!/bin/sh
# Link every skill in this repo into ~/.claude/skills. Safe to re-run.
DIR=$(cd "$(dirname "$0")" && pwd)
TARGET="$HOME/.claude/skills"

mkdir -p "$TARGET"

for skill in "$DIR"/*/; do
	name=$(basename "$skill")
	[ -f "$skill/SKILL.md" ] || continue
	# -n so re-running replaces the link instead of nesting inside it
	ln -sfn "$skill" "$TARGET/$name"
	echo "  $name"
done

echo "Done. Skills are in $TARGET - check with /help in Claude Code."
