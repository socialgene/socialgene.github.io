## Running hmmsearch at scale on [CHTC](https://chtc.cs.wisc.edu/)

These instructions cover how to annotate large numbers of proteins with HMMER, using the University of Wisconsin-Madison's Center for High Throughput Computing (CHTC) facilities. If your facility uses HTCondor many of the steps may be similar.

While Nextflow does have support for HTCondor, CHTC's filesystems aren't configured for that kind of use. Hopefully this will change in a future version of Nextflow (https://github.com/nextflow-io/nextflow/issues/1473). For this reason SocialGene has a custom implementation for running large numbers of hmmsearch jobs on CHTC.

> Note: While this is specific to CHTC, the general principles and files can be applied to other HTCondor and additional high-throughput compute environments.

```bash
outdir='/tmp/socialgene_data/ultraquickstart'
outdir_download_cache='/tmp/socialgene_data/cache'

nextflow run socialgene/sgnf \
    -profile ultraquickstart,docker \
    --outdir $outdir \
    --outdir_download_cache $outdir_download_cache \
    --max_cpus 4 \
    --max_memory 4.GB \
    --htcondor 
```

And we can see the following progress:

```bash
Manifest's pipeline version: ultraquickstart,docker
executor >  local (18)
[82/f30982] process > SOCIALGENE_SGNF:SOCIALGENE:PARAMETER_EXPORT_FOR_NEO4J                                   [100%] 1 of 1 ✔
[skipped  ] process > SOCIALGENE_SGNF:SOCIALGENE:GENOME_HANDLING:NCBI_GENOME_DOWNLOAD                         [100%] 1 of 1, stored: 1 ✔
[1f/90b022] process > SOCIALGENE_SGNF:SOCIALGENE:GENOME_HANDLING:PROCESS_GENBANK_FILES (1)                    [100%] 1 of 1 ✔
[b3/185427] process > SOCIALGENE_SGNF:SOCIALGENE:GENOME_HANDLING:DEDUPLICATE_GENOMIC_INFO (assembly_to_locus) [100%] 5 of 5 ✔
[6d/9382b1] process > SOCIALGENE_SGNF:SOCIALGENE:GENOME_HANDLING:DEDUPLICATE_PROTEIN_INFO (protein_ids)       [100%] 2 of 2 ✔
[d2/bbae62] process > SOCIALGENE_SGNF:SOCIALGENE:DEDUPLICATE_AND_INDEX_FASTA                                  [100%] 1 of 1 ✔
[f9/6d31f6] process > SOCIALGENE_SGNF:SOCIALGENE:SEQKIT_SPLIT                                                 [100%] 1 of 1 ✔
[skipped  ] process > SOCIALGENE_SGNF:SOCIALGENE:HMM_PREP:GATHER_HMMS:DOWNLOAD_HMM_DATABASE (amrfinder)       [100%] 1 of 1, stored: 1 ✔
[27/690ff7] process > SOCIALGENE_SGNF:SOCIALGENE:HMM_PREP:HMM_HASH                                            [100%] 1 of 1 ✔
[3c/6a59e2] process > SOCIALGENE_SGNF:SOCIALGENE:HTCONDOR_PREP                                                [100%] 1 of 1 ✔
[-        ] process > SOCIALGENE_SGNF:SOCIALGENE:HMMSEARCH_PARSE                                              -
[-        ] process > SOCIALGENE_SGNF:SOCIALGENE:MERGE_PARSED_DOMTBLOUT                                       -
[b9/44ec67] process > SOCIALGENE_SGNF:SOCIALGENE:NEO4J_HEADERS                                                [100%] 1 of 1 ✔
[83/9e580b] process > SOCIALGENE_SGNF:SOCIALGENE:DOWNLOAD_GOTERMS                                             [100%] 1 of 1 ✔
[a5/95eed1] process > SOCIALGENE_SGNF:SOCIALGENE:NEO4J_ADMIN_IMPORT_DRYRUN (Building Neo4j database)          [100%] 1 of 1 ✔
[01/543381] process > SOCIALGENE_SGNF:SOCIALGENE:CUSTOM_DUMPSOFTWAREVERSIONS (1)                              [100%] 1 of 1 ✔
[02/1230ce] process > SOCIALGENE_SGNF:SOCIALGENE:MULTIQC                                                      [100%] 1 of 1 ✔
-[socialgene/sgnf] Pipeline completed successfully-
```


After the pipeline is completed, the output directory will contain a new directory called `htcondor_cache`:

```bash
ls -l /tmp/socialgene_data/ultraquickstart/htcondor_cache
```

Which will contain the following files:

```bash
chtc_submission_file.sub
fasta.tar
hmmsearch.sh
hmm.tar
instructions.txt
sample_matrix.csv
submit_server_finish.sh
submit_server_setup.sh
versions.yml
```


The `instructions.txt` file will contain the instructions to submit the job on CHTC.

After the last step on HTCondor (running `submit_server_finish.sh`) there will be a file called `chtc_results.tar`. Transfer the file to your local machine and extract it (preferably to an empty directory ). For every job that was run on CHTC, there will be a file ending in `.domtblout.gz`. 

For example, to extract the files to `/tmp/chtc_results`:

```bash
tar -xvf chtc_results.tar -C /tmp/chtc_results
```

The pipeline can will then be run a second time with the `--domtblout_path` parameter pointing to the directory where the `.domtblout.gz` files are located (make sure to enclose path in single quotes `'`, not double `"`); the `--htcondor` parameter removed; and the `-resume` parameter added. For example:


```bash
outdir='/tmp/socialgene_data/ultraquickstart'
outdir_download_cache='/tmp/socialgene_data/cache'

nextflow run socialgene/sgnf \
    -profile ultraquickstart,docker \
    --outdir $outdir \
    --outdir_download_cache $outdir_download_cache \
    --max_cpus 4 \
    --max_memory 4.GB \
    --domtblout_path '/tmp/chtc_results/*.domtblout.gz' \
    -resume
```
