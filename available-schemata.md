---
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
- **Lancaster University**

## consolidated-schema

- [Guidelines](releases/documentation/consolidated-schema.html)
- [Schema](releases/rng/consolidated-schema.rng)

To
		use this schema, add the following lines just before the `<TEI>` element:

```
<?xml-model href="https://raw.githubusercontent.com/tei-for-special-collections/consolidated-schema/refs/heads/main/releases/rng/consolidated-schema.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="https://raw.githubusercontent.com/tei-for-special-collections/consolidated-schema/refs/heads/main/releases/rng/consolidated-schema.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
```

## manuscripts-catalogue

- [Guidelines](releases/documentation/manuscripts-catalogue.html)
- [Schema](releases/rng/manuscripts-catalogue.rng)

To
		use this schema, add the following lines just before the `<TEI>` element:

```
<?xml-model href="https://raw.githubusercontent.com/tei-for-special-collections/consolidated-schema/refs/heads/main/releases/rng/manuscripts-catalogue.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="https://raw.githubusercontent.com/tei-for-special-collections/consolidated-schema/refs/heads/main/releases/rng/manuscripts-catalogue.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
```

## cdcp

- [Guidelines](releases/documentation/cdcp.html)
- [Schema](releases/rng/cdcp.rng)

To
		use this schema, add the following lines just before the `<TEI>` element:

```
<?xml-model href="https://raw.githubusercontent.com/tei-for-special-collections/consolidated-schema/refs/heads/main/releases/rng/cdcp.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="https://raw.githubusercontent.com/tei-for-special-collections/consolidated-schema/refs/heads/main/releases/rng/cdcp.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
```

## Development
See [https://github.com/tei-for-special-collections/consolidated-schema](https://github.com/tei-for-special-collections/consolidated-schema) for
more information or to view the core ODD files used to generate the materials on this site.
