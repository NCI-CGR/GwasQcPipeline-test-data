# %% [markdown]
# # Create a 1KG test VCF

# %%
# Imports
from collections import defaultdict
from pathlib import Path
from random import random, seed

import pysam

from cgr_gwas_qc.parsers.illumina import BeadPoolManifest

seed(42)

# %% [markdown]
# ## Prep work

# %%
# Download VCF file to cache..
vcf_file = Path("../.cache/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.vcf.gz")

if not vcf_file.exists():
    from urllib.request import urlretrieve

    vcf_file.parent.mkdir(exist_ok=True)
    url = "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf.gz"
    urlretrieve(url, vcf_file)
    urlretrieve(url + ".tbi", vcf_file.with_suffix(".gz.tbi"))

# %% [markdown]
# ## Get List of Variants

# %%
bpm_file = Path("../illumina/bpm/small_manifest.bpm")
bpm = BeadPoolManifest(bpm_file)

variants = defaultdict(set)
for chrom, pos in zip(bpm.chroms, bpm.map_infos):
    variants[chrom].add(pos - 1)
    variants[chrom].add(pos)
    variants[chrom].add(pos + 1)
chroms = list(variants.keys())

# %% [markdown]
# ## Create Test VCF

# %%
# Load 1KG VCF
vcf = pysam.VariantFile(vcf_file)

# %%
# Clean up the VCF header for test VCF.
vcf_header = pysam.VariantHeader()
for record in vcf.header.records:
    if record.key == "contig" and record["ID"] not in chroms:
        # Remove unused contigs
        continue

    if record.key == "ALT" and record["ID"].startswith("CN"):
        # Remove CNVs and other variants that are SNPs
        continue

    vcf_header.add_record(record)

# %%
# test dataset
vcf_out_file = Path("../1KG/small_1KG.vcf")
vcf_out_file.parent.mkdir(exist_ok=True, parents=True)

# %%
with vcf_out_file.open(mode="w") as f:
    f.write(str(vcf_header))
    for chrom, positions in variants.items():
        if chrom not in vcf_header.contigs.keys():
            continue
        print(chrom)
        for row in vcf.fetch(chrom):
            if row.start in positions:
                f.write(str(row))
            elif random() <= 1e-6:
                # Add random rows for a challenge
                f.write(str(row))
print("done")

# %% [markdown]
# ## Compress and index

# %%
# bcftools view -O z -o ../1KG/small_1KG.vcf.gz -l 9 ../1KG/small_1KG.vcf
# bcftools index -t ../1KG/small_1KG.vcf.gz