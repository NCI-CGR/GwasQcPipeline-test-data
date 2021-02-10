rule all:
    input:
        expand("b/{sample}.out", sample=[1]),


rule a:
    output:
        "a/{sample}.out",
    group:
        "grp0"
    threads: 1
    resources:
        mem_gb=2
    shell:
        "touch {output}"


rule b:
    input:
        "a/{sample}.out",
    output:
        "b/{sample}.out",
    group:
        "grp0"
    threads: 2
    resources:
        mem_gb=4
    shell:
        "touch {output}"
