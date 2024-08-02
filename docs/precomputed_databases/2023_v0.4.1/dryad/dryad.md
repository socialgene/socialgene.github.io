
# Dryad Data Access
The data for first manuscript has been deposited in the Dryad repository for longer term preservation.

The data can be accessed at the following link: [https://doi.org/10.5061/dryad.ns1rn8q2k](https://doi.org/10.5061/dryad.ns1rn8q2k)

# Data Description
The included databases are described [here](../general/).

One difference is the full SocialGene RefSeq Neo4j database had to be split into 24 parts for hosting on Dryad. The resulting parts follow the naming convention `neo4j_db_refseq_base.dump_split_0`, `neo4j_db_refseq_base.dump_split_01`, ..., `neo4j_db_refseq_base.dump_split_23`.

Before use the full database dump file must be merged by downloading all 24 parts and concatenating them together.

For example:
```bash
cat neo4j_db_refseq_base.dump_split_* > neo4j_db_refseq_base.dump
mad5sum -c md5checksums.txt
```

Dryad only allows for a flat file structure so the files are all in the same "directory". The included files are:

- md5 checksums
    - `md5checksums.txt`
- HMM files (for use with any of the 2023_v0.4.1 dataabses)
    - `socialgene_nr_hmms_file_with_cutoffs_1_of_1.hmm.gz`
    - `socialgene_nr_hmms_file_without_cutoffs_1_of_1.hmm.gz`
    - `hmminfo.tsv.gz`
- Neo4j database dump files
    - All RefSeq
        - `neo4j_db_refseq_base.dump_split_00`
        - `neo4j_db_refseq_base.dump_split_01`
        - `neo4j_db_refseq_base.dump_split_02`
        - `neo4j_db_refseq_base.dump_split_03`
        - `neo4j_db_refseq_base.dump_split_04`
        - `neo4j_db_refseq_base.dump_split_05`
        - `neo4j_db_refseq_base.dump_split_06`
        - `neo4j_db_refseq_base.dump_split_07`
        - `neo4j_db_refseq_base.dump_split_08`
        - `neo4j_db_refseq_base.dump_split_09`
        - `neo4j_db_refseq_base.dump_split_10`
        - `neo4j_db_refseq_base.dump_split_11`
        - `neo4j_db_refseq_base.dump_split_12`
        - `neo4j_db_refseq_base.dump_split_13`
        - `neo4j_db_refseq_base.dump_split_14`
        - `neo4j_db_refseq_base.dump_split_15`
        - `neo4j_db_refseq_base.dump_split_16`
        - `neo4j_db_refseq_base.dump_split_17`
        - `neo4j_db_refseq_base.dump_split_18`
        - `neo4j_db_refseq_base.dump_split_19`
        - `neo4j_db_refseq_base.dump_split_20`
        - `neo4j_db_refseq_base.dump_split_21`
        - `neo4j_db_refseq_base.dump_split_22`
        - `neo4j_db_refseq_base.dump_split_23`
    - All RefSeq Actinomycetota
        - `neo4j_db_actinomycetota_base.dump`
        - `params_actinomycetota.json`
    - All RefSeq Streptomyces
        - `neo4j_db_streptomyces_base.dump`
        - `params_micromonospora.json`
    - All RefSeq Micromonospora
        - `neo4j_db_micromonospora_base.dump`
        - `params_streptomyces.json`
    - All RefSeq antiSMASH-7.0 BGCs
        - `neo4j_db_refseq_antismash_bgcs_base.dump`
        - `params_refseq_antismash_bgcs.json`



## Checksums
Additionally, there is a single `md5checksums.txt` file that contains the md5 checksums for all of the files in the dataset. This can be used to verify the integrity of any or all of the files after downloading. This includes the expected md5sum of the concatenated `neo4j_db_refseq_base.dump` file.



