---
title: "How to configure a {{ CH }} target endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up a {{ CH }} target endpoint in {{ data-transfer-full-name }}."
---

# Configuring a {{ CH }} target endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mch-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ mch-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need the [`{{ roles.mch.viewer }}` role](../../../../managed-clickhouse/security/index.md#mch-viewer) or the primitive [`viewer` role](../../../../iam/concepts/access-control/roles.md#viewer) issued for the folder hosting a cluster of this managed database.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mch-full-name }}](../../../../managed-clickhouse/).

{% list tabs %}

- Management console

   {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse.md) %}

- CLI

   * Endpoint type: `clickhouse-target`.

   {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-clickhouse.md) %}

- {{ TF }}

   * Endpoint type: `clickhouse_target`.

   {% include [Managed ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-clickhouse.md) %}

   Example of the configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       clickhouse_target {
         security_groups = [ "list of security group IDs" ]
         subnet_id       = "<subnet ID>"
         connection {
           connection_options {
             mdb_cluster_id = "<{{ mch-name }} cluster ID>"
             database       = "<name of database to transfer>"
             user           = "<username to connect>"
             password {
               raw = "<user password>"
             }
           }
         }
         <advanced endpoint settings>
       }
     }
   }
   ```


    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   {% include [Managed ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/managed-clickhouse.md) %}

{% endlist %}

## Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs %}

- Management console

   {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse.md) %}

- CLI

   * Endpoint type: `clickhouse-target`.

   {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-clickhouse.md) %}

- {{ TF }}

   * Endpoint type: `clickhouse_target`.

   {% include [On premise ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-clickhouse.md) %}

   Example of the configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       clickhouse_target {
         security_groups = [ "list of security group IDs" ]
         subnet_id       = "<subnet ID>"
         connection {
           connection_options {
             on_premise {
               http_port   = "<HTTP connection port>"
               native_port = "<native interface connection port>"
               shards {
                 name  = "<shard name>"
                 hosts = [ "list of shard host IPs or FQDNs" ]
               }
               tls_mode {
                 enabled {
                   ca_certificate = "<certificate in PEM format>"
                 }
               }
             }
             database = "<name of database to transfer>"
             user     = "<username to connect>"
             password {
               raw = "<user password>"
             }
           }
         }
         <advanced endpoint settings>
       }
     }
   }
   ```


   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   {% include [On premise ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-clickhouse.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.cleanup_policy.title }}**: Select a way to clean up data in the target database before the transfer:

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Select this option if you are only going to do replication without copying data.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Fully delete tables included in the transfer (used by default).

         Use this option so that the latest version of the table schema is always transferred to the target database from the source whenever the transfer is activated.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}`: Delete only the data from the tables included in the transfer but leave the schema.

         Use this option if the schema in the target database differs from the one that would have been transferred from the source during the transfer.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.sharding_settings.title }}**: Specify the settings for [sharding](../../../../managed-clickhouse/concepts/sharding.md):

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.no_sharding.title }}**: No sharding is used.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_column.title }}**: The name of the column in tables that data will be sharded by. A uniform distribution across shards will be determined by a hash from this column value. Specify the name of the column to be sharded in the appropriate field.

         For sharding by specific column values, specify them in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingByTransferID.transfer_to_shard.array_item_label }}** field. This field defines the mapping between the column and shard index values (the sequential number of the shard in the name-sorted list of shards), to enable sharding by specific data values.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_transfer_id.title }}**: Data will be distributed across shards based on the transfer ID value. The transfer will ignore the **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingByTransferID.transfer_to_shard.title }}** setting and will only shard the data based on the transfer ID.

         {% note warning %}

         If you omit the sharding columns and the **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_transfer_id.title }}** setting, all the data will be moved to the same shard.

         {% endnote %}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.alt_names.title }}**: Specify the settings for renaming tables during a transfer, if required.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.flush_interval.title }}**: Specify the delay with which the data should arrive at the target cluster. Increase the value in this field if ClickHouse fails to merge data parts.

- {{ TF }}

   * `clickhouse_cluster_name`: Specify the name of the cluster that the data will be transferred to.

   * `alt_names`: If necessary, set rules for renaming the source database tables when transferring them to the target database:

      * `from_name`: Source table name.
      * `to_name`: Target table name.

   * `sharding.column_value_hash.column_name`: The name of the column in tables that data will be [sharded](../../../../managed-clickhouse/concepts/sharding.md) by. A uniform distribution across shards will be determined by a hash from this column value.

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
