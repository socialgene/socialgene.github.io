## Install

This tutorial assumes you already have [Nextflow](./nextflow/install_nextflow.md){: target='_blank'} and [Docker](https://docs.docker.com/get-docker/){: target='_blank'} installed on your computer.

Replace the `outdir` path below with the path you want the results to be placed into. Open bash or whatever shell you use, run the commands, and (fingers-crossed) watch the magic happen.

## Run

```bash
outdir="/change/this/path/ultraquickstart"

# Uses nextflow to download the socialgene pipeline from GitHub
nextflow pull socialgene/sgnf -r main

# Run a simple test pipeline
nextflow run socialgene/sgnf -r main \
    -profile ultraquickstart,docker \
    --outdir $outdir \
    -resume
```
