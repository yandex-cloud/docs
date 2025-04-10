---
title: How to set up an {{ GP }} target endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up a {{ GP }} target endpoint in {{ data-transfer-full-name }}.
---
# Transferring data to a {{ GP }} target endpoint


{{ data-transfer-full-name }} enables you to migrate data to a {{ GP }} database and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Prepare the {{ GP }}](#prepare) database for the transfer.
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](../../../troubleshooting/index.md) to resolve them.

## Scenarios for transferring data to {{ GP }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

    * [Migrating a {{ GP }} cluster](../../../tutorials/managed-greenplum.md).
    * [Migration with change of storage from {{ MY }} to {{ GP }}](../../../tutorials/mmy-to-mgp.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    * [Delivering data from {{ KF }} to {{ GP }}](../../../tutorials/managed-kafka-to-greenplum.md).

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

    * [Loading data from {{ objstorage-name }} to {{ GP }}](../../../tutorials/object-storage-to-greenplum.md).

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ PG }}](../source/postgresql.md)
* [{{ MY }}](../source/mysql.md)
* [{{ GP }}](../source/greenplum.md)
* [{{ KF }}](../source/kafka.md)
* [{{ AB }}](../../../transfer-matrix.md#airbyte)
* [{{ DS }}](../source/data-streams.md)
* [{{ objstorage-full-name }}](../source/object-storage.md)
* [{{ ydb-name }}](../source/ydb.md)
* [Oracle](../source/oracle.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

## Preparing the target database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/greenplum-prepare.md) %}

## Configuring the {{ GP }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* [{{ mgp-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).


### {{ mgp-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you will need the [`{{ roles.mgp.viewer }}`](../../../../managed-greenplum/security/index.md#mgp-viewer) role or the primitive [`viewer`](../../../../iam/roles-reference.md#viewer) role for the folder the cluster of this managed database resides in.

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

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTarget.cleanup_policy.title }}**: Select a way to clean up data in the target database before the transfer:

    * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Select this option if you are only going to do replication without copying data.

    * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Completely delete the tables included in the transfer (default).

        Use this option to always transfer the latest version of the table schema to the target database from the source whenever the transfer is activated.

    * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}`: Delete only the data from the tables included in the transfer but keep the schema.

        Use this option if the schema in the target database differs from the one that would have been transferred from the source during the transfer.

{% endlist %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
