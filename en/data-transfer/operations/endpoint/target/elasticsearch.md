---
title: "How to set up a target {{ ES }} endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up a target {{ ES }} endpoint in {{ data-transfer-full-name }}."
---

# Configuring target endpoints {{ ES }}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mes-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).


## {{ mes-name }} cluster {#managed-service}

Connection with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mes-full-name }}](../../../../managed-elasticsearch/).

{% list tabs %}

- Management console

   {% include [Managed Elasticsearch](../../../../_includes/data-transfer/necessary-settings/ui/managed-elasticsearch.md) %}

{% endlist %}


## Custom installation {#on-premise}

Connecting to nodes with explicitly specified network addresses and ports.

{% list tabs %}

- Management console

   {% include [On premise Elasticsearch UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-elasticsearch.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   {% include [Field Cleanup Policy Disabled/Drop/Truncate](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-do-not-clean-drop.md) %}

{% endlist %}
