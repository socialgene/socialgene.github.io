### Neo4j memory configuration

You will need to select the amount of memory Neo4j will be allowed to use, this is set within the `NEO4J MEMORY LIMITS` section of the `common_parameters.env` file; or through the docker run command.

It's hard to estimate but for optimal performance `ram_to_provide_to_neo4j` below should probably be around the size of the database on disk +10-20%, however it will run with significantly less than that (e.g. A 50-gene BGC was searched against the 500GB RefSeq database using only `ram_to_provide_to_neo4j=5GB`), it will just require more disk I/O which means it will become dependent on hard drive speed.

The size of the database on disk can be found by looking at the size of the "socialgene_neo4j/data" directory which is located where you specified `--outdir` when running the Nextflow workflow:

=== "shell"
```
du -sh $outdir/socialgene_neo4j/data
10G    ./socialgene_neo4j/data
```

Noe4j can help you determine memory settings based on a given total RAM to make available. To do so run the following, substituting the amount of RAM you want to dedicate to Neo4j in `ram_to_provide_to_neo4j`. Continuing the example above, we'll set `ram_to_provide_to_neo4j` to 10GB plus 20%

=== "shell"
```
ram_to_provide_to_neo4j=12G
pipeline_version='latest'

docker run \
    --user="$(id -u)":"$(id -g)" \
    --env NEO4J_AUTH=neo4j/test \
    --interactive \
    --tty \
    chasemc2/sgnf-sgpy:$pipeline_version \
        neo4j-admin \
            server memory-recommendation \
                --memory=$ram_to_provide_to_neo4j \
                --verbose \
                --docker
```

That will spit out a lot of text, but the important lines we'll steal are:

=== "shell"
```
NEO4J_server_memory_heap_initial__size='4600m'
NEO4J_server_memory_heap_max__size='4600m'
NEO4J_server_memory_pagecache_size='4g'
```

Which can be used to modifiy the respective lines of the docker command under the ["Launching Neo4j"](advanced_start.md#launching-neo4j) section below.

For more detailed info on memory settings in Neo4j refer to [the Neo4j memrec documentation page](https://neo4j.com/docs/operations-manual/current/tools/neo4j-admin/neo4j-admin-memrec/).

### Launching Neo4j

An example of launching the database directly:
Set sg_neoloc below to the "neo4j" directory, this is the directory created by Nextflow workflow containing the folders "import", "data", etc
And set the memory values to be the results from ["Neo4j memory configuration"](advanced_start.md#neo4j-memory-configuration) above.

=== "shell"
```bash
sg_neoloc='/my/nextflow_outdir/socialgene_neo4j'

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
```

=== "shell"
```bash
pipeline_version='latest'

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
        --env NEO4J_dbms_security_procedures_unrestricted=algo.*,apoc.*,n10s.*,gds.*, \
        --env NEO4J_dbms_security_procedures_allowlist=algo.*,apoc.*,n10s.*,gds.* \
        --env NEO4J_server_config_strict__validation_enabled=false \
        --env NEO4J_server_memory_heap_initial__size=$NEO4J_server_memory_heap_initial__size \
        --env NEO4J_server_memory_heap_max__size=$NEO4J_server_memory_heap_max__size \
        --env NEO4J_server_memory_pagecache_size=$NEO4J_server_memory_pagecache_size \
        --env NEO4J_server_jvm_additional='-XX:+ExitOnOutOfMemoryError' \
    chasemc2/sgnf-sgpy:$pipeline_version

```

If you have paid for the enterprise version of Neo4j you can use the following:

```
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
        --env NEO4J_dbms_security_procedures_unrestricted=algo.*,apoc.*,n10s.*,gds.*, \
        --env NEO4J_dbms_security_procedures_allowlist=algo.*,apoc.*,n10s.*,gds.* \
        --env NEO4J_server_config_strict__validation_enabled=false \
        --env NEO4J_server_memory_heap_initial__size=$NEO4J_server_memory_heap_initial__size \
        --env NEO4J_server_memory_heap_max__size=$NEO4J_server_memory_heap_max__size \
        --env NEO4J_server_memory_pagecache_size=$NEO4J_server_memory_pagecache_size \
        --env NEO4J_server_jvm_additional='-XX:+ExitOnOutOfMemoryError' \
        --env NEO4J_ACCEPT_LICENSE_AGREEMENT='yes' \
    neo4j:5.17.0-enterprise
```

<div id="video" class="tabcontent" style="display:inline-block;width: 75%">
<script id="asciicast-bKeOmGonFS9vPtWbgOm2GrqhS" src="https://asciinema.org/a/bKeOmGonFS9vPtWbgOm2GrqhS.js" async></script>
</div>

You can then open the Neo4j database in a web browser by typing `localhost:7474` in the url bar.
