#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { CHECKM2 } from '../../../../modules/nf-core/checkm2/main.nf'

workflow test_checkm2 {
    
    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
    ]

    CHECKM2 ( input )
}
