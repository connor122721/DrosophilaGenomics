# *In2lt inversion status and de novo assembly of a wild-derived Drosophila melanogaster*

**Date: May 21st, 2024**

This repository hosts the scripts utilized for generating a *de novo* assembly of *Drosophila melanogaster*.

### Author:
Connor S. Murray  
Email: csm6hg@virginia.edu

### Script Repository:

#### cnv_analysis:
Contains the scripts used for classifying structural variants (SVs) across NGS data.

- **Smoove**: 
  - Smoove used to call SVs across short-read dataset.

#### DeNovoAssembly:
Contains associated scripts for *de novo* assembly of PacBio HiFi reads, scaffolding, and dotplot creation.

- **HiCanu**: 
  - *De novo* assembly software.

- **LongStitch**:
  - Scaffolding of contigs software.

- **BUSCO**:
  - Benchmark universal single-copy orthologous (BUSCO) genes to assess genome completeness.

- **Dotplot_DGenies**:
  - DGenies used to compare sequences with *DMel6* genome.
