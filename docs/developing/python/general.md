# Using the main SocialGene class

Import and create the class:

```python
from socialgene.base.socialgene import SocialGene
my_bgc = SocialGene()
```

Load a Genbank file:

```python
my_bgc.parse_genbank("/home/chase/Downloads/diazaquinomycin.gbk", append=False)
```

Annotate the proteins with pyhmmer:

```python
protein_ids = list(my_bgc.bgc.proteins.keys())
my_bgc.bgc.pyhmmer_hmmsearch(hash_id_list=protein_ids)
```
