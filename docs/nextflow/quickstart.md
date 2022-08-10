## Install Conda and Nextflow

If you haven't installed Nextflow, please do that first. Instructions for doing so: [here](./install_nextflow.md).


## Super-Quickstart

### Running the Nextflow pipeline

Replace the `outdir` path below with the path you want the results to be placed into. And then run the following commands which will initiate a simple test run.

```bash
outdir="/home/chase/Documents/socialgene_data/superquickstart"

nextflow pull socialgene/sgnf -r main

nextflow run socialgene/sgnf -r main \
    -profile simple_run,conda \
    --outdir_per_run "$outdir/run_info" \
    --outdir_neo4j "$outdir/neo4j" \
    --outdir_long_cache "$outdir/long_cache" \
    --max_cpus 4 \
    --max_memory '4.GB' \
    --max_time '60.h' \
    -resume  
```

<div id="video" class="tabcontent" style="display:inline-block;width: 75%">
<script id="asciicast-O4eRe3YNVeRPR4ekRZMH0ry3s" src="https://asciinema.org/a/O4eRe3YNVeRPR4ekRZMH0ry3s.js" async></script>
</div>

### Results

- `outdir_per_run` will contain information about the run (timing, memory used, etc).  The final collection of HMMs used to annotate the proteins during the run, and a tsv summary file of those, can be found here. Also, the file of HMMs contained here is what would be used by the Django app. 
- `outdir_neo4j` will contain **both** the neo4j database **and** the files used to create it
  - The directory structure is required for the import step when creating a neo4j database. If you are sure you won't need to re-run/"resume" the nextflow pipeline the `import` directory can be deleted.
- `outdir_long_cache` contains things like the HMM model downloads, which shouldn't vary between runs of the workflow. If the Nextflow pipeline is caching downloads but you want to re-download HMM models, etc, delete this drectory.

### Running the super-quickstart example with a modified configuration file

While the super-quickstart is minimal, you may still want to adjust some basic parameters.

Notice `simple_run` in the "super-quickstart" command above. This references a basic nextflow configuration file that is included with the nextflow pipeline code base (it's located in: `~/sgnf/conf/examples/simple_run.config`) that will run the full pipeline on a single RefSeq genome (it just happens to be Micromonospora sp. NBRC 110037, for no specific reason).

Download the `sgnf` repo by one of the following methods:

- GitHub web interface (`https://github.com/socialgene/sgnf`)
- GitHub zip file (typing `https://github.com/socialgene/sgnf/archive/refs/heads/main.zip` into your internet browser)
- Git on command line (`git clone https://github.com/socialgene/sgnf.git`)

Navigate to downloaded directory (unzipping if necessary), then navigate to the file at `~/sgnf/conf/examples/simple_run.config` and take a look at the values within the `params{ ... }` block. 

TODO: Add how to access param  documentation using nfcore


It also contains the following parameters which can be modified to fit your computer/resources:

- fasta_splits
  - The pipeline will split the created non-redundant FASTA file into `fasta_splits` number of files (Note: While it will be gzipped, this will double the disk space of input proteins)
  - This is mainly for parallelizing the HMM search step
    - For 100's to 1000's of genomes probably ~1000-2000 so you get good checkpointing
    - For smaller number genomes the number of CPUs is a good number, but some proteins will take more time than others to annotate, so slightly more than the number of CPUs might work better.
- max_cpus
  - The maximum number of CPUs the pipeline can use at once
- max_memory
  - The maximum RAM the pipeline can use at once
- max_time
  - The maximum time allowed for any single process (again, "single process", not the entire pipeline)

>Note: MMseqs2 is quite fast and can be used for most input data sizes. Reciprocal Diamond BLASTp **is not**, so only set it to true if you have a descent number of cpu cores and below maybe a couple dozen input genomes (also, low-hundreds of genomes can create upwards of 100's of gigabytes of Diamond BLASTp output depending on the settings used)

As shown below
- set the `outdir`  which is the main directory you want all the output files to be written to
- `cd` into the downloaded `sgnf` directory 
- Run the Nextflow pipeline

```bash
outdir="/home/chase/Documents/socialgene_data/micromonospora"

cd "my/path/to/sgnf"

nextflow run . \
    -profile simple_run,conda \
    --outdir_per_run "$outdir/run_info" \
    --outdir_neo4j "$outdir/neo4j" \
    --outdir_long_cache "$outdir/long_cache"  \
     -resume  
```

#### Nextflow Pipeline Execution Time

The length of time the pipeline takes relies heavily on the number of cores used (and possibly RAM (when using pyHMMER)), so estimates are difficult. On my work desktop (AMD® Ryzen 9 3900xt 12-core processor × 24 | 62.7 GiB RAM) a single genome will finish in a couple minutes. Sometimes downloading PFAM can be the longest step if it isn't cached.
Annotating all Micromonospora genomes (~200) may take a couple hours. On our server (100 logical cores | 1 TB RAM ) (though done while under heavy use by others) but using 40 logical cores, a couple thousand genomes ran through in just under 24 hours.
