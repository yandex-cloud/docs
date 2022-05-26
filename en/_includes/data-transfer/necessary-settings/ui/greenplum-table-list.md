* **Included tables**: Data is only transferred from the listed tables.

    If the table is partitioned, then to include the table in this list, you can specify both the entire table and its individual partitions.

    Also make sure that for the tables included in the list [the necessary privileges have been granted](../../../../data-transfer/operations/prepare.md#source-gp) to the user running the transfer.

* **Excluded tables**: Data from the listed tables is not transferred.

    If the table is partitioned, then to exclude the table from this list, you must list all its partitions.

    Both lists support expressions in the following format:
    
    * `<schema name>.<table name>`: Fully qualified table name.
    * `<schema name>.*`: All tables in the specified schema.
    * `<table name>`: Table in the default schema.

