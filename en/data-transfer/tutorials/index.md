# {{ data-transfer-name }} tutorials


Using {{ data-transfer-name }}, you can implement a variety of scenarios for migrating data, capturing data changes, delivering data from queues, loading data to data marts, and mirroring and uploading data to scalable storage.

## Data migration {#migration}

Migration is a task that involves transferring data from one data storage to another. In {{ data-transfer-name }}, migration often means migrating a database from obsolete local databases to managed cloud ones.

![migration](../../_assets/data-transfer/tutorials/migration.svg)

* [Migrating {{ PG }} clusters](managed-postgresql.md)
* [Migrating {{ MY }} clusters](managed-mysql-to-mysql.md)
* [Migrating {{ CH }} clusters](managed-clickhouse.md)
* [Data resharding in a {{ mch-name }} cluster](mch-mch-resharding.md)
* [Migrating {{ GP }} clusters](managed-greenplum.md)
* [Migrating {{ MG }} clusters](managed-mongodb.md)
* [Migrating {{ MG }} cluster from 4.4 to 6.0](mongodb-versions.md)
* [Migrating data from AWS RDS for {{ PG }}](rds-to-mpg.md)
* [Migrating {{ OS }} clusters](os-to-mos.md)

Mirroring data across queues is a separate migration task.

* [{{ KF }} mirroring](mkf-to-mkf.md)

Syncing data from a third-party cluster.

* [Syncing data from {{ MY }}](sync-mysql.md)

Migration with data storage type changed.

* [{{ MY }} to {{ ydb-short-name }}](managed-mysql-to-ydb.md)
* [{{ PG }} to {{ ydb-short-name }}](mpg-to-ydb.md)
* [{{ MY }} to {{ PG }}](mmy-to-mpg.md)
* [{{ PG }} to {{ MY }}](mpg-to-mmy.md)
* [{{ MY }} to {{ GP }}](mmy-to-mgp.md)
* [{{ ES }} to {{ OS }}](mes-to-mos.md)
* [{{ OS }} to {{ ydb-short-name }}](opensearch-to-ydb.md)
* [{{ PG }} to {{ OS }}](postgresql-to-opensearch.md)

## Change data capture {#cdc}

[Change Data Capture](../concepts/cdc.md) (CDC) is a process of tracking changes in a database and delivering them to consumers with public serialization format supported when writing data to a Debezium queue.
CDC is used for creating apps that are sensitive to real-time data changes, exchanging data between different services, including those with different levels of availability, and collecting and delivering data from the production environment to internal data storage for processing and analysis.

![cdc](../../_assets/data-transfer/tutorials/cdc.svg)

* {{ MY }} change data capture and delivery to:
  * [{{ KF }}](cdc-mmy.md)
  * [{{ DS }}](mmy-to-yds.md)
* {{ PG }} change data capture and delivery to:
  * [{{ KF }}](cdc-mpg.md)
  * [{{ DS }}](mpg-to-yds.md)
* {{ ydb-short-name }} change data capture and delivery to:
  * [{{ KF }}](cdc-ydb.md)
  * [{{ DS }}](ydb-to-yds.md)

## Delivering data from queues {#delivery-to-queue}

Data delivery is a process of delivering arbitrary data to target storage. It includes data retrieval from a queue and its deserialization with subsequent transformation to target storage format.

![queue](../../_assets/data-transfer/tutorials/queue.svg)

* [{{ KF }} to {{ CH }}](mkf-to-mch.md)
* [{{ KF }} to {{ PG }}](mkf-to-mpg.md)
* [{{ KF }} to {{ GP }}](managed-kafka-to-greenplum.md)
* [{{ KF }} to {{ MG }}](mkf-to-mmg.md)
* [{{ KF }} to {{ MY }}](mkf-to-mmy.md)
* [{{ KF }} to {{ OS }}](mkf-to-mos.md)
* [{{ KF }} to {{ ydb-short-name }}](mkf-to-ydb.md)
* [{{ KF }} to {{ DS }}](mkf-to-yds.md)
* [{{ DS }} to {{ CH }}](yds-to-clickhouse.md)
* [{{ DS }} to {{ objstorage-name }}](yds-to-objstorage.md)
* [{{ DS }} to {{ OS }}](trails-to-os.md)
* [{#T}](data-ingestion.md)

## Uploading data to data marts {#upload-to-data-mart}

Loading data to data marts is a process of transferring prepared data to storage for subsequent visualization. Sources are data storages used for massively parallel processing of data. Targets are data storages that can quickly deliver data.

![data mart](../../_assets/data-transfer/tutorials/data-mart.svg)

* [{{ GP }} to {{ CH }}](greenplum-to-clickhouse.md)
* [{{ MY }} to {{ CH }}](mysql-to-clickhouse.md)
* [{{ metrika }} to {{ CH }}](metrika-to-clickhouse.md)
* [{{ PG }} to {{ CH }}](rdbms-to-clickhouse.md)
* [{{ GP }} to {{ PG }}](greenplum-to-postgresql.md)
* [{{ yandex-direct }} to {{ CH }}](direct-to-mch.md)
* [{{ objstorage-name }} to {{ PG }}](object-storage-to-postgresql.md)
* [{{ objstorage-name }} to {{ GP }}](object-storage-to-greenplum.md)
* [{{ objstorage-name }} to {{ MY }}](objs-mmy-migration.md)
* [{{ objstorage-name }} to {{ CH }}](object-storage-to-clickhouse.md)
* [{{ objstorage-name }} to {{ ydb-short-name }}](object-storage-to-ydb.md)
* [{{ ydb-short-name }} to {{ CH }}](ydb-to-clickhouse.md)
* [{{ OS }} to {{ CH }}](opensearch-to-clickhouse.md)

## Importing data to {{ objstorage-name }} {#upload-to-storage}

Uploading data to scalable {{ objstorage-name }} storage allows you to save on data storage and simplifies the exchange with contractors.

![storage](../../_assets/data-transfer/tutorials/storage.svg)

* [{{ MY }} to {{ objstorage-name }}](mmy-objs-migration.md)
* [{{ PG }} to {{ objstorage-name }}](mpg-to-objstorage.md)
* [{{ OS }} to {{ objstorage-name }}](opensearch-to-object-storage.md)
* [{{ ydb-short-name }} to {{ objstorage-name }}](ydb-to-object-storage.md)


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}




{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
