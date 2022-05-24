# Ovewrview

```python
from rich import inspect
```

```python
from socialgene.base.socialgene import SocialGene
my_bgc = SocialGene()
```

```python
inspect(my_bgc, methods = True)
```

```python
inspect(my_bgc.parse_genbank)
```

```python
my_bgc.parse_genbank("/home/chase/Downloads/diazaquinomycin.gbk", append=False)
```

Read {'CDS': 50, 'subregion': 1, 'region': 1, 'gene': 50, 'aSDomain': 6, 'aSModule': 5, 'CDS_motif': 3} from diazaquinomycin

This will add loci and proteins

Loci reference protein hashes and the protein/locus' locations.

Proteins are saved and referenced separately so that duplicates are only stored once.

```python
inspect(my_bgc.bgc, methods = True)
```

```python
```

```python
```

```python
```
