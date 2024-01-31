---
title: "How to configure a {{ CH }} target endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up a {{ CH }} target endpoint in {{ data-transfer-full-name }}."
---

# Transferring data to a {{ CH }} target endpoint

{{ data-transfer-full-name }} enables you to migrate data to a {{ CH }} database and implement various scenarios of data transfer, processing and transformation. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Prepare the {{ CH }}](#prepare) database for the transfer.
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data to {{ CH }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
   * [Migrating the {{ CH }} cluster](../../../tutorials/managed-clickhouse.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
   * [Delivering data from {{ KF }} to {{ CH }}](../../../tutorials/mkf-to-mch.md).
   * [Delivering data from {{ DS }} to {{ CH }}](../../../tutorials/yds-to-clickhouse.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}
   * [Loading {{ GP }} data to {{ CH }}](../../../tutorials/greenplum-to-clickhouse.md).
   * [Loading {{ MY }} data to {{ CH }}](../../../tutorials/mysql-to-clickhouse.md).
   * [Loading {{ metrika }} data to {{ CH }}](../../../tutorials/metrika-to-clickhouse.md).
   * [Loading {{ yandex-direct }} data to {{ CH }}](../../../tutorials/direct-to-mch.md).

* [Loading {{ PG }} data to {{ CH }}](../../../tutorials/rdbms-to-clickhouse.md).

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ PG }}](../source/postgresql.md).
* [{{ MY }}](../source/mysql.md).
* [{{ CH }}](../source/clickhouse.md).
* [{{ GP }}](../source/greenplum.md).
* [{{ objstorage-full-name }}](../source/object-storage.md).
* [{{ KF }}](../source/kafka.md).
* [Airbyte](../../../transfer-matrix.md#airbyte).
* [{{ metrika }}](../source/metrika.md).
* [{{ DS }}](../source/data-streams.md).
* [Oracle](../source/oracle.md).

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

## Preparing the target database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/clickhouse-prepare.md) %}

## Configuring the {{ CH }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mch-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

### {{ mch-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mch.viewer }}` role](../../../../managed-clickhouse/security/index.md#mch-viewer) or the [`viewer` primitive role](../../../../iam/concepts/access-control/roles.md#viewer) assigned to the folder where this managed database cluster resides.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse.md) %}

- CLI {#cli}

   * Endpoint type: `clickhouse-target`.

   {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-clickhouse.md) %}

- {{ TF }} {#tf}

   * Endpoint type: `clickhouse_target`.

   {% include [Managed ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-clickhouse.md) %}

   Here is an example of the configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
     name = "<endpoint_name>"
     settings {
       clickhouse_target {
         security_groups = ["<list_of_security_group_IDs>"]
         subnet_id       = "<subnet_ID>"
         connection {
           connection_options {
             mdb_cluster_id = "<cluster_ID>"
             database       = "<migrated_database_name>"
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

   {% include [Managed ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/managed-clickhouse.md) %}

{% endlist %}

### Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse.md) %}

- CLI {#cli}

   * Endpoint type: `clickhouse-target`.

   {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-clickhouse.md) %}

- {{ TF }} {#tf}

   * Endpoint type: `clickhouse_target`.

   {% include [On premise ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-clickhouse.md) %}

   Here is an example of the configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
     name = "<endpoint_name>"
     settings {
       clickhouse_target {
         security_groups = ["<list_of_security_group_IDs>"]
         subnet_id       = "<subnet_ID>"
         connection {
           connection_options {
             on_premise {
               http_port   = "<port_for_HTTP_connections>"
               native_port = "<port_for_connecting_to_native_interface>"
               shards {
                 name  = "<shard_name>"
                 hosts = [ "list_of_IP_addresses_or_FQDN_hosts_of_the_shard" ]
               }
               tls_mode {
                 enabled {
                   ca_certificate = "<PEM_certificate>"
                 }
               }
             }
             database = "<migrated_database_name>"
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

   {% include [On premise ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-clickhouse.md) %}

{% endlist %}

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.cleanup_policy.title }}**: Select a way to clean up data in the target database before the transfer:

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Select this option if you are only going to do replication without copying data.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Completely delete tables included in the transfer (used by default).

         Use this option so that the latest version of the table schema is always transferred to the target database from the source whenever the transfer is activated.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}`: Delete only the data from the tables included in the transfer but leave the schema.

         Use this option if the schema in the target database differs from the one that would have been transferred from the source during the transfer.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.sharding_settings.title }}**: Specify the settings for [sharding](../../../../managed-clickhouse/concepts/sharding.md):

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.no_sharding.title }}**: No sharding is used.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_column.title }}**: Name of the column in tables by which the data will be sharded. Uniform distribution between shards will depend on a hash from this column value. Specify the name of the column to be sharded in the appropriate field.

         For sharding by specific column values, specify them in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingByTransferID.transfer_to_shard.array_item_label }}** field. This field defines the mapping between the column and shard index values (the sequential number of the shard in the name-sorted list of shards), to enable sharding by specific data values.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_transfer_id.title }}**: Data will be distributed across shards based on the transfer ID value. The transfer will ignore the **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingByTransferID.transfer_to_shard.title }}** setting and will only shard the data based on the transfer ID.

         {% note warning %}

         If you omit the sharding columns and the **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_transfer_id.title }}** setting, all the data will be moved to the same shard.

         {% endnote %}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.alt_names.title }}**: Specify the settings for renaming tables during a transfer, if required.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.flush_interval.title }}**: Specify the delay with which the data should arrive at the target cluster. Increase the value in this field if {{ CH }} fails to merge data parts.

- {{ TF }} {#tf}

   * `clickhouse_cluster_name`: Specify the name of the cluster that the data will be transferred to.

   * `alt_names`: If necessary, set rules for renaming the source database tables when transferring them to the target database:

      * `from_name`: Source table name.
      * `to_name`: Target table name.

   * `sharding.column_value_hash.column_name`: Name of the column in tables by which the data will be [sharded](../../../../managed-clickhouse/concepts/sharding.md). Uniform distribution between shards will depend on a hash from this column value.

   * `sharding.transfer_id`: If `true`, the data is sharded based on the transfer ID value. The transfer will ignore the `sharding.column_value_hash.column_name` setting and will only shard the data based on the transfer ID.

      {% note warning %}

      If you omit the sharding columns and the `sharding.transfer_id` setting, all the data will be moved to the same shard.

      {% endnote %}

   * `cleanup_policy`: Select a way to clean up data in the target database before the transfer:

      * `CLICKHOUSE_CLEANUP_POLICY_DROP`: Fully delete tables included in the transfer (default).

         Use this option so that the latest version of the table schema is always transferred to the target database from the source whenever the transfer is activated.

      * `CLICKHOUSE_CLEANUP_POLICY_DISABLED`: Do not clean up.

         Select this option if only replication without copying data is performed.

{% endlist %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Troubleshooting data transfer issues {#troubleshooting}

* [New tables are not added](#no-new-tables).
* [Data is not transferred](#no-transfer)

See a full list of recommendations in the [Troubleshooting](../../../troubleshooting/index.md) section.

{% include [no-new-tables](../../../../_includes/data-transfer/troubles/no-new-tables.md) %}

{% include [table-names](../../../../_includes/data-transfer/troubles/table-names.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}