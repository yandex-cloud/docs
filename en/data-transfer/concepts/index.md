---
title: "Relationship between {{ data-transfer-full-name }} service resources"
description: "{{ data-transfer-full-name} } allows you to easily transfer data between databases. The service allows you to reduce the time for the migration process, minimize downtime when switching to a new database or have a permanent replica of the database."
---

# Relationships between resources in {{ data-transfer-name }}

{{ data-transfer-full-name }} helps transfer data between DBMS, object storages, and message brokers. This way you can reduce the migration period and minimize downtime when switching to a new database.

{{ data-transfer-full-name }} is configurable via {{ yandex-cloud }} standard interfaces.

The service is suitable for creating a permanent replica of the database. The transfer of the database schema from the source to the target is automated.

## Endpoint {#endpoint}

_Endpoint_ is a configuration used to connect to the _datasource_ service or _target_ service. In addition to connection settings, the endpoint may contain information about which data will be involved in the transfer and how it should be processed during the transfer.

The following can be the data source or target:


| Service | Source | Target |
|------------------------------------------------------------------------------------------------------------|:------------------------------------:|:------------------------------------:|
| {{ KF }} topic: Your own topic or a topic in [{{ mkf-short-name }}](../../managed-kafka/) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| AWS CloudTrail message stream | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| Your own BigQuery database | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| {{ CH }} database: Your own or as part of the [{{ mch-short-name }} service](../../managed-clickhouse/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ GP }} database: Your own or as part of the [{{ mgp-short-name }} service](../../managed-greenplum/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ MG }} database: Your own or as part of the [{{ mmg-short-name }} service](../../managed-mongodb/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| {{ MY }} database: Your own or as part of the [{{ mmy-short-name }} service](../../managed-mysql/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Your own Oracle database | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| {{ PG }} database: Your own or as part of the [{{ mpg-short-name }} service](../../managed-postgresql/) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| S3 compatible bucket | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| Data stream [{{ yds-full-name }}](../../data-streams/) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| {{ ydb-name }} database: A database in [{{ ydb-name }}](../../ydb/) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| Bucket [{{ objstorage-full-name }}](../../storage/) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |



## Transfer {#transfer}

_Transfer_ is the process of transmitting data between the source and target service. It should be in the same folder as the endpoints used.

If subnets are specified for endpoints, they must be hosted in the same [availability zone](../../overview/concepts/geo-scope.md). Otherwise, activating the transfer with such endpoints will result in an error.

### Transfer types {#transfer-type}

The following types of transfers are available:

* _{{ dt-type-copy }}_: Moves a snapshot of the source to the target.
* _{{ dt-type-repl }}_: Continuously receives changes from the source and applies them to the target. Initial data synchronization is not performed.
* _{{ dt-type-copy-repl }}_: Transfers the current state of the source to the target and keeps it up-to-date.

For more information about the differences between transfer types, see [{#T}](./transfer-lifecycle.md).

### Compatibility of sources and targets {#connectivity-matrix}

{% include [include](../../_includes/data-transfer/connectivity-marix.md) %}

## Service specifics for sources and targets {#features}

### {{ CH }} {#clickhouse}

If replication is enabled on a {{ CH }} target, the engines for recreating tables are selected depending on the source type:

* When transferring data from row-oriented database management systems, the [ReplicatedReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) and [ReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replacingmergetree/) engines are used.
* When transferring data from {{ CH }}, the [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) engines are used.

### {{ GP }} {#greenplum}

Transfers to and from {{ GP }} are provided on request. Contact [support]({{ link-console-support }}) or your account manager.

### {{ MG }} {#mongodb}

By default, the service does not shard collections transferred to a sharded cluster. For more information, see [Preparing for the transfer](../operations/prepare.md#target-mg).

Transfers to {{ MG }} do not migrate indexes. When a transfer changes its status to {{ dt-status-repl }}, manually create an index for each sharded collection:

```javascript
db.<collection name>.createIndex(<index properties>)
```

For more information about the `createIndex()` function, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/reference/method/db.collection.createIndex/#mongodb-method-db.collection.createIndex).

### {{ PG }} {#postgresql}

* The service does not transfer `MATERIALIZED VIEWS`. When transfering data from one {{ PG }} cluster to another, create all the required materialized views in the target cluster after [deactivating the transfer](../operations/transfer.md#deactivate).

* The service does not transfer custom data types if the endpoint specifies a list of included or excluded tables for the source. If this is the case, please transfer your custom data types manually.

* When transferring [partitioned tables](https://www.postgresql.org/docs/current/ddl-partitioning.html), take the following into account:

   **For tables partitioned with declarative partitioning:**

   * The user needs access to the master table and all its partitions on the source.
   * The transfer is performed based on the <q>as is</q> principle: all partitions and the master table will be created on the target.
   * At the copying stage, partitions are transferred to the target independently of each other. This enables the user to speed up the transfer by enabling sharding in the [transfer settings](../operations/transfer#create).
   * At the replication stage, data will automatically be placed into the required partitions.
   * If new partitions are created on the source after the transfer has entered the replication stage, you need to transfer them to the target manually.
   * The user can only transfer a part of the partitions to the target. To do this, the user must add these partitions to the [List of included tables](../operations/endpoint/source/postgresql#additional-settings) or close access to unnecessary partitions on the source.

   **For tables partitioned with the inheritance method:**

   * The user needs access to the parent table and all child tables.
   * At the copying stage, data from the child tables is not duplicated in the parent table. To transfer data from the child tables, they must be explicitly specified in the list of tables to be transferred.
   * At the copying stage, the child tables are transferred to the target independently of each other. This enables the user to speed up the transfer by enabling sharding in the [transfer settings](../operations/transfer#create).
   * At the replication stage, data will automatically be placed into the required child tables or the parent table if inheritance is not used for partitioning.
   * If the child tables are created on the source after the transfer has entered the replication stage, you need to transfer them to the target manually.

   When migrating a database from {{ PG }} to another DBMS, the user can enable the [Merge inherited tables](../operations/endpoint/source/postgresql#additional-settings) option in the source endpoint. In this case:

   * Only the parent table will be transferred to the target, and it will contain the data of those child tables which were explicitly specified in the list of tables to be transferred.
   * The user can still speed up the transfer by enabling sharding in the [transfer settings](../operations/transfer#create), because child tables from the source are concurrently copied to the common table on the target.


### {{ yds-full-name }} {#yds}

By default, a separate table is created for every partition when data is transferred from {{ yds-name }} to {{ CH }}. For all data to be entered in a single table, specify conversion rules in the [advanced endpoint settings for the source](../operations/endpoint/source/data-streams.md#additional-settings).
