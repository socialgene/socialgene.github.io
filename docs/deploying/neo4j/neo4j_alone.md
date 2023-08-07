## Running Neo4j by itself

If you want to start a connection to the neo4j database without Django, etc.

Change the location of the neo4j database (directory containing the `data` directory) in the command below

=== "shell"
```bash
sg_neoloc='/path/to/neo4j/database'
```

If that directory is missing any of the folders:
`logs`
`import`
`plugins`

Set the `sg_neoloc` variable as shown above and then `mkdir` the missing directory (e.g. `mkdir $sg_neoloc/logs`)

Then run the following to start the Docker container:

=== "shell"
```bash
sg_neoloc='/path/to/neo4j/database'

docker run \
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
       --env NEO4J_dbms_memory_heap_initial__size='4g' \
       --env NEO4J_dbms_memory_heap_max__size='4g' \
       --env NEO4J_dbms_memory_pagecache_size='3g' \
       --env NEO4J_dbms_jvm_additional='-XX:+ExitOnOutOfMemoryError' \
    neo4j:4.4.7

```

To stop it, find the `CONTAINER ID` by running `docker ps`. Replace container_id in `docker stop container_id` then run the command to stop the container.
