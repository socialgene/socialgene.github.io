
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

And to restore:

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


## More info

<a href="https://neo4j.com/docs/operations-manual/current/backup-restore/offline-backup/" target="_blank">https://neo4j.com/docs/operations-manual/current/backup-restore/offline-backup/</a>

