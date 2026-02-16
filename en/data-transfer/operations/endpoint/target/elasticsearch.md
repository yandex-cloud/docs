---
title: How to set up an {{ ES }} target endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up an {{ ES }} target endpoint in {{ data-transfer-full-name }}.
---
# Transferring data to an {{ ES }} target endpoint


{{ data-transfer-full-name }} enables you to migrate data to a {{ ES }} database and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Configure one of the supported data sources](#supported-sources).
1. [Prepare the {{ ES }}](#prepare) database for the transfer.
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ KF }}](../source/kafka.md)
* [{{ DS }}](../source/data-streams.md)
* [{{ PG }}](../source/postgresql.md)
* [{{ ES }}](../source/elasticsearch.md)
* [{{ OS }}](../source/opensearch.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

## Preparing the target database {#prepare}

{% include [elastic-version](../../../../_includes/data-transfer/elastic-version-note.md) %}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/elasticsearch-prepare.md) %}

## Configuring the {{ ES }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* [{{ ES }} connection settings](#on-premise). These are required parameters.
* [Additional parameters](#additional-settings).


### Custom installation {#on-premise}

Connection to nodes with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.addresses.title }}**: Click ![image](../../../../_assets/console-icons/plus.svg) to add a new data node. For each node, specify:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearchHostPort.host.title }}**: IP address or FQDN of the host with the `DATA` role you need to connect to.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearchHostPort.port.title }}**: Port number {{ data-transfer-name }} will use to connect to the host with the `DATA` role.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.ssl_enabled.title }}**: Select this option if a secure SSL connection is used.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.ca_certificate.title }}**: Upload the certificate file or add its contents as text if data encryption is required, e.g., to comply with the PCI DSS requirements.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md).
      If this field has a value specified for both endpoints, both subnets must be hosted in the same availability zone.
      
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchConnection.user.title }}**: Specify the username {{ data-transfer-name }} will use to connect to the cluster.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchConnection.password.title }}**: Enter the user password to the cluster.


   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

     Thus, you will be able to apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).


{% endlist %}

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchTarget.cleanup_policy.title }}**: Select a way to clean up data in the target database before the transfer:

        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Select this option if you are only going to do replication without copying data.

        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Completely delete the tables included in the transfer (default).

            Use this option to always transfer the latest version of the table schema to the target database from the source whenever the transfer is activated.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchTarget.sanitize_doc_keys.title }}**: Use this option to automatically replace keys that are not valid for {{ ES }} in the target fields.

        {% include [sanitize-rules](../../../../_includes/data-transfer/necessary-settings/ui/es-os-sanitize-rules.md) %}

{% endlist %}


After configuring the data source and target, [create and start the transfer](../../transfer.md#create).
