## Building a database of a given taxon

This tutorial assumes that you have already gone through the nextflow pipeline quickstart.

There are some different example configurations for this task in the directory: `~sgnf/conf/examples/genome_by_taxon`

Can also view it here: <https://github.com/socialgene/sgnf/blob/758bde8b0b1420a9f0774bdeb38a8b725096cfd4/conf/examples/genome_by_taxon/micromonospora.config>

For this tutorial we'll use `conf/examples/genome_by_taxon/micromonospora.config`

If you're lazy, the only thing that you have to change is the `outdir` part of the command and following parameter:

`ncbi_genome_download_command = '--assembly-levels complete,chromosome,scaffold bacteria --genera "micromonospora aurantiaca" --parallel 8'`

Between the quotes -> `ncbi_genome_download_command = ''`, you can put any valid command for <https://github.com/kblin/ncbi-genome-download>

And, while you might be lazy, it's probably a good idea to also adjust the CPUs, memory, etc. to match your computer.
