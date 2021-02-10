#!/bin/sh
# properties = {"type": "group", "groupid": "grp0", "local": false, "input": [], "output": ["a/2.out", "a/4.out", "a/7.out", "a/1.out", "a/10.out"], "threads": 5, "resources": {}, "jobid": "c5d9d8f1-d0e9-5f7b-9c57-77efdf0a0fe6", "cluster": {}}
cd /var/mnt/scratch/pytest_tmp &&
   PATH='/home/fearjm/miniconda3/envs/GwasQcPipeline/bin':$PATH /home/fearjm/miniconda3/envs/GwasQcPipeline/bin/python3.8 \
      -m snakemake a/2.out a/4.out a/7.out a/1.out a/10.out --snakefile /var/mnt/scratch/GwasQcPipeline/tests/data/job_scripts/single_rule_10_samples.smk \
      --force -j --keep-target-files --keep-remote --max-inventory-time 0 \
      --wait-for-files /var/mnt/scratch/pytest_tmp/.snakemake/tmp.ddeep3kp --latency-wait 5 \
      --attempt 1 --scheduler greedy \
      --wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
      --allowed-rules a a a a a --nocolor --notemp --no-hooks --nolock \
      --mode 2 --skip-script-cleanup && touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.ddeep3kp/c5d9d8f1-d0e9-5f7b-9c57-77efdf0a0fe6.jobfinished || (
   touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.ddeep3kp/c5d9d8f1-d0e9-5f7b-9c57-77efdf0a0fe6.jobfailed
   exit 1
)
