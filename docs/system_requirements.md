## System Requirements

SocialGene was developed and tested on Ubuntu Linux. Because everything is Docker-ized it should work on Mac or Windows given you have Docker successfully installed on those systems; that said, support for those OSs will be less of a priority than linux.

Currently there's no Conda distributiuon of Neo4j or the SocialGene Python package so the Nextflow pipeline will only work with Docker. If there's time/interest we can look at putting the SocialGene Python package onto bioconda and modifying the pipeline as necessary.
