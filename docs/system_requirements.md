## System Requirements

### OS
SocialGene was developed and tested on Ubuntu Linux. Because everything is Docker-ized it should work on Mac or Windows given you have Docker successfully installed on those systems; that said, support for those OSs will be less of a priority than linux.

### CPUs

Steps using MMseqs2, DIAMOND, HMMER, antiSMASH, etc benefit from having many CPUs available. 
### Memory
With larger inputs MMseqs2 and DIAMOND blastp can require significant amounts of RAM.

### Disk

Additionally, and especially, for larger runs, a significant amount of disk space may be required.

To get some idea for a larger run:

When ~8,500 *Streptomyces* genomes were used as input for a SocialGene workflow that runs hmmsearch using the antismash, amrfinder, pfam, resfams,and tigrfam HMM databases; MMseqs2 clustering to 90, 70, and 50; incorporates all of NCBI taxonomy; incorporates all MIBiG BGCs; and runs antiSMASH on all input genomes...

It required ~90 GB of scratch space (temp files that allow -resume in Nextflow but can be deleted after a successful run). And an additional ~90 GB in the specified `outdir`.

- `$outdir/socialgene_per_run` (70GB)
    - 39 GB antismash output
    - 16 GB downloaded input genomes
    - 11 GB MMSeqs2 cluster databases
    - 3 GB non-redundant FASTA
    - 400 MB non-redundant HMM models
    - 17 MB workflow stats

- `$outdir/socialgene_neo4j` (23 GB)
    - 18.7 GB Neo4j database
    - 4.4 GB Neo4j import data

To run all of RefSeq required a few terabytes, as the >300,000 genomes alone require more than a terabyte.

The neo4j database itself will run most performant off of fast hard drives (e.g. ssd/nvme).


### Time

Hard to estimate but the ~8,500 *Streptomyces* example above ran on a single server (dual AMD® EPYC 7352 24-Core processors, with 1TB RAM) and took 1021.0 CPU hours but completed in 21 hours.

I would recommend running the ultraquickstart example or your own input with reduced set of genomes first to help determine appropriate cpu/mem/time settings.

### Docker

Currently there's no Conda distribution of Neo4j or the SocialGene Python package so the Nextflow pipeline will only work with Docker. If there's time/interest we can look at putting the SocialGene Python package onto bioconda and modifying the pipeline as necessary. However, there would still be no Conda distribution of Neo4j so that step of the Nextflow workflow would have to be done manually (using docker or manual installation of Neo4j), though the workflow will export the proper commands to do so.

