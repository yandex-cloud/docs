---
title: How to set up a {{ CH }} target endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up a {{ CH }} target endpoint in {{ data-transfer-full-name }}.
---

# Transferring data to a {{ CH }} target endpoint

{{ data-transfer-full-name }} enables you to migrate data to a {{ CH }} database and implement various data transfer, processing, and transformation scenarios. To set up a transfer:

1. [Review possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Prepare the {{ CH }}](#prepare) database for the transfer.
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) and [launch](../../transfer.md#activate) the transfer.
1. Perform the required database tasks while [monitoring the transfer status](../../monitoring.md).
1. If you run into any problems, [check the available solutions](#troubleshooting) for troubleshooting.

## {{ CH }} data transfer scenarios {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
    * [Migrating a {{ CH }} cluster](../../../tutorials/managed-clickhouse.md).
    * [{#T}](../../../tutorials/opensearch-to-clickhouse.md).

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
* [{{ ytsaurus-name }}](../source/yt.md)
* [Oracle](../source/oracle.md)
* [{{ OS }}](../source/opensearch.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

{% note info %}

{{ CH }} has date range restrictions. If the source database contains unsupported dates, this may result in an [error](#date-range) and stop the transfer.

{% endnote %}

## Preparing the target database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/clickhouse-prepare.md) %}

## Configuring the {{ CH }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can configure:

* Connection settings for a [{{ mch-full-name }} cluster](#managed-service) or a [custom deployment](#on-premise), including those running on {{ compute-full-name }} VMs. These settings are required.
* [Optional settings](#additional-settings).

See also the [endpoint setup recommendations](#recommended-settings-queue) if [{{ CH }} gets data from queues](#scenarios).

### {{ mch-name }} cluster {#managed-service}


{% note warning %}

To create or edit a managed database endpoint, you will need the [`{{ roles.mch.viewer }}`](../../../../managed-clickhouse/security.md#managed-clickhouse-viewer) role or the primitive [`viewer`](../../../../iam/roles-reference.md#viewer) role for the folder where its cluster resides.

{% endnote %}


Connection to the database with the cluster specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse-target.md) %}

- CLI {#cli}

    * Endpoint type: `clickhouse-target`.

    {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-clickhouse-target.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `clickhouse_target`.

    {% include [Managed ClickHouse {{ TF }}](../../../../_includes/data-transfer/necessary-settings/terraform/managed-clickhouse-target.md) %}

    Configuration file structure example:

    
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


    For more information, see [this {{ TF }} provider guide]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/managed-clickhouse-target.md) %}

{% endlist %}

### Custom installation {#on-premise}

Connection to the database with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse-target.md) %}

- CLI {#cli}

    * Endpoint type: `clickhouse-target`.

    {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-clickhouse-target.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `clickhouse_target`.

    {% include [On premise ClickHouse {{ TF }}](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-clickhouse-target.md) %}

    Configuration file structure example:

    
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
                  hosts = [ "list of IP addresses and FQDNs of shard hosts" ]
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


    For more information, see [this {{ TF }} provider guide]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On premise ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-clickhouse-target.md) %}

{% endlist %}

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    * {% include [cleanup_policy](../../../../_includes/data-transfer/fields/clickhouse/ui/cleanup-policy.md) %}

    * {% include [sharding_settings](../../../../_includes/data-transfer/fields/clickhouse/ui/sharding-settings.md) %}

    * {% include [advanced_settings](../../../../_includes/data-transfer/fields/clickhouse/ui/advanced-settings.md) %}

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

        You can specify only one sharding option: `sharding.column_value_hash.column_name`, `sharding.transfer_id`, `sharding.custom_mapping`, or `sharding.round_robin`. If no sharding option is specified, the system will transfer all data to a single shard.

    * {% include [alter-schema-change-tf](../../../../_includes/data-transfer/fields/alter-schema-change-tf.md) %}

- API {#api}

    * {% include [altNames](../../../../_includes/data-transfer/fields/clickhouse/api/alt-names.md) %}

    * {% include [cleanupPolicy](../../../../_includes/data-transfer/fields/clickhouse/api/cleanup-policy.md) %}

    * {% include [sharding](../../../../_includes/data-transfer/fields/clickhouse/api/sharding.md) %}

{% endlist %}

Once you have configured the source and target, [create and launch the transfer](../../transfer.md#create).

## Endpoint setup recommendations {#recommended-settings-queue}

To speed up delivery of large data volumes from {{ yds-name }} or {{ mkf-name }} queues to {{ CH }}, configure the endpoints as follows:

{% list tabs group=instructions %}

- Management console {#console}

    * If the target {{ CH }} cluster has sharding enabled and the data is migrated into a sharded table, write the data into [local tables](../../../../managed-clickhouse/tutorials/sharding.md#uses), not a distributed one. In the target, query the migrated data from the distributed table. To override the table used for writing, specify it in the target settings: **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.alt_names.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.AltName.to_name.title }}**.
    * If you chose JSON in the source under **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.converter.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.format.title }}**, specify `UTF-8` instead of `STRING` for string types in the data schema.
    * Selecting **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.add_rest_column.title }}** may slow down your data transfers.
    * To migrate multiple topics, specify the same {{ CH }} table name for all source topics in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.alt_names.title }}** target setting.

- CLI {#cli}

    * If the target {{ CH }} cluster has sharding enabled and the data is migrated into a sharded table, write the data into [local tables](../../../../managed-clickhouse/tutorials/sharding.md#uses), not a distributed one. In the target, query the migrated data from the distributed table. To override the table used for writing, specify it in the `--alt-name` target setting.
    * To migrate multiple topics, specify the same {{ CH }} table name for all source topics in the `--alt-name` target setting.

- {{ TF }} {#tf}

    * If the target {{ CH }} cluster has sharding enabled and the data is migrated into a sharded table, write the data into [local tables](../../../../managed-clickhouse/tutorials/sharding.md#uses), not a distributed one. In the target, query the migrated data from the distributed table. To override the table used for writing, specify it in the `alt_names.to_name` target setting.
    * If you chose JSON in the source under `parser.json_parser`:
      * Specify `UTF-8` instead of `STRING` for string types in the `parser.json_parser.data_schema` data schema.
      * Setting `parser.json_parser.add_rest_column=true` may slow down your transfer.
    * To migrate multiple topics, specify the same `alt_names.to_name` {{ CH }} table name for all `alt_names.from_name` source topics in the `alt_names` target setting.

- API {#api}

    * If sharding is enabled on the target {{ CH }} cluster and you are writing to a sharded table, use the [ underlying](../../../../managed-clickhouse/tutorials/sharding.md) `ReplicatedMergeTree` engine table, rather than the `Distributed` engine table. In the target, query the migrated data from the distributed table. To override the table used for writing, specify it in the `altNames.toName` target setting.
    * If you chose JSON in the source under `parser.jsonParser`:
      * Specify `UTF-8` instead of `STRING` for string types in the `parser.jsonParser.dataSchema` data schema.
      * Setting `parser.jsonParser.addRestColumn=true` may slow down your transfer.
    * To migrate multiple topics, specify the same `altNames.toName` {{ CH }} table name for all `altNames.fromName` source topics in the `altNames` target setting.

{% endlist %}

## Mapping supported data types between DBMS and endpoint {#type-mapping}

#|
|| **{{ CH }} type** | **Endpoint type** ||
|| Int64 | int64 ||
|| Int32 | int32 ||
|| Int16 | int16 ||
|| Int8 | int8 ||
|| UInt64 | uint64 ||
|| UInt32 | uint32 ||
|| UInt16 | uint16 ||
|| UInt8 | uint8 ||
|| Float64 | float ||
|| Float64 | double ||
|| String | string ||
|| String | utf8 ||
|| UInt8 | boolean ||
|| Date | date ||
|| DateTime | datetime ||
|| DateTime64(9) | timestamp ||
|| String | any ||
|#

## Data transfer troubleshooting {#troubleshooting}

* [New tables are not added](#no-new-tables).
* [Data is not transferred](#no-transfer).
* [Date range is not supported](#date-range).
* [Lack of resources or increasing data latency](#pod-restarted).
* [Data blocks limit exceeded](#partition-blocks).

For the full list of recommendations, see [Troubleshooting](../../../troubleshooting/index.md).

{% include [no-new-tables](../../../../_includes/data-transfer/troubles/clickhouse/no-new-tables.md) %}

{% include [date-range](../../../../_includes/data-transfer/troubles/clickhouse/date-range.md) %}

{% include [pod-restarted](../../../../_includes/data-transfer/troubles/clickhouse/pod-restarted.md) %}

{% include [max-partitions](../../../../_includes/data-transfer/troubles/clickhouse/max-partitions.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
