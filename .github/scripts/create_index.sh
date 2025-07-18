#!/bin/sh

# This replaces the token(s) that are used to determine word boudaries with an end of line character.
# This gets around issues with filenames that have spaces in them.
# For some reason, '\n' doesn't work in the action like it does in OSX. In OSX, it interprets it as the end of line
# character. In the GitHub Action container, it interprets it as a literal 'n'
IFS=$"
"
url="https://raw.githubusercontent.com/${GITHUB_REPOSITORY}/refs/heads/main/"
echo "---
permalink: /index.html
---

# The Consolidated Schema

This **Consolidated Schema** is the customized TEI P5 schema used by:

- **The Bodleian Libraries**
  - [Senmai (general MSS)](https://github.com/bodleian/senmai-mss)
  - [Medieval](https://github.com/bodleian/medieval-mss)
  - [Hebrew](https://github.com/bodleian/hebrew-mss)
  - [Genizah](https://github.com/bodleian/genizah-mss)
  - [Georgian](https://github.com/bodleian/georgian-mss)
  - [Armenian](https://github.com/bodleian/armenian-mss)
  - [Tibetan (Karchak)](https://github.com/bodleian/karchak-mss)
- **Cambridge University Library**
  - [CUDL](https://cudl.lib.cam.ac.uk/)
- **Fihrist**
  - [fihrist-mss](https://github.com/fihristorg/fihrist-mss)
- **The University of Manchester**
- **Lancaster University**"
if [ "$BUILD_CORE" = true ]; then
  ODDS_TO_PROCESS=$(find odd -name 'consolidated-schema.odd'; find odd -name '*.odd' -not -name 'consolidated-schema.odd';);
else
  ODDS_TO_PROCESS=$(find odd -name '*.odd' -not -name 'consolidated-schema.odd');
fi
for odd_file in $ODDS_TO_PROCESS; do
	odd_basename=$(basename "${odd_file}" .odd)
	echo "
## ${odd_basename}"
	if [ -f "releases/documentation/${odd_basename}.html" ]; then
	  echo
	  echo "- [Guidelines](releases/documentation/${odd_basename}.html)"
  fi
  if [ -f "releases/rng/${odd_basename}.rng" ]; then
		echo "- [Schema](releases/rng/${odd_basename}.rng)"
    echo "
To
		use this schema, add the following lines just before the \`<TEI>\` element:

\`\`\`
<?xml-model href=\"${url}/releases/rng/${odd_basename}.rng\" type=\"application/xml\" schematypens=\"http://relaxng.org/ns/structure/1.0\"?>
<?xml-model href=\"${url}/releases/rng/${odd_basename}.rng\" type=\"application/xml\" schematypens=\"http://purl.oclc.org/dsdl/schematron\"?>
\`\`\`"
  fi
			done
	echo "
## Development
See [https://github.com/tei-for-special-collections/consolidated-schema](https://github.com/tei-for-special-collections/consolidated-schema) for
more information or to view the core ODD files used to generate the materials on this site."
