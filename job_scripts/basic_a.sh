#!/bin/sh
# properties = {"type": "single", "rule": "a", "local": false, "input": [], "output": ["a/1.out"], "wildcards": {"sample": "1"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 2, "cluster": {}}
cd /var/mnt/scratch/pytest_tmp &&
   PATH='/home/fearjm/miniconda3/envs/GwasQcPipeline/bin':$PATH /home/fearjm/miniconda3/envs/GwasQcPipeline/bin/python3.8 \
      -m snakemake a/1.out --snakefile /var/mnt/scratch/GwasQcPipeline/tests/data/job_scripts/basic.smk \
      --force -j --keep-target-files --keep-remote --max-inventory-time 0 \
      --wait-for-files /var/mnt/scratch/pytest_tmp/.snakemake/tmp.7jfyit94 --latency-wait 5 \
      --attempt 1 --force-use-threads --scheduler greedy \
      --wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
      --allowed-rules a --nocolor --notemp --no-hooks --nolock \
      --mode 2 --skip-script-cleanup && touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.7jfyit94/2.jobfinished || (
   touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.7jfyit94/2.jobfailed
   exit 1
)
