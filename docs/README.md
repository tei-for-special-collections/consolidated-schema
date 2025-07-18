# The Consolidated Schema

This repository hosts the **Consolidated Schema**, a customized TEI P5 schema written in TEI’s ODD. It’s used by:

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

## Documentation & Deployment

The HTML documentation and RelaxNG schema are automatically generated and published at [https://tei-for-special-collections.github.io/consolidated-schema/](https://tei-for-special-collections.github.io/consolidated-schema/) whenever its ODD is updated.

## Creating Your Own Schema based on the Consolidated Schema.

To base your own TEI customization on the Consolidated Schema, add the following `source` attribute to your `<schemaSpec>`:

```
<schemaSpec
  source="https://raw.githubusercontent.com/tei-for-special-collections/consolidated-schema/refs/heads/main/releases/odd/consolidated-schema.compiled.odd"
/>
```

## Provided Customizations

We have provided two customisations in this repository. 

- [Cambridge Digital Collection Platform](https://cambridge-collection.github.io/) uses [odd/cdcp.odd](https://github.com/tei-for-special-collections/consolidated-schema/blob/main/odd/cdcp.odd).
- [Medieval Manuscripts in Oxford Libraries](https://medieval.bodleian.ox.ac.uk/) uses  [odd/manuscripts-catalogue.odd](https://github.com/tei-for-special-collections/consolidated-schema/blob/main/odd/manuscripts-catalogue.odd).


