---
title: How to set up a {{ GP }} source endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to create and configure a {{ GP }} source endpoint in {{ data-transfer-full-name }}.
---

# Transferring data from a {{ GP }}/{{ CB }} source endpoint

{{ data-transfer-full-name }} enables you to migrate data from a {{ GP }} and {{ CB }} database and implement various transfer, processing, and transformation scenarios. To set up a transfer:

1. [Review possible data transfer scenarios](#scenarios).
1. [Prepare the {{ GP }}](#prepare) database for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) and [launch](../../transfer.md#activate) the transfer.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. If you run into any problems, [check the available solutions](../../../troubleshooting/index.md) for troubleshooting.

## {{ GP }} and {{ CB }} data transfer scenarios {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

    * [Migrating a {{ GP }} or an {{ CB }} cluster](../../../tutorials/managed-greenplum.md).

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

    * [Loading data from {{ GP }} or {{ CB }} to a {{ CH }} data mart](../../../tutorials/greenplum-to-clickhouse.md).
    * [Loading data from {{ GP }} or {{ CB }} to a {{ PG }} data mart](../../../tutorials/greenplum-to-postgresql.md).

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the {{ GP }} and {{ CB }} database {#prepare}

{% include [prepare greenplum db](../../../../_includes/data-transfer/endpoints/sources/greenplum-prepare.md) %}

## Configuring the {{ GP }} and {{ CB }} source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can configure:

* Connection settings for a [{{ mgp-full-name }} cluster](#managed-service) or a [custom deployment](#on-premise), including those running on {{ compute-full-name }} VMs. These settings are required.
* [Optional settings](#additional-settings).


### {{ mgp-name }} cluster {#managed-service}


{% note warning %}

To create or edit a managed database endpoint, you will need the [`{{ roles.mgp.viewer }}`](../../../../managed-greenplum/security/index.md#mgp-viewer) role or the primitive [`viewer`](../../../../iam/roles-reference.md#viewer) role for the folder where its cluster resides.

{% endnote %}


Connection to the database with the cluster specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [Managed Greenplum](../../../../_includes/data-transfer/necessary-settings/ui/managed-greenplum.md) %}

{% endlist %}


### Custom installation {#on-premise}

Connection to the database with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [On premise Greenplum UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-greenplum.md) %}

{% endlist %}

### Table filter {#filter-settings}

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTableFilter.include_tables.title }}**: Only data from the tables listed here will be transferred.

      If a table is partitioned, you can use this field to specify both the entire table and individual partitions.

      Make sure that, for tables to be included in the list, [all the necessary privileges are granted](../../../../data-transfer/operations/prepare.md#source-gp) to the user to perform the data transfer.

      {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTableFilter.exclude_tables.title }}**: Data from the listed tables is not transferred.

      If a table is partitioned, to exclude it from the list, make sure to list all of its partitions.

      The lists include the name of the [schema]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-ddl-ddl-schema.html) that describes the DB contents, structure, and integrity constraints, as well as the table name. Both lists support expressions in the following format:

      * `<schema_name>.<table_name>`: Full table name.
      * `<schema_name>.*`: All tables in the specified schema.
      * `<table_name>`: Table in the default schema.

      The names of the tables you include or exclude must follow the {{ GP }} and {{ CB }} identifier naming rules. Double quotes within a table name are not supported. Outer quotes are only used as delimiters and will be deleted when processing paths.

{% endlist %}

### Advanced settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.strong_consistency.title }}**: When enabled, {{ data-transfer-name }} will apply additional steps to the source to assure [snapshot consistency](#snapshot-consistency).

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.service_schema.title }}**: Schema for placing auxiliary objects of the transfer.

      The schema name must meet the ID naming rules in {{ GP }}. Double quotes are not supported in schema names.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.disable_gpfdist.title }}**: Disables [`gpfdist`](../../../../managed-greenplum/operations/gpfdist/connect.md) for transfers from {{ GP }} to {{ GP }}.

{% endlist %}

### Nuances to working with a {{ GP }}/{{ CB }} source {#advanced}

{{ data-transfer-name }} supports {{ GP }} 6.28 or higher and {{ CB }} Cloudberry 2.

The service performs operations on a cluster with the `READ COMMITTED` [level of isolation]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-SET_TRANSACTION.html).

{{ data-transfer-name }} supports operation with [parallel copy](../../../concepts/sharded.md) enabled for a {{ GP }} and {{ CB }} source.

During operation with parallel copy enabled, {{ data-transfer-name }} maintains an open transaction on the master host. If this transaction is interrupted, a transfer will return an error.

With parallel copy disabled, a transfer will move data from these {{ GP }} or {{ CB }} objects: `TABLE`, `VIEW`, `FOREIGN TABLE`, and `EXTERNAL TABLE`. Data from these objects will be treated as data from ordinary tables and processed by the target accordingly. With parallel copy enabled, a transfer will only move tables (`TABLE` objects). However, tables with the `DISTRIBUTED REPLICATED` [allocation policy]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-CREATE_TABLE.html) will not be transferred.

If a {{ GP }}/{{ CB }}-to-{{ GP }}/{{ CB }} transfer does not use direct reads from segments, the number of threads cannot exceed the minimum number of segments in the participating clusters.

You can check the number of segments in the [management console]({{ link-console-main }}) or by running an SQL query:

```pgsql
SELECT COUNT(*) FROM gp_segment_configuration WHERE role='p' AND content >= 0;
```

The number of workers participating in the transfer is limited to a specified number of threads. Each worker transfers tables one by one, with each table only transferred by one worker.

### Snapshot consistency {#snapshot-consistency}

When you start a transfer with parallel copy off (default), the service interacts only with the cluster's [master host](../../../../managed-greenplum/concepts/index.md) when copying data. The tables being copied are accessed in `ACCESS SHARE` [lock mode]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-LOCK.html). Snapshot consistency is achieved through database mechanisms.

When you start a transfer with parallel copy on, the service interacts with both the master host and the cluster's [segment hosts](../../../../managed-greenplum/concepts/index.md) in utility mode. The tables being copied are accessed in `ACCESS SHARE` or `SHARE` lock mode, depending on the snapshot consistency setting.

To guarantee snapshot consistency, a transfer with parallel copy on has to ensure the data in the tables remains static. With `ACCESS SHARE` (default), the service is unable to guarantee that the data will remain static, so this must be ensured externally. With `SHARE`, database mechanisms are in place to guarantee that data in the source tables remains static.

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}


## Configuring the target {#supported-targets}

Configure one of the supported data targets:

* [{{ PG }}](../target/postgresql.md)
* [{{ CH }}](../target/clickhouse.md)
* [{{ GP }}/{{ CB }}](../target/greenplum.md)
* [{{ ytsaurus-name }}](../source/yt.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

Once you have configured the source and target, [create and launch the transfer](../../transfer.md#create).
