---
title: "Tutorial on setting up {{ GP }} a target endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you'll learn how to set up a {{ GP }} target endpoint in {{ data-transfer-full-name }}."
---

# Configuring {{ GP }} target endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* {% if product == "yandex-cloud" %}[{{ mgp-full-name }} cluster](#managed-service) connection or {% endif %}[custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

{% if product == "yandex-cloud" %}

## {{ mgp-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mgp-full-name }}](../../../../managed-greenplum/).

{% list tabs %}

- Management console

   {% include [Managed Greenplum](../../../../_includes/data-transfer/necessary-settings/ui/managed-greenplum.md) %}

{% endlist %}

{% endif %}

## Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs %}

- Management console

   {% include [On premise Greenplum UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-greenplum.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   {% include [Field Cleanup Policy Disabled/Drop/Truncate](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-disabled-drop-truncate.md) %}

{% endlist %}

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
