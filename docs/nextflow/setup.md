# Install Nextflow/nf-core

## Using Conda

While not necessary, I recommend and find it simplest to work within Conda environments.
If you don't have Conda installed,you can do that first using the instructions at <a href="https://docs.conda.io/en/latest/miniconda.html" target="_blank">https://docs.conda.io/en/latest/miniconda.html</a>

After installing Conda, use the following command to create a minimal nextflow environement

```bash
conda create --name nf bioconda::nextflow>=23.04 bioconda::nf-core>=2.4
```

To activate and use the newly-created environment:

```bash
conda activate nf
```

## Not using Conda

- See <a href="https://www.nextflow.io/docs/latest/getstarted.html" target="_blank">Nextflow's installation documentation</a>

## Install on Windows

**Note: Untested and unsupported**

- <a href="https://www.nextflow.io/blog/2021/setup-nextflow-on-windows.html" target="_blank">https://www.nextflow.io/blog/2021/setup-nextflow-on-windows.html</a>
