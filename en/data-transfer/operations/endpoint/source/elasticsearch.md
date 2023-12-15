---
title: "How to set up an {{ ES }} source endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up an {{ ES }} source endpoint in {{ data-transfer-full-name }}."
---

# Configuring {{ ES }} source endpoints

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mes-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).


## {{ mes-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need the [`{{ roles.mes.viewer }}` role](../../../../managed-elasticsearch/security/index.md#mes-viewer) or the primitive [`viewer` role](../../../../iam/concepts/access-control/roles.md#viewer) issued for the folder hosting a cluster of this managed database.

{% endnote %}


Connection with the cluster ID specified in {{ yandex-cloud }}.

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

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchSource.dump_index_with_mapping.title }}**: Select this option to move data types from a source to a target before a transfer is started. If the option is disabled and no index schema is set on the target, data types on the target will be identified automatically during a transfer.

   {% include [dump-index-warning](../../../../_includes/data-transfer/necessary-settings/ui/dump-index-warning.md) %}

{% endlist %}
