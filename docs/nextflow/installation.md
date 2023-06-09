## Install with Conda

While not necessary, I find it simplest to work within Conda environements and would recommend that.
If you don't have Conda installed, do that first using the instructions <a href="https://docs.conda.io/en/latest/miniconda.html" target="_blank">here</a>

After installing Conda, use the following command to create a minimal nextflow environement

```bash
conda create --name nf bioconda::nextflow>=22.04.0 bioconda::nf-core>=2.4.1
```

To activate and use the newly-created environment:

```bash
conda activate nf
```

## Install without Conda

- See <a href="https://www.nextflow.io/docs/latest/getstarted.html" target="_blank">Nextflow's installation documentation</a>

## Install on Windows

**Note: Untested and currently unsupported**

- <a href="https://www.nextflow.io/blog/2021/setup-nextflow-on-windows.html" target="_blank">https://www.nextflow.io/blog/2021/setup-nextflow-on-windows.html</a>

