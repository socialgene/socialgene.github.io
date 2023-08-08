There are a few different ways to input proteins and/or genomes into the Nextflow workflow.

## Local files

### Genomes
To run the pipeline using already downloaded/local genbank files (e.g. `.gbk`or `.gbff`) provide the path to the files via `--local_genbank`. This can be a [glob pattern](https://www.digitalocean.com/community/tools/glob).

!!! note
    If you are entering parameters on the command line and using a glob, make sure to enclose the path/glob in single quotes to prevent expansion.

!!! note
    The genbank files must already contain protein sequences (SocialGene doesn't currently do any gene/ORF prediction).

=== "shell"

```bash
nextflow run \
    socialgene/sgnf \
  --local_genbank '/path/to/genbank/files/*.gbk' \
  ...
  ...
```

### Proteins

You can also input non-genomic proteins using local *protein* FASTA files (e.g. `.faa`). These will be connected to "nucleotide" and "assembly" nodes with a filename identifier.

Provide the path to the files via `--local_fasta`. This can be a [glob pattern](https://www.digitalocean.com/community/tools/glob).

!!! note
    If you are entering parameters on the command line and using a glob, make sure to enclose the path/glob in single quotes to prevent expansion.

=== "shell"

```bash
nextflow run \
    socialgene/sgnf \
  --local_genbank '/path/to/protein/fasta/files/*.fasta' \
  ...
  ...
```

## Retrieve genomes from NCBI

### ncbi-genome-download (preferred)

The Nextflow workflow contains Kai Blin's `ncbi-genome-download` tool which can be used to retrieve genomes from NCBI. This can be done by using the Nextflow workflow parameter `ncbi_genome_download_command`, which simply passes an argument string to the ncbi-genome-download commmand. See the [tool's website](https://github.com/kblin/ncbi-genome-download#usage){: target='_blank'} for examples.

For example, the following will download and run the workflow on all "Paraburkholderia acidicola" genomes available within GenBank.

=== "shell"

```bash
nextflow run \
    socialgene/sgnf \
  --ncbi_genome_download_command 'bacteria --section genbank --genera "Paraburkholderia acidicola"' \
  ...
  ...
```

!!! warning
    It is very easy to download a LOT of genomes/data with this tool. To get an idea of how many genomes a query might return, you can first do an interactive search of a taxon, etc, here: [https://www.ncbi.nlm.nih.gov/datasets/genome](https://www.ncbi.nlm.nih.gov/datasets/genome){: target='_blank'}

### NCBI datasets

NCBI has a new-ish command line tool for downloading genomes, called NCBI datasets. A command may be passed to `datasets download` by using the Nextflow pipeline `ncbi_datasets_command`.

e.g. For all assemblies within the genus *Micromonospora* you could use: `ncbi_datasets_command = 'genome taxon "micromonospora"'`
e.g. For the strain `Micromonospora sp. B006` you could use: `ncbi_datasets_command = 'genome accession GCF_003408515.1'`

=== "shell"
```bash
nextflow run \
    socialgene/sgnf \
  --ncbi_datasets_command 'genome taxon "micromonospora"' \
  ...
  ...
```

!!! warning
    It is very easy to download a LOT of genomes/data with this tool. To get an idea of how many genomes a query might return, you can first do an interactive search of a taxon, etc, here: [https://www.ncbi.nlm.nih.gov/datasets/genome](https://www.ncbi.nlm.nih.gov/datasets/genome){: target='_blank'}

Related to the above warning, the download step of the workflow may take some time depending on your internet speed and number of genomes to be downloaded.


## HMM models

### Prebuilt models

The Nextflow workflow is able to download HMM models from any or all of the following: ["antismash","amrfinder","bigslice","classiphage", "ipresto","pfam","prism","resfams","tigrfam","virus_orthologous_groups"].

These can be selected by using the `hmmlist` parameter and comma-separated string:

e.g. `--hmmlist 'resfams,antismash'`

You can also use `--hmmlist all` to use all models from all of the databases SocialGene knows about. 

!!! note
    Depending on your location/internet speed this step can take some time to download.

Because they don't change, HMM models are downloaded and stored for long-term use between workflow runs to `--outdir_download_cache`. Where possible SocialGene pulls versioned HMM models. The versions used can be modified using workflow parameters [found here](https://github.com/socialgene/sgnf/blob/e968c7b3759471b90ec988867e4b78fce4be33b1/nextflow.config#L90-L97){: target='_blank'}.

### Custom models

To use your own HMM model use the parameter: `--custom_hmm_file`

e.g. `--custom_hmm_file '/path/to/my/hmm.hmm'`

The file should be a valid HMMER HMM model.

For info on HMMs see:
https://www.ebi.ac.uk/training/online/courses/pfam-creating-protein-families/
