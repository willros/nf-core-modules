#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { CHECKM2_CHECKM2DB } from '../../../../../modules/nf-core/checkm2/checkm2db/main.nf'

workflow test_checkm2_checkm2db {
    CHECKM2_CHECKM2DB ( )
}