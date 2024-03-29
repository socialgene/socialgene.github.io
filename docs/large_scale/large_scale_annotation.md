reminder- need to change base.config memory requirments


These instructions cover how to annotate large numbers of proteins with HMMER, using the University of Wisconsin-Madison's Center for High Throughput Computing (CHTC) facilities. If your facility uses HTCondor many of the steps may be similar.

While Nextflow does have support for HTCondor, CHTC's filesystems aren't configured for that kind of use. Hopefully this will change in a future version of Nextflow (https://github.com/nextflow-io/nextflow/issues/1473).


Copy the HMM models over to SQUID (https://chtc.cs.wisc.edu/uw-research-computing/file-avail-squid.html)
=== "shell"
```bash
USERNAME='cmclark8'
HMMPATH='/media/bigdrive2/chase/socialgene/2022_07_13/refseq_test/socialgene_per_run/hmm_cache/socialgene_nr_hmms_file_1_of_1.hmm.gz'
scp "${HMMPATH}" "${USERNAME}@transfer.chtc.wisc.edu:/squid/${USERNAME}"
```



=== "shell"
```bash
USERNAME='cmclark8'
DATAGLOB='/media/bigdrive2/chase/socialgene/2022_07_13/refseq_test/refseq_nr_protein_fasta_dir/crabhash/fasta_for_chtc/outfolder/*.faa.gz'

rsync -avh  \
 ${DATAGLOB} \
"${USERNAME}@submit2.chtc.wisc.edu:/home/${USERNAME}/sg_input_fasta"
```




Log into the submit server

On the sublit server: 
Create a conda environment to pass to the workers:

=== "shell"
```bash
conda create -n sg_conda bioconda::hmmer=3.3.2 conda-forge::sed conda-forge::gzip 

conda install -c conda-forge conda-pack -y
conda pack -n sg_conda 
chmod 644 sg_conda.tar.gz
ls -sh sg_conda.tar.gz
```

Clean and recreate output folders:
=== "shell"
```bash
rm -rf errors outputs sg_input_fasta
mkdir errors outputs sg_input_fasta
```

Create the sample matrix:

=== "shell"
```bash
ls sg_input_fasta > /home/cmclark8/sample_matrix.csv
sed -i  's/^/socialgene_nr_hmms_file_1_of_1.hmm.gz,/' /home/cmclark8/sample_matrix.csv
```






- Submit jobs:
    - `condor_submit /home/cmclark8/chtc_submission.sub`
- Check status:
    - `condor_q`
- Get more info about a job:
    - `condor_q -better-analyze JOBID`
- Stop/remove a job
    - `condor_rm 9974133.0`
- Check disk quote on submit server
    - `quota -vs`
- Check priority:
    - `condor_userprio`


### Troubleshooting

If your jobs are held and you get an error like:

> 	Error from slot1_4@e133.chtc.wisc.edu: FILETRANSFER:1:non-zero exit (1) from /usr/libexec/condor/curl_plugin. Error: The requested URL returned error: 403 Forbidden using http_proxy=http://squid-wid.chtc.wisc.edu:3128 (http://proxy.chtc.wisc.edu/SQUID/cmclark8/socialgene_nr_hmms_file_1_of_1.hmm.gz)

Chnage the permissions of the files on SQUID:

For example (change to your squid username):

=== "shell"
```bash
chmod +r /squid/cmclark8/*
```



move files back:

=== "shell"
```bash
USERNAME='cmclark8'
OUTDIR='/media/bigdrive2/chase/socialgene/2022_07_13/results'

rsync -avh  \
 "${USERNAME}@submit2.chtc.wisc.edu:/home/${USERNAME}/*domtblout.gz" \
 ${OUTDIR}

rsync -avh  \
 "${USERNAME}@submit2.chtc.wisc.edu:/home/${USERNAME}/*md5" \
 ${OUTDIR}
```


-------

=== "shell"
```bash
sg_neoloc='/media/bigdrive2/chase/socialgene/2022_07_13/refseq_test/socialgene_neo4j'
sg_neoloc='/home/chase/neo4j_db/socialgene_neo4j'
pipeline_version='latest'

docker run \
    --user=$(id -u):$(id -g) \
    -p7474:7474 -p7687:7687 \
    -v $sg_neoloc/data:/opt/conda/bin/neo4j/data \
    -v $sg_neoloc/logs:/opt/conda/bin/neo4j/logs \
    -v $sg_neoloc/import:/opt/conda/bin/neo4j/import \
    -v $sg_neoloc/plugins:/opt/conda/bin/neo4j/plugins \
    --env NEO4J_AUTH=neo4j/test \
       --env NEO4J_apoc_export_file_enabled=true \
       --env NEO4J_apoc_import_file_enabled=true \
       --env NEO4J_apoc_import_file_use__neo4j__config=true \
       --env NEO4JLABS_PLUGINS=\[\"apoc\"\] \
       --env NEO4J_dbms_security_procedures_unrestricted=gds.\\\*,algo.*,apoc.*\
       --env NEO4J_dbms_security_procedures_allowlist=gds.*,algo.*,apoc.* \
       --env NEO4J_dbms_memory_heap_initial__size='31g' \
       --env NEO4J_dbms_memory_heap_max__size='200g' \
       --env NEO4J_dbms_memory_pagecache_size='557000m' \
       --env NEO4J_dbms_jvm_additional='-XX:+ExitOnOutOfMemoryError' \
       --env NEO4J_dbms_connector_bolt_address='0.0.0.0:7687' \
    chasemc2/sgnf-sgpy:$pipeline_version

```


```cypher
CREATE CONSTRAINT ON (n:protein) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT ON (n:protein) ASSERT n.name IS UNIQUE;
CREATE CONSTRAINT ON (n:nucleotide) ASSERT n.internal_id IS UNIQUE;
CREATE CONSTRAINT ON (n:assembly) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT ON (n:hmm) ASSERT n.id IS UNIQUE;
CREATE CONSTRAINT ON (n:taxid) ASSERT n.id IS UNIQUE;
```


```
:auto USING PERIODIC COMMIT 500
LOAD CSV from 'file:///assembly' as row
FIELDTERMINATOR '\t'
MERGE (a1:assembly {id:row[0]}));
///////////////////////////////////////////////////////
:auto USING PERIODIC COMMIT 1000
LOAD CSV from 'file:///nuc' as row
FIELDTERMINATOR '\t'
MERGE (a1:nucleotide {id:row[0]});
///////////////////////////////////////////////////////
:auto USING PERIODIC COMMIT 1000
LOAD CSV from 'file:///reduced' as row
FIELDTERMINATOR '\t'
MATCH (p1:protein {name:row[5]})
MATCH (n1:nucleotide {id:row[1]})
MERGE (n1)-[:ENCODES {start:row[2], end:row[3], strand:row[4]}]->(p1);
///////////////////////////////////////////////////////
:auto USING PERIODIC COMMIT 1000
LOAD CSV from 'file:///reduced' as row
FIELDTERMINATOR '\t'
MATCH (a1:assembly {id:row[0]})
MATCH (n1:nucleotide {id:row[1]})
MERGE (n1)-[:ASSEMBLES_TO]->(a1);
```


curl -s https://ftp.ncbi.nlm.nih.gov/genomes/ASSEMBLY_REPORTS/assembly_summary_refseq.txt |  cut -f 1,6 | grep -v '#.*' > assembly_species
```cypher
:auto USING PERIODIC COMMIT 1000
LOAD CSV from 'file:///assembly_species' as row
FIELDTERMINATOR '\t'
MATCH (a1:assembly {id:row[0]})
MATCH (t1:taxid {id:toString(row[1])})
MERGE (a1)-[:IS_TAXON]->(t1);

```


Remote ssh for the web interface:

=== "shell"
```bash
ifconfig
ssh -L 7687:172.17.0.1:7687 -L 7474:172.17.0.1:7474 chase@10.130.167.147
ssh -L 7474:172.17.0.1:7474 chase@10.130.167.147
```
ssh -O  cancel -f -N -L 127.0.0.1:7687:127.0.0.1:7687 chase@10.130.167.147


pkill -f "ssh -f -N [chase@10.130.167.147]
