#!/bin/sh
# properties = {"type": "group", "groupid": "grp0", "local": false, "input": [], "output": ["b/1.out"], "threads": 1, "resources": {}, "jobid": "33a0847f-1400-57c3-82cb-dc6be6efcaee", "cluster": {}}
cd /var/mnt/scratch/pytest_tmp &&
   PATH='/home/fearjm/miniconda3/envs/GwasQcPipeline/bin':$PATH /home/fearjm/miniconda3/envs/GwasQcPipeline/bin/python3.8 \
      -m snakemake b/1.out --snakefile /var/mnt/scratch/GwasQcPipeline/tests/data/job_scripts/basic_group.smk \
      --force -j --keep-target-files --keep-remote --max-inventory-time 0 \
      --wait-for-files /var/mnt/scratch/pytest_tmp/.snakemake/tmp.9_74ods5 --latency-wait 5 \
      --attempt 1 --scheduler greedy \
      --wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
      --allowed-rules a b --nocolor --notemp --no-hooks --nolock \
      --mode 2 --skip-script-cleanup && touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.9_74ods5/33a0847f-1400-57c3-82cb-dc6be6efcaee.jobfinished || (
   touch /var/mnt/scratch/pytest_tmp/.snakemake/tmp.9_74ods5/33a0847f-1400-57c3-82cb-dc6be6efcaee.jobfailed
   exit 1
)
