## System Requirements

SocialGene was developed and tested on Ubuntu Linux. Because everything is Docker-ized it should work on Mac or Windows given you have Docker successfully installed on those systems; that said, support for those OSs will be less of a priority than linux.

There is a preference that the Nextflow workflow is run with Docker, but it should work with Conda as well.

Currently there's no Conda version for Neo4j so the Nextflow pipeline won't attempt the Neo4j database import if using Conda instead of Docker. However, the command for the import step will be written to the following two files (one with command line instructions, one with Docker).

```sh
~/chosen_out_directory/socialgene_neo4j/command_to_build_neo4j_database_with_docker.sh
~/chosen_out_directory/socialgene_neo4j/command_to_build_neo4j_database.sh
```
