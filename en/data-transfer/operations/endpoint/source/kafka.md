# Source endpoint parameters {{ KF }}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can set the following:

* Connection settings to a [{{ mkf-full-name }} cluster](#managed-service) or a [custom installation](#on-premise), including those based on {{ compute-full-name }} virtual machines. These parameters are required.
* [Additional parameters](#additional-settings).

## {{ mkf-name }} cluster {#managed-service}

Connecting with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mkf-full-name }}](../../../../managed-kafka/).

{% list tabs %}

- Management console

    {% include [Managed Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-kafka.md) %}

{% endlist %}

## Custom installation {#on-premise}

Connecting to the {{ KF }} cluster with explicitly specified network addresses and broker host ports.

{% list tabs %}

- Management console

    {% include [On premise Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-kafka.md) %}

{% endlist %}

## Additional parameters {#additional-settings}

{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-processing-order.md) %}

{% list tabs %}

- Management console

    {% include [Kafka/YDS additional Settings](../../../../_includes/data-transfer/kf-yds-additional-settings.md) %}

{% endlist %}
