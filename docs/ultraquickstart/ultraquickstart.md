## Preface

This tutorial assumes you already have [Nextflow](/nextflow/setup){: target='_blank'} and [Docker](https://docs.docker.com/get-docker/){: target='_blank'} installed.


## Create a SocialGene Database

### Pull the latest version of SocialGene's Nextflow workflow

```
nextflow pull socialgene/sgnf
```

### Run the Nextflow pipeline

Assign `outdir` and `outdir_download_cache` paths below with the paths you want the results to be placed into. Open bash or whatever shell you use, run the commands, and (fingers-crossed) watch the magic happen.

```bash
outdir='/tmp/socialgene_data/ultraquickstart'
outdir_download_cache='/tmp/socialgene_data/cache'

nextflow run socialgene/sgnf \
    -profile ultraquickstart,docker \
    --outdir $outdir \
    --outdir_download_cache $outdir_download_cache \
    --max_cpus 4 \
    --max_memory 4.GB \
    -resume
```

## Launch the database

Notice that the `sg_neoloc` path below is the `$outdir` path from above plus `/socialgene_neo4j` (the newly created neo4j database directory)

```bash
sg_neoloc='/tmp/socialgene_data/ultraquickstart/socialgene_neo4j'

docker run \
    --user=$(id -u):$(id -g) \
    -p7474:7474 -p7687:7687 \
    -v $sg_neoloc/data:/data \
    -v $sg_neoloc/logs:/logs \
    -v $sg_neoloc/import:/var/lib/neo4j/import \
    -v $sg_neoloc/plugins:/plugins \
    -v $sg_neoloc/conf:/var/lib/neo4j/conf \
        --env NEO4J_AUTH=neo4j/test12345 \
        --env NEO4J_PLUGINS='["apoc", "graph-data-science"]' \
        --env NEO4J_dbms_security_procedures_unrestricted=algo.*,apoc.*,n10s.*,gds.*, \
        --env NEO4J_dbms_security_procedures_allowlist=algo.*,apoc.*,n10s.*,gds.* \
        --env NEO4J_server_config_strict__validation_enabled=false \
        --env NEO4J_server_memory_heap_initial__size='4G' \
        --env NEO4J_server_memory_heap_max__size='4G' \
        --env NEO4J_server_memory_pagecache_size='3G' \
        --env NEO4J_server_jvm_additional='-XX:+ExitOnOutOfMemoryError' \
    neo4j:5.7.0
```

If you get some error about ports being unavailable/used, you'll want to change the line `-p7474:7474 -p7687:7687`.
The first number before the colon is what you'll change, the new number(s) will be what you use for the address below (under "Look at what you've made!"). For detailed info about port configuration in NEO4J see: [https://neo4j.com/docs/operations-manual/current/configuration/connectors](https://neo4j.com/docs/operations-manual/current/configuration/connectors){: target='_blank'}


## Look at what you've made!

Open an internet browser and go to the url: `http://localhost:7474`.

You should see a login screen:
![Neo4j web page, logging in](./media/localhost_login.png)

The username/password were set inside the `docker run` command (`--env NEO4J_AUTH=neo4j/test12345`). In this case the username was `neo4j` and password was `test12345`.

After authenticating you should be able to see the database entries and start querying the database:
![Neo4j web page, logged in](./media/localhost_logged_in.png)
