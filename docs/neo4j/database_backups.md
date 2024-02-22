
## Create a full database dump/backup

The following takes a database named "neo4j" found in `database/location/socialgene_neo4j` and creates a single dump file at `database/location/socialgene_neo4j/backups/neo4j.dump`. While it will be smaller than the space occupied by the `database/location/socialgene_neo4j` directory, the file can still be quite large.

=== "shell"
```bash

sg_neoloc='/database/location/socialgene_neo4j'
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
    neo4j/neo4j-admin:5.16.0 \
        neo4j-admin database dump \
            --to-path=/backups \
            neo4j
```

## Restore from a full database dump/backup

Given a Neo4j database dump file at path `$dump_path`, rehydrate the database inside directory `$sg_neoloc`.

=== "shell"
```bash
dump_path='/path/to/neo4j.dump
sg_neoloc='/path/to/new/db/directory'

# mkdir because the docker image will create dirs as root if they don't exist
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
    --volume=$sg_neoloc/data:/var/lib/neo4j/data \
    --volume=$sg_neoloc/plugins:/var/lib/neo4j/plugins \
    --volume=$sg_neoloc/logs:/var/lib/neo4j/logs \
    --volume=$dump_path:/var/lib/neo4j/neo4j.dump \
    --env NEO4J_AUTH=neo4j/test \
    neo4j/neo4j-admin:5.16.0 \
        neo4j-admin database load \
            --from-path=. \
            neo4j         
```

!!! note
    The script below will create the database named as "neo4j", no matter what the $dump_path file name is. To change the db name you would have to modify both `--volume=$dump_path:/var/lib/neo4j/neo4j.dump \` and the last `neo4j` in the Docker command. Unless you are familiar with Neo4j, and want to load multiple databases at once, you probably should leave it as "neo4j".


## Restore faster please

The rehydration step is quite I/O intensive. Therefore, for larger database dumps, and if you have enough spare RAM, it may be beneficial to copy the database dump file onto RAM first and then load/rehydrate so that read and write won't be occuring on the same hard drive. On Ubuntu Linux that would look something like this:

=== "shell"
```bash
dump_path='/path/to/neo4j.dump'
sg_neoloc='/path/to/new/db/directory'

# copy the dump file to RAM
mkdir -p /dev/shm/social_gene_dump
cp $dump_path /dev/shm/social_gene_dump

# Change the $dump_path
dump_path='/dev/shm/social_gene_dump/neo4j.dump'

# mkdir because the docker image will create dirs as root if they don't exist
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
    --volume=$sg_neoloc/data:/var/lib/neo4j/data \
    --volume=$sg_neoloc/plugins:/var/lib/neo4j/plugins \
    --volume=$sg_neoloc/logs:/var/lib/neo4j/logs \
    --volume=$dump_path:/var/lib/neo4j/neo4j.dump \
    --env NEO4J_AUTH=neo4j/test \
    neo4j/neo4j-admin:5.16.0 \
        neo4j-admin database load \
            --from-path=. \
            neo4j
            
```

## More info

<a href="https://neo4j.com/docs/operations-manual/current/backup-restore/offline-backup/" target="_blank">https://neo4j.com/docs/operations-manual/current/backup-restore/offline-backup/</a>

## Ultraquickstart Example 

A database dump generated from the ultraquickstart example can be found at [https://github.com/socialgene/sgnf/releases/download/v0.2.4/ultraquickstart.dump](https://github.com/socialgene/sgnf/releases/download/v0.2.4/ultraquickstart.dump)


## Launch the Database

After hydrating a database dump you can launch it using the directions in [Database Launch](/neo4j/database_launch)
