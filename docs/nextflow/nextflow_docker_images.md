# Docker and the Nextflow Pipeline

## Overview of Docker images
The following Docker images are used from the Nextflow pipeline. While `socialgene-nf` is still a bit of an ["everything but the kitchen sink"](https://dictionary.cambridge.org/us/dictionary/english/everything-but-the-kitchen-sink)  kitchen-sink image, the idea is to have separate images for software like antiSMASH which has a large Docker image (to ensure it's only used when antiSMASH is being run) and HMMER which is run in a highly-parallel fashion and should have as small an image as possible (important for cloud-based/running across many machines).

Docker images:

- socialgene-nf:0.0.1
    - bit of a kitchen sink that contains SocialGene's python package, Neo4j, FASTA manipulation tools, DIAMOND, mmseqs2 and more
- socialgene-small:0.0.1
    - small image only used for downloading things and simple file manipulation
- socialgene-antismash:6.1.1
    - image version follows the antismash version it contains
- socialgene-hmmer:3.3.2
    - image version follows the HMMER version it contains
- socialgene-hmmer_plus:3.3.2
    - image version follows the HMMER version it contains

All of the docker images should be on DockerHub, but if you need to build them locally you can do so by following the steps below.

## Build Docker images locally

Download the socialgene repository

```bash
git clone https://github.com/socialgene/sgnf.git
```

Enter the sgnf/dockerfiles directory

```bash
cd ./sgnf/dockerfiles
```

Then run the make_docker script (reminder for Chase only: add `---upload` to auto-upload to DockerHub after building)

```bash
make_docker.sh 
```
