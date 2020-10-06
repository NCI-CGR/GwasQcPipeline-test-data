# GwasQcPipeline Test Data

This repository is meant to be a submodule for `GwasQcPipeline`. It contains all of the test for this project.

```bash
.
├── example_sample_sheet.csv            # A made up sample sheet based on what is provided by CGR
├── illumina                            # Test data copied from Illumina's github
│  ├── bpm
│  │  ├── small_manifest.bpm
│  │  └── small_manifest.csv
│  ├── gtc
│  │  ├── small_genotype.gtc
│  │  └── small_genotype.vcf
│  ├── LICENSE
│  └── README.md
├── plink                               #  Plink outputs generated by running legacy pipeline
│  ├── T0001_fwd.map
│  ├── T0001_fwd.ped
│  ├── T0001_top.map
│  └── T0001_top.ped
├── README.md                           # This readme
└── scripts                             # Scripts used to help make test data
   └── make_test_1KG_vcf.py
```