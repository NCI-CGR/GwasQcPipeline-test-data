#!/usr/bin/env python
"""Make multi-sample plink file.

Simulates a multi-sample plink file based on the 1KG test VCF file.
"""
import json
from collections import Counter
from dataclasses import dataclass
from pathlib import Path
from random import choices, randint, seed
from subprocess import run
from typing import Iterable, List, Tuple

import numpy as np
import pysam
from more_itertools import flatten
from pysam.libcbcf import VariantRecord

seed(42)
NUM_SAMPLES = 10
counter: Counter = Counter()  # Track the number of each flag
sample_cnt = 0  # Increment the sample ID number


@dataclass
class Marker:
    chrom: str
    variant_id: str
    coordinate: int
    ref: str
    alts: List[str]
    allele_freqs: Tuple[float]
    status: str  # Indicates if marker was {unknown_chrom, simulated, indel, flipped, ...}

    @classmethod
    def from_vcf(cls, variant: VariantRecord, status: str) -> "Marker":
        return cls(
            variant.chrom,
            variant.id,
            variant.pos,
            variant.ref,
            variant.alts,
            variant.info["AF"],
            status,
        )

    def to_map(self) -> str:
        return "{} {} 0 {}\n".format(self.chrom, self.variant_id, self.coordinate)


@dataclass
class Sample:
    sample_id: str
    snps: Iterable[Tuple[str, str]]  # A list of SNPs (allele A, allele B)

    def to_ped(self):
        return "{} {} 0 0 0 -9 {}\n".format(
            self.sample_id, self.sample_id, " ".join(flatten(self.snps)),
        )


def main() -> None:
    vcf_file = Path("tests/data/1KG/small_1KG.vcf.gz")

    markers = [generate_marker(variant) for variant in pysam.VariantFile(vcf_file, "r")]
    samples = (generate_sample(markers) for _ in range(NUM_SAMPLES))

    # Create MAP file
    map_file = Path("tests/data/plink/samples.map")
    with map_file.open("w") as f:
        f.writelines(marker.to_map() for marker in markers)

    # Create PED file
    ped_file = Path("tests/data/plink/samples.ped")
    with ped_file.open("w") as f:
        f.writelines(sample.to_ped() for sample in samples)

    # Save the counts for different "status" classes.
    log_file = Path("tests/data/plink/samples.json")
    json.dump(counter, log_file.open("w"))

    # Convert text based plink files (MAP, PED) to binary binary plink files (BED, BIM, FAM)
    run(
        f"plink --map {map_file} --ped {ped_file} --out tests/data/plink/samples", shell=True,
    )


def generate_marker(variant: VariantRecord) -> Marker:
    """Pull variants from 1KG and add little noise.

    Simulates noise by adding markers that have an unknown chromosome
    ("MT"), creates new markers not in 1KG (simulate), flags indels, flags
    ambiguous variants, and randomly flips REF/ALT for a few variants.
    """

    # Add an ID based on location if missing.
    if variant.id is None:
        variant.id = f"1KG_{variant.chrom}_{variant.pos}"

    # Simulate a few problematic markers (i.e., on MT or at a different position)
    status = choices(["keep", "unknown_chrom", "simulate"], weights=[0.8, 0.01, 0.09])[0]

    # Simulate some mitochondial markers, these are not in the 1KG VCF and will be removed.
    if status == "unknown_chrom":
        variant.chrom = "MT"
        counter[status] += 1
        return Marker.from_vcf(variant, status)

    # Simulate an allele that is not in the 1KG VCF (just move the postion a bit).
    if status == "simulate":
        variant.pos -= 2
        variant.id = f"sim{randint(90_000_000, 900_000_000):09d}"  # make a simple random ID.
        counter[status] += 1
        return Marker.from_vcf(variant, status)

    # Flag indels based on REF/ALT string lengths
    if len(variant.ref) > 1 or any(len(x) > 1 for x in variant.alts):
        status = "indel"
        counter[status] += 1
        return Marker.from_vcf(variant, status)

    # Flag alleles are ambiguous
    if sorted(variant.alleles) in [["A", "T"], ["C", "G"]]:
        status = "ambiguous"
        counter[status] += 1
        return Marker.from_vcf(variant, status)

    # Randomly flip a few REF/ALT to add little more noise
    if randint(0, 100) <= 10:
        status = "flip"
        ref, alt = variant.ref, variant.alts[0]
        variant.alleles = (alt, ref)
        counter[status] += 1
        return Marker.from_vcf(variant, status)

    # Keep the original marker as is
    counter[status] += 1
    return Marker.from_vcf(variant, status)


def generate_sample(markers: List[Marker]) -> Sample:
    """Simulates a sample from a list of markers."""
    # Name samples T0001 to T0010
    global sample_cnt
    sample_cnt += 1
    sample_id = f"T{sample_cnt:06d}"
    snps = (simulate_allele_A_B(marker) for marker in markers)
    return Sample(sample_id, snps)


def simulate_allele_A_B(marker: Marker) -> Tuple[str, str]:
    """Generate a sample allele A/B for a specific loci.

    Returns:
        A tuple with (Allele A, Allele B).
    """
    # Add some random missing data
    if randint(0, 1000) <= 1:
        return "0", "0"

    # Select the most popular ALT.
    # NOTE: you could add logic hear to make some tri-allelic markers.
    ref = marker.ref
    alt = marker.alts[np.argmax(marker.allele_freqs)]

    # Translate indels
    if len(ref) > len(alt):
        return "D", "D"
    elif len(ref) < len(alt):
        return "I", "I"

    return ref, alt


if __name__ == "__main__":
    main()
