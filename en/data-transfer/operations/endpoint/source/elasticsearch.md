---
title: "How to set up an {{ ES }} source endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up an {{ ES }} source endpoint in {{ data-transfer-full-name }}."
---

# Transferring data from the {{ ES }} source endpoint

{{ data-transfer-full-name }} enables you to migrate search and analytics data from a {{ ES }} database and implement various scenarios of data transfer, processing and transformation. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the {{ ES }}](#prepare) database for the transfer.
1. [Set up an endpoint source](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data from {{ ES }} {#scenarios}

{% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

* [Migration with the storage type changed from {{ ES }} to {{ OS }}](../../../tutorials/mes-to-mos.md)

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [prepare elasticsearch db](../../../../_includes/data-transfer/endpoints/sources/elasticsearch-prepare.md) %}

## Configuring the {{ ES }} source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mes-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).


### {{ mes-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mes.viewer }}` role](../../../../managed-elasticsearch/security/index.md#mes-viewer) or the [`viewer` primitive role](../../../../iam/concepts/access-control/roles.md#viewer) assigned to the folder where this managed database cluster resides.

{% endnote %}


Connection with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [Managed Elasticsearch](../../../../_includes/data-transfer/necessary-settings/ui/managed-elasticsearch.md) %}

{% endlist %}


### Custom installation {#on-premise}

Connecting to nodes with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [On premise Elasticsearch UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-elasticsearch.md) %}

{% endlist %}

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchSource.dump_index_with_mapping.title }}**: Select this option to move data types from a source to a target before a transfer is started. If the option is disabled and no index schema is set on the target, data types on the target will be identified automatically during a transfer.

   {% include [dump-index-warning](../../../../_includes/data-transfer/necessary-settings/ui/dump-index-warning.md) %}

{% endlist %}


## Configuring the data target {#supported-targets}

Configure the target endpoint:

* [{{ OS }}](../target/opensearch.md).

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Troubleshooting data transfer issues {#troubleshooting}

* [Transfer failure](#ambiguous-resolution-es)
* [Document duplication on the target](#duplication)

See a full list of recommendations in the [Troubleshooting](../../../troubleshooting/index.md) section.

{% include [ambiguous-object-resolution-es](../../../../_includes/data-transfer/troubles/elastic-opensearch/ambiguous-object-resolution-es.md) %}

{% include [duplication](../../../../_includes/data-transfer/troubles/elastic-opensearch/duplication.md) %}