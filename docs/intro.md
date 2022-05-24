Socialgene consists of three components:

1. `/socialgene`: a Python package
    - Contains the logic for a lot of the data transformations used to build the database.
    - Contains functions for transforming data for input query data
    - Contains the functions underlying the REST queries
2. `/nextflow`: a Nextflow/nf-core workflow
    - Used to generate the large database.
    - It uses the Python package (#1)
3. `/django`: a Django web site
    - Used to query the database, initiate socialgene python scripts, and visualize results
    - Fairly trivial to setup your own instance using `docker-compose`

For more detailed information about each, navigate to the subfolder's README.md.

The general flow starts with creating a socialgene Neo4j database:

- Create a Neo4j graph database
  - This is done usinge the Nextflow pipeline which handles...
    - Downloading, upconverting, andalyzing, and reducing duplicate HMMs
    - Downloading genomes from NCBI
    - Creating and HMM-annotating a set of non-redundant proteins from the input genomes
    - Creating all the necessary data nd header input files for the Neo4j graph database
    - Creating the Neo4j graph database

Instructions for running the Nextflow pipeline can be found here: TODO

It is best to run the pipeline on a machine that has a decent number of CPUs. A couple hundred genomes (*Micromonospora*) should fininsh in a couple hours on a 12-core machine. Anything in the 100's may take a good number of hours/potentially days. For large 1000's and anything >10000 genomes it's advisable to split and run on a cluster. For repository-scale annotations we're leverageing thousands of CPUs through CHTC and the Open Science Grid.

The database can be interacted with in two ways:

1) Through the socialgene Python library
2) Through the Django application (web-based GUI)
    - The Django app primarily relies on functions within the socialgene Python library
    - It has been developed using Docker Compose which has shortcut command in the Makefile for easier use

Instructions for installing and using the Python library can be found here: TODO
Instructions for installing and using the Django app can be found here: TODO
