[![GitHub Actions CI Status](https://github.com/nf-core/socialgene/workflows/nf-core%20CI/badge.svg)](https://github.com/nf-core/socialgene/actions?query=workflow%3A%22nf-core+CI%22)
[![GitHub Actions Linting Status](https://github.com/nf-core/socialgene/workflows/nf-core%20linting/badge.svg)](https://github.com/nf-core/socialgene/actions?query=workflow%3A%22nf-core+linting%22)
[![AWS CI](https://img.shields.io/badge/CI%20tests-full%20size-FF9900?labelColor=000000&logo=Amazon%20AWS)](https://nf-co.re/socialgene/results)
[![Cite with Zenodo](http://img.shields.io/badge/DOI-10.5281/zenodo.XXXXXXX-1073c8?labelColor=000000)](https://doi.org/10.5281/zenodo.XXXXXXX)

[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A521.04.0-23aa62.svg?labelColor=000000)](https://www.nextflow.io/)
[![run with conda](http://img.shields.io/badge/run%20with-conda-3EB049?labelColor=000000&logo=anaconda)](https://docs.conda.io/en/latest/)
[![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
[![run with singularity](https://img.shields.io/badge/run%20with-singularity-1d355c.svg?labelColor=000000)](https://sylabs.io/docs/)

[![Get help on Slack](http://img.shields.io/badge/slack-nf--core%20%23socialgene-4A154B?labelColor=000000&logo=slack)](https://nfcore.slack.com/channels/socialgene)
[![Follow on Twitter](http://img.shields.io/badge/twitter-%40nf__core-1DA1F2?labelColor=000000&logo=twitter)](https://twitter.com/nf_core)
[![Watch on YouTube](http://img.shields.io/badge/youtube-nf--core-FF0000?labelColor=000000&logo=youtube)](https://www.youtube.com/c/nf-core)

## Overview

The nextflow workflow makes heavy use of the Python app (so code is testable and can run on its own). Its purpose is to reproducibly gather the required data, run hmmsearch, parse results, and create the neo4j database.

## Check the workflow with a test run

If you haven't already, create and enter socialgene's conda environment

=== "shell"
```bash
make create_conda
conda activate socialgene
```

Run the nextflow test pipeline. Change the outdirs to the desired locations.  

Exectute the below code from socialgene's top directory

=== "shell"
```bash
 nextflow run nextflow \
        -profile test \
        --outdir_per_run "/test/per_run_info" \
        --outdir_neo4j "/test/neo4j_database" \
        --outdir_long_cache "/test/long_term_storage"

```

- `outdir_per_run` will contain information about the run (timings, memory used, etc)
- `outdir_neo4j` will contain **both** the neo4j database **and** the files used to create it/import
  - This directory structure is required for import step when creating the neo4j database. If you won't need to "resume" the nextflow pipeline the `import` directory can be deleted
- `outdir_long_cache` contains things like the HMM models which shouldn't vary between runs of the workflow.

## Including BLASTp and/or MMSEQS2

BLASTp and MMSEQS inter-protein comparisons can be made be includeing the `--blastp` and/or `--mmseqs2` flags.

BLASTp is very time/resource consuming and should only be used on limited datasets.

=== "shell"
```bash
nextflow run nextflow \
  -profile test \
  --outdir_per_run "/path/to/outdir_per_run" \
  --outdir_neo4j "/path/to/outdir_neo4j" \
  --outdir_long_cache "/path/to/outdir_long_cache" \
  -resume \
  --fasta_splits 1 \
  --blastp true \
  --mmseqs2 true
```

## Introduction

<!-- TODO nf-core: Write a 1-2 sentence summary of what data the pipeline is for and what it does -->
**nf-core/socialgene** is a bioinformatics best-practice analysis pipeline for Repository-scale protein-hmm network annotation and analysis.

The pipeline is built using [Nextflow](https://www.nextflow.io), a workflow tool to run tasks across multiple compute infrastructures in a very portable manner. It uses Docker/Singularity containers making installation trivial and results highly reproducible. The [Nextflow DSL2](https://www.nextflow.io/docs/latest/dsl2.html) implementation of this pipeline uses one container per process which makes it much easier to maintain and update software dependencies. Where possible, these processes have been submitted to and installed from [nf-core/modules](https://github.com/nf-core/modules) in order to make them available to all nf-core pipelines, and to everyone within the Nextflow community!

<!-- TODO nf-core: Add full-sized test dataset and amend the paragraph below if applicable -->
On release, automated continuous integration tests run the pipeline on a full-sized dataset on the AWS cloud infrastructure. This ensures that the pipeline runs on AWS, has sensible resource allocation defaults set to run on real-world datasets, and permits the persistent storage of results to benchmark between pipeline releases and other analysis sources. The results obtained from the full-sized test can be viewed on the [nf-core website](https://nf-co.re/socialgene/results).

## Pipeline summary

<!-- TODO nf-core: Fill in short bullet-pointed list of the default steps in the pipeline -->

1. Read QC ([`FastQC`](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/))
2. Present QC for raw reads ([`MultiQC`](http://multiqc.info/))

## Quick Start

The main SocialGene conda environment contains nextflow so, if you haven't already, download miniconda and then create the SocialGene conda environment

=== "shell"
```bash
conda env create --file https://raw.githubusercontent.com/chasemc/socialgene/main/nextflow/python_environment.yml
```

=== "shell"
```bash
conda activate socialgene
```

If you want to use the docker image you can create it with the following command:

=== "shell"
```bash
docker build . --tag chasemc/socialgene
```

## Run the Nextflow Pipeline

=== "shell"
```bash
# set the directory all files will be placed in 
sg_outdir='/Users/chase/Documents/socialgene_test_run2'

# Run the nextflow pipeline
nextflow run nextflow \
    -profile test,conda \
    --outdir_per_run "${sg_outdir}/per" \
    --outdir_neo4j "${sg_outdir}/neo" \
    --outdir_long_cache '/Users/chase/Documents/socialgene_data/all_micromonospora/socialgene_results/longy' \
    --fasta_splits 0 \
    -resume 
```

sg_outdir="/home/chase/socialgene_results"

neoloc='/Users/chase/Documents/socialgene_test_run/neo/neo4j'
neoloc='/home/chase/Documents/test/extra/neo/neo4j'

docker run \
    -p7474:7474 -p7687:7687 \
    -v $neoloc/data:/data \
    -v $neoloc/logs:/logs \
    -v $neoloc/import:/var/lib/neo4j/import \
    -v $neoloc/plugins:/plugins \
    --env NEO4J_AUTH=neo4j/test \
       --env NEO4J_dbms_allow__upgrade=true \
       --env NEO4J_apoc_export_file_enabled=true \
       --env NEO4J_apoc_import_file_enabled=true \
       --env NEO4J_apoc_import_file_use__neo4j__config=true \
       --env NEO4JLABS_PLUGINS=\[\"apoc\"\] \
     neo4j:4.4.7
