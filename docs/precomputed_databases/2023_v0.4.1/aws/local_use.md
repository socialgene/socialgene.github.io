# Introduction to SocialGene using Precomputed databases on AWS

First a reminder that you can always make your own SocialGene database using the Nextflow workflow (https://github.com/socialgene/sgnf) which allows you to easily pull public genomes from NCBI or use your own. It also automates the download and annotation of genomic (or other) proteins with well known HMM databases, and/or your own models.

And while I engineered the pipeline to handle hundreds of thousands of genomes, large inputs do require a lot compute, memory, and storage. So, I precomputed a few databases for the community to use and am happy to announce that these are now available on AWS for free download.

Those databases include 340,000 genomes from NCBI RefSeq and smaller subsets of that for Actinomycetota, *Streptomyces*, and *Micromonospora*.  Additionally, antiSMASH v7 was used to compute BGC regions across all 340,000 RefSeq genomes and we have made that SocialGene database available as well.

You can find the space requirements for each of the databases [here](https://socialgene.github.io/precomputed_databases/2023_v0.4.1/general/#databases-and-their-disk-space-requirements)

## Getting started

Note:
   To run this tutorial you will need Docker installed (this isn't mandatory, you can install Neo4j manually but it won't be covered here)
   I also will assume we are using a Linux machine, but the commands should be similar for MacOS and Windows WSL2.

All of the files available on AWS are listed [here](https://socialgene.github.io/precomputed_databases/2023_v0.4.1/aws/aws/#all-files).

We can also see that using the AWS CLI:

```sh
aws s3 ls socialgene-open-data --recursive --human-readable --no-sign-request
```

## Downloading the smallest database

Download the smallest database to the local machine:
```sh
wget https://socialgene-open-data.s3.amazonaws.com/2023_v0.4.1/methods_comparison/methods_comparison.dump
```


Now we will have a single file in the current directory called `methods_comparison.dump`. This is a Neo4j database dump file that we will use to create a Neo4j database. More information about how to create and restore SocialGene database dumps can be found [here](https://socialgene.github.io/neo4j/database_backups).



## Rehydrating the database

To restore the database, we will follow the directions and code provided [here](https://socialgene.github.io/neo4j/database_backups/#restore-from-a-full-database-dumpbackup).

You can replace `${PWD}` with the path to the directory where you downloaded the database dump file.


```sh
dump_path="${PWD}/methods_comparison.dump"
sg_neoloc="${PWD}"
pipeline_version='latest'

# mkdir because the docker image will create directories as root if they don't exist
mkdir -p $sg_neoloc/data
mkdir -p $sg_neoloc/logs
mkdir -p $sg_neoloc/plugins
mkdir -p $sg_neoloc/conf
mkdir -p $sg_neoloc/import

docker run \
    --user=$(id -u):$(id -g) \
    --interactive \
    --tty \
    --rm \
    --volume=$sg_neoloc/data:/opt/conda/bin/neo4j/data \
    --volume=$sg_neoloc/plugins:/opt/conda/bin/neo4j/plugins \
    --volume=$sg_neoloc/logs:/opt/conda/bin/neo4j/logs \
    --volume=$dump_path:/opt/conda/bin/neo4j/neo4j.dump \
    --env NEO4J_AUTH=neo4j/test \
    chasemc2/sgnf-sgpy:1.2.2 \
        neo4j-admin database load \
            --from-path=. \
            neo4j
```

## Launching the database

Now we can launch the database. Full documentation on this step is available [here](https://socialgene.github.io/neo4j/database_launch).

```sh
sg_neoloc=$PWD

NEO4J_server_memory_heap_initial__size='4600m'
NEO4J_server_memory_heap_max__size='4600m'
NEO4J_server_memory_pagecache_size='4g'

mkdir -p $sg_neoloc/conf
# Allow import and export of files from database
echo 'apoc.export.file.enabled=true' > $sg_neoloc/conf/apoc.conf
echo 'apoc.import.file.enabled=true' >> $sg_neoloc/conf/apoc.conf
echo 'apoc.export.file.use_neo4j_config=false' >> $sg_neoloc/conf/apoc.conf
echo 'apoc.import.file.use_neo4j_config=false' >> $sg_neoloc/conf/apoc.conf
# Set import/export of files from database to $sg_neoloc/import
echo 'server.directories.import=/opt/conda/bin/neo4j/import' >> $sg_neoloc/conf/neo4j.conf
echo 'server.directories.export=/opt/conda/bin/neo4j/import' >> $sg_neoloc/conf/neo4j.conf

docker run \
    --user=$(id -u):$(id -g) \
    -p7474:7474 -p7687:7687 \
    -v $sg_neoloc/data:/data \
    -v $sg_neoloc/logs:/logs \
    -v $sg_neoloc/import:/opt/conda/bin/neo4j/import \
    -v $sg_neoloc/plugins:/plugins \
    -v $sg_neoloc/conf:/opt/conda/bin/neo4j/conf \
        --env NEO4J_AUTH=neo4j/test12345 \
        --env NEO4J_PLUGINS='["apoc", "graph-data-science"]' \
        --env NEO4J_dbms_security_procedures_unrestricted=algo.*,apoc.*,gds.*, \
        --env NEO4J_dbms_security_procedures_allowlist=algo.*,apoc.*,gds.* \
        --env NEO4J_server_config_strict__validation_enabled=false \
        --env NEO4J_server_memory_heap_initial__size=$NEO4J_server_memory_heap_initial__size \
        --env NEO4J_server_memory_heap_max__size=$NEO4J_server_memory_heap_max__size \
        --env NEO4J_server_memory_pagecache_size=$NEO4J_server_memory_pagecache_size \
        --env NEO4J_server_jvm_additional='-XX:+ExitOnOutOfMemoryError' \
    neo4j:5.17.0
```

