---
title: How to set up a {{ ytsaurus-name }} target endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up a {{ ytsaurus-name }} target endpoint in {{ data-transfer-full-name }}.
---

# Transferring data to a {{ ytsaurus-name }} target endpoint

{{ data-transfer-full-name }} enables you to migrate data to {{ ytsaurus-name }} and implement various data transfer, processing, and transformation scenarios.


There are two types of target endpoints available for {{ ytsaurus-name }}:

* `YTSaurus Dynamic`: Writing data to [dynamic tables](https://ytsaurus.tech/docs/ru/user-guide/dynamic-tables/overview).
* `YTSaurus Static`: Writing data to [static tables](https://ytsaurus.tech/docs/ru/user-guide/storage/static-tables).


To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform the required operations with the database and [see how the transfer is going](../../monitoring.md).


## Scenarios for transferring data to {{ ytsaurus-name }} using {{ data-transfer-full-name }} {#scenarios}

You can implement scenarios for loading data from tables into {{ yandex-cloud }} managed databases for storage in the cloud, processing, and loading into data marts for visualization.

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ KF }}](../source/kafka.md) (transfer is only possible to a `YTSaurus Dynamic` target)
* [{{ CH }}](../source/clickhouse.md)
* [{{ GP }}](../source/greenplum.md)
* [{{ MG }}](../source/mongodb.md)
* [{{ MY }}](../source/mysql.md)
* [{{ PG }}](../source/postgresql.md)
* [{{ objstorage-full-name }}](../source/object-storage.md)
* [Oracle](../source/oracle.md)
* [{{ ydb-name }}](../source/ydb.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

## Preparing the target database {#prepare}

1. To transfer to static tables, grant permissions to create and write to tables (`write` permission for the directory with tables). If data cleanup is performed before the transfer, grant the `remove` permission. To perform a transfer, you will also need the `use` permission for the account associated with the directory the tables will be in.

1. To transfer to dynamic tables, in addition to the `write`, `remove`, and `use` permissions, grant the permission to `mount` tables.

## Configuring the {{ ytsaurus-name }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* Settings for connecting to a [{{ myt-full-name }} cluster](#cluster). These are required parameters.
* [Additional settings](#additional-settings).

### Supported data delivery schemas and limits {#supported-transfers}

| Data delivery schemas                                             | Support level                            | Constraints                                                                                                                                              |
|-------------------------------------------------------------------|----------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| Delivering data to static tables                             | ![image](../../../../_assets/common/yes.svg) | Without data transformation (sharding, rotation, or splitting tables into subtables)                                                                    |
| Parallel copy of data to static tables                    | ![image](../../../../_assets/common/no.svg)  | Under development.                                                                                                                        |
| Delivering data to dynamic tables through static ones          | ![image](../../../../_assets/common/yes.svg) | All intermediate operations on table parts are run as non-transactional and users can see them.<br>`Disabled` and `Drop` cleanup policy limits ^1^. |
| Parallel copy of data to dynamic tables through static ones | ![image](../../../../_assets/common/yes.svg) | All intermediate operations on table parts are run as non-transactional and users can see them.<br>`Disabled` and `Drop` cleanup policy limits ^1^. |

^1^ Cleanup policy limits:
* If the `Disabled` cleanup policy is used, there is no guarantee that new data in existing tables will take precedence over the old should the keys overlap.
* With the `Drop` policy, the old tables are cleaned up before parts of new tables are added to them. We will fix that.

{% note warning %}

For dynamic tables, primary keys in the data are a requirement. {{ ytsaurus-name }} dynamic tables store data in `key:value` format, where the key and its associated value must also be specified. If there is no non-key column value, the `__dummy` non-key stub column will be created. If there is no primary key, the transfer will end with an error.

{% endnote %}

### {{ myt-name }} cluster {#cluster}

{% list tabs group=instructions %}

- Management console {#console}

  
  {% include [main-settings](../../../../_includes/data-transfer/fields/yt/ui/main-settings.md) %}

  * **Path**: Path to the folder to write the transferred data to.


  * {% include [Cleanup Policy](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-disabled-drop.md) %}

{% endlist %}


### Advanced settings {#additional-settings}


#### Settings for the YTSaurus Dynamic database type

{% list tabs group=instructions %}

- Management console {#console}

    * **Table settings**:

        * {% include [medium](../../../../_includes/data-transfer/fields/yt/ui/medium.md) %}
        * {% include [chunk-format](../../../../_includes/data-transfer/fields/yt/ui/chunk-format.md) %}
        * {% include [atomic-transactions](../../../../_includes/data-transfer/fields/yt/ui/atomic-transactions.md) %}
        * {% include [ttl](../../../../_includes/data-transfer/fields/yt/ui/ttl.md) %}
        * {% include [custom-attributes](../../../../_includes/data-transfer/fields/yt/ui/custom-attributes.md) %}

    * **Write settings**:

        * {% include [alter-schema-change](../../../../_includes/data-transfer/fields/alter-schema-change.md) %}
        * {% include [big-value](../../../../_includes/data-transfer/fields/yt/ui/big-value.md) %}
        * {% include [copy-via-static-table](../../../../_includes/data-transfer/fields/yt/ui/copy-via-static-table.md) %}
        * {% include [computing-pool](../../../../_includes/data-transfer/fields/yt/ui/computing-pool.md) %}

{% endlist %}

#### Settings for the YTSaurus Static database type

{% list tabs group=instructions %}

- Management console {#console}

    * **Table settings**:

        * {% include [chunk-format](../../../../_includes/data-transfer/fields/yt/ui/chunk-format.md) %}
        * **Sort static tables**: Enable this option if you need to [sort table records](https://ytsaurus.tech/docs/ru/user-guide/storage/static-tables#sorted_tables) by key.
        * {% include [custom-attributes](../../../../_includes/data-transfer/fields/yt/ui/custom-attributes.md) %}

    * **Write settings**:

        * {% include [big-value](../../../../_includes/data-transfer/fields/yt/ui/big-value.md) %}
        * {% include [computing-pool](../../../../_includes/data-transfer/fields/yt/ui/computing-pool.md) %}

{% endlist %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

