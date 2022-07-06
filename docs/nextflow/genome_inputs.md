There are a few different ways to input genomes into the Nextflow pipeline.


## Local files

Note: This strategy may change in the future.

To run the pipeline using already downloaded/local genbank files (e.g. `.gbk` or `.gbff`) you need to set two parameters.

1) The path to the files via `local_genbank`. This can be a [glob pattern](https://www.digitalocean.com/community/tools/glob). If you have thousands of files you should provide the path of a single directory that contains all the files so as to not overwhelm the pipeline.

2) A glob pattern of the input files via `sequence_files_glob`.


For example, if `local_genbank='/home/me/input_genome_*.gbk'` then `sequence_files_glob='input_genome_*.gbk'`




## ncbi-genome-download

Kai Blin's `ncbi-genome-download` tool can be used to retrieve genomes from NCBI using the Nextflow pipeline parameter `ncbi_genome_download_command`

e.g.  `ncbi_genome_download_command = 'bacteria --genera "Paraburkholderia acidicola"'`

This can be passed through the command line...

``` bash

nextflow run \
    socialgene/sgnf \
  --ncbi_genome_download_command 'bacteria --genera "Paraburkholderia acidicola"' \
  ...

```

... or through a config file.

An example config file can be found [here](https://github.com/socialgene/sgnf/conf/examples/input_examples/ncbi_genome_download.config). And commands for ncbi-genome-download can be found on its GitHub page: [https://github.com/kblin/ncbi-genome-download](https://github.com/kblin/ncbi-genome-download)


## NCBI datasets

NCBI has a newish command line tool for downloading genomes, called NCBI datasets. A command may be passed to `datasets download` by using the Nextflow pipeline `ncbi_datasets_command`.


e.g. For all assemblies within the genus *Micromonospora* you could use: `ncbi_datasets_command = 'genome taxon "micromonospora"'`
e.g. For the strain `Micromonospora sp. B006` you could use: `ncbi_datasets_command = 'genome accession GCF_003408515.1'`
This can be passed through the command line or a config file (see further down)

``` bash

nextflow run \
    socialgene/sgnf \
  --ncbi_datasets_command 'genome taxon "micromonospora"' \
  ...

```

In the Nextflow pipeline the `datasets download` command is provided extra arguments to limit the download size: `'--include-gbff --exclude-genomic-cds --exclude-protein --exclude-rna --exclude-seq'`. To provide your own extra arguments to the `datasets download` command you should use a config file and overwrite the `ext.args` argument of the process (see below). You can find the default `withName: 'NCBI_DATASETS_DOWNLOAD'{}` within `sgnf/conf/modules.config`.

```
process {
    withName: 'NCBI_DATASETS_DOWNLOAD_TAXON' {
       ext.args = 'insert command here'
    }
}
```


An example config file can be found [here](https://github.com/socialgene/sgnf/conf/examples/input_examples/ncbi_genome_download.config). And commands/arguments for NCBI datasets can be found on its [website](https://www.ncbi.nlm.nih.gov/datasets/docs/v1/reference-docs/command-line/datasets/download/genome/)

