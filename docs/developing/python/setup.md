# Setup

Download the socialgene repository

```bash
git clone https://github.com/chasemc/socialgene.git
```

Move to the socialgene directory....

```bash
cd socialgene
```
Open whatever environment you usually work in (venv, conda, etc.) that works with pip install.

Install normally, but with update on save:

```bash
# pip3 install -e .
make install
```

Install with pytest, dev tools, and update on save:

```bash
# python3 -m pip install --upgrade pip setuptools wheel numpy pytest-cov
make pipinstall_test_extras
```
