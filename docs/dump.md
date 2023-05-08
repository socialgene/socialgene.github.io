To create a database dump:

```bash

sg_neoloc='/home/chase/Documents/data/socialgene_backup'
mkdir -p $sg_neoloc/backups

docker run \
    --user=$(id -u):$(id -g) \
    --interactive \
    --tty \
    --rm \
    --volume=$sg_neoloc/data:/data \
    --volume=$sg_neoloc/backups:/backups \
    --env NEO4J_AUTH=neo4j/test \
    neo4j/neo4j-admin:5.1.0 \
        neo4j-admin database dump \
            --to-path=/backups \
            neo4j
```

And to restore:


```bash

sg_neoloc='/home/chase/Documents/data/socialgene_backup'
dump_path=${sg_neoloc}/neo4j.dump
mkdir -p $sg_neoloc/data
mkdir -p $sg_neoloc/logs
mkdir -p $sg_neoloc/plugins

docker run \
    --user=$(id -u):$(id -g) \
    --interactive \
    --tty \
    --rm \
    --volume=$sg_neoloc/data:/sg_neoloc/data \
    --volume=$sg_neoloc/plugins:/sg_neoloc/plugins \
    --volume=$sg_neoloc/logs:/sg_neoloc/logs \
    --volume=$dump_path:/var/lib/neo4j/neo4j.dump \
    --env NEO4J_AUTH=neo4j/test \
    neo4j/neo4j-admin:5.1.0 \
        neo4j-admin database load \
            --from-path=. \
            neo4j
            
```






More info on Neo4j database dumps:

https://neo4j.com/docs/operations-manual/current/backup-restore/offline-backup/
