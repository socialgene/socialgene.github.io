
First you need to create directories for postgres and redis data, otherwise docker-compose will create them as root user

```bash
mkdir local_postgres_data local_postgres_data_backups redis-data
```

You also need to set the environment variable `HMM_LOCATION` to the path of the hmms file used to create the Neo4j database

Run the docker compose/build all containers

```bash
make django_up
```

Another Make command `upq` is a quicker shortcut that also *doesn't* run the build stage

Stop all containers

```bash
make down 
```

`make up` runs everything in the background, `make upq` doesn't build, just runs in foreground

(base) chase@titan:~/Documents/github/socialgene/django/socialgeneweb$ npm install

make makemigrations
