---
title: How to set up a {{ CH }} target endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up a {{ CH }} target endpoint in {{ data-transfer-full-name }}.
---

# Transferring data to a {{ CH }} target endpoint

{{ data-transfer-full-name }} enables you to migrate data to a {{ CH }} database and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Prepare the {{ CH }}](#prepare) database for the transfer.
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data to {{ CH }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
    * [Migrating a {{ CH }} cluster](../../../tutorials/managed-clickhouse.md).
    * [Redistributing data across shards](../../../tutorials/mch-mch-resharding.md).
    * [{#T}](../../../tutorials/opensearch-to-clickhouse.md)

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    * [Delivering data from {{ KF }} to {{ CH }}](../../../tutorials/mkf-to-mch.md).
    * [Delivering data from {{ DS }} to {{ CH }}](../../../tutorials/yds-to-clickhouse.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}
    * [Loading {{ GP }} data to {{ CH }}](../../../tutorials/greenplum-to-clickhouse.md).
    * [Loading {{ MY }} data to {{ CH }}](../../../tutorials/mysql-to-clickhouse.md).
    * [Loading {{ metrika }} data to {{ CH }}](../../../tutorials/metrika-to-clickhouse.md).
    * [Loading {{ yandex-direct }} data to {{ CH }}](../../../tutorials/direct-to-mch.md).

    * [Loading {{ PG }} data to {{ CH }}](../../../tutorials/rdbms-to-clickhouse.md).
    * [Loading data from {{ objstorage-name }} to {{ CH }}](../../../tutorials/object-storage-to-clickhouse.md).
    * [Loading data from {{ ydb-short-name }} to the {{ CH }} data mart](../../../tutorials/ydb-to-clickhouse.md).

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ PG }}](../source/postgresql.md)
* [{{ MY }}](../source/mysql.md)
* [{{ CH }}](../source/clickhouse.md)
* [{{ GP }}](../source/greenplum.md)
* [{{ KF }}](../source/kafka.md)
* [{{ AB }}](../../../transfer-matrix.md#airbyte)
* [{{ metrika }}](../source/metrika.md)
* [{{ DS }}](../source/data-streams.md)
* [{{ objstorage-full-name }}](../source/object-storage.md)
* [Oracle](../source/oracle.md)
* [{{ ES }}](../source/elasticsearch.md)
* [{{ OS }}](../source/opensearch.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

{% note info %}

{{ CH }} has date range restrictions. If the source database contains unsupported dates, this may result in an [error](#date-range) and stop the transfer.

{% endnote %}

## Preparing the target database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/clickhouse-prepare.md) %}

## Configuring the {{ CH }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* [{{ mch-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

### {{ mch-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mch.viewer }}` role](../../../../managed-clickhouse/security.md#managed-clickhouse-viewer) or the [`viewer` primitive role](../../../../iam/roles-reference.md#viewer) assigned for the folder where this managed database cluster resides.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse-target.md) %}

- CLI {#cli}

    * Endpoint type: `clickhouse-target`.

    {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-clickhouse-target.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `clickhouse_target`.

    {% include [Managed ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-clickhouse-target.md) %}

    Here is an example of the configuration file structure:


    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        clickhouse_target {
          clickhouse_cluster_name="<shard_group>"
          security_groups = ["<list_of_security_group_IDs>"]
          subnet_id       = "<subnet_ID>"
          connection {
            connection_options {
              mdb_cluster_id = "<cluster_ID>"
              database       = "<name_of_database_to_migrate>"
              user           = "<username_for_connection>"
              password {
                raw = "<user_password>"
              }
            }
          }
          <additional_endpoint_settings>
        }
      }
    }
    ```


    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/managed-clickhouse-target.md) %}

{% endlist %}

### Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse.md) %}

- CLI {#cli}

    * Endpoint type: `clickhouse-target`.

    {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-clickhouse-target.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `clickhouse_target`.

    {% include [On premise ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-clickhouse-target.md) %}

    Here is an example of the configuration file structure:


    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        clickhouse_target {
          clickhouse_cluster_name="<cluster_name>"
          security_groups = ["<list_of_security_group_IDs>"]
          subnet_id       = "<subnet_ID>"
          connection {
            connection_options {
              on_premise {
                http_port   = "<HTTP_connection_port>"
                native_port = "<port_for_native_interface_connection>"
                shards {
                  name  = "<shard_name>"
                  hosts = [ “list of IP addresses and FQDNs of shard hosts" ]
                }
                tls_mode {
                  enabled {
                    ca_certificate = "<certificate_in_PEM_format>"
                  }
                }
              }
              database = "<name_of_database_to_migrate>"
              user     = "<username_for_connection>"
              password {
                raw = "<user_password>"
              }
            }
          }
          <additional_endpoint_settings>
        }
      }
    }
    ```


    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On premise ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-clickhouse-target.md) %}

{% endlist %}

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    * {% include [cleanup_policy](../../../../_includes/data-transfer/fields/clickhouse/ui/cleanup-policy.md) %}

    * {% include [sharding_settings](../../../../_includes/data-transfer/fields/clickhouse/ui/sharding-settings.md) %}

    * {% include [alt_names](../../../../_includes/data-transfer/fields/clickhouse/ui/alt-names.md) %}

    * {% include [flush_interval](../../../../_includes/data-transfer/fields/clickhouse/ui/flush-interval.md) %}

- CLI {#cli}

    * {% include [alt-name](../../../../_includes/data-transfer/fields/clickhouse/cli/alt-name.md) %}

    * Data [sharding](../../../../managed-clickhouse/concepts/sharding.md) settings:

        * {% include [shard-by-column-hash](../../../../_includes/data-transfer/fields/clickhouse/cli/shard-by-column-hash.md) %}

        * {% include [custom-sharding-column-name](../../../../_includes/data-transfer/fields/clickhouse/cli/custom-sharding-column-name.md) %}

        * {% include [custom-sharding-mapping-string](../../../../_includes/data-transfer/fields/clickhouse/cli/custom-sharding-mapping-string.md) %}

        * {% include [shard-by-transfer-id](../../../../_includes/data-transfer/fields/clickhouse/cli/shard-by-transfer-id.md) %}

        You can only specify one of the sharding options:

        * `--shard-by-column-hash`
        * `--custom-sharding-column-name` and `--custom-sharding-mapping-string`
        * `--shard-by-transfer-id`

- {{ TF }} {#tf}

    * {% include [cleanup_policy](../../../../_includes/data-transfer/fields/clickhouse/terraform/cleanup-policy.md) %}

    * {% include [alt_names](../../../../_includes/data-transfer/fields/clickhouse/terraform/alt-names.md) %}

    * Data [sharding](../../../../managed-clickhouse/concepts/sharding.md) settings:

        * {% include [column_value_hash](../../../../_includes/data-transfer/fields/clickhouse/terraform/sharding-column-value-hash.md) %}

        * {% include [transfer_id](../../../../_includes/data-transfer/fields/clickhouse/terraform/sharding-transfer-id.md) %}

        * {% include [custom_mapping](../../../../_includes/data-transfer/fields/clickhouse/terraform/custom-mapping.md) %}

        * {% include [round_robin](../../../../_includes/data-transfer/fields/clickhouse/terraform/round-robin.md) %}

        You can only specify one of the sharding options: `sharding.column_value_hash.column_name`, `sharding.transfer_id`, `sharding.custom_mapping`, or `sharding.round_robin`. If no sharding option is specified, all data will be transferred to a single shard.

- API {#api}

    * {% include [altNames](../../../../_includes/data-transfer/fields/clickhouse/api/alt-names.md) %}

    * {% include [cleanupPolicy](../../../../_includes/data-transfer/fields/clickhouse/api/cleanup-policy.md) %}

    * {% include [sharding](../../../../_includes/data-transfer/fields/clickhouse/api/sharding.md) %}

{% endlist %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Troubleshooting data transfer issues {#troubleshooting}

* [New tables are not added](#no-new-tables).
* [Data is not transferred](#no-transfer).
* [Unsupported date range](#date-range).

For more troubleshooting tips, see [Troubleshooting](../../../troubleshooting/index.md).

{% include [no-new-tables](../../../../_includes/data-transfer/troubles/no-new-tables-mch.md) %}

{% include [table-names](../../../../_includes/data-transfer/troubles/table-names.md) %}

{% include [date-range](../../../../_includes/data-transfer/troubles/date-range.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
