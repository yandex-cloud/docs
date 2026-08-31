---
title: How to set up a {{ GP }}/{{ CB }} target endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up a {{ GP }}/{{ CB }} target endpoint in {{ data-transfer-full-name }}.
---
# Transferring data to a {{ GP }}/{{ CB }} target endpoint

{{ data-transfer-full-name }} enables you to migrate data to a {{ GP }}/{{ CB }} database and implement various data transfer, processing, and transformation scenarios. To set up a transfer:

1. [Review possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Prepare your {{ GP }}/{{ CB }}](#prepare) database for the transfer.
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) and [launch](../../transfer.md#activate) the transfer.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. If you run into any problems, [check the available solutions](../../../troubleshooting/index.md) for troubleshooting.

## Scenarios for transferring data to {{ GP }}/{{ CB }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

    * [Migrating a {{ GP }} or an {{ CB }} cluster](../../../tutorials/managed-greenplum.md).
    * [Migrating with change of storage from {{ MY }} to {{ GP }} or {{ CB }}](../../../tutorials/mmy-to-mgp.md).
    * [Migrating with change of storage from {{ OS }} to {{ GP }} or {{ CB }}](../../../tutorials/opensearch-to-greenplum.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    * [Delivering data from {{ KF }} to {{ GP }} or {{ CB }}](../../../tutorials/managed-kafka-to-greenplum.md).

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

    * [Loading data from {{ objstorage-name }} to {{ GP }} or {{ CB }}](../../../tutorials/object-storage-to-greenplum.md).

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ PG }}](../source/postgresql.md)
* [{{ MY }}](../source/mysql.md)
* [{{ GP }}/{{ CB }}](../source/greenplum.md)
* [{{ KF }}](../source/kafka.md)
* [{{ AB }}](../../../transfer-matrix.md#airbyte)
* [{{ DS }}](../source/data-streams.md)
* [{{ objstorage-full-name }}](../source/object-storage.md)
* [{{ ytsaurus-name }}](../source/yt.md)
* [{{ ydb-name }}](../source/ydb.md)
* [Oracle](../source/oracle.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

## Preparing the target database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/greenplum-prepare.md) %}

## Configuring the {{ GP }} or {{ CB }} target endpoint {#endpoint-settings}

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

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTarget.cleanup_policy.title }}**: Select the pre-transfer cleanup policy for the target database:

    * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Select this option if you are only replicating data, without copying it.

    * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Delete all tables included in the transfer. This is the default option.

        Use it to always transfer the latest table schemas on every transfer activation.

    * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}`: Delete data from the transferred tables, leaving the schema intact.

        Use this option if the target schema differs from the one that would be transferred from the source.

{% endlist %}

Once you have configured the source and target, [create and launch the transfer](../../transfer.md#create).

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
