---
title: "How to configure an {{ KF }} target endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up an {{ KF }} target endpoint in {{ data-transfer-full-name }}."
---
# Transferring data to an {{ KF }} target endpoint

{{ data-transfer-full-name }} enables you to migrate data to an {{ KF }} queue and implement various scenarios of data processing and transformation. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](../../../../data-transfer/troubleshooting/index.md) to resolve them.

## Scenarios for transferring data to {{ KF }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

   Mirroring data across queues is a separate migration task.
   * [{{ KF }} mirroring](../../../tutorials/mkf-to-mkf.md)

1. {% include [cdc](../../../../_includes/data-transfer/scenario-captions/cdc.md) %}

   * [{{ MY }} change data capture and delivery to {{ KF }}](../../../tutorials/cdc-mmy.md).
   * [{{ PG }} change data capture and delivery to {{ KF }}](../../../tutorials/cdc-mpg.md).
   * [{{ ydb-short-name }} change data capture and delivery to {{ KF }}](../../../tutorials/cdc-ydb.md).

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ PG }}](../source/postgresql.md).
* [{{ MY }}](../source/mysql.md).
* [{{ KF }}](../source/kafka.md).
* [Airbyte](../../../transfer-matrix.md#airbyte).
* [{{ DS }}](../source/data-streams.md).
* [{{ ydb-name }}](../source/ydb.md).

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

## Configuring the {{ KF }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mkf-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings and [serialization settings](#serializer), including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Apache Kafka topic settings](#kafka-settings).

### {{ mkf-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mkf.viewer }}` role](../../../../managed-kafka/security/index.md#mkf-viewer) or the [`viewer` primitive role](../../../../iam/concepts/access-control/roles.md#viewer) assigned to the folder where this managed database cluster resides.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [Managed Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-kafka-target.md) %}

{% endlist %}

### Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [On premise Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-kafka-target.md) %}

{% endlist %}

### Topic settings {{ KF }} {#kafka-settings}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}**: Specify the name of the topic to send messages to. Select **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.save_tx_order.title }}**, so as not to split an event stream into independent queues by table.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}**: Specify the topic prefix, similar to the `Debezium database.server.name` setting. Messages will be sent to a topic named `<topic_prefix>.<schema>.<table_name>`.

   {{ data-transfer-full-name }} supports CDC for transfers from {{ PG }}, {{ MY }}, and {{ ydb-short-name }} databases to {{ KF }} and {{ yds-full-name }}. Data is sent to the target in Debezium format. For more information about CDC mode, see [Change data capture](../../../concepts/cdc.md).

   {% include [CDC-YDB](../../../../_includes/data-transfer/note-ydb-cdc.md) %}

{% endlist %}

### {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }} {#serializer}

{% list tabs group=instructions %}

- Management console {#console}

   {% include [serializer](../../../../_includes/data-transfer/serializer.md) %}

{% endlist %}

### Additional settings {#additional-settings}

You can specify [topic configuration parameters](https://docs.confluent.io/platform/current/installation/configuration/topic-configs.html) to use when creating new topics.

Specify the parameter and one of its possible values, e.g., `cleanup.policy` and `compact`.

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).
