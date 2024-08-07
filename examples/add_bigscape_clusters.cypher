
// Run BiG-SCAPE https://github.com/medema-group/BiG-SCAPE and get the resulting ".network" file
// The following query will add the BiG-SCAPE similarity edges to the graph (assuming the nucleotide nodes have the same name as the BGCs)

LOAD CSV WITH HEADERS FROM 'file:///bigscape_clustered_mibig.network'  AS row FIELDTERMINATOR '\t' 
MATCH (n1:nucleotide {external_id:row.clustername_1})
MATCH (n2:nucleotide {external_id:row.clustername_2})
CREATE (n1)-[:BIGSCAPE_SIMILARITY {
    raw_distance:row.raw_distance,
    squared_similarity:row.squared_similarity,
    jaccard_index:row.jaccard_index,
    dss_index:row.dss_index,
    adjacency_index:row.adjacency_index,
    raw_dss_non_anchor:row.raw_dss_non_anchor,
    raw_dss_anchor:row.raw_dss_anchor,
    non_anchor_domains:row.non_anchor_domains,
    anchor_domains:row.anchor_domains,
    combined_group:row.combined_group,
    shared_group:row.shared_group
    }]->(n2);
    
// Run BiG-SCAPE https://github.com/medema-group/BiG-SCAPE and get the resulting "mix_clustering.tsv" file
// The following query will add the BiG-SCAPE cluster number to the assembly nodes (assuming the assembly nodes have the same name as the BGCs)
LOAD CSV WITH HEADERS FROM 'file:///mix_clustering_c0.30.tsv'  AS row FIELDTERMINATOR '\t' 
MATCH (a1:assembly {uid:row.bgc_name})
SET a1.bigscape_cluster = toInteger(row.family_number);   
