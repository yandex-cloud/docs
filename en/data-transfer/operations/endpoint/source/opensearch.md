---
title: How to set up an {{ OS }} source endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to create and configure an {{ OS }} source endpoint in {{ data-transfer-full-name }}.
alternate:
  - href: en/data-transfer/operations/endpoint/source/opensearch.md
    type: text/markdown
    title: Markdown version
---
# Transferring data from an {{ OS }} source endpoint

{{ data-transfer-full-name }} enables you to migrate search and analytics data from an {{ OS }} database and implement various data transfer, processing, and transformation scenarios. To set up a transfer:

1. [Review possible data transfer scenarios](#scenarios).
1. [Prepare the {{ OS }}](#prepare) database for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) and [launch](../../transfer.md#activate) the transfer.
1. Perform the required database tasks while [monitoring the transfer status](../../monitoring.md).
1. If you run into any problems, [check the available solutions](#troubleshooting) for troubleshooting.

## {{ OS }} data transfer scenarios {#scenarios}

{% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

* [Migrating a {{ OS }} cluster](../../../tutorials/os-to-mos.md).
* [Loading data from {{ OS }} to {{ objstorage-name }}](../../../tutorials/opensearch-to-object-storage.md).
* [Migration with change of storage from {{ OS }} to {{ ydb-short-name }}](../../../tutorials/opensearch-to-ydb.md).
* [Migration with change of storage from {{ OS }} to {{ GP }}](../../../tutorials/opensearch-to-greenplum.md).

* [{#T}](../../../tutorials/opensearch-to-clickhouse.md)

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [prepare opensearch db](../../../../_includes/data-transfer/endpoints/sources/opensearch-prepare.md) %}

## Configuring the {{ OS }} source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can configure:

* Connection settings for a [{{ mos-full-name }} cluster](#managed-service) or a [custom deployment](#on-premise), including those running on {{ compute-full-name }} VMs. These settings are required.
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

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchSource.dump_index_with_mapping.title }}**: Select this option to move data types from a source to a target before a transfer is started. If the option is disabled and no index schema is set on the target, data types on the target will be identified automatically during a transfer.

    {% include [dump-index-warning](../../../../_includes/data-transfer/necessary-settings/ui/dump-index-warning.md) %}

{% endlist %}


## Configuring the data target {#supported-targets}

Configure the target endpoint:

* [{{ OS }}](../target/opensearch.md)
* [{{ CH }}](../target/clickhouse.md)
* [{{ GP }}](../target/greenplum.md)
* [{{ ydb-full-name }}](../target/yandex-database.md)
* [{{ objstorage-full-name }}](../target/object-storage.md)
* [{{ KF }}](../target/kafka.md)
* [{{ DS }}](../target/data-streams.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

Once you have configured the source and target, [create and launch the transfer](../../transfer.md#create).

## Data transfer troubleshooting {#troubleshooting}

* [Transfer interrupted with an error message](#ambiguous-resolution-os)
* [Document duplication on the target](#duplication)
* [Exceeding the limit on the maximum number of fields](#exceeding-fields-limit)
* [Transfer failure with the `mapper_parsing_exception` error](#data-types)
* [`SSL is required` error](#ssl-required)
* [No tables found](#no-tables)

For the full list of recommendations, see [Troubleshooting](../../../troubleshooting/index.md).

{% include [ambiguous-object-resolution-os](../../../../_includes/data-transfer/troubles/elastic-opensearch/ambiguous-object-resolution-os.md) %}

{% include [duplication](../../../../_includes/data-transfer/troubles/elastic-opensearch/duplication.md) %}

{% include [exceeding-fields-limit](../../../../_includes/data-transfer/troubles/elastic-opensearch/exceeding-fields-limit.md) %}

{% include [mapper-parsing-exception](../../../../_includes/data-transfer/troubles/elastic-opensearch/mapper-parsing-exception.md) %}

{% include [ssl-is-required](../../../../_includes/data-transfer/troubles/elastic-opensearch/ssl-is-required.md) %}

{% include [no-tables](../../../../_includes/data-transfer/troubles/elastic-opensearch/no-tables.md) %}