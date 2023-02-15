
![SocialGene Logo](https://raw.githubusercontent.com/socialgene/logos/main/logos/horizontal.svg)

This repo contains the editable documentation of using Socialgene.

If you just want to view the documentation, navigate to: [socialgene.github.io](https://socialgene.github.io)

---

Satus Checks and Availability:

#### Python

- ![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/chasemc/socialgene)
- [![Python Package CI](https://github.com/socialgene/socialgene/actions/workflows/python_package_ci.yml/badge.svg)](https://github.com/socialgene/socialgene/actions/workflows/python_package_ci.yml)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
- [![docker](https://img.shields.io/badge/docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
- [![pypi](http://img.shields.io/badge/pypi-3EB049?labelColor=000000&logo=pypi)](https://docs.conda.io/en/latest/) ![PyPI - Status](https://img.shields.io/pypi/status/socialgene) ![PyPI - Downloads](https://img.shields.io/pypi/dm/socialgene) ![PyPI - Wheel](https://img.shields.io/pypi/wheel/socialgene)

#### Django

- [![Built with Cookiecutter Django](https://img.shields.io/badge/built%20with-Cookiecutter%20Django-ff69b4.svg?logo=cookiecutter)](https://github.com/cookiecutter/cookiecutter-django/)
[![Django CI](https://github.com/socialgene/socialgene/actions/workflows/django_ci.yml/badge.svg)](https://github.com/socialgene/socialgene/actions/workflows/django_ci.yml)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

- [![docker](https://img.shields.io/badge/docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
- [![pypi](http://img.shields.io/badge/pypi-3EB049?labelColor=000000&logo=pypi)](https://docs.conda.io/en/latest/)

### Nextflow

- [![nf-core linting](https://github.com/socialgene/socialgene/actions/workflows/nextflow_linting.yml/badge.svg)](https://github.com/socialgene/socialgene/actions/workflows/nextflow_linting.yml) [![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A521.10.3-23aa62.svg?labelColor=000000)](https://www.nextflow.io/) [![run with conda](http://img.shields.io/badge/run%20with-conda-3EB049?labelColor=000000&logo=anaconda)](https://docs.conda.io/en/latest/) [![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)

---

### To run locally

```bash
make create_conda
conda activate sg_doc_build
mkdocs serve
```
