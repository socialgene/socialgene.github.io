## User-facing classes

### `SocialGene()`

This is the main class that most other user-facing classes should/do inherit from

### `FindMyBGC()`

### `SingleProteinSearch()`

#### Common example use cases

Starting with a single input protein and

- [want to compare it against all other proteins in the Neo4j database](jupyter/single_protein_search.ipynb)

Starting with a set of proteins (BGC) and

- [want to compare against all other proteins in the Neo4j database](jupyter/findmybgc.ipynb)

## Other

Most of the the classes that describe the structure of `SocialGene()` (e.g. proteins, domains, loci) live in `socialgene/src/socialgene/classes/molbio.py`
