---
title: "How to configure a source {{ GP }} endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up a source {{ GP }} endpoint in {{ data-transfer-full-name }}."
---

# Configuring {{ GP }} source endpoints

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mgp-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).



## {{ mgp-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need the [`{{ roles.mgp.viewer }}` role](../../../../managed-greenplum/security/index.md#mgp-viewer) or the primitive [`viewer` role](../../../../iam/concepts/access-control/roles.md#viewer) issued for the folder hosting a cluster of this managed database.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs %}

- Management console

   {% include [Managed Greenplum](../../../../_includes/data-transfer/necessary-settings/ui/managed-greenplum.md) %}

{% endlist %}



## Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs %}

- Management console

   {% include [On premise Greenplum UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-greenplum.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTableFilter.include_tables.title }}**: Data is only transferred from listed tables.

      If a table is partitioned, you can use this field to specify both the entire table and individual partitions.

      Make sure that, for tables to be included in the list, [all the necessary privileges are granted](../../../../data-transfer/operations/prepare.md#source-gp) to the user on whose behalf data will be transferred.

      {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTableFilter.exclude_tables.title }}**: Data from the listed tables is not transferred.

      If a table is partitioned, to exclude it from the list, make sure to list all of its partitions.

      The lists include the name of the [schema]({{gp.docs.vmware}}/6/greenplum-database/admin_guide-ddl-ddl-schema.html) (description of DB contents, structure, and integrity constraints) and the table name. Both lists support expressions in the following format:

      * `<schema_name>.<table_name>`: Fully qualified table name.
      * `<schema_name>.*`: All tables in the specified schema.
      * `<table_name>`: Table in the default schema.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.strong_consistency.title }}**: When enabled, {{ data-transfer-name }} will apply additional steps to the source to assure [snapshot consistency](#snapshot-consistency).

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.service_schema.title }}**: Schema for placing auxiliary objects of the transfer.

{% endlist %}

## Specifics of working with the Greenplum source {#advanced}

{{ data-transfer-name }} only supports {{ GP }} version 6. {{ GP }} versions 4 and 5 are not supported.

The service performs operations on a {{ GP }} cluster with the [READ COMMITTED]({{ gp.docs.pivotal }}/6-19/ref_guide/sql_commands/SET_TRANSACTION.html) `level of isolation`.

{{ data-transfer-name }} supports operation with [parallel copy](../../../concepts/sharded.md) enabled for a {{ GP }} source.

During operation with parallel copy enabled, {{ data-transfer-name }} maintains an open transaction on the {{ GP }} master host. If this transaction is interrupted, a transfer will return an error.

With parallel copy disabled, a transfer will move data from {{ GP }} objects such as `TABLE`, `VIEW`, `FOREIGN TABLE`, and `EXTERNAL TABLE`. Data from these objects will be treated as data from ordinary tables and processed by the target accordingly. With parallel copy enabled, a transfer will only move tables (`TABLE` objects). Tables with the `DISTRIBUTED REPLICATED`({{ gp.docs.pivotal }}/6-19/admin_guide/distribution.html) [allocation policy] will not be transferred.

### Snapshot consistency {#snapshot-consistency}

When starting a transfer with parallel copy disabled (by default), the service copies data only interacting with the {{ GP }} cluster's [master host](../../../../managed-greenplum/concepts/index.md). The copied tables are accessed in [ACCESS SHARE]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-sql_commands-LOCK.html) `lock mode`. Snapshot consistency is achieved through {{ GP }} mechanisms.

When starting a transfer with parallel copy enabled, the service copies data interacting with both the {{ GP }} cluster's master host and [segment hosts](../../../../managed-greenplum/concepts/index.md) in utility mode. Access to the tables to be copied locks the tables in `ACCESS SHARE` or `SHARE` mode depending on the Snapshot consistency setting.

To guarantee snapshot consistency, transfers with parallel copy enabled need to ensure that data in the tables being transferred remains static. For `ACCESS SHARE` locks (by default), the service does not guarantee that the data will remain static: this must be assured externally. For `SHARE` locks, the {{ GP }} mechanisms guarantee that data in the source tables remains static.

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
