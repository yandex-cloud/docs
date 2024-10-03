---
title: How to configure a {{ GP }} source endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up a {{ GP }} source endpoint in {{ data-transfer-full-name }}.
---

# Transferring data from a {{ GP }} source endpoint


{{ data-transfer-full-name }} enables you to migrate data from a {{ GP }} database and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the {{ GP }}](#prepare) database for the transfer.
1. [Set up an endpoint source](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](../../../troubleshooting/index.md) to resolve them.

## Scenarios for transferring data from {{ GP }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

   * [Migrating a {{ GP }} cluster](../../../tutorials/managed-greenplum.md).

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

   * [Loading data from {{ GP }} to the {{ CH }} data mart](../../../tutorials/greenplum-to-clickhouse.md).
   * [Loading data from {{ GP }} to the {{ PG }} data mart](../../../tutorials/greenplum-to-postgresql.md).

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the {{ GP }} source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mgp-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).



### {{ mgp-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mgp.viewer }}` role](../../../../managed-greenplum/security/index.md#mgp-viewer) or the [`viewer` primitive role](../../../../iam/roles-reference.md#viewer) assigned for the folder where this managed database cluster resides.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [Managed Greenplum](../../../../_includes/data-transfer/necessary-settings/ui/managed-greenplum.md) %}

{% endlist %}



### Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [On premise Greenplum UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-greenplum.md) %}

{% endlist %}

### Table filter {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTableFilter.include_tables.title }}**: Only data from the tables listed here will be transferred.

      If a table is partitioned, you can use this field to specify both the entire table and individual partitions.

      Make sure that, for tables to be included in the list, [all the necessary privileges are granted](../../../../data-transfer/operations/prepare.md#source-gp) to the user to perform the data transfer.

      {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTableFilter.exclude_tables.title }}**: Data from the listed tables is not transferred.

      If a table is partitioned, to exclude it from the list, make sure to list all of its partitions.

      The lists include the name of the [schema]({{gp.docs.vmware}}/6/greenplum-database/admin_guide-ddl-ddl-schema.html) (description of DB contents, structure, and integrity constraints) and the table name. Both lists support expressions in the following format:

      * `<schema_name>.<table_name>`: Fully qualified table name.
      * `<schema_name>.*`: All tables in the specified schema.
      * `<table_name>`: Table in the default schema.

      Included and excluded table names must meet the ID naming rules in {{ GP }}. Double quotes within a table name are not supported. Outer quotes are only used as delimiters and will be deleted when processing paths.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.strong_consistency.title }}**: When enabled, {{ data-transfer-name }} will apply additional steps to the source to assure [snapshot consistency](#snapshot-consistency).

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.service_schema.title }}**: Schema for placing auxiliary objects of the transfer.

   The schema name must meet the ID naming rules in {{ GP }}. Double quotes in a schema name are not supported.

{% endlist %}

### Specifics of working with the Greenplum source {#advanced}

{{ data-transfer-name }} only supports {{ GP }} version 6. {{ GP }} versions 4 and 5 are not supported.

The service performs operations on a {{ GP }} cluster with the [READ COMMITTED]({{ gp.docs.pivotal }}/6-19/ref_guide/sql_commands/SET_TRANSACTION.html) `level of isolation`.

{{ data-transfer-name }} supports operation with [parallel copy](../../../concepts/sharded.md) enabled for a {{ GP }} source.

During operation with parallel copy enabled, {{ data-transfer-name }} maintains an open transaction on the {{ GP }} master host. If this transaction is interrupted, a transfer will return an error.

With parallel copy disabled, a transfer will move data from {{ GP }} objects such as `TABLE`, `VIEW`, `FOREIGN TABLE`, and `EXTERNAL TABLE`. Data from these objects will be treated as data from ordinary tables and processed by the target accordingly. With parallel copy enabled, a transfer will only move tables (`TABLE` objects). Tables with the `DISTRIBUTED REPLICATED`({{ gp.docs.vmware }}/6-19/admin_guide/distribution.html) [allocation policy] will not be transferred.

### Snapshot consistency {#snapshot-consistency}

When starting a transfer with parallel copy disabled (by default), the service copies data only interacting with the {{ GP }} cluster's [master host](../../../../managed-greenplum/concepts/index.md). The copied tables are accessed in [ACCESS SHARE]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-sql_commands-LOCK.html) `lock mode`. Snapshot consistency is achieved through {{ GP }} mechanisms.

When starting a transfer with parallel copy enabled, the service copies data interacting with both the {{ GP }} cluster's master host and [segment hosts](../../../../managed-greenplum/concepts/index.md) in utility mode. Access to the tables to be copied locks the tables in `ACCESS SHARE` or `SHARE` mode depending on the Snapshot consistency setting.

To guarantee snapshot consistency, transfers with parallel copy enabled need to ensure that data in the tables being transferred remains static. For `ACCESS SHARE` locks (by default), the service does not guarantee that the data will remain static: this must be assured externally. For `SHARE` locks, the {{ GP }} mechanisms guarantee that data in the source tables remains static.

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}


## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ PG }}](../target/postgresql.md).
* [{{ CH }}](../target/clickhouse.md).
* [{{ GP }}](../target/greenplum.md).

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).
