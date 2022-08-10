## Overview

Socialgene consists of three components:

1. A Nextflow/nf-core workflow/pipeline (<a href="https://github.com/socialgene/sgnf" target="_blank">github.com/socialgene/sgnf</a>)
    - If you are trying SocialGene for the first time this is where you'll start.
    - It coordinates data download, manipulation and creating a database.
    - It coordinates the use of the Python package (#2)
2. A Python library (<a href="https://github.com/socialgene/sgpy" target="_blank">github.com/socialgene/sgpy</a>)
    - Contains the logic for a lot of the data transformations used to build the database
    - Contains functions for manipulation sequence, domain, and genomic context data 
    - Not really meant for end-users right now, but may be simplified in the future. There's some useful constructs for handling genomic data with HMMER annotations (at least I think so).
3. A django web site (<a href="https://github.com/socialgene/sgweb" target="_blank">github.com/socialgene/sgweb</a>)
    - Currently a very basic GUI for submitting/coordinating pre-built database queries
    - Relatively simple to set up locally using `docker compose`

--- 
## How does this all work?

The general flow starts with creating a socialgene Neo4j database. This is done using the Nextflow pipeline which handles...

- Downloading proteins/genomes from NCBI (or using local genomes)
- Downloading HMMs (or using local HMMs) and upconverting to the latest HMMER format
- Creating and HMM-annotating a set of non-redundant proteins from the input genomes (optional)
- Comparing all input proteins via all-vs-all BLASTp and/or MMseqs2 (optional)
- Creating/Transforming all the necessary data and input files for importing into a Neo4j graph database
- Importing/Creating the Neo4j graph database

It isn't necessary, but is best to run the pipeline on a machine that has a decent number of CPUs to take advantage of parallel processing. Annotating a few hundred genomes (*Micromonospora* (each has approximately 6000 proteins)) with ~50,000 HMM models (pulling from most of the available HMM sources) will finish in a couple hours on a 12-core machine. The speed is roughly proportional to the provided number of CPUs.
