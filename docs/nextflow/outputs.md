- When running the Nextflow workflow we provided a `--outdir "my_results_directory"` parameter. This outputs all results into the provided directory; note: if Nextflow can't find the directory it will create the entire filepath provided.
- Additionally, files that don't change between runs (e.g. downloaded HMM models) are stored for long term use into the path specified by `--outdir_download_cache`.


Within the `--outdir`directory (show above as set to "my_results_directory") the workflow will create two directories `./socialgene_neo4j` and `./socialgene_neo4j`.

```
┣ 📂 socialgene_per_run
┗ 📂 socialgene_neo4j
```

```
┣ 📂 socialgene_per_run (contains files that are specific to the Nextflow run but not included in the database)
  ┣ 📂 antismash_results
  ┣ 📂 blastp_cache (DIAMOND database)
  ┣ 📂 hmm_cache (processed HMM files)
  ┣ 📂 mmseqs_databases (MMseqs2 cluster database(s))
  ┣ 📂 nonredundant_fasta (non-redundant, indexed protein fasta)
  ┣ 📂 pipeline_info (stats about the workflow run)
```

```
┣ 📂 socialgene_neo4j
  - contains all the files for import into the Neo4j Database, as well as the Neo4j Database
  - To run the database, the Neo4j Docker image is pointed directly at the `📂 socialgene_neo4j` directory, the structure is important (Neo4j looks for each of the directories). If you delete one of the subdirectories (`data`, `import`, `logs`, `plugins`) and don't recreate it the Neo4j Docker image will make it again, but as root user, and you will only be able to delete if you have sudo permissions.
  ┣ 📂 data (contains the Neo4j database)
  ┣ 📂 import (contains gzipped tsv files that were used to import data into Neo4j)
  ┣ 📂 logs (Neo4j runtime logs)
  ┣ 📂 plugins (Neo4j plugins (apoc, gds, etc.))
  ┣ 📄 import.report (contains report of all warnings and errors during database import creation)  
```
