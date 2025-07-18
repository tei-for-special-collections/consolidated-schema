#!/bin/sh

# This replaces the token(s) that are used to determine word boudaries with an end of line character.
# This gets around issues with filenames that have spaces in them.
# For some reason, '\n' doesn't work in the action like it does in OSX. In OSX, it interprets it as the end of line
# character. In the GitHub Action container, it interprets it as a literal 'n'
IFS=$"
"
rng_name="$(echo "$1"| sed -E 's#\.[^.]*$##g')";
echo "Creating output for ${1}"
$GITHUB_WORKSPACE/tei/bin/teitorng "${1}" "${GITHUB_WORKSPACE}/main/releases/rng/${rng_name}.rng";
java -DentityExpansionLimit=9000000 -jar $GITHUB_WORKSPACE/saxon-he-12.1.jar -xi:on -o:${GITHUB_WORKSPACE}/main/releases/odd/${rng_name}.compiled.odd "$1" $GITHUB_WORKSPACE/tei/odds/odd2odd.xsl
java -DentityExpansionLimit=9000000 -jar $GITHUB_WORKSPACE/saxon-he-12.1.jar -xi:on -o:${GITHUB_WORKSPACE}/main/releases/documentation/${rng_name}.html "${GITHUB_WORKSPACE}/main/releases/odd/${rng_name}.compiled.odd" $GITHUB_WORKSPACE/main/.github/lib/xslt/import-sample.xsl