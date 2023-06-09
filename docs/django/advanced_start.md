## Adjusting parameters before starting

Make sure you're in the top SocialGene directory () and have adjusted any necessary parameters in `common_parameters.env`. Set the `HMM_LOCATION` variable to the full path of the HMMs file created from the Nextflow pipeline (`/home/chase/my_outdir/socialgene_long_cache/hmm_hash/socialgene_nr_hmms_file_1_of_1.hmm`) You shouldn't need to but if you changed any of the `HMMSEARCH...` parameters while creating the database, those settings should be exactly the same when launching the Django app. Additionally the file containing the HMMs created from the Nextflow pipeline should be.

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
ram_to_provide_to_neo4j=40G

docker run \
    --user="$(id -u)":"$(id -g)" \
    --env NEO4J_AUTH=neo4j/test \
    --interactive \
    --tty \
    neo4j:5.1.0 \
        neo4j-admin \
            server memory-recommendation \
                --memory=$ram_to_provide_to_neo4j \
                --verbose \
                --docker
```

For more detailed info on memory settings in Neo4j refer to [the Neo4j memrec documentation page](https://neo4j.com/docs/operations-manual/current/tools/neo4j-admin/neo4j-admin-memrec/).

### Launching Neo4j alone

An example of launching the database directly:
Set sg_neoloc below to the "neo4j" directory, this is the directory containing "import", "data", etc

```bash

sg_neoloc='/home/chase/Documents/socialgene_data/older/mibig2/socialgene_neo4j'

mkdir -p $sg_neoloc/conf
echo 'apoc.export.file.enabled=true' > $sg_neoloc/conf/apoc.conf
echo 'apoc.import.file.enabled=true' >> $sg_neoloc/conf/apoc.conf
echo 'apoc.export.file.use_neo4j_config=false' >> $sg_neoloc/conf/apoc.conf
echo 'apoc.import.file.use_neo4j_config=false' >> $sg_neoloc/conf/apoc.conf
echo 'server.directories.import=/var/lib/neo4j/import' >> $sg_neoloc/conf/neo4j.conf
echo 'server.directories.export=/var/lib/neo4j/import' >> $sg_neoloc/conf/neo4j.conf

# curl https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/5.1.0/apoc-5.1.0-extended.jar > $sg_neoloc/plugins/apoc-5.1.0-extended.jar
# wget https://github.com/xerial/sqlite-jdbc/releases/download/3.40.1.0/sqlite-jdbc-3.40.1.0.jar


docker run \
    --user=$(id -u):$(id -g) \
    -p7474:7474 -p7687:7687 \
    -v $sg_neoloc/data:/data \
    -v $sg_neoloc/logs:/logs \
    -v $sg_neoloc/import:/var/lib/neo4j/import \
    -v $sg_neoloc/plugins:/plugins \
    -v $sg_neoloc/conf:/var/lib/neo4j/conf \
        --env NEO4J_AUTH=neo4j/test \
        --env NEO4J_PLUGINS='["apoc"]' \
        --env NEO4J_dbms_security_procedures_unrestricted=algo.*,apoc.*,n10s.*, \
        --env NEO4J_dbms_security_procedures_allowlist=algo.*,apoc.*,n10s.* \
        --env NEO4J_server_config_strict__validation_enabled=false \
        --env NEO4J_server_memory_heap_initial__size='15g' \
        --env NEO4J_server_memory_heap_max__size='40g' \
        --env NEO4J_server_memory_pagecache_size='16g' \
        --env NEO4J_server_jvm_additional='-XX:+ExitOnOutOfMemoryError' \
    neo4j:5.1.0

```



<div id="video" class="tabcontent" style="display:inline-block;width: 75%">
<script id="asciicast-bKeOmGonFS9vPtWbgOm2GrqhS" src="https://asciinema.org/a/bKeOmGonFS9vPtWbgOm2GrqhS.js" async></script>
</div>

You can then open the Neo4j database in a web browser by typing `localhost:7474` in the url bar.

To make SocialGene queries faster you can add a couple indices for protein and hmm IDs using the following commands in the neo4j browser:

`CREATE CONSTRAINT ON (n:protein) ASSERT n.id IS UNIQUE`

`CREATE CONSTRAINT ON (n:hmm) ASSERT n.id IS UNIQUE`

## Other MAKE commands

More make commands can be found by looking through the `Makefile` file or by running

```bash
make help
```
