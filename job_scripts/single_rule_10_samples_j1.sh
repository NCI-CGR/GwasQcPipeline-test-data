#!/bin/sh
# properties = {"type": "group", "groupid": "grp0", "local": false, "input": [], "output": ["a/5.out", "a/8.out", "a/9.out", "a/6.out", "a/3.out"], "threads": 5, "resources": {}, "jobid": "3b50c5e0-bdc8-5c98-ae8d-564b4649af3f", "cluster": {}}
cd /var/mnt/scratch/pytest_tmp &&
   PATH='/home/fearjm/miniconda3/envs/GwasQcPipeline/bin':$PATH /home/fearjm/miniconda3/envs/GwasQcPipeline/bin/python3.8 \
      -m snakemake a/5.out a/8.out a/9.out a/6.out a/3.out --snakefile /var/mnt/scratch/GwasQcPipeline/tests/data/job_scripts/single_rule_10_samples.smk \
      --force -j --keep-target-files --keep-remote --max-inventory-time 0 \
      --wait-for-files /var/mnt/scratch/pytest_tmp/.snakemake/tmp.ddeep3kp --latency-wait 5 \
      --attempt 1 --scheduler greedy \
      --wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
      --allowed-rules a a a a a --nocolor --notemp --no-hooks --nolock \
      --mode 2 --skip-script-cleanup && touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.ddeep3kp/3b50c5e0-bdc8-5c98-ae8d-564b4649af3f.jobfinished || (
   touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.ddeep3kp/3b50c5e0-bdc8-5c98-ae8d-564b4649af3f.jobfailed
   exit 1
)
