# Overview

## Citations

Citing software is important because it helps the developers justify to granting bodies (or bosses) that their software is useful and should be funded.

Socialgene should be cited as:

zzzzzzzzzzzzzzzzzzzzzz


Additionally, any run of the Nextflow pipeline prints all software used for each step in the pipeline:

```
$results_path/socialgene_per_run/pipeline_info/software_versions.yml
```




## Components 

Socialgene consists of three components:

1. A Nextflow/nf-core workflow/pipeline (<a href="https://github.com/socialgene/sgnf" target="_blank">github.com/socialgene/sgnf</a>)
    - If you are trying SocialGene for the first time this is where you'll want to start.
    - It coordinates data download, manipulation and the creation of a database
2. A Python library (<a href="https://github.com/socialgene/sgpy" target="_blank">github.com/socialgene/sgpy</a>)
    - Contains the logic for a lot of the data transformations used to build the database
    - Contains functions for manipulation sequence, domain, and genomic context data
    - Not really meant for end-users right now, but may be simplified in the future. There's some useful/intuitive constructs for handling genomic data with HMMER annotations (at least I think so).
3. A Django web site (<a href="https://github.com/socialgene/sgweb" target="_blank">github.com/socialgene/sgweb</a>)
    - Currently a very basic GUI for submitting/coordinating pre-built database queries
    - Relatively simple to set up locally using `docker compose`
    - Currently there aren't plans to make a public server but that could change

--- 
## What does this do?

The general flow starts with creating a SocialGene Neo4j database. This is done using the Nextflow pipeline which handles...

- Downloading proteins/genomes from NCBI or using local genomes (genbank format)
- Downloading HMMs from multiple databases (or using local HMMs) and upconverting to the latest HMMER format (optional)
- Creating and HMM-annotating a set of non-redundant proteins from the input genomes (optional)
- Comparing input proteins via all-vs-all DIAMOND BLASTp (optional) and/or MMseqs2 clustering (optional)
- Annotating input genomes with antiSMASH (optional)
- Creating/Transforming all the necessary data and input files for importing into a Neo4j graph database
- Importing/Creating the Neo4j graph database (optional)
- And more...

Basically, all the steps are optional which allows you to customize based on your needs.

## What is the output?

1. All output files for the processing steps (e.g. BLASTp output table) 2) all flatfiles necessary to import data into Neo4j 3) A Neo4j database containing all the data and relationships

The Neo4j database can be interacted with in multiple ways including:

1. Through the SocialGene Python package (or Neo4j's Python package)
2. Through SocialGene's Django application (web-based GUI)
3. Running Neo4j and then using "Neo4j Browser" or any number of other tools that use Neo4j (Cytoscape, Gephi, yFiles/yWorks, etc.)



For info on HMMs see:
https://www.ebi.ac.uk/training/online/courses/pfam-creating-protein-families/
