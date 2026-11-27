---
title: How to set up an {{ OS }} target endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up an {{ OS }} target endpoint in {{ data-transfer-full-name }}.
alternate:
  - href: en/data-transfer/operations/endpoint/target/opensearch.md
    type: text/markdown
    title: Markdown version
---

# Transferring data to an {{ OS }} target endpoint

{{ data-transfer-full-name }} enables you to migrate data to a {{ OS }} database and implement various data transfer, processing, and transformation scenarios. To set up a transfer:

1. [Review possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Prepare the {{ OS }}](#prepare) database for the transfer.
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) and [launch](../../transfer.md#activate) the transfer.
1. Perform the required database tasks while [monitoring the transfer status](../../monitoring.md).
1. If you run into any problems, [check the available solutions](#troubleshooting) for troubleshooting.

## {{ OS }} data transfer scenarios {#scenarios}

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}

   * [Delivering data from {{ KF }} to {{ OS }}](../../../tutorials/mkf-to-mos.md).

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
    * [Migrating an {{ OS }} cluster](../../../tutorials/os-to-mos.md).
    * [Migration with change of storage from {{ PG }} to {{ OS }}](../../../tutorials/postgresql-to-opensearch.md).

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ PG }}](../source/postgresql.md)
* [{{ DS }}](../source/data-streams.md)
* [{{ KF }}](../source/kafka.md)
* [{{ OS }}](../source/opensearch.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

{% note info %}

There is a data type restriction: if the sorurce sends an `ip` record (IP address), it will be saved as a `text` record in the target.

{% endnote %}

## Preparing the target database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/opensearch-prepare.md) %}

## Configuring the {{ OS }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can configure:

* Connection settings for a [{{ mos-full-name }}](#managed-service) cluster or a [custom deployment](#on-premise), including those running on {{ compute-full-name }} VMs. These settings are required.
* [Optional settings](#additional-settings).


### {{ mos-name }} cluster {#managed-service}


{% note warning %}

To create or edit a managed database endpoint, you will need the [`{{ roles.mos.viewer }}`](../../../../managed-opensearch/security/index.md#managed-opensearch-viewer) role or the primitive [`viewer`](../../../../iam/roles-reference.md#viewer) role for the folder where its cluster resides.

{% endnote %}

Connection with the cluster specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [Managed OpenSearch](../../../../_includes/data-transfer/necessary-settings/ui/managed-opensearch.md) %}

{% endlist %}


### Custom installation {#on-premise}

Connection to nodes with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [On premise OpenSearch UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-opensearch.md) %}

{% endlist %}

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchTarget.cleanup_policy.title }}**: Select the pre-transfer cleanup policy for the target database:

        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Select this option if you are only replicating data, without copying it.

        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Delete all tables included in the transfer. This is the default option.

            Use it to always transfer the latest table schemas on every transfer activation.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchTarget.sanitize_doc_keys.title }}**: Use this option to automatically replace keys that are not valid for {{ OS }} in the target fields.

        {% include [sanitize-rules](../../../../_includes/data-transfer/necessary-settings/ui/es-os-sanitize-rules.md) %}

{% endlist %}

Once you have configured the source and target, [create and launch the transfer](../../transfer.md#create).

## Data transfer troubleshooting {#troubleshooting}

* [Transfer interrupted with an error message](#ambiguous-resolution-os)
* [Document duplication on the target](#duplication)
* [Exceeding the limit on the maximum number of fields](#exceeding-fields-limit)
* [Transfer failure with the `mapper_parsing_exception` error](#data-types)
* [`SSL is required` error](#ssl-required)
* [No tables found](#no-tables).

For the full list of recommendations, see [Troubleshooting](../../../troubleshooting/index.md).

{% include [ambiguous-object-resolution-os](../../../../_includes/data-transfer/troubles/elastic-opensearch/ambiguous-object-resolution-os.md) %}

{% include [duplication](../../../../_includes/data-transfer/troubles/elastic-opensearch/duplication.md) %}

{% include [exceeding-fields-limit](../../../../_includes/data-transfer/troubles/elastic-opensearch/exceeding-fields-limit.md) %}

{% include [mapper-parsing-exception](../../../../_includes/data-transfer/troubles/elastic-opensearch/mapper-parsing-exception.md) %}

{% include [ssl-is-required](../../../../_includes/data-transfer/troubles/elastic-opensearch/ssl-is-required.md) %}

{% include [no-tables](../../../../_includes/data-transfer/troubles/elastic-opensearch/no-tables.md) %}
