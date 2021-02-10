#!/bin/sh
# properties = {"type": "group", "groupid": "grp0", "local": false, "input": [], "output": ["a/1.out", "a/5.out", "a/8.out", "a/7.out", "a/10.out"], "threads": 10, "resources": {"mem": 10, "time_min": 50}, "jobid": "0210f1df-6ee6-582e-8be1-3c4da9ad0bdb", "cluster": {}}
cd /var/mnt/scratch/pytest_tmp &&
   PATH='/home/fearjm/miniconda3/envs/GwasQcPipeline/bin':$PATH /home/fearjm/miniconda3/envs/GwasQcPipeline/bin/python3.8 \
      -m snakemake a/1.out a/5.out a/8.out a/7.out a/10.out --snakefile /var/mnt/scratch/GwasQcPipeline/tests/data/job_scripts/single_rule_10_samples_with_resources.smk \
      --force -j --keep-target-files --keep-remote --max-inventory-time 0 \
      --wait-for-files /var/mnt/scratch/pytest_tmp/.snakemake/tmp.vtp_4es4 --latency-wait 5 \
      --attempt 1 --scheduler greedy \
      --wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
      --allowed-rules a a a a a --nocolor --notemp --no-hooks --nolock \
      --mode 2 --skip-script-cleanup && touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.vtp_4es4/0210f1df-6ee6-582e-8be1-3c4da9ad0bdb.jobfinished || (
   touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.vtp_4es4/0210f1df-6ee6-582e-8be1-3c4da9ad0bdb.jobfailed
   exit 1
)
