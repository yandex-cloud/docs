---
title: "How to set up a target {{ OS }} endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up a target {{ OS }} endpoint in {{ data-transfer-full-name }}."
---

# Configuring target endpoints {{ OS }}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mos-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).


## {{ mos-name }} cluster {#managed-service}

Connection with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mos-full-name }}](../../../../managed-opensearch/).

{% list tabs %}

- Management console

   {% include [Managed OpenSearch](../../../../_includes/data-transfer/necessary-settings/ui/managed-opensearch.md) %}

{% endlist %}


## Custom installation {#on-premise}

Connecting to nodes with explicitly specified network addresses and ports.

{% list tabs %}

- Management console

   {% include [On premise OpenSearch UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-opensearch.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   {% include [Field Cleanup Policy Disabled/Drop/Truncate](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-do-not-clean-drop.md) %}

{% endlist %}
