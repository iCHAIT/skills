#!/bin/sh
# Link every skill in this repo into ~/.claude/skills. Safe to re-run.
#   --copy   copy instead of symlinking (no live edits, no repo dependency)
DIR=$(cd "$(dirname "$0")" && pwd)
TARGET="$HOME/.claude/skills"

mkdir -p "$TARGET"

for skill in "$DIR"/*/; do
	name=$(basename "$skill")
	[ -f "$skill/SKILL.md" ] || continue
	if [ "$1" = "--copy" ]; then
		rm -rf "$TARGET/$name"
		cp -R "$skill" "$TARGET/$name"
	else
		# -n so re-running replaces the link instead of nesting inside it
		ln -sfn "$skill" "$TARGET/$name"
	fi
	echo "  $name"
done

echo "Done. Skills are in $TARGET - check with /help in Claude Code."
