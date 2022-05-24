## Overview

Socialgene consists of three components:

1. `/socialgene`: a Python package
    - Contains the logic for a lot of the data transformations used to build the database.
    - Contains functions for transforming data for input query data
    - Contains the functions underlying the REST queries
2. `/nextflow`: a Nextflow/nf-core workflow
    - Used to generate the large database.
    - It uses the Python package (#1)
3. `/django`: a Django web site
    - Used to query the database, initiate socialgene python scripts, and visualize results.
    - Fairly trivial to setup your own instance using `docker-compose`

The general flow starts with creating a socialgene Neo4j database. This is done using a Nextflow pipeline which handles...

- Downloading, upconverting, andalyzing, and reducing duplicate HMMs
- Downloading genomes from NCBI
- Creating and HMM-annotating a set of non-redundant proteins from the input genomes
  - Can also compare input proteins with BLASTp and MMseqs2
- Creating all the necessary data and input files for importing into a Neo4j graph database
- Creating the Neo4j graph database

It is best to run the pipeline on a machine that has a decent number of CPUs. A few hundred genomes (*Micromonospora*) should finnish in a couple hours on a 12-core machine. Anywhere to 100's-1000's may take a good number of hours/potentially days if using all available HMMs. For >10000 genomes it's advisable to split and run on a cluster. For repository-scale annotations we're leveraging thousands of CPUs through CHTC and the Open Science Grid.

If you haven't already, create and enter socialgene's conda environment.

```bash
make create_conda
conda activate socialgene
```

Run the nextflow test pipeline. Change the outdirs to the desired locations.  

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

---

## Django interface

### Create a superuser/admin account

Must be done after running `make up` at least once so the postgres database gets created.

```bash
make manage createsuperuser
```

### Celery task handler info

- tips
  - <https://www.vinta.com.br/blog/2018/celery-wild-tips-and-tricks-run-async-tasks-real-world/>
