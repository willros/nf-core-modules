// TODO CHANGE!
process CHECKM2_PREDICT {
    tag "$meta.id"
    label 'process_medium'

    conda "bioconda::checkm2=1.0.1"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/checkm2:1.0.1--pyh7cba7a3_0':
        'biocontainers/checkm2:1.0.1--pyh7cba7a3_0' }"

    input:
    tuple val(meta), path(fasta, stageAs: "input_bins/*")
    val(fasta_ext)
    path(db_file)

    output:
    tuple val(meta), path("checkm2_out/quality_report.tsv"),   emit: quality_report
    tuple val(meta), path("checkm2_out/diamond_output/*.tsv"), emit: diamond
    tuple val(meta), path("checkm2_out/protein_files/*.faa"),  emit: protein
    path "versions.yml",                                       emit: versions


    when:
    task.ext.when == null || task.ext.when

    script:
    def args  = task.ext.args   ?: ''
    prefix    = task.ext.prefix ?: "${meta.id}"
    """
    checkm2 \\
    predict \\
    ${args} \\
    --threads $task.cpus \\
    --database_path ${db} \\
    --input ${fasta} \\
    --output-directory checkm2_out

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        checkm: \$( checkm2 --version )
    END_VERSIONS
    """
}

