rule all:
    input:
        expand("b/{sample}.out", sample=[1]),


rule a:
    output:
        "a/{sample}.out",
    shell:
        "touch {output}"


rule b:
    input:
        "a/{sample}.out",
    output:
        "b/{sample}.out",
    shell:
        "touch {output}"
