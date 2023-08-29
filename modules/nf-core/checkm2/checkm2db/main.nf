process CHECKM2_CHECKM2DB {
    tag "$meta.id"
    label 'process_single'

    conda "bioconda::checkm2=1.0.1"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/checkm2:1.0.1--pyh7cba7a3_0':
        'biocontainers/checkm2:1.0.1--pyh7cba7a3_0' }"

    output:
    path 'checkm2_db/CheckM2_database/uniref100.KO.1.dmnd', emit: db
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    """
    checkm2 \\
        database \\
        --download \\
        $args \\
        --path checkm2_db \\

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        checkm2: \$( checkm2 --version )
    END_VERSIONS
    """
}