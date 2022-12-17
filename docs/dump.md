```bash

sg_neoloc='/home/chase/Documents/socialgene_data/mibig_3_1/socialgene_neo4j'
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

More info on Neo4j database dumps:

https://neo4j.com/docs/operations-manual/current/backup-restore/offline-backup/
