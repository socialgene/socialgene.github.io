When running the ultraquickstart command we provided a `--outdir $outdir` parameter to the Nextflow pipeline. This outputs all results into the provided directory; note: if Nextflow can't find the directory it will create the entire filepath provided.

Within this top directory ("📦ultraquickstart" above) there are three directories (for this example):

```
┣ 📂genome_downloads
┣ 📂socialgene_neo4j
┗ 📂socialgene_per_run
```

- 📂genome_downloads
  - contains... the downloaded genome files
- 📂socialgene_per_run
  - contains files that are specific to the Nextflow run but not included in the database
    - BLASTp database of the nonredundant proteins
    - MMseqs2 results (clustered fasta)
    - Reports/stats about the Nextflow run
- 📂socialgene_neo4j
  - contains all the files for import into the Neo4j Database, as well as the Neo4j Database
  - The Neo4j Docker image is pointed directly at the `📂socialgene_neo4j` directory, the structure is important (Neo4j looks for each of the directtories). If you delete one of the subdirectories (`data`, `import`, `logs`, `plugins`) the Neo4j Docker image will make it again, but as root user.
  - 📂data
    - contains the Neo4j database
  - 📂import
    - contains the files imported into Neo4j (Docker Neo4j will also write outputs here)
  - 📂logs
    - Ne4j logs
  - 📂plugins
    - Neo4j plugins

```
📦ultraquickstart
┣ 📂genome_downloads
┃ ┗ 📂ncbi_datasets_download
┃ ┃ ┗ 📂ncbi_dataset
┃ ┃ ┃ ┗ 📂data
┃ ┃ ┃ ┃ ┗ 📂GCA_000005845.2
┣ 📂socialgene_neo4j
┃ ┣ 📂data
┃ ┃ ┣ 📂databases
┃ ┃ ┃ ┗ 📂neo4j
┃ ┃ ┗ 📂transactions
┃ ┃ ┃ ┗ 📂neo4j
┃ ┣ 📂import
┃ ┃ ┣ 📂diamond_blastp
┃ ┃ ┣ 📂genomic_info
┃ ┃ ┣ 📂hmm_tsv_parse
┃ ┃ ┣ 📂mmseqs2_easycluster
┃ ┃ ┣ 📂neo4j_headers
┃ ┃ ┣ 📂parameters
┃ ┃ ┣ 📂parsed_domtblout
┃ ┃ ┣ 📂protein_info
┃ ┃ ┗ 📂taxdump_process
┃ ┣ 📂logs
┃ ┗ 📂plugins
┗ 📂socialgene_per_run
┃ ┣ 📂blastp_cache
┃ ┣ 📂hmm_cache
┃ ┣ 📂mmseqs2_cache
┃ ┗ 📂pipeline_info
```

---

Using `--outdir` is the easiest option but if, for example, you want to download all the genomes to a different, specified directory, there are other options within the nextflow pipeline (e.g. `--outdir_genomes`).
