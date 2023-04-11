---
title: "{{ data-transfer-full-name }} specifics for sources and targets"
description: "{{ data-transfer-full-name }} considers the specifics of sources and targets when preparing a transfer and transferring data."
---

# Specifics of working with endpoints

{{ data-transfer-full-name }} has some performance limitations and specifics depending on the endpoint types.

## {{ CH }} {#clickhouse}

{{ dt-type-copy }} and {{ dt-type-copy-repl }} transfers (in the copy step) _from {{ CH }} to {{ CH }}_ do not support `VIEW` objects. In source endpoints of the {{ CH }} type, `VIEW` objects must be on the "List of excluded tables" if the "List of included tables" is empty or not specified. If the "List of included tables" is not empty, it must not contain `VIEW` objects.

The source supports `MATERIALIZED VIEW` objects but handles them as regular tables. This means that in transfers _from {{ CH }} to {{ CH }}_, `MATERIALIZED VIEW` items are transferred as tables rather than `MATERIALIZED VIEW` objects.

If replication is enabled on a {{ CH }} target, the engines for recreating tables are selected depending on the source type:

* When transferring data from row-oriented database management systems, the [ReplicatedReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) and [ReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replacingmergetree/) engines are used.
* When transferring data from {{ CH }}, the [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) engines are used.

## {{ GP }} {#greenplum}

Transfers _from {{ GP }} to {{ GP }}_ and _from {{ GP }} to {{ PG }}_ do not support transfers of a schema in the current {{data-transfer-full-name}} version. If there are user-defined table data types in these transfers, create these data types in the target database manually before starting a transfer. To manually transfer a schema, use [`pg_dump`]({{ gp.docs.pivotal }}/6-19/utility_guide/ref/pg_dump.html).

The source treats `FOREIGN TABLE` and `EXTERNAL TABLE` as a regular view and uses the general algorithm for `VIEW` objects when handling them.

The source never transfers data from a `MATERIALIZED VIEW`, even during transfers from {{ GP }} to a different database.

## {{ MG }} {#mongodb}

By default, the service does not shard collections transferred to a sharded cluster. For more information, see [Preparing for the transfer](../operations/prepare.md#target-mg).

Transfers to {{ MG }} do not migrate indexes. When a transfer changes its status to {{ dt-status-repl }}, manually create an index for each sharded collection:

```javascript
db.<collection name>.createIndex(<index properties>)
```

For more information about the `createIndex()` function, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/reference/method/db.collection.createIndex/#mongodb-method-db.collection.createIndex).

## {{ PG }} {#postgresql}

The source never transfers data from a `MATERIALIZED VIEW`, even during transfers from {{ PG }} to a different database. In transfers _from {{ PG }} to {{ PG }}_, a `MATERIALIZED VIEW` is treated as a regular view and handled using the general algorithm for `VIEW` objects.

The source treats a `FOREIGN TABLE` as a regular view and uses the general algorithm for views when handling them.

If the source of a transfer _from {{ PG }} to {{ PG }}_ has a non-empty "List of included tables" specified, user-defined data types that are present in these tables aren't transferred. If this is the case, please transfer your custom data types manually.

When transferring [partitioned tables](https://www.postgresql.org/docs/current/ddl-partitioning.html), take the following into account:

* **For tables partitioned with declarative partitioning:**

   * The user needs access to the master table and all its partitions on the source.
   * The transfer is performed based on the <q>as is</q> principle: all partitions and the master table will be created on the target.
   * At the copying stage, partitions are transferred to the target independently of each other. This enables the user to speed up the transfer by enabling sharding in the [transfer settings](../operations/transfer#create).
   * At the replication stage, data will automatically be placed into the required partitions.
   * If new partitions are created on the source after the transfer has entered the replication stage, you need to transfer them to the target manually.
   * The user can only transfer a part of the partitions to the target. To do this, the user must add these partitions to the [List of included tables](../operations/endpoint/source/postgresql#additional-settings) or close access to unnecessary partitions on the source.

* **For tables partitioned with the inheritance method:**

   * The user needs access to the parent table and all child tables.
   * At the copying stage, data from the child tables is not duplicated in the parent table. To transfer data from the child tables, they must be explicitly specified in the list of tables to be transferred.
   * At the copying stage, the child tables are transferred to the target independently of each other. This enables the user to speed up the transfer by enabling sharding in the [transfer settings](../operations/transfer#create).
   * At the replication stage, data will automatically be placed into the required child tables or the parent table if inheritance is not used for partitioning.
   * If the child tables are created on the source after the transfer has entered the replication stage, you need to transfer them to the target manually.

   When migrating a database from {{ PG }} to another DBMS, the user can enable the [Merge inherited tables](../operations/endpoint/source/postgresql#additional-settings) option in the source endpoint. In this case:

   * Only the parent table will be transferred to the target, and it will contain the data of those child tables which were explicitly specified in the list of tables to be transferred.
   * The user can still speed up the transfer by enabling sharding in the [transfer settings](../operations/transfer#create), because child tables from the source are concurrently copied to the common table on the target.



## {{ yds-full-name }} {#yds}

By default, a separate table is created for every partition when data is transferred from {{ yds-name }} to {{ CH }}. For all data to be entered in a single table, specify conversion rules in the [advanced endpoint settings for the source](../operations/endpoint/source/data-streams.md#additional-settings).


## Oracle {#oracle}

The source ignores `VIEW` and `MATERIALIZED VIEW` objects in transfers of any type.
