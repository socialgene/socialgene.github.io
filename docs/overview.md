## System Requirements

This tutorial assumes you already have [git](https://github.com/git-guides/install-git), [conda](https://docs.conda.io/en/latest/miniconda.html) and [Docker](https://docs.docker.com/get-docker/) installed on your computer.

SocialGene was developed and tested on Ubuntu Linux. Because everything is Conda-ized/Docker-ized I see no reason that would prevent it from working on Mac or Windows given you have Conda and Docker successfully installed on those systems; that said, support for those OSs may be minimal.

## Setting up SocialGene with Make

There is a [Makefile](https://opensource.com/article/18/8/what-how-makefile) in the top directory that makes it easy to perform a majority (if not all) of the things you might want to do.

### Download socialgene

Download the socialgene repository

```bash
git clone https://github.com/chasemc/socialgene.git
```

### Install socialgene and its dependencies

Move to the socialgene directory....

```bash
cd socialgene
```

Create a Conda environment:

```bash
make create_conda
```

**Note**: If you receive an error saying you don't have Make you can just run the Conda create manually and manually install Make within that Conda environment:

```bash
conda env create --file conda_environment.yml
conda activate socialgene
conda install -c anaconda make  
```

To test that socialgene is correctly installed you can run the python test:

```bash
pip install coverage pytest
make pytest
```

## Configuration

Nearly all of SocialGene's parameters are contained in one file `common_parameters.env`. (You may notice the file is seen in a couple of places but it's all the same file and modifications to any one `common_parameters.env` will modify all `common_parameters.env` files- the actual file is in `./socialgene/src/socialgene/common_parameters.env`) Settings specified here have effects in the Python package (and therefore Nextflow) and Django app.

## Creating the Neo4j Database

### Creating a Nextflow configuration file

The easiest way to get started is to use the example, basic Nextflow configuration file (it's located in: `~/nextflow/conf/examples/simple_run.config`)

Open that file and take a look at the values within the `params{ ... }` block

Change the memory and cpu values to fit your computer.


### Selecting the "modules" you want to use

Currently you can choose between `hmms`, `mmseqs2`, or `blastp` for making protein-protein connections in the database

MMseqs2 is quite fast and can be used for most data sizes. On the other hand, the all-vs-all Diamond Blastp option isn't super fast and will generate larger outputs (~40GB for 200 genomes), so only set it to true if you have a descent number of cpu cores and less than maybe a couple dozen input genomes.

`builddb` is set to `true` or `false` and tells determines whether the last step, building the Neo4j database, should be performed. If set to `false`, all data gathering and processing steps will still be performed, only the final database import step will be skipped.

If you're using genomes from NCBI and `ncbi_taxonomy = true` then the NCBI taxonomy database will be downloaded, formatted and included in the graph database.

### Running the Nextflow pipeline

Set where you want all the files to write to (the `outdir` below), and run the Nextflow pipeline.

```bash
outdir="/home/chase/Documents/socialgene_data/micromonospora"

nextflow run nextflow \
    -profile simple_run,conda \
    --outdir_per_run $outdir/run_info \
    --outdir_neo4j "$outdir/neo4j" \
    --outdir_long_cache "$outdir/long_cache"  \
    -resume  
```

- `outdir_per_run` will contain information about the run (timings, memory used, etc)
- `outdir_neo4j` will contain **both** the neo4j database **and** the files used to create it/import
  - This directory structure is required for import step when creating the neo4j database. If you won't need to "resume" the nextflow pipeline the `import` directory can be deleted
- `outdir_long_cache` contains things like the HMM models which shouldn't vary between runs of the workflow.

### Making things faster by parallelizing

Note:  The PYHMMER annotation step will finish faster if the proteins are split and provided in parallel. To do this, append `--fasta_splits` to the Nextflow command above and set the number of splits to perform (e.g. `--fasta_splits 12`). At the bottom of the `simple_run.config file you'll notice:

```base
process {
 withName:PYHMMER {
        cpus   = { check_max( 2    * task.attempt, 'cpus'    ) }
        memory = { check_max( 2 * task.attempt, 'memory'  ) }
        time   = { check_max( 600.h  * task.attempt, 'time'    ) }
    }
}
```

A good rule of thumb is to set this process' cpus to `2` as shown here, and to set `--fasta_splits` to at least 1/2 the `max_cpus` argument. For large datasets setting this even higher will allow following progress of the task easier and provide more checkpoints if something fails along the way and the pipeline has to be restarted.

### Nextflow Pipeline Execution Time

The length of time the pipeline takes relies heavily on the number of cores used (and possibly RAM (when using pyHMMER)), so estimates are difficult. On my work desktop (AMD® Ryzen 9 3900xt 12-core processor × 24 | 62.7 GiB RAM) a single genome will finish in a couple minutes (When starting from scratch, usually downloading PFAM is the longest step), and annotating all Micromonospora (~200 genomes) may take a couple of hours. On our lab's server (100 logical cores | 1 TB RAM ) using 40 logical cores, a couple thousand genomes ran through in just under 24 hours (though this was done while under concurrent heavy use by others).

## Running the Django app

Instructions to run the Django app in "local" mode/not-production mode (currently the only mode).

### Adjusting parameters before starting

Make sure you're in the top socialgene directory and have adjusted any necessary parameters in  `common_parameters.env`. Set the `HMM_LOCATION` variable to the full path of the HMMs file created from the Nextflow pipeline (`/home/chase/my_outdir/socialgene_long_cache/hmm_hash/socialgene_nr_hmms_file_1_of_1.hmm`) You shouldn't need to but if you changed any of the `HMMSEARCH...` parameters while creating the database, those settings should be exactly the same when launching the Django app. Additionally the file containing the HMMs created from the Nextflow pipeline should be.

Neo4j memory constraints are also set from within the `common_parameters.env` file. See Neo4j memory configuration for info on how to determine optimal values.

```bash
NEO4J_dbms_memory_pagecache_size=3g
NEO4J_dbms_memory_heap_initial__size=4g
NEO4J_dbms_memory_heap_max__size=4g
```

## Building and running the Djang Docker containers

To start the Django and peripheral docker containers:

```bash
make django_up
```

Note: the first time running docker compose will take a while to download/build all the images

## Connecting to Django

To use the app, open a browser and go to the url: [`127.0.0.1:8009`](https://localhost:8009)

Stop all the containers with

```bash
make down
```

You can check the status of all running containers using the following:

```bash
docker ps
```

## Querying the database directly, from Neo4j's browser view

When complete, you have the option of viewing the database within Neo4j's browser (but you'll need to know Cypher to do much there <https://neo4j.com/developer/cypher/>)

Note: if the Django app is already running on your computer you can skip running Docker commands below.

### Neo4j memory configuration

You will need to select the amount of memory Neo4j can use, this is set within the `NEO4J MEMORY LIMITS`section of the `common_parameters.env` file.

Noe4j can help you determine the correct values. To do so run the following, substituting the amount of RAM you want to dedicate to Neo4j in `ram_to_provide_to_neo4j`

```bash
ram_to_provide_to_neo4j=60G

docker run \
    --user="$(id -u)":"$(id -g)" \
    --env NEO4J_AUTH=neo4j/test \
    --interactive \
    --tty \
    neo4j:4.4.7 \
        neo4j-admin \
            memrec \
                --memory=$ram_to_provide_to_neo4j \
                --verbose \
                --docker
```

For more detailed info on memory settings in Neo4j refer to [the Neo4j memrec documentation page](https://neo4j.com/docs/operations-manual/current/tools/neo4j-admin/neo4j-admin-memrec/).

### Launching Neo4j alone

An example of launching the database directly:
Set sg_neoloc to the "neo4j" directory, the one containing "import", "data", etc

```bash
sg_neoloc='/home/chase/Documents/socialgene_data/297c364c-b154-4edd-a7d5-68decf9effa2/socialgene_neo4j'
sg_neoloc='/home/chase/Documents/socialgene_data/input_examples/socialgene_neo4j'

docker run \
    --user=$(id -u):$(id -g) \
    -p7474:7474 -p7687:7687 \
    -v $sg_neoloc/data:/data \
    -v $sg_neoloc/logs:/logs \
    -v $sg_neoloc/import:/var/lib/neo4j/import \
    -v $sg_neoloc/plugins:/plugins \
    --env NEO4J_AUTH=neo4j/test \
       --env NEO4J_apoc_export_file_enabled=true \
       --env NEO4J_apoc_import_file_enabled=true \
       --env NEO4J_apoc_import_file_use__neo4j__config=true \
       --env NEO4JLABS_PLUGINS=\[\"apoc\"\] \
       --env NEO4J_dbms_security_procedures_unrestricted=gds.\\\*,algo.*,apoc.*\
       --env NEO4J_dbms_security_procedures_allowlist=gds.*,algo.*,apoc.* \
       --env NEO4J_dbms_memory_heap_initial__size='23000m' \
       --env NEO4J_dbms_memory_heap_max__size='23000m' \
       --env NEO4J_dbms_memory_pagecache_size='20g' \
       --env NEO4J_dbms_jvm_additional='-XX:+ExitOnOutOfMemoryError' \
    neo4j:4.4.7

```

<div id="video" class="tabcontent" style="display:inline-block;width: 75%">
<script id="asciicast-bKeOmGonFS9vPtWbgOm2GrqhS" src="https://asciinema.org/a/bKeOmGonFS9vPtWbgOm2GrqhS.js" async></script>
</div>

You can then open the Neo4j database in a web browser by typing `localhost:7474` in the url bar.

To make socialgene queries faster you can add a couple indices for protein and hmm IDs using the following commands in the neo4j browser:

`CREATE CONSTRAINT ON (n:protein) ASSERT n.id IS UNIQUE`

`CREATE CONSTRAINT ON (n:hmm) ASSERT n.id IS UNIQUE`

## Other MAKE commands

More make commands can be found by looking through the `Makefile` file or by running

```bash
make help
```
