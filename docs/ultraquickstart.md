
If you haven't installed Nextflow, please do that first. Instructions for doing so: [here](./nextflow/install_nextflow.md).


Replace the `outdir` path below with the path you want the results to be placed into. Open bash or whatever shell you use, run the commands, and (fingers-crossed) watch the magic happen.

```bash
outdir="/home/chase/Documents/socialgene_data/superquickstart"

# Uses nextflow to download the socialgene pipeline from GitHub
nextflow pull socialgene/sgnf -r main

# Run a simple test pipeline
nextflow run socialgene/sgnf -r main \
    -profile ultraquickstart,conda \
    --outdir_per_run $outdir/run_info \
    --outdir_neo4j "$outdir/neo4j" \
    --outdir_long_cache "$outdir/long_cache"  \
     -resume  
```
