---
title: How to set up an {{ KF }} target endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up an {{ KF }} target endpoint in {{ data-transfer-full-name }}.
---

# Transferring data to an {{ KF }} target endpoint

{{ data-transfer-full-name }} enables you to migrate data to an {{ KF }} queue and implement various data processing and transformation scenarios. To implement a transfer:

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
  
    * [Capturing changes from {{ MY }} and delivering to {{ KF }}](../../../tutorials/cdc-mmy.md).
    * [{{ ydb-short-name }} change data capture and delivery to {{ KF }}](../../../tutorials/cdc-ydb.md).
    * [Capturing changes from {{ PG }} and delivering to {{ KF }}](../../../tutorials/cdc-mpg.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    * [Delivering data from a {{ DS }} queue to {{ KF }}](../../../tutorials/yds-to-kafka.md)

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ PG }}](../source/postgresql.md)
* [{{ MY }}](../source/mysql.md)
* [{{ KF }}](../source/kafka.md)
* [{{ AB }}](../../../transfer-matrix.md#airbyte)
* [{{ DS }}](../source/data-streams.md)
* [{{ ydb-name }}](../source/ydb.md)
* [{{ ES }}](../source/elasticsearch.md)
* [{{ OS }}](../source/opensearch.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

## Configuring the {{ KF }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* [{{ mkf-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings and [serialization settings](#serializer), including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Apache Kafka topic settings](#kafka-settings).

### {{ mkf-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you will need the [`{{ roles.mkf.viewer }}`](../../../../managed-kafka/security/index.md#mkf-viewer) role or the primitive [`viewer`](../../../../iam/roles-reference.md#viewer) role for the folder the cluster of this managed database resides in.

{% endnote %}


Connection with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [Managed Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-kafka-target.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `kafka_target`.

    {% include [Managed Kafka Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-kafka-target.md) %}

    Here is the configuration file example:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        kafka_target {
          security_groups = ["<list_of_security_group_IDs>"]
          connection {
            cluster_id = "<cluster_ID>"
          }
          auth {
            <authentication_method>
          }
          <topic_settings>
          <serialization_settings>
        }
      }
    }
    ```


    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed Kafka API](../../../../_includes/data-transfer/necessary-settings/api/managed-kafka-target.md) %}

{% endlist %}

### Custom installation {#on-premise}

Connection with the {{ KF }} cluster with explicitly specified network addresses and broker host ports.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [On premise Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-kafka-target.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `kafka_target`.

    {% include [On-premise Kafka Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-kafka-target.md) %}

    Here is the configuration file example:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        kafka_target {
          security_groups = ["<list_of_security_group_IDs>"]
          connection {
            on_premise {
              broker_urls = ["<list_of_IP_addresses_or_broker_host_FQDNs>"]
              subnet_id  = "<ID_of_subnet_with_broker_hosts>"
            }
          }
          auth = {
            <authentication_method>
          }
          <topic_settings>
          <serialization_settings>
        }
      }
    }
    ```


    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On-premise Kafka API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-kafka-target.md) %}

{% endlist %}

### {{ KF }} topic settings {#kafka-settings}

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}**: Specify the name of the topic to send messages to. Select **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.save_tx_order.title }}**, so as not to split an event stream into independent queues by table.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}**: Specify the topic prefix, similar to the `Debezium database.server.name` setting. Messages will go to the topic named `<topic_prefix>.<schema>.<table_name>`.

- {{ TF }} {#tf}

    Under `topic_settings`, specify one of the options to send messages to a topic:

    * `topic`: Specify parameters in this section to send all messages to one topic:
        * `topic_name`: Name of the topic to send messages to.
        * `save_tx_order`: Option for saving the order of transactions. Set to `true` not to split the event stream into independent queues by table.

    * `topic_prefix`: Specify a prefix to send messages to different topics with the given prefix.

        {% include [kafka-topic-prefix-explanation](../../../../_includes/data-transfer/kafka-topic-prefix-explanation.md) %}

- API {#api}

    In the `topicSettings` field, specify one of the options to send messages to a topic:

    * `topic`: Specify parameters in this field to send all messages to one topic:
        * `topicName`: Name of the topic to send messages to.
        * `saveTxOrder`: Option for saving the order of transactions. Set to `true` not to split the event stream into independent queues by table.

    * `topicPrefix`: Specify a prefix to send messages to different topics with the given prefix.

        {% include [kafka-topic-prefix-explanation](../../../../_includes/data-transfer/kafka-topic-prefix-explanation.md) %}

{% endlist %}

{{ data-transfer-full-name }} supports CDC for transfers from {{ PG }}, {{ MY }}, and {{ ydb-short-name }} databases to {{ KF }} and {{ yds-full-name }}. Data is sent to the target in Debezium format. For more information about CDC mode, see [Change data capture](../../../concepts/cdc.md).

{% include [CDC-YDB](../../../../_includes/data-transfer/note-ydb-cdc.md) %}

### Serialization settings {#serializer}

{% list tabs group=instructions %}

- Management console {#console}

    {% include [serializer](../../../../_includes/data-transfer/serializer.md) %}

- {{ TF }} {#tf}

    {% include [serializer](../../../../_includes/data-transfer/serializers/terraform.md) %}

- API {#api}

    {% include [serializer](../../../../_includes/data-transfer/serializers/api.md) %}

{% endlist %}

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    You can specify [topic configuration parameters](https://docs.confluent.io/platform/current/installation/configuration/topic-configs.html) to use when creating new topics.

    Specify the parameter and one of its possible values, e.g., `cleanup.policy` and `compact`.

{% endlist %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).
