## Nodes

|      Label       |                                                                                Description                                                                                 | NF results subdirectory |       Neo4j header file       |
|:---------------- |:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |:----------------------- |:----------------------------- |
|     assembly     | Represents a single genome/assembly/BGC. If the input was a FASTA file or if assembly wasn't in the genbank metadata then this will represent the file the data came from. |       genomic_info      |        assembly.header        |
|      goterm      |                                                                            Represent a GO term                                                                             |         goterms         |         goterms.header        |
|       hmm        |                                                                Represents a single non-redundant HMM model                                                                 |         hmm_info        |      sg_hmm_nodes.header      |
|    hmm_source    |                                                             Represents the source of an HMM model (e.g. PFAM)                                                              |         hmm_info        |       hmm_source.header       |
| mz_cluster_index |                                                                      Represents a single m/z cluster                                                                       |       paired_omics      | mz_cluster_index_nodes.header |
|  mz_source_file  |                                                                 Represents the file m/z features came from                                                                 |       paired_omics      |     mz_source_file.header     |
|    nucleotide    |                                                Represents a single nucleotide sequence (e.g. a contig/scaffold/chromosome)                                                 |       genomic_info      |          locus.header         |
|    parameters    |                                                    Parameters and environmental variables used during database creation                                                    |        parameters       |       parameters.header       |
|     protein      |                                                                     Represents a non-redundant protein                                                                     |       protein_info      |       protein_ids.header      |
|      taxid       |                                                               Represents a single taxon within NCBI taxonomy                                                               |     taxdump_process     |          taxid.header         |
| tigrfam_mainrole |                                                                       Represents a TIGRFAM main role                                                                       |       tigrfam_info      |    tigrfam_mainrole.header    |
|   tigrfam_role   |                                                                         Represents a TIGRFAM role                                                                          |       tigrfam_info      |      tigrfam_role.header      |
| tigrfam_subrole  |                                                                       Represents a TIGRFAM sub role                                                                        |       tigrfam_info      |     tigrfam_subrole.header    |

## Relationships

|       Label       |                          Relationship                         | NF results subdirectory |        Neo4j header file        |
|:----------------- |:------------------------------------------------------------- |:----------------------- |:------------------------------- |
|     ANNOTATES     |                (:hmm)-[:ANNOTATES]->(:protein)                |     parsed_domtblout    |   protein_to_hmm_header.header  |
|    ASSEMBLES_TO   |           (:nucleotide)-[:ASSEMBLES_TO]->(:assembly)          |       genomic_info      |     assembly_to_locus.header    |
|       BLASTP      |                (:protein)-[:BLASTP]->(:protein)               |      diamond_blastp     |          blastp.header          |
|  CLUSTER_TO_FILE  |   (:mz_source_file)-[:CLUSTER_TO_FILE]->(:mz_cluster_index)   |       paired_omics      |  cluster_to_source_file.header  |
|      ENCODES      |              (:nucleotide)-[:ENCODES]->(:protein)             |       genomic_info      |     locus_to_protein.header     |
|    GOTERM_RELS    |              (:goterm)-[:GOTERM_RELS]->(:goterm)              |         goterms         |         go_to_go.header         |
|       GO_ANN      |               (:hmm_source)-[:GO_ANN]->(:goterm)              |       tigrfam_info      |       tigrfam_to_go.header      |
|      IS_TAXON     |               (:assembly)-[:IS_TAXON]->(:taxid)               |       genomic_info      |     assembly_to_taxid.header    |
|    MAINROLE_ANN   |      (:tigrfam_role)-[:MAINROLE_ANN]->(:tigrfam_mainrole)     |       tigrfam_info      |  tigrfamrole_to_mainrole.header |
|       METABO      |            (:assembly)-[:METABO]->(:mz_source_file)           |       paired_omics      |    assembly_to_mz_file.header   |
|      MMSEQS2      |               (:protein)-[:MMSEQS2]->(:protein)               |     mmseqs2_cluster     |          mmseqs2.header         |
| MOLECULAR_NETWORK | (:mz_cluster_index)-[:MOLECULAR_NETWORK]->(:mz_cluster_index) |       paired_omics      |     molecular_network.header    |
|   PROTEIN_TO_GO   |             (:protein)-[:PROTEIN_TO_GO]->(:goterm)            |       protein_info      |       protein_to_go.header      |
|      ROLE_ANN     |           (:hmm_source)-[:ROLE_ANN]->(:tigrfam_role)          |       tigrfam_info      |      tigrfam_to_role.header     |
|     SOURCE_DB     |               (:hmm)-[:SOURCE_DB]->(:hmm_source)              |         hmm_info        | hmm_source_relationships.header |
|    SUBROLE_ANN    |       (:tigrfam_role)-[:SUBROLE_ANN]->(:tigrfam_subrole)      |       tigrfam_info      |  tigrfamrole_to_subrole.header  |
|    TAXON_PARENT   |               (:taxid)-[:TAXON_PARENT]->(:taxid)              |     taxdump_process     |      taxid_to_taxid.header      |
