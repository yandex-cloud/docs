---
title: "{{ data-transfer-full-name }} specifics for sources and targets"
description: "{{ data-transfer-full-name }} considers the specifics of sources and targets when preparing a transfer and transferring data."
---

# Specifics of working with endpoints

{{ data-transfer-full-name }} has some performance limitations and specifics depending on the endpoint types.

## {{ CH }} {#clickhouse}

The {{ dt-type-copy }} and {{ dt-type-copy-repl }} type transfers (at the copying stage) _from {{ CH }} to {{ CH }}_ do not support `VIEW`. In source endpoints of the {{ CH }} type, `VIEW` objects must be on the "List of excluded tables" if the "List of included tables" is empty or not specified. If the "List of included tables" is not empty, it must not contain `VIEW` objects.

The source supports `MATERIALIZED VIEW` objects but handles them as regular tables. This means that in transfers _from {{ CH }} to {{ CH }}_, `MATERIALIZED VIEW` items are transferred as tables rather than `MATERIALIZED VIEW` objects.

If replication is enabled on a {{ CH }} target, the engines for recreating tables are selected depending on the source type:

* When transferring data from row-oriented database management systems, the [ReplicatedReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) and [ReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replacingmergetree/) engines are used.
* When transferring data from {{ CH }}, the [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) engines are used.

## {{ GP }} {#greenplum}

Transfers _from {{ GP }} to {{ GP }}_ and _from {{ GP }} to {{ PG }}_ do not support moving a schema in the current {{ data-transfer-full-name }} version. If there are user-defined table data types in these transfers, create these data types in the target database manually before starting a transfer. To manually transfer a schema, use [pg_dump]({{ gp.docs.vmware }}/5/greenplum-database/utility_guide-client_utilities-pg_dump.html).

The source treats `FOREIGN TABLE` and `EXTERNAL TABLE` as a regular view and uses the general algorithm for `VIEW` objects when handling them.

{% include [matview limits](../../_includes/data-transfer/pg-gp-matview.md) %}

## {{ MG }} {#mongodb}

By default, the service does not shard collections transferred to a sharded cluster. For more information, see [Preparing for the transfer](../operations/prepare.md#target-mg).

Transfers to {{ MG }} do not migrate indexes. When a transfer changes its status to {{ dt-status-repl }}, manually create an index for each sharded collection:

```javascript
db.<collection_name>.createIndex(<index_properties>)
```

For more information about the `createIndex()` function, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/reference/method/db.collection.createIndex/#mongodb-method-db.collection.createIndex).

## {{ MY }} {#mysql}

Types of data in {{ MY }} target tables may have the `unsigned` property:

* `unsigned smallint`: Values greater than 2^31 are too large to be stored on the target.
* `unsigned bigint`: Values greater than 2^63 are too large to be stored on the target.

A primary key in {{ MY }} cannot be a string of unlimited length.

The {{ MY }} target ignores the source schema name and creates tables in the schema whose name is specified in the endpoint settings.

## {{ PG }} {#postgresql}

{% include [pg-types-limits](../../_includes/data-transfer/notes/pg-source-features.md) %}

The source treats `FOREIGN TABLE` as a regular view and uses the general algorithm for views when handling them.

If the source of a transfer _from {{ PG }} to {{ PG }}_ has a non-empty "List of included tables" specified, user-defined data types in these tables are not transferred. If this is the case, transfer your custom data types manually.

When transferring [partitioned tables](https://www.postgresql.org/docs/current/ddl-partitioning.html), take the following into account:

* **For tables partitioned with declarative partitioning:**

   * The user needs access to the master table and all its partitions on the source.
   * The transfer is performed based on the <q>as is</q> principle: all partitions and the master table will be created on the target.
   * At the copying stage, partitions are transferred to the target independently of each other. To speed up their transfer, configure [parallel copy](sharded.md).
   * At the replication stage, data will automatically be placed into the required partitions.
   * If new partitions are created on the source after the transfer has entered the replication stage, you need to transfer them to the target manually.
   * The user can only transfer a part of the partitions to the target. To do this, the user must add these partitions to the [List of included tables](../operations/endpoint/source/postgresql#additional-settings) or close access to unnecessary partitions on the source.

* **For tables partitioned with the inheritance method:**

   * The user needs access to the parent table and all child tables.
   * At the copying stage, data from the child tables is not duplicated in the parent table. To transfer data from the child tables, they must be explicitly specified in the list of tables to be transferred.
   * At the copying stage, the child tables are transferred to the target independently of each other. To speed up their transfer, configure [parallel copy](sharded.md).
   * At the replication stage, data will automatically be placed into the required child tables or the parent table if inheritance is not used for partitioning.
   * If the child tables are created on the source after the transfer has entered the replication stage, you need to transfer them to the target manually.

   When migrating a database from {{ PG }} to another DBMS, the user can enable the [Merge inherited tables](../operations/endpoint/source/postgresql#additional-settings) option in the source endpoint. In this case:

   * Only the parent table will be transferred to the target, and it will contain the data of those child tables which were explicitly specified in the list of tables to be transferred.
   * The user can still speed up the transfer because child tables from the source are concurrently copied to the common table on the target. To speed up the transfer, enable [parallel copy](sharded.md).

### Data transfer rate {#postgresql-speed}

Average rate of transferring a table to a single stream for transfers from {{ PG }} to:

* {{ PG }}: 21 Mbps.
* Another DBMS: 3.5 Mbps.

You can speed up data transfers using [sharded copying](./sharded.md).



### Number of connections to a database {#postgresql-connection-limit}

{{ PG }} has a [limit on the number of times a user can connect](../../managed-postgresql/concepts/settings-list.md#setting-conn-limit) to the database. If this limit is exceeded for a transfer, the transfer will work incorrectly or fail.

You can calculate the number of connections a transfer will require using the following formulas:

* For the {{ PG }} resource and the _{{ dt-type-copy }}_ transfer type:

   ```text
   <number_of_workers> * <number_of_threads> + 1
   ```

   Where:
   * `number_of_workers` and `number_of_threads`: Parameters of the transfer, where the {{ PG }} source is specified.
   * `1`: Connection for the master transaction.

* For the {{ PG }} resource and the _{{ dt-type-copy-repl }}_ transfer type:

   ```text
   <number_of_workers> * <number_of_threads> + 2
   ```

   Where:
   * `number_of_workers` and `number_of_threads`: Parameters of the transfer, where the {{ PG }} source is specified.
   * `2`: Connections for the master transaction and slot monitor.

* For the {{ PG }} target:

   ```text
   <number_of_workers> * <number_of_threads>
   ```

   Where `number_of_workers` and `number_of_threads` are the parameters of the transfer, where the {{ PG }} target is specified.

If the calculated amount exceeds the limit, do one of the following:

* [Reduce the number of workers or threads](../../data-transfer/operations/transfer.md#update) in the transfer.
* [Increase the maximum allowed number of connections](../../managed-postgresql/operations/cluster-users.md#update-settings) for a user in {{ PG }}.

## {{ yds-full-name }} {#yds}

By default, a separate table is created for every partition when data is transferred from {{ yds-name }} to {{ CH }}. For all data to be entered in a single table, specify conversion rules in the [advanced endpoint settings for the source](../operations/endpoint/source/data-streams.md#additional-settings).


## Oracle {#oracle}

The source ignores `VIEW` and `MATERIALIZED VIEW` objects in transfers of any type.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
