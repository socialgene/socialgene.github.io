## UIDs

Most nodes have a "uid" property which stand for unique identifier. It is unique, but only within the same Node label; e.g. only one uid will be present across all "protein" nodes.

## Proteins

For proteins the uid is the sha512t24u hash of the protein sequence, this means proteins with identical amino acid sequences are stored only once and referenced by this uid.

Protein nodes also have a CRC64 hash which can be used to cross-reference UniProt. The original protein ID from the input FASTA/Genome is found not on the redundant protein nodes but on the relationship between the node representing the nucleotide sequence the protein was found on, and the non-redundant protein. A query 

=== "Cypher"

```cypher
MATCH ()-[e1:ENCODES]->(p1:protein {uid:"bnI__-NwnuHiyLRDrRcUdrPyYyIjfONy"}) 
RETURN e1.protein_id as protein_id, p1.uid as uid
LIMIT 2

```

Results in:





| protein_id    | protein_uid                      |
|---------------|----------------------------------|
| ALC45_RS09175 | bnI__-NwnuHiyLRDrRcUdrPyYyIjfONy |
| ALT75_RS12645 | bnI__-NwnuHiyLRDrRcUdrPyYyIjfONy |

## Assemblies

For assemblies  SocialGene tries to assign a uid in preference of:


1) extract the `Assembly:` identifier from the `dbxrefs` section of a genbank file and use it as the uid

2) use the name of the input file as the uid (assumption that a single file contains a single assembly/genome)

3) assign a random string as the uid


!!!note
    If a FASTA file was used as input the nucleotide and assembly node uids will be the FASTA file's name.

## Nucleotides

Nucleotide sequences ("Locus" in GBK files) are assigned a unique id by hashing the assembly uid they come from, and the external nucleotide identifier. See the example below. The original nucleotide identifier is stored on the nucleotide node as the property `external_id`. 

=== "Cypher"

```cypher
MATCH (n1:nucleotide {external_id:"NZ_CXED01000052.1"})
RETURN n1
LIMIT 1
```

Returns the node and its properties:

```
{
  "identity": 43109979,
  "labels": [
    "nucleotide"
  ],
  "properties": {
    "strain": "20051272_1361367",
    "collection_date": "2005-01-01",
    "country": "Egypt",
    "db_xref": "taxon:624",
    "uid": "zzGRoTd7WPwP8XCrEzdEmnbWtvJvCsap",
    "serovar": "NA",
    "external_id": "NZ_CXED01000052.1",
    "mol_type": "genomic DNA",
    "isolation_source": "feces"
  },
  "elementId": "43109979"
}
```


In this case the uid of the nucleotide node is `zzGRoTd7WPwP8XCrEzdEmnbWtvJvCsap`, which is the hash of assembly uid "GCF_001246015.1" and the nucleotide external_id "NZ_CXED01000052.1".

This can be verified in the SocialGene python library:

=== "Python"

```python
from socialgene.hashing.hashing import hasher
hasher("GCF_001246015.1___NZ_CXED01000052.1")

# 'zzGRoTd7WPwP8XCrEzdEmnbWtvJvCsap'
```

!!!note
    If a FASTA file was used as input the nucleotide and assembly node uids will be the FASTA file's name.
