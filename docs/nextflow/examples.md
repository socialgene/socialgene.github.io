# Examples


The most reproducible way to change how the pipeline should run is to use custom Nextflow configuration files.

 There are a number of example configuration files here: <a href="https://github.com/socialgene/sgnf/tree/main/conf/examples" target="_blank">https://github.com/socialgene/sgnf/tree/main/conf/examples</a>



## Use a profile included in SocialGene

To use a built-in configuration file (the ones listed at the link above) use the `-profile whichever-profile-i-want` flag.

For example, the command below will use the `ultraquickstart` configuration file (<a href="https://github.com/socialgene/sgnf/blob/main/conf/examples/ultraquickstart.config" target="_blank">https://github.com/socialgene/sgnf/blob/main/conf/examples/ultraquickstart.config</a>) and run the processes using Docker.

=== "shell"
```bash
nextflow run socialgene/sgnf -r main \
    -profile ultraquickstart,docker 
    
```
