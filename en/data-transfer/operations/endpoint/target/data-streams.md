---
title: How to configure a {{ yds-full-name }} target endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up a {{ yds-full-name }} target endpoint in {{ data-transfer-full-name }}.
---
# Transferring data to a {{ yds-full-name }} target endpoint


{{ data-transfer-full-name }} enables you to migrate data to a {{ yds-full-name }} queue and implement various data processing and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data to {{ yds-full-name }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/cdc.md) %}
   * [{{ MY }} change data capture and delivery to {{ DS }}](../../../tutorials/mmy-to-yds.md).
   * [{{ PG }} change data capture and delivery to {{ DS }}](../../../tutorials/mpg-to-yds.md).
   * [{{ ydb-short-name }} change data capture and delivery to {{ DS }}](../../../tutorials/ydb-to-yds.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}

   * [Delivering data from {{ KF }} to {{ DS }}](../../../tutorials/mkf-to-yds.md).

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ PG }}](../source/postgresql.md).
* [{{ MY }}](../source/mysql.md).
* [{{ KF }}](../source/kafka.md).
* [{{ ydb-name }}](../source/ydb.md).
* [{{ AB }}](../../../transfer-matrix.md#airbyte).
* [{{ DS }}](../source/data-streams.md).
* [{{ objstorage-full-name }}](../source/object-storage.md).
* [{{ ES }}](../source/elasticsearch.md).
* [{{ OS }}](../source/opensearch.md).

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

## Configuring the {{ yds-full-name }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* Stream [connection settings](#general-settings) in {{ yds-full-name }} and [serialization settings](#serializer). These are required parameters.
* [Additional settings](#additional-settings).

### Basic settings {#general-settings}

{% list tabs group=instructions %}

- Management console {#console}

   {% include [Data Streams UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-data-streams-target.md) %}

{% endlist %}

### Advanced settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSTargetAdvancedSettings.save_tx_order.title }}**: Do not split an event stream into independent queues by table.

{% endlist %}

### {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }} {#serializer}

{% list tabs group=instructions %}

- Management console {#console}

   {% include [serializer](../../../../_includes/data-transfer/serializer.md) %}

{% endlist %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Troubleshooting data transfer issues {#troubleshooting}

* [Transfer failure](#overloaded)
* [{{ sf-short-name }} redirects](#redirects)

See a full list of recommendations in the [Troubleshooting](../../../troubleshooting/index.md) section.

{% include [overloaded](../../../../_includes/data-transfer/troubles/overloaded.md) %}

{% include [redirects](../../../../_includes/data-transfer/troubles/data-streams/data-streams-redirects.md) %}