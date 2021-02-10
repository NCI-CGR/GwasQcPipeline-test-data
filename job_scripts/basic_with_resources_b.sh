#!/bin/sh
# properties = {"type": "single", "rule": "b", "local": false, "input": ["a/1.out"], "output": ["b/1.out"], "wildcards": {"sample": "1"}, "params": {}, "log": [], "threads": 2, "resources": {"mem_gb": 4}, "jobid": 1, "cluster": {}}
cd /var/mnt/scratch/pytest_tmp &&
   PATH='/home/fearjm/miniconda3/envs/GwasQcPipeline/bin':$PATH /home/fearjm/miniconda3/envs/GwasQcPipeline/bin/python3.8 \
      -m snakemake b/1.out --snakefile /var/mnt/scratch/GwasQcPipeline/tests/data/job_scripts/basic_with_resources.smk \
      --force -j --keep-target-files --keep-remote --max-inventory-time 0 \
      --wait-for-files /var/mnt/scratch/pytest_tmp/.snakemake/tmp.bkr49p8k a/1.out --latency-wait 5 \
      --attempt 1 --force-use-threads --scheduler greedy \
      --wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
      --allowed-rules b --nocolor --notemp --no-hooks --nolock \
      --mode 2 --skip-script-cleanup && touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.bkr49p8k/1.jobfinished || (
   touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.bkr49p8k/1.jobfailed
   exit 1
)
