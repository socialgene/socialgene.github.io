# Overview

SocialGene is a complex <a href="https://en.wikipedia.org/wiki/Extract,_transform,_load" target="_blank">ETL</a> workflow centered around analyzing protein and genomic context similarity; built for natural product drug discovery but also with broader applications.

The general flow starts with creating a SocialGene Neo4j database. This is done using the <a href="https://github.com/socialgene/sgnf" target="_blank">Nextflow workflow</a> which handles...

- Downloading proteins and/or genomes from NCBI, MIBiG, etc, or using local genomes (genbank format)
- Creating a set of non-redundant proteins from the input proteins/genomes
- Downloading HMM models from multiple sources (or using local HMMs), creating a non-redundant set of models, and upconverting to the latest HMMER format (optional)
- HMM-annotating the non-redundant proteins (optional)
- Comparing the non-redundant proteins via all-vs-all DIAMOND BLASTp (optional)
- Clustering the non-redundant proteins with MMseqs2 cascaded clustering (optional)
- Annotating input genomes with antiSMASH (optional)
- Downloading and linking all of NCBI Taxonomy (optional)
- Creating/Cleaning/Transforming all input and produced data for import into a Neo4j graph database
- Importing/Creating the Neo4j graph database (optional)
- And more...

Most steps are optional which allows you to customize the output database to your needs.

## What is the output?

1. Output files for the processing steps. e.g. BLASTp database, MMseqs2 index, non-redundant HMM model file, etc.
2. All outputs files are tab separated, gzipped files which are then imported into Neo4j
3. A Neo4j database containing all the data and relationships

The Neo4j database can be interacted with in multiple ways including:

1. Through the SocialGene Python package (or Neo4j's Python package or other drivers)
2. Through SocialGene's Django application (web-based GUI) (not yet released)
3. Using "Neo4j Browser" or directly from a number of other tools that use or have Neo4j plugins (Cytoscape, Gephi, yFiles/yWorks, etc.)

## Components

1. A Nextflow/nf-core pipeline (<a href="https://github.com/socialgene/sgnf" target="_blank">github.com/socialgene/sgnf</a>)
    - If you are trying to create your own SocialGene database this is where you want to start
    - It coordinates data download, manipulation and the creation of a SocialGene database
2. A Python library (<a href="https://github.com/socialgene/sgpy" target="_blank">github.com/socialgene/sgpy</a>)
    - Contains the code for most of the data transformations used to build the database
    - Contains functions for manipulation sequence, domain, and genomic context data
    - Contains functions for manipulating SocialGene/Neo4j databases 
        - e.g. adding antismash results and MIBiG metadata which require graph-modifications so can't be directly imported within the Nextflow pipeline
<!-- 
3. A Django web server (<a href="https://github.com/socialgene/sgweb" target="_blank">github.com/socialgene/sgweb</a>)
    - Currently a very basic GUI for submitting/coordinating pre-built database queries
    - Relatively simple to set up locally using `docker compose`
    - Currently there aren't plans to make a public server but that could change -->

## Citations

Citing software is important because it helps developers justify to granting bodies (or bosses) that their software is useful and should be funded.

Socialgene should be cited as:

TODO:


Additionally, any run of the Nextflow pipeline will create a citations of all additional software used:

```
$results_path/socialgene_per_run/pipeline_info/software_versions.yml
```
TODO: /home/chase/Documents/github/kwan_lab/socialgene/sgnf/citation.py



TODO: For info on HMMs see:
https://www.ebi.ac.uk/training/online/courses/pfam-creating-protein-families/


## Let us know you're using SocialGene!

<iframe src="https://docs.google.com/forms/d/e/1FAIpQLScxcCMSdkd9xB6azZl7k8HRfkFegK2KmYZR8C0yoHfp4wQMYA/viewform?embedded=true" width="640" height="2122" frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>
