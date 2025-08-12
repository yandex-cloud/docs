---
title: How to set up an {{ OS }} source endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to configure a {{ OS }} source endpoint when creating or modifying it in {{ data-transfer-full-name }}.
---
# Transferring data from an {{ OS }} source endpoint

{{ data-transfer-full-name }} enables you to migrate search and analytics data from an {{ OS }} database and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the {{ OS }}](#prepare) database for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data from {{ OS }} {#scenarios}

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

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* [{{ mos-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).


### {{ mos-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mos.viewer }}`](../../../../managed-opensearch/security/index.md#mos-viewer) role or the [`viewer`](../../../../iam/roles-reference.md#viewer) primitive role assigned for the folder where this managed database cluster resides.

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

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Troubleshooting data transfer issues {#troubleshooting}

* [Transfer interrupted with an error message](#ambiguous-resolution-es)
* [Document duplication on the target](#duplication)
* [Exceeding the limit on the maximum number of fields](#exceeding-fields-limit)
* [Transfer failure with the mapper_parsing_exception error](#data-types)
* [SSL is required error](#ssl-required)
* [No tables found](#no-tables)

For more troubleshooting tips, see [Troubleshooting](../../../troubleshooting/index.md).

{% include [ambiguous-object-resolution-os](../../../../_includes/data-transfer/troubles/elastic-opensearch/ambiguous-object-resolution-os.md) %}

{% include [duplication](../../../../_includes/data-transfer/troubles/elastic-opensearch/duplication.md) %}

{% include [exceeding-fields-limit](../../../../_includes/data-transfer/troubles/elastic-opensearch/exceeding-fields-limit.md) %}

{% include [mapper-parsing-exception](../../../../_includes/data-transfer/troubles/elastic-opensearch/mapper-parsing-exception.md) %}

{% include [ssl-is-required](../../../../_includes/data-transfer/troubles/elastic-opensearch/ssl-is-required.md) %}

{% include [no-tables](../../../../_includes/data-transfer/troubles/elastic-opensearch/no-tables.md) %}