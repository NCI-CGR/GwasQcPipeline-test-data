#!/bin/sh
# properties = {"type": "group", "groupid": "grp0", "local": false, "input": [], "output": ["a/3.out", "a/6.out", "a/4.out", "a/9.out", "a/2.out"], "threads": 10, "resources": {"mem": 10, "time_min": 50}, "jobid": "5fffc17a-a038-554a-81b3-b6a29ffbb9a4", "cluster": {}}
cd /var/mnt/scratch/pytest_tmp &&
   PATH='/home/fearjm/miniconda3/envs/GwasQcPipeline/bin':$PATH /home/fearjm/miniconda3/envs/GwasQcPipeline/bin/python3.8 \
      -m snakemake a/3.out a/6.out a/4.out a/9.out a/2.out --snakefile /var/mnt/scratch/GwasQcPipeline/tests/data/job_scripts/single_rule_10_samples_with_resources.smk \
      --force -j --keep-target-files --keep-remote --max-inventory-time 0 \
      --wait-for-files /var/mnt/scratch/pytest_tmp/.snakemake/tmp.vtp_4es4 --latency-wait 5 \
      --attempt 1 --scheduler greedy \
      --wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
      --allowed-rules a a a a a --nocolor --notemp --no-hooks --nolock \
      --mode 2 --skip-script-cleanup && touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.vtp_4es4/5fffc17a-a038-554a-81b3-b6a29ffbb9a4.jobfinished || (
   touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.vtp_4es4/5fffc17a-a038-554a-81b3-b6a29ffbb9a4.jobfailed
   exit 1
)
