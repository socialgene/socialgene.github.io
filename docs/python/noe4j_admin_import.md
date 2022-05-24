### Info

[Noe4j's admin import tools](https://neo4j.com/docs/operations-manual/current/tutorial/neo4j-admin-import/) is used to created the initial database.

Socialgene's Neo4jAdminImport class handles the non-data-creation steps in this process (also doesn't handle the writing/placement of created-data).

This largely boils down to:

1) Creating the necessary header files that Neo4j needs for import
2) Validating that the expected data files are present
3) Creating and executing the Neo4j admin import command line import arguments

Regarding #3- Socialgene contains different modules based on what the user is trying to achieve. These have consequences on what data is created, the structure of the resulting graph and thus the import arguments.
e.g. Running the "paired omics" pipeline will create additional node and relationship types, which require additional header files. Those would be created by instantiating `Neo4jAdminImport` with additional `sg_modules` (e.g. 1`Neo4jAdminImport(sg_modules=["base","paired_omics"])`)
