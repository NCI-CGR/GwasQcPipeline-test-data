rule all:
    input:
        expand("a/{sample}.out", sample=[x for x in range(1, 11)]),


rule a:
    output:
        "a/{sample}.out",
    group: "grp0"
    shell:
        "touch {output}"
