## Overview

Socialgene consists of three components:

1. A Nextflow/nf-core workflow/pipeline (<a href="https://github.com/socialgene/sgnf" target="_blank">github.com/socialgene/sgnf</a>)
    - If you are trying SocialGene for the first time this is what you want and will use.
    - It coordinates data download, manipulation and, ultimately, creating a database.
    - It coordinates the use of the Python package (#2)
2. `/socialgene`: a Python package (<a href="https://github.com/socialgene/sgpy" target="_blank">github.com/socialgene/sgpy</a>)
    - Contains the logic for a lot of the data transformations used to build the database.
    - Contains functions for transforming data for input query data
    - Contains the functions underlying the REST queries
    - Not really meant for end-users right now, but can be. There's some (I think) useful constructs for handling genomic data with HMMER annotations.
3. A django web site (<a href="https://github.com/socialgene/sgweb" target="_blank">github.com/socialgene/sgweb</a>)
    - Still basic, but can be used as a GUI when querying of a database.
    - Relatively simple to set up your own instance using `docker-compose`

--- 
## How does this work?

The general flow starts with creating a socialgene Neo4j database. This is done using a Nextflow pipeline which handles...

- Downloading, up-converting, organizing, and reducing duplicate HMMs
- Downloading genomes from NCBI (or using local genomes)
- Creating and HMM-annotating a set of non-redundant proteins from the input genomes
  - Can also compare input proteins with all-vs-all BLASTp and/or MMseqs2
- Creating all the necessary data and input files for importing into a Neo4j graph database
- Creating the Neo4j graph database

It is best to run the pipeline on a machine that has a decent number of CPUs. Annotating a few hundred genomes (*Micromonospora* (each has approximately 6000 proteins)) with ~50,000 HMM models (pulling from most of the available HMM sources) will finish in a couple hours on a 12-core machine.
