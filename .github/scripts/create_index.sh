#!/bin/sh

IFS=$'\n'
echo '<!doctype html><html lang="en"><head><meta charset="utf-8"><title>Available Resources</title></head><body><h1>Available Resources</h1>'
for odd_file in odd/*.odd; do
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
