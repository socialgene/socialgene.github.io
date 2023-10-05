## Running the Database with Slurm

Save the script below as `launch-sg-database.sh`.

Modify `sg_neoloc`variable to the filepath of the database (directory containing `data`, `logs`, `import`, `plugins`, and `conf`)
Modify cpu, memory, and time requirements as needed.


And then launch with `srun launch-sg-database.sh`
To launch in the background use `sbatch launch-sg-database.sh`


```shell
#!/bin/bash
#
#SBATCH --job-name=sg-database
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 4
#SBATCH --mem-per-cpu=60G
#SBATCH --time=24:00:00
#SBATCH -o sg-database.%N.%j.out # STDOUT
#SBATCH -e sg-database.%N.%j.err # STDERR

sg_neoloc='/tmp/sg'


# ram_to_provide_to_neo4j=60G

# docker run \
#     --user="$(id -u)":"$(id -g)" \
#     --env NEO4J_AUTH=neo4j/test \
#     --interactive \
#     --tty \
#     neo4j:5.7.0 \
#         neo4j-admin \
#             server memory-recommendation \
#                 --memory=$ram_to_provide_to_neo4j \
#                 --verbose \
#                 --docker



NEO4J_server_memory_heap_initial__size='23000m'
NEO4J_server_memory_heap_max__size='23000m'
NEO4J_server_memory_pagecache_size='26g'


mkdir -p $sg_neoloc/conf
# Allow import and export of files from database
echo 'apoc.export.file.enabled=true' > $sg_neoloc/conf/apoc.conf
echo 'apoc.import.file.enabled=true' >> $sg_neoloc/conf/apoc.conf
echo 'apoc.export.file.use_neo4j_config=false' >> $sg_neoloc/conf/apoc.conf
echo 'apoc.import.file.use_neo4j_config=false' >> $sg_neoloc/conf/apoc.conf
# Set import/export of files from database to $sg_neoloc/import
echo 'server.directories.import=/var/lib/neo4j/import' >> $sg_neoloc/conf/neo4j.conf
echo 'server.directories.export=/var/lib/neo4j/import' >> $sg_neoloc/conf/neo4j.conf


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
        --env NEO4J_server_memory_heap_initial__size=$NEO4J_server_memory_heap_initial__size \
        --env NEO4J_server_memory_heap_max__size=$NEO4J_server_memory_heap_max__size \
        --env NEO4J_server_memory_pagecache_size=$NEO4J_server_memory_pagecache_size \
        --env NEO4J_server_jvm_additional='-XX:+ExitOnOutOfMemoryError' \
    neo4j:5.7.0

```
