# Working with databases during transfer

When working with data transfers, you must take into account the specific features of databases.
While the transfer with replication is running (_{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ [transfer types](../concepts/index.md#transfer-type)), the data on the source and target may differ, so during this time, errors may occur when reading data from the target database. After [deactivating](./transfer.md#deactivate) the transfer, all data on the source and target will be the same (eventual consistency).

## MySQL {#mysql}

{% include [MY](../../_includes/data-transfer/endpoints/sources/mysql-work-with-db.md) %}

## PostgreSQL {#postgresql}

{% include [PG](../../_includes/data-transfer/endpoints/sources/pg-work-with-db.md) %}

## MongoDB {#mongodb}

{% include [MG](../../_includes/data-transfer/endpoints/sources/mongo-work-with-db.md) %}