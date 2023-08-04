## Parameters galore!

Nextflow workflows tend to be parameter-heavy and this one is no different. The best and most up to date way to see the available parameters and descriptions is to use Nextflow or nf-core directly

### Using Nextflow directly

To print a shortlist of parameters available in the Nextflow workflow:

```bash
nextflow run socialgene/sgnf --help
```

![nextflow help](./media/nextflow_help_cli.png)

And to see all parameters:

```bash
nextflow run socialgene/sgnf --help --show_hidden_params
```

### Using nf-core

By running `nf-core launch` but cancelling instead of launching a run.

```bash
nf-core launch socialgene/sgnf
```

![nfcore help](./media/nfcore_help_web.png)

