# Configuring target endpoint {{ KF }}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mkf-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Apache Kafka topic settings](#kafka-settings).

## {{ mkf-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mkf-full-name }}](../../../../managed-kafka/).

{% list tabs %}

- Management console

   {% include [Managed Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-kafka-target.md) %}

{% endlist %}

## Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses.

{% list tabs %}

- Management console

   {% include [On premise Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-kafka-target.md) %}

{% endlist %}

## Topic settings {{ KF }} {#kafka-settings}

{% list tabs %}

- Management console

   {% include [On premise Kafka UI](../../../../_includes/data-transfer/kafka-topic.md) %}

{% endlist %}
