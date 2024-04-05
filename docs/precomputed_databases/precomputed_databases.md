I have precomputed a handful of databases I thought the natural product community would find helpful. Some of these are quite large so read the requirments for each *before* downloading.


You will need at least enough disk space to accommodate the dump file and rehydrated database. The dump file is not required after rehydrating (can be deleted) but if you have enough space might it be good to keep around in case you want to rebuild the database from scratch without downloading again (e.g. you make a lot of custom database modifications but mess up and want to start over).

- All of RefSeq
    - Database dump file: ~220 GB
    - Rehydrated database: ~650 GB
    - Rehydrated database with indexes: ~663 GB
    - 343,381 genomes + MIBiG BGCs

- All RefSeq antiSAMSH-7.0 BGCs
    - Database dump file is ~10 GB
    - Rehydrated database is ~29 GB
    - 2,105,746 BGCs from 307,469 genomes + MIBiG BGCs 

- All RefSeq Actinomycetota
    - Database dump file is ~30 GB
    - Rehydrated database is ~86 GB
    - 29,479 genomes + MIBiG BGCs

- All RefSeq *Streptomyces*
    - Database dump file is ~8 GB
    - Rehydrated database is ~23 GB
    - 3,087 genomes + MIBiG BGCs

- All RefSeq *Micromonospora*
    - Database dump file is ~1 GB
    - Rehydrated database is ~3 GB
    - 314 genomes + MIBiG BGCs


All of the above databases were built with the same set of HMM models.

- 42f058a208642475823558f052b5a08e  socialgene_nr_hmms_file_without_cutoffs_1_of_1.hmm.gz
- b741ec988e670291cd9cbbaccf2fb594  socialgene_nr_hmms_file_with_cutoffs_1_of_1.hmm.gz
