
## Docker and the Nextflow Pipeline

The following Docker images are used from the Nextflow pipeline. While socialgene-nf is still a bit of an ["everything but the kitchen sink"](https://dictionary.cambridge.org/us/dictionary/english/everything-but-the-kitchen-sink)  kitchen-sink image, the idea is to have separate images for software like antiSMASH which has a large Docker image (to ensure it's only used when antiSMASH is being run) and HMMER which is run in a highly-parallel fashion so should have as small an image as possible (important for cloud-based/running across many machines).

- socialgene-nf:0.0.1
- socialgene-antismash:6.1.1
- socialgene-small:0.0.1
- socialgene-hmmer:3.3.2
- socialgene-hmmer_plus:3.3.2

All of the docker images should be on DockerHub, but if you need to build them locally you can do so by following the steps below.

### Local build of Docker images

Download the socialgene repository

```bash
git clone https://github.com/socialgene/sgnf.git
```

Enter the sgnf/dockerfiles directory

```bash
cd ./sgnf/dockerfiles
```

Then run the make_docker script (reminder for Chase only: add `---upload` to auto-upload to DockerHub after building)

```bash
make_docker.sh 
```
