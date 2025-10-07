---
title: How to set up an {{ ES }} source endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to configure a {{ ES }} source endpoint when creating or modifying it in {{ data-transfer-full-name }}.
---

# Transferring data from an {{ ES }} source endpoint


{{ data-transfer-full-name }} enables you to migrate search and analytics data from an {{ ES }} database and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the {{ ES }}](#prepare) database for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data from {{ ES }} {#scenarios}

{% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

* [Migration with the storage type changed from {{ ES }} to {{ OS }}](../../../tutorials/mes-to-mos.md)

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [elastic-version](../../../../_includes/data-transfer/elastic-version-note.md) %}

{% include notitle [White IP list](../../../../_includes/data-transfer/configure-white-ip.md) %}

## Configuring the {{ ES }} source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* [Custom installation](#on-premise) settings. These are required parameters.
* [Additional parameters](#additional-settings).

### Custom installation {#on-premise}

Connecting to nodes with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.addresses.title }}**: Click ![image](../../../../_assets/console-icons/plus.svg) to add a new data node. For each node, specify:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearchHostPort.host.title }}**: IP address or FQDN of the host with the `DATA` role you want to connect to.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearchHostPort.port.title }}**: Port number {{ data-transfer-name }} will use for connections to the `DATA` host.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.ssl_enabled.title }}**: Select this option if a secure SSL connection is used.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.ca_certificate.title }}**: Upload the certificate file or add its contents as text if you need to encrypt the data to transfer, e.g., to meet the PCI DSS requirements.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md).
      If the value in this field is specified for both endpoints, both subnets must be hosted in the same availability zone.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchConnection.user.title }}**: Specify the username {{ data-transfer-name }} will use to connect to the cluster.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchConnection.password.title }}**: Enter the user password to the cluster.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

     Thus, you will be able to apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).

{% endlist %}

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchSource.dump_index_with_mapping.title }}**: Select this option to move data types from a source to a target before a transfer is started. If the option is disabled and no index schema is set on the target, data types on the target will be identified automatically during a transfer.

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