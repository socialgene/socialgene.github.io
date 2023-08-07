# Docker and the Nextflow Pipeline

## Overview of Docker images
The following Docker images are used in the Nextflow pipeline. While `sgnf_sgpy` is still a bit of an ["everything but the kitchen sink"](https://dictionary.cambridge.org/us/dictionary/english/everything-but-the-kitchen-sink)  image, the idea is to have separate images for software like antiSMASH which has a large Docker image (to ensure it's only used when antiSMASH is being run) and HMMER which is run in a highly-parallel fashion and should have as small an image as possible.

Docker images:

- sgnf_sgpy
    - bit of a kitchen sink container that contains SocialGene's python package (using pip/git), Neo4j, FASTA manipulation tools, DIAMOND, mmseqs2 and more
- sgnf_minimal
    - small image only used for downloading files from the internet and simple file manipulation
- sgnf_antismash
    - conda version of antismash; is labeled by the antismash version it contains
- sgnf_hmmer
    - a minimial HMMER image
- sgnf_hmmer_plus_dockerimage
    - contains HMMER and some extras for downloading/unzipping files, etc.

All of the docker images are automatically built and uploaded to DockerHub every time a new release of the Nextflow workflow is created. So there should always be a docker image version that matches the SocialGene [Nextflow workflow version](https://github.com/socialgene/sgnf/blob/e968c7b3759471b90ec988867e4b78fce4be33b1/nextflow.config#L18).


These docker image versions can also be set using workflow parameters to allow local custom images to be used/tested instead of the default (the version specified by the workflow manifest)

Workflow parameters:

=== "shell"
```
--sgnf_antismash_dockerimage
--sgnf_hmmer_dockerimage
--sgnf_hmmer_plus_dockerimage
--sgnf_sgpy_dockerimage
--sgnf_minimal_dockerimage
```

For example, if I've created a local dev version of the "sgnf_sgpy" docker image  `docker build . -t -chasemc2/sgnf-sgpy:dev`
I could then run the pipeline using this image by using the Nextflow parameter: `--sgnf_sgpy_dockerimage 'dev'`


