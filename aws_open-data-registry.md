Name: SocialGene RefSeq Databases
Description: Precomputed SocialGene Neo4j graph databases of various sizes built from RefSeq genomes and MIBiG BGCs. 
Documentation: https://socialgene.github.io/precomputed_databases/2023_v0.4.1/aws
Contact: https://github.com/socialgene/socialgene.github.io/issues
ManagedBy: University of Wisconsin-Madison
UpdateFrequency: This database is currently what was published in our 2024 paper introducing SocialGene, but an updated database may be added in the future.
Tags:
  - metagenomics
  - genomics
  - bioinformatics
  - microbiome
  - natural products
  - drug discovery
License: There are no restrictions on the use of this data. Individual components of the database may have their own license.
Resources:
  - Description: SocialGene 2023_v0.4.1 Data and Database Dumps
    ARN: arn:aws:s3:::socialgene-open-data
    Region: us-east-2
    Type: S3 Bucket
    Explore:
    - '[Browse Bucket](https://socialgene-open-data.s3.amazonaws.com/)'
DataAtWork:
  Tutorials:
    - Title:
      URL: http://127.0.0.1:8000/precomputed_databases/2023_v0.4.1/aws/aws_instructions/
      NotebookURL:
      AuthorName: Chase M. Clark
      AuthorURL: chasemc.github.io
      Services: EC2
