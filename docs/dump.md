To create a database dump:

```bash

sg_neoloc='/media/socialgene_nvme/v0_1_5/streptomyces/socialgene_neo4j'
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

And to restore:


```bash

sg_neoloc='/home/chase/Downloads/neo4j_dump/actinobacteria'
dump_path=${sg_neoloc}/neo4j.dump
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






More info on Neo4j database dumps:

https://neo4j.com/docs/operations-manual/current/backup-restore/offline-backup/
