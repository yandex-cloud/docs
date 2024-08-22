---
title: "How to configure a {{ ydb-full-name }} source endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up a {{ ydb-full-name }} source endpoint when creating or updating it in {{ data-transfer-full-name }}."
---

# Transferring data from an {{ ydb-name }} source endpoint


{{ data-transfer-full-name }} enables you to migrate data from a {{ ydb-name }} database and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the {{ ydb-name }}](#prepare) database for the transfer.
1. [Set up an endpoint source](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data from {{ ydb-name }} {#scenarios}

1. {% include [cdc](../../../../_includes/data-transfer/scenario-captions/cdc.md) %}

* [Capturing changes from {{ PG }} and delivering to {{ DS }}](../../../tutorials/ydb-to-yds.md).
* [Capturing changes from {{ PG }} and delivering to {{ KF }}](../../../tutorials/cdc-ydb.md).

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

   * [Loading data from {{ ydb-short-name }} to the {{ CH }} data mart](../../../tutorials/ydb-to-clickhouse.md).

1. {% include [storage](../../../../_includes/data-transfer/scenario-captions/storage.md) %}

   * [Loading data from {{ ydb-short-name }} to {{ objstorage-name }}](../../../../_tutorials/dataplatform/datatransfer/ydb-to-object-storage.md).

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/sources/ydb-prepare.md) %}

## Configuring the {{ ydb-name }} source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:
* {{ ydb-full-name }} DB connection settings. These are required parameters.
* Transfer path list (for tables and directories).


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`ydb.viewer` role](../../../../ydb/security/index.md#ydb-viewer) or the [`viewer` primitive role](../../../../iam/roles-reference.md#viewer) assigned for the folder where this managed database cluster resides.

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

  * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/database-name.md) %}


  * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/service-account.md) %}

  * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/security-groups.md) %}


  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}**: Add paths to the {{ ydb-name }} tables and directories to transfer.

    Table and directory names must meet the ID naming rules in {{ ydb-short-name }}. Escaping double quotes is not required. The `/` character is used as a delimiter in the path. For more information, see the [{{ ydb-short-name }} documentation](https://ydb.tech/docs/ru/concepts/connect#database).

    Adding new paths when editing an endpoint used in {{ dt-type-copy-repl }} transfers in the {{ dt-status-repl }} status will not result in uploading the data history of these tables. To add a table with its historical data, use the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** field in the [transfer settings](../../transfer.md#update).

    For {{ dt-type-copy }} transfers, you may skip specifying paths. In this case, all tables will be transferred.

    For {{ dt-type-repl }} or {{ dt-type-copy-repl }} transfers, specifying paths is required, including when you replicate all tables.

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.changefeed_custom_name.title }}**: Here, specify the name of the update stream if it was already created. Otherwise, leave the field blank.

{% endlist %}


## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ CH }}](../target/clickhouse.md)​.
* [{{ objstorage-full-name }}](../target/object-storage.md)​.
* [{{ KF }}](../target/kafka.md).
* [{{ DS }}](../target/data-streams.md).
* [{{ ydb-full-name }}](../target/yandex-database.md)​.

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Troubleshooting data transfer issues {#troubleshooting}

Known issues when using a {{ ydb-name }} endpoint:

{% include [overloaded](../../../../_includes/data-transfer/troubles/overloaded.md) %}

See a full list of recommendations in the [Troubleshooting](../../../troubleshooting/index.md) section.
