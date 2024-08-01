# Precomputed Databases hosted on AWS S3

## Instructions for download and use

Install the latest version of the AWS CLI using the instructions on the [AWS CLI website](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

### Using Neo4j Community Edition

First, download one of the database dump files from the AWS S3 bucket ([files listed below](#files-explanation)). For example, to download the *Micromonospora* database dump file to the current directory:

```bash
aws s3 cp s3://socialgene/2023_v0.4.1/micromonospora/neo4j_db_micromonospora_base.dump .
```

Then follow the instructions for [restoring from a full database dump/backup](../../../neo4j/database_backups/#restore-from-a-full-database-dumpbackup) to rehydrate the Neo4j database. Note that the instructions use Docker, so you will need to have Docker installed or [manually install Neo4j](https://neo4j.com/docs/operations-manual/current/installation/).


### Using Neo4j Enterprise Edition

Ensure you have a valid license for Neo4j Enterprise Edition. Install the latest version of the Neo4j Enterprise Edition using the instructions on the [Neo4j website](https://neo4j.com/download/).

Follow the directions at [https://neo4j.com/docs/operations-manual/current/backup-restore/restore-backup/#restore-cloud-storage](https://neo4j.com/docs/operations-manual/current/backup-restore/restore-backup/#restore-cloud-storage) for restoring a database directly from cloud storage.

## Files Explanation

### Database files

The included database dumps and disk space requirements are described [here](../general/).

The paths to just the dumps are:

- All RefSeq:
    - `s3://socialgene/2023_v0.4.1/refseq/neo4j_db_refseq_base.dump`
- All RefSeq Actinomycetota:
    - `s3://socialgene/2023_v0.4.1/actinomycetota/neo4j_db_actinomycetota_base.dump`
- All RefSeq Streptomyces:
    - `s3://socialgene/2023_v0.4.1/streptomyces/neo4j_db_streptomyces_base.dump`
- All RefSeq Micromonospora:
    - `s3://socialgene/2023_v0.4.1/micromonospora/neo4j_db_micromonospora_base.dump`
- All RefSeq antiSMASH-7.0 BGCs:
    - `s3://socialgene/2023_v0.4.1/refseq_antismash_bgcs/neo4j_db_refseq_antismash_bgcs_base.dump`


### All files

The following files are included in the AWS S3 bucket:

```
.
├── 2023_v0.4.1
│   ├── actinomycetota
│   │   ├── neo4j_db_actinomycetota_base.dump
│   │   └── run_info
│   │       ├── execution_report_2023-12-02_06-51-28.html
│   │       ├── execution_timeline_2023-12-02_06-51-28.html
│   │       ├── execution_trace_2023-12-02_06-51-28.txt
│   │       ├── params_2023-12-02_15-33-12.json
│   │       └── pipeline_dag_2023-12-02_06-51-28.html
│   ├── documentation
│   │   ├── structure.md
│   │   └── summary.md
│   ├── hmm_models
│   │   ├── hmminfo.gz
│   │   ├── socialgene_nr_hmms_file_with_cutoffs_1_of_1.hmm.gz
│   │   └── socialgene_nr_hmms_file_without_cutoffs_1_of_1.hmm.gz
│   ├── micromonospora
│   │   ├── neo4j_db_micromonospora_base.dump
│   │   └── run_info
│   │       ├── execution_report_2023-12-03_11-49-37.html
│   │       ├── execution_timeline_2023-12-03_11-49-37.html
│   │       ├── execution_trace_2023-12-03_11-49-37.txt
│   │       ├── params_2023-12-03_16-54-34.json
│   │       └── pipeline_dag_2023-12-03_11-49-37.html
│   ├── refseq
│   │   ├── command_to_build_neo4j_database_with_docker.sh
│   │   ├── import
│   │   │   ├── antismash_results.jsonl.gz
│   │   │   ├── genomic_info
│   │   │   │   ├── 2687a0b8f048c5081fbfe919b52c1727.assemblies.gz
│   │   │   │   ├── 51f1cf08d20aa569b0822d6c2cf859c9.assembly_to_taxid.gz
│   │   │   │   ├── 8bb70ed3e5f7ee8f8d740f2184207c19.locus_to_protein.gz
│   │   │   │   ├── b3ed6e17dba5be04143622d89f77e7dd.loci.gz
│   │   │   │   └── d29bdf974a8769a329af5cc5dc5f91c6.assembly_to_locus.gz
│   │   │   ├── goterms
│   │   │   │   ├── 2068e8e87a576280156e1ec92161d019.goterm_edgelist
│   │   │   │   ├── e4916a1a9abc084c587c6172f7509118.goterms
│   │   │   │   └── versions.yml
│   │   │   ├── hmm_info
│   │   │   │   ├── 20263cb059a54d1c773a2e7a23b2c073.sg_hmm_nodes
│   │   │   │   └── 527acf97d838e23ff39ae8df6d8261a2.all.hmminfo
│   │   │   ├── mmseqs2_cluster
│   │   │   │   └── 4e75f1c51535471c3225a8bd78dd2c32.mmseqs2_results_cluster.tsv.gz
│   │   │   ├── neo4j_headers
│   │   │   │   ├── assembly.header
│   │   │   │   ├── assembly_to_locus.header
│   │   │   │   ├── assembly_to_taxid.header
│   │   │   │   ├── go_to_go.header
│   │   │   │   ├── goterms.header
│   │   │   │   ├── hmm_source.header
│   │   │   │   ├── hmm_source_relationships.header
│   │   │   │   ├── locus.header
│   │   │   │   ├── locus_to_protein.header
│   │   │   │   ├── mmseqs2.header
│   │   │   │   ├── parameters.header
│   │   │   │   ├── protein_ids.header
│   │   │   │   ├── protein_to_go.header
│   │   │   │   ├── protein_to_hmm_header.header
│   │   │   │   ├── sg_hmm_nodes.header
│   │   │   │   ├── taxid.header
│   │   │   │   ├── taxid_to_taxid.header
│   │   │   │   ├── tigrfam_mainrole.header
│   │   │   │   ├── tigrfam_role.header
│   │   │   │   ├── tigrfam_subrole.header
│   │   │   │   ├── tigrfam_to_go.header
│   │   │   │   ├── tigrfam_to_role.header
│   │   │   │   ├── tigrfamrole_to_mainrole.header
│   │   │   │   ├── tigrfamrole_to_subrole.header
│   │   │   │   └── versions.yml
│   │   │   ├── parameters
│   │   │   │   ├── d89feb1a1348b51bb4bcf295af700f51.socialgene_parameters.gz
│   │   │   │   └── versions.yml
│   │   │   ├── parsed_domtblout
│   │   │   │   ├── 40dcdeb59968818c8ef3fffa35971947.parseddomtblout.gz
│   │   │   │   └── versions.yml
│   │   │   ├── protein_info
│   │   │   │   ├── c04b2d3997942e7cb5ac7c292aa73afb.protein_to_go.gz
│   │   │   │   └── ecb0e13c7f82cc39004f9e318bdecd98.protein_ids.gz
│   │   │   ├── taxdump_process
│   │   │   │   ├── 842f6c6514f6c81e4ca6a30ce7ec9772.nodes_taxid.gz
│   │   │   │   ├── e1973763d9fb63342e7169968a572b7c.taxid_to_taxid.gz
│   │   │   │   └── versions.yml
│   │   │   └── tigrfam_info
│   │   │       ├── 2deedec3965b082a1536f2a7612820d7.tigrfamrole_to_mainrole.gz
│   │   │       ├── 3a5edc8721c146058e104678b250fff2.tigrfam_subrole.gz
│   │   │       ├── 4da23e7a3d5bb06e3cf41d8a398aeb99.tigrfam_to_go.gz
│   │   │       ├── 5ad847d09afb9716bc3c155cba2f89f3.tigrfam_mainrole.gz
│   │   │       ├── 93ad0a4066afbbf2ceb20a21a73e7178.tigrfam_role.gz
│   │   │       ├── a0d6530f10e4593fd79ba286a407ac90.tigrfamrole_to_subrole.gz
│   │   │       ├── fc03559179b378cda7d37ba580601588.tigrfam_to_role.gz
│   │   │       └── versions.yml
│   │   ├── neo4j_db_refseq_base.dump
│   │   └── run_info
│   │       ├── params_2023-11-30_18-13-52.json
│   │       └── pipeline_dag_2023-12-01_13-24-10.html
│   ├── refseq_antismash_bgcs
│   │   ├── neo4j_db_refseq_antismash_bgcs_base.dump
│   │   └── run_info
│   │       ├── execution_report_2023-12-11_15-30-04.html
│   │       ├── execution_timeline_2023-12-11_15-30-04.html
│   │       ├── execution_trace_2023-12-11_15-30-04.txt
│   │       ├── params_2023-12-12_06-00-22.json
│   │       └── pipeline_dag_2023-12-11_15-30-04.html
│   └── streptomyces
│       ├── neo4j_db_streptomyces_base.dump
│       └── run_info
│           ├── execution_report_2023-12-02_18-46-19.html
│           ├── execution_timeline_2023-12-02_18-46-19.html
│           ├── execution_trace_2023-12-02_18-46-19.txt
│           ├── params_2023-12-03_15-35-49.json
│           └── pipeline_dag_2023-12-02_18-46-19.html
└── md5checksums.txt
```


The difference between this and the Dryad-hosted databases is that the Dryad-hosted full RefSeq database is split into multiple parts. The AWS-hosted databases are not split into multiple parts. Additionally, the AWS-hosted databases include the flat file TSVs that are used to build the full SocialGene RefSeq Neo4j database. 

### Flat files

The TSV flat files are included in the `import` directory of the `refseq` database directory and may be useful for building custom databases (including non-Neo4j) or other analyses. The associations of individual flat files to their column header files are in the tables below. All of the flat files are gzip compressed even if the `.gz` extension is not present in the filename.


The paths in the table below start with the `import` directory which  is located in the `refseq` database directory (`2023_v0.4.1/refseq/import`).



|neo4j_type|neo4j_label     |neo4j_header_path                           |flat_file_path                                |
|----------|----------------|--------------------------------------------|----------------------------------------------|
|node      |tigrfam_mainrole|import/neo4j_headers/tigrfam_mainrole.header|import/tigrfam_info/\*.tigrfam_mainrole.*    |
|node      |tigrfam_subrole |import/neo4j_headers/tigrfam_subrole.header |import/tigrfam_info/\*.tigrfam_subrole.*     |
|node      |parameters      |import/neo4j_headers/parameters.header      |import/parameters/\*.socialgene_parameters.* |
|node      |hmm             |import/neo4j_headers/sg_hmm_nodes.header    |import/hmm_info/\*.sg_hmm_nodes.*            |
|node      |assembly        |import/neo4j_headers/assembly.header        |import/genomic_info/\*.assemblies.*          |
|node      |hmm_source      |import/neo4j_headers/hmm_source.header      |import/hmm_info/\*.hmminfo.*                 |
|node      |tigrfam_role    |import/neo4j_headers/tigrfam_role.header    |import/tigrfam_info/\*.tigrfam_role.*        |
|node      |goterm          |import/neo4j_headers/goterms.header         |import/goterms/\*.goterms.*                  |
|node      |protein         |import/neo4j_headers/protein_ids.header     |import/protein_info/\*.protein_ids.*         |
|node      |taxid           |import/neo4j_headers/taxid.header           |import/taxdump_process/\*.nodes_taxid.*      |
|node      |nucleotide      |import/neo4j_headers/locus.header           |import/genomic_info/\*.loci.*                |



|neo4j_type                                                                                                                     |neo4j_label                         |neo4j_header_path                                   |flat_file_path                                          |
|-------------------------------------------------------------------------------------------------------------------------------|------------------------------------|----------------------------------------------------|--------------------------------------------------------|
|relationship                                                                                                                   |GO_ANN                              |import/neo4j_headers/tigrfam_to_go.header           |import/tigrfam_info/\*.tigrfam_to_go.*                  |
|relationship                                                                                                                   |SUBROLE_ANN                         |import/neo4j_headers/tigrfamrole_to_subrole.header  |import/tigrfam_info/\*.tigrfamrole_to_subrole.*         |
|relationship                                                                                                                   |MMSEQS2                             |import/neo4j_headers/mmseqs2.header                 |import/mmseqs2_cluster/\*.mmseqs2_results_cluster.tsv.* |
|relationship                                                                                                                   |ANNOTATES                           |import/neo4j_headers/protein_to_hmm_header.header   |import/parsed_domtblout/\*.parseddomtblout.*            |
|relationship                                                                                                                   |IS_TAXON                            |import/neo4j_headers/assembly_to_taxid.header       |import/genomic_info/\*.assembly_to_taxid.*              |
|relationship                                                                                                                   |ROLE_ANN                            |import/neo4j_headers/tigrfam_to_role.header         |import/tigrfam_info/\*.tigrfam_to_role.*                |
|relationship                                                                                                                   |ENCODES                             |import/neo4j_headers/locus_to_protein.header        |import/genomic_info/\*.locus_to_protein.*               |
|relationship                                                                                                                   |SOURCE_DB                           |import/neo4j_headers/hmm_source_relationships.header|import/hmm_info/\*..hmminfo.*                           |
|relationship                                                                                                                   |TAXON_PARENT                        |import/neo4j_headers/taxid_to_taxid.header          |import/taxdump_process/\*.taxid_to_taxid.*              |
|relationship                                                                                                                   |PROTEIN_TO_GO                       |import/neo4j_headers/protein_to_go.header           |import/protein_info/\*.protein_to_go.*                  |
|relationship                                                                                                                   |ASSEMBLES_TO                        |import/neo4j_headers/assembly_to_locus.header       |import/genomic_info/\*.assembly_to_locus.*              |
|relationship                                                                                                                   |MAINROLE_ANN                        |import/neo4j_headers/tigrfamrole_to_mainrole.header |import/tigrfam_info/\*.tigrfamrole_to_mainrole.*        |

