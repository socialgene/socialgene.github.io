# Precomputed databases, version: 2023_v0.4.1

## Introduction

In addition to the >340,000 genome RefSeq database, I have precomputed several smaller databases I thought the natural product community (and others) may find helpful.

The version of the databases is `2023_v0.4.1` because the databases were built in 2023 using version 0.4.1 of the SocialGene Nextflow workflow.

The databases were built using the same set of less-redundant HMM models. Which means you can use the single set of provided HMM files with any of these databases.


## Databases and their disk space requirements

!!! note
    Some of the databases are quite large so please read the hardware requirements *before* downloading.

You will need at least enough disk space to accommodate the dump file and rehydrated database. The dump file is not required after rehydrating (can be deleted) but if you have enough space might it be good to keep around in case you want to rebuild the database from scratch without downloading again (e.g. you make a lot of custom database modifications but mess up and want to start over).

- All of RefSeq
    - Database dump file: ~220 GB
    - Rehydrated database: ~650 GB
    - Rehydrated database with indexes: ~663 GB
    - 343,381 genomes + MIBiG BGCs

- All RefSeq antiSAMSH-7.0 BGCs
    - Database dump file is ~10 GB
    - Rehydrated database is ~29 GB
    - 2,105,746 BGCs from 307,469 genomes + MIBiG BGCs 

- All RefSeq Actinomycetota
    - Database dump file is ~30 GB
    - Rehydrated database is ~86 GB
    - 29,479 genomes + MIBiG BGCs

- All RefSeq *Streptomyces*
    - Database dump file is ~8 GB
    - Rehydrated database is ~23 GB
    - 3,087 genomes + MIBiG BGCs

- All RefSeq *Micromonospora*
    - Database dump file is ~1 GB
    - Rehydrated database is ~3 GB
    - 314 genomes + MIBiG BGCs

- Three genomes used for protein similarity method comparisons
    - Database dump file is ~99 MB
    - Rehydrated database is ~744 MB
    - 3 genomes
        - GCF_000009045.1, GCF_000005845.2, GCF_008931305.1 (Bacillus subtilis subsp. subtilis str. 168, Escherichia coli str. K-12 substr. MG1655, and Streptomyces coelicolor A3(2); downloaded on June 20, 2024)
    



All of the above databases were built with the same set of HMM models, these are found in the two files:

- socialgene_nr_hmms_file_without_cutoffs_1_of_1.hmm.gz
- socialgene_nr_hmms_file_with_cutoffs_1_of_1.hmm.gz


## Nextflow workflow parameters used in building the databases


- All RefSeq 
    - [params_refseq.json](../parameters/params_refseq.json)
- All RefSeq Actinomycetota
    - [params_actinomycetota.json](../parameters/params_actinomycetota.json)
- All RefSeq Streptomyces
    - [params_streptomyces.json](../parameters/params_streptomyces.json)
- All RefSeq Micromonospora
    - [params_micromonospora.json](../parameters/params_micromonospora.json)
- All RefSeq antiSMASH-7.0 BGCs
    - [params_refseq_antismash_bgcs.json](../parameters/params_refseq_antismash_bgcs.json)
- Three genomes used for protein similarity method comparisons
    - [params_methods_comparison.json](../parameters/params_methods_comparison.json)



## Instructions for downloading data from...

- [Dryad](./dryad/dryad.md)
- [AWS S3](./aws/aws.md)


## Access information

Data was derived from the following sources:

- RefSeq https://www.ncbi.nlm.nih.gov/home/about/policies (opens in new window)

- Resfams http://www.dantaslab.org/resfams (opens in new window)

- antiSMASH (Many of the HMM models are from PFAM)
  - GNU Affero General Public License v3.0
  - https://github.com/antismash/antismash/blob/e2d777c6cd035e6bf20f7eec924a350b00b84c7b/LICENSE.txt (opens in new window)

- AMRFinder
  - Public domain
  - https://github.com/ncbi/amr/blob/c5fe35453ee102dcb2e44d6b1198992b1ab7a355/LICENSE (opens in new window)

- PFAM
  - CC0 1.0 License
  - https://ftp.ebi.ac.uk/pub/databases/Pfam/releases/Pfam35.0/relnotes.txt (opens in new window)

- resfams
  - MIT License
  - http://www.dantaslab.org/s/LICENSE.txt (opens in new window)

- TIGRFAM
  - Creative Commons Attribution-ShareAlike 4.0
  - https://www.ncbi.nlm.nih.gov/refseq/annotation_prok/tigrfams
