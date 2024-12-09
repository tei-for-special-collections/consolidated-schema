#!/bin/sh

# This replaces the token(s) that are used to determine word boudaries with an end of line character.
# This gets around issues with filenames that have spaces in them.
# For some reason, '\n' doesn't work in the action like it does in OSX. In OSX, it interprets it as the end of line
# character. In the GitHub Action container, it interprets it as a literal 'n'
IFS=$"
"
echo '<!doctype html><html lang="en"><head><meta charset="utf-8"><title>Available Resources</title></head><body><h1>Available Resources</h1>'
if [ "$BUILD_CORE" = true ]; then
  ODDS_TO_PROCESS=$(find . -name '*.odd' -exec basename {} ".odd" \;);
else
  ODDS_TO_PROCESS=$(find . -name '*.odd' -not -name 'consolidated-schema.odd' -exec basename {} ".odd" \;);
fi
for odd_file in $ODDS_TO_PROCESS; do
	odd_basename=$(basename "${odd_file}" .odd)
	echo "<h2>${odd_basename}</h2>"
	if [ -f "documentation/${odd_basename}.html" -o -f "rng/${odd_basename}.rng" ]; then
		echo "<ul>"
		for resource in "documentation/${odd_basename}.html" "rng/${odd_basename}.rng"; do
			echo '<li><a href="'"${resource}"'">'"${resource}"'</a></li>'
		done
		echo '</ul>'
	fi
done
echo '</body></html>'
