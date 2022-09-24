```bash


sg_neoloc='/home/chase/Documents/socialgene_data/aaa/input_examples/socialgene_neo4j'
mkdir -p $sg_neoloc/backups

docker run \
    --user=$(id -u):$(id -g) \
    -p7474:7474 -p7687:7687 \
    --interactive\
    --tty\
    --rm \
    --volume=$sg_neoloc/data:/data \
    --volume=$sg_neoloc/backups:/backups \
    --env NEO4J_AUTH=neo4j/test \
    neo4j/neo4j-admin:4.4.7 \
        neo4j-admin dump \
            --database=neo4j \
            --to=/backups/output.dump
```
