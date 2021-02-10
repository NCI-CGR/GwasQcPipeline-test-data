rule all:
    input:
        expand("a/{sample}.out", sample=[x for x in range(1, 11)]),


rule a:
    output:
        "a/{sample}.out",
    group:
        "grp0"
    threads: 2
    resources:
        mem=2,
        time_min=10,
    shell:
        "touch {output}"
