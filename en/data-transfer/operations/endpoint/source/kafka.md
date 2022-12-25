---
title: "How to configure {{ KF }} source endpoints in {{ data-transfer-full-name }}"
description: "Following this guide you will learn how to configure {{ KF }} source endpoints in {{ data-transfer-full-name }}."
---

# Configuring an {{ KF }} source endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mkf-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ mkf-name }} cluster {#managed-service}

Connection with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mkf-full-name }}](../../../../managed-kafka/).

{% list tabs %}

- Management console

   {% include [Managed Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-kafka.md) %}

{% endlist %}

## Custom installation {#on-premise}

Connection with the {{ KF }} cluster with explicitly specified network addresses and broker host ports.

{% list tabs %}

- Management console

   {% include [On premise Kafka UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-kafka.md) %}

{% endlist %}

## Additional parameters {#additional-settings}

{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-evhub-processing-order.md) %}

{% list tabs %}

- Management console

   {% include [Kafka/YDS additional Settings](../../../../_includes/data-transfer/kf-yds-evhub-additional-settings.md) %}

{% endlist %}
