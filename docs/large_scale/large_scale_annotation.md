



Copy the HMM models over to SQUID (https://chtc.cs.wisc.edu/uw-research-computing/file-avail-squid.html)
```
rsync -avh /home/chase/Documents/socialgene_data/chtc_test/hmm_files USERNAME@transfer.chtc.wisc.edu:/squid/USERNAME/
```






Log into the submit server


```bash

conda create -n sg_conda bioconda::hmmer=3.3.2

conda install -c conda-forge conda-pack -y
conda pack -n sg_conda 
chmod 644 sg_conda.tar.gz
ls -sh sg_conda.tar.gz

```
