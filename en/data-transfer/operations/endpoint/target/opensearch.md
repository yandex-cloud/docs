---
title: "How to set up an {{ OS }} target endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up an {{ OS }} target endpoint in {{ data-transfer-full-name }}."
---
# Transferring data to an {{ OS }} target endpoint

{{ data-transfer-full-name }} enables you to migrate data to an {{ OS }} database and implement various scenarios of data transfer, processing and transformation. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Prepare the {{ OS }}](#prepare) database for the transfer.
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data to {{ OS }} {#scenarios}

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
   * [Delivering data from {{ DS }} to {{ OS }}](../../../tutorials/trails-to-os.md).
   * [Delivering data from {{ KF }} to {{ OS }}](../../../tutorials/mkf-to-mos.md).

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
   * [Migrating the {{ OS }} cluster](../../../tutorials/os-to-mos.md).
   * [Migration with storage changed from {{ ES }} to {{ OS }}](../../../tutorials/mes-to-mos.md).

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ PG }}](../source/postgresql.md).
* [{{ DS }}](../source/data-streams.md).
* [{{ KF }}](../source/kafka.md).
* [{{ ES }}](../source/elasticsearch.md).
* [{{ OS }}](../source/opensearch.md).

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

## Preparing the target database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/opensearch-prepare.md) %}

## Configuring the {{ OS }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mos-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).


### {{ mos-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mos.viewer }}` role](../../../../managed-opensearch/security/index.md#mos-viewer) or the [`viewer` primitive role](../../../../iam/concepts/access-control/roles.md#viewer) assigned to the folder where this managed database cluster resides.

{% endnote %}


Connection with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [Managed OpenSearch](../../../../_includes/data-transfer/necessary-settings/ui/managed-opensearch.md) %}

{% endlist %}


### Custom installation {#on-premise}

Connecting to nodes with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [On premise OpenSearch UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-opensearch.md) %}

{% endlist %}

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchTarget.cleanup_policy.title }}**: Select a way to clean up data in the target database before the transfer:

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Select this option if you are only going to do replication without copying data.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Completely delete tables included in the transfer (used by default).

         Use this option so that the latest version of the table schema is always transferred to the target database from the source whenever the transfer is activated.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchTarget.sanitize_doc_keys.title }}**: Use this option to automatically replace keys that are not valid for {{ OS }} in the target fields.

      {% include [sanitize-rules](../../../../_includes/data-transfer/necessary-settings/ui/es-os-sanitize-rules.md) %}

{% endlist %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Troubleshooting data transfer issues {#troubleshooting}

* [Transfer failure](#ambiguous-resolution-es)
* [Document duplication on the target](#duplication)

See a full list of recommendations in the [Troubleshooting](../../../troubleshooting/index.md) section.

{% include [ambiguous-object-resolution-os](../../../../_includes/data-transfer/troubles/elastic-opensearch/ambiguous-object-resolution-os.md) %}

{% include [duplication](../../../../_includes/data-transfer/troubles/elastic-opensearch/duplication.md) %}


