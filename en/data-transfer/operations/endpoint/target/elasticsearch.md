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

   **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchTarget.cleanup_policy.title }}**: Select a way to clean up data in the target database before the transfer:

   * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Select this option if you are only going to do replication without copying data.

   * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Fully delete tables included in the transfer (used by default).

      Use this option so that the latest version of the table schema is always transferred to the target database from the source whenever the transfer is activated.


{% endlist %}
