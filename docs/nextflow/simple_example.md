## Install Conda and Nextflow

If you don't have Conda installed, do that first using the instructions here: <https://docs.conda.io/en/latest/miniconda.html>

After installing and intializing conda, the easiest thing to do is run the command below to create an environment with nextflow and nf-core and activate it before running the rest of this tutorial:

```bash
conda create --name nf bioconda::nextflow>=22.04.0 bioconda::nf-core>=2.4.1
conda activate nf
```

## Super-Quickstart

Replace the `outdir` path below with the path you want the results to be placed into. And then run the commands.

```bash
outdir="/home/chase/Documents/socialgene_data/superquickstart"

nextflow pull socialgene/sgnf -r main

nextflow run socialgene/sgnf -r main \
    -profile simple_run,conda \
    --outdir_per_run $outdir/run_info \
    --outdir_neo4j "$outdir/neo4j" \
    --outdir_long_cache "$outdir/long_cache"  \
     -resume  
```

<div id="video" class="tabcontent" style="display:inline-block;width: 75%">
<script id="asciicast-O4eRe3YNVeRPR4ekRZMH0ry3s" src="https://asciinema.org/a/O4eRe3YNVeRPR4ekRZMH0ry3s.js" async></script>
</div>

- `outdir_per_run` will contain information about the run (timings, memory used, etc)
- `outdir_neo4j` will contain **both** the neo4j database **and** the files used to create it/import
  - This directory structure is required for import step when creating the neo4j database. If you won't need to "resume" the nextflow pipeline the `import` directory can be deleted
- `outdir_long_cache` contains things like the HMM models which shouldn't vary between runs of the workflow.

### Adapting the example configuration file

While the super-quickstart is nice, you probably want to adjust some basic parameters, even for this simple example.

`simple_run` in the "super-quickstart" command references a basic nextflow configuration file that is included with the nextflow pipeline (it's located in: `~/sgnf/conf/examples/simple_run.config`) that will run the full pipeline on a single RefSeq genome (it just happens to be Micromonospora sp. NBRC 110037).

Download the `sgnf` repo by one of the following methods:

- GitHub web interface (<https://github.com/socialgene/sgnf>)
- GitHub link (typing `https://github.com/socialgene/sgnf/archive/refs/heads/main.zip` into your internet browser)
- command line (`git clone https://github.com/socialgene/sgnf.git`)

Open `~/sgnf/conf/examples/simple_run.config` and take a look at the values within the `params{ ... }` block:

- config_profile_name
  - name of this conig run  
- config_profile_description
  - description of this config run
- enable_conda
  - should the pipeline use conda (right now this must be true)
- ncbi_datasets_taxon
  - taxon argument to pass to ncbi_datasets
- builddb
  - whether the neo4j database building step should be performed
- paired_omics
  - whether the paired omics pipeline should be performed
- hmmlist
  - "all" or a subset (e.g. ["pfam", "antismash"]) of HMM models to annotate the input genome(s) with
- hmms
  - whether to run the HMM annotation pipeline
- mmseqs2
  - whether to run MMseqs2
- blastp
  - whether to run the BLASTp pipeline
- ncbi_taxonomy
  - whether to add ncbi_taxonomy to the graph database and attempt to associate genome accessions to taxonomy ids

It also contains the following parameters which you can modify to fit your computer:

- fasta_splits
  - Number of chunks to split all input proteins into (Will double size of input)
  - This is mainly for parallelizing the HMM search step
    - For 100's to 1000's of genomes probably ~1000-2000 so you get good checkpointing
    - For smaller number genomes ~1/2 number of CPUS, but can play around with the number to max out CPUs
- max_cpus
  - The maximum number of CPUs the pipeline can use at once
- max_memory
  - The maximum RAM the pipeline can use at once
- max_time
  - The maximum allowed time for any single process

Change the memory and cpu values to fit your computer.

>Note: MMseqs2 is quite fast and can be used for most data sizes. BLASTp **is not**, so only set it to true if you have a descent number of cpu cores and below maybe a couple dozen input genomes (also, low-hundreds of genomes will create upwards of 100GB of BLASTp output)

Before starting the pipeline:

- Set where you want all the files to write to (set the `outdir` path)
- `cd` into the downloaded `sgnf` directory (set the path to `sgnf` after "cd ")
- Run the Nextflow pipeline.

```bash
outdir="/home/chase/Documents/socialgene_data/micromonospora"

cd "my/path/to/sgnf"

nextflow run . \
    -profile simple_run,conda \
    --outdir_per_run $outdir/run_info \
    --outdir_neo4j "$outdir/neo4j" \
    --outdir_long_cache "$outdir/long_cache"  \
     -resume  
```

#### Nextflow Pipeline Execution Time

The length of time the pipeline takes relies heavily on the number of cores used (and possibly RAM (when using pyHMMER)), so estimates are difficult. On my work desktop (AMD® Ryzen 9 3900xt 12-core processor × 24 | 62.7 GiB RAM) a single genome will finish in a couple minutes. Sometimes downloading PFAM can be the longest step if it isn't cached.
Annotating all Micromonospora genomes (~200) may take a couple hours. On our a server (100 logical cores | 1 TB RAM ) (though done while under heavy use by others) using 40 logical cores, a couple thousand genomes ran through in just under 24 hours.
