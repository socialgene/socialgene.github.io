
## Create a full database dump/backup

The following takes a database named "neo4j" found in `database/location/socialgene_neo4j` and creates a single dump file at `database/location/socialgene_neo4j/backups/neo4j.dump`. While it will be smaller than the space occupied by the `database/location/socialgene_neo4j` directory, the file can still be quite large.

=== "shell"
```bash

sg_neoloc='database/location/socialgene_neo4j'
# mkdir because the docker image will create dirs as root if they don't exist
mkdir -p $sg_neoloc/backups

docker run \
    --user=$(id -u):$(id -g) \
    --interactive \
    --tty \
    --rm \
    --volume=$sg_neoloc/data:/data \
    --volume=$sg_neoloc/backups:/backups \
    --env NEO4J_AUTH=neo4j/test \
    neo4j/neo4j-admin:5.7.0 \
        neo4j-admin database dump \
            --to-path=/backups \
            neo4j
```

## Load a full database dump/backup

Given a Neo4j database dump file at path `database/location/socialgene_neo4j/neo4j.dump`

=== "shell"
```bash
sg_neoloc='database/location/socialgene_neo4j'
dump_path=${sg_neoloc}/neo4j.dump

# mkdir just in case, because the docker image will create dirs as root if they don't exist
mkdir -p $sg_neoloc/data
mkdir -p $sg_neoloc/logs
mkdir -p $sg_neoloc/plugins

docker run \
    --user=$(id -u):$(id -g) \
    --interactive \
    --tty \
    --rm \
    --volume=$sg_neoloc/data:/var/lib/neo4j/data \
    --volume=$sg_neoloc/plugins:/var/lib/neo4j/plugins \
    --volume=$sg_neoloc/logs:/var/lib/neo4j/logs \
    --volume=$dump_path:/var/lib/neo4j/neo4j.dump \
    --env NEO4J_AUTH=neo4j/test \
    neo4j/neo4j-admin:5.7.0 \
        neo4j-admin database load \
            --from-path=. \
            neo4j         
```

## Rehydrate faster please

The rehydration step is quite I/O intensive. Therefore, if you have enough RAM, it can be beneficial to copy the database dump file onto RAM first and then load/rehydrate so that read and write won't be occuring on the same hard drive. On Ubuntu Linux would look something like this:

=== "shell"
```bash
sg_neoloc='database/location/socialgene_neo4j'
dump_path='path/to/neo4j.dump'

# copy the dump file to RAM
mkdir -p /dev/shm/social_gene_dump
cp $dump_path /dev/shm/social_gene_dump

# Change the $dump_path
dump_path='/dev/shm/social_gene_dump/neo4j.dump'

# mkdir just in case, because the docker image will create dirs as root if they don't exist
mkdir -p $sg_neoloc/data
mkdir -p $sg_neoloc/logs
mkdir -p $sg_neoloc/plugins

docker run \
    --user=$(id -u):$(id -g) \
    --interactive \
    --tty \
    --rm \
    --volume=$sg_neoloc/data:/var/lib/neo4j/data \
    --volume=$sg_neoloc/plugins:/var/lib/neo4j/plugins \
    --volume=$sg_neoloc/logs:/var/lib/neo4j/logs \
    --volume=$dump_path:/var/lib/neo4j/neo4j.dump \
    --env NEO4J_AUTH=neo4j/test \
    neo4j/neo4j-admin:5.7.0 \
        neo4j-admin database load \
            --from-path=. \
            neo4j
            
```

## More info

<a href="https://neo4j.com/docs/operations-manual/current/backup-restore/offline-backup/" target="_blank">https://neo4j.com/docs/operations-manual/current/backup-restore/offline-backup/</a>

## Ultraquickstart Example 

A database dump generated from the ultraquickstart example can be found at [https://github.com/socialgene/sgnf/releases/download/v0.2.4/ultraquickstart.dump](https://github.com/socialgene/sgnf/releases/download/v0.2.4/ultraquickstart.dump)
