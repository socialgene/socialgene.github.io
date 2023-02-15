## System Requirements

SocialGene was developed and tested on Ubuntu Linux. Because everything is Docker-ized I see no reason that would prevent it from working on Mac or Windows given you have Docker successfully installed on those systems; that said, support for those OSs will be minimal.

While the Nextflow pipeline should work with Docker, it isn't currently able to build the Neo4j database with Conda. However, the command to import the resulting data with Docker will be written to

```$chosen_out_directory/socialgene_neo4j/command_to_build_neo4j_database_with_docker.sh```





There is preference that you run the Nextflow with Docker.


This tutorial assumes you already have [git](https://github.com/git-guides/install-git), [conda](https://docs.conda.io/en/latest/miniconda.html) and [Docker](https://docs.docker.com/get-docker/) installed on your computer.




## Setting up SocialGene with Make

There is a [Makefile](https://opensource.com/article/18/8/what-how-makefile) in the top directory that makes it easy to perform a majority (if not all) of the things you might want to do.
