---
title: How to set up a {{ ydb-name }} target endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up an {{ ydb-name }} target endpoint in {{ data-transfer-full-name }}.
---
# Transferring data to a {{ ydb-name }} target endpoint


{{ data-transfer-full-name }} enables you to migrate data to a {{ ydb-name }} database and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Prepare the {{ ydb-name }}](#prepare) database for the transfer.
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data to {{ ydb-name }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
    
    * [Migration with change of storage from {{ MY }} to {{ ydb-short-name }}](../../../tutorials/managed-mysql-to-ydb.md).
    * [Migration with change of storage from {{ PG }} to {{ ydb-short-name }}](../../../tutorials/mpg-to-ydb.md).
    * [Migration with change of storage from {{ OS }} to {{ ydb-short-name }}](../../../tutorials/opensearch-to-ydb.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    
    * [Delivering data from {{ KF }} to {{ ydb-short-name }}](../../../tutorials/mkf-to-ydb.md).
    * [Delivering data from {{ DS }} to {{ ydb-short-name }}](../../../tutorials/yds-to-ydb.md).
1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

    * [Loading data from {{ objstorage-name }} to {{ ydb-short-name }}](../../../tutorials/object-storage-to-ydb.md).

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ MY }}](../source/mysql.md)
* [{{ KF }}](../source/kafka.md)
* [{{ AB }}](../../../transfer-matrix.md#airbyte)
* [{{ DS }}](../source/data-streams.md)
* [{{ objstorage-full-name }}](../source/object-storage.md)
* [{{ PG }}](../source/postgresql.md)
* [{{ ES }}](../source/elasticsearch.md)
* [{{ OS }}](../source/opensearch.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

## Preparing the target database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/ydb-prepare.md) %}

## Configuring the {{ ydb-name }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* {{ ydb-full-name }} DB connection settings. These are required parameters.
* [Additional parameters](#additional-settings).

### {{ ydb-full-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`ydb.viewer` role](../../../../ydb/security/index.md#ydb-viewer) or the [`viewer` primitive role](../../../../iam/roles-reference.md#viewer) assigned for the folder where this managed database cluster resides.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [YDB UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-database.md) %}

{% endlist %}

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.shard_count.title }}**: Specify the required number of `N` shards.

        If the setting is specified, the `_shard_col` column is added to tables. Its values are calculated as the remainder of `H/N`, where `H` is the result of the hash function at the current time, and `N` is the number of shards according to the setting.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.default_compression.title }}**: Set the `COMPRESSION` setting for the default column group (FAMILY default).
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.path.title }}**: Specify the [subdirectory]({{ ydb.docs }}/concepts/datamodel/dir) to host your tables.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.partition_policy.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.part_type.title }}**: Hour, day, or month.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.part_size.title }}**: In the selected units of measurement.

            When the time interval equal to the selected unit of measurement ends, the oldest database table will be deleted and a new one will be created.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.keep_part_count.title }}**: Required number of tables in the target database.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.time_column.title }}**: Column to split (_partition_) the table based on. The column must be of the _time_ type.


            For more information about partitioning tables, see the [{{ ydb-full-name }}]({{ ydb.docs }}/concepts/datamodel/table#partitioning) documentation.


        If this setting is used, the specified number of data tables for different intervals is created in the target database. The name of each table is selected automatically by the date and time of the start of the interval. Depending on the values in the specified column of the source table, the original rows are distributed across the respective tables in the target database.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.alt_names.title }}**: Fill if you need to rename the source database tables when transferring them to the target database.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.is_table_column_oriented.title }}**: Select this option to create column-oriented OLAP tables. By default, row-oriented OLTP tables are used.

{% endlist %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Troubleshooting data transfer issues {#troubleshooting}

Known issues when using a {{ ydb-name }} endpoint:

{% include [overloaded](../../../../_includes/data-transfer/troubles/overloaded.md) %}

For more troubleshooting tips, see [Troubleshooting](../../../troubleshooting/index.md).
