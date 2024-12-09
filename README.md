This repository is core schema containing the shared standards employed by various projects and institutions, such as [Fihrist](https://github.com/fihristorg/fihrist-mss), The Bodleian Libraries ([Senmai](https://github.com/bodleian/senmai-mss), [Medieval](https://github.com/bodleian/medieval-mss), [Hebrew](https://github.com/bodleian/hebrew-mss), [Genizah](https://github.com/bodleian/genizah-mss), [Georgian](https://github.com/bodleian/georgian-mss), [Armenian](https://github.com/bodleian/armenian-mss), and [Tibetan](https://github.com/bodleian/karchak-mss)), The Cambridge University Library ([CUDL](https://cudl.lib.cam.ac.uk/)).

The schema is a customised version of the TEI (Text Encoding Initiative) P5 standard written using TEI's [ODD](http://www.tei-c.org/guidelines/customization/getting-started-with-p5-odds/). This file then converted into a RelaxNG (with schematron) file that XML editors and validating parsers can understand as well as html documentation for encoders.

Every commit onto the main branch of this repository triggers an automatic rebuild of the RelaxNG schema file ([https://tei-for-special-collections.github.io/consolidated-schema/rng/consolidated-schema.rng]((https://tei-for-special-collections.github.io/consolidated-schema/available-schemata.html)) and documentation ([https://tei-for-special-collections.github.io/consolidated-schema/documentation/consolidated-schema.html]((https://tei-for-special-collections.github.io/consolidated-schema/available-schemata.html)). These updated files are committed both to the repository and automatically deployed onto our github pages site ([https://tei-for-special-collections.github.io/consolidated-schema/available-schemata.html]((https://tei-for-special-collections.github.io/consolidated-schema/available-schemata.html))

To validate against the schema, you can either select it manually when validating your file or you can add in an appropriate `xml-model` declaration that your XML editor should automatically use). The xml-models for both RelaxNG and schematron validation are:

```
<?xml version="1.0" encoding="UTF-8"?>
<?xml-model href="https://raw.githubusercontent.com/tei-for-special-collections/consolidated-schema/refs/heads/main/rng/consolidated-schema.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="https://raw.githubusercontent.com/tei-for-special-collections/consolidated-schema/refs/heads/main/rng/consolidated-schema.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
```

You can see all the schemata and documentation available in this repository in its [available schemata list](https://tei-for-special-collections.github.io/consolidated-schema/available-schemata.html)

TODO: Create template file(s)
