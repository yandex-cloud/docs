---
title: "How to configure {{ CH }} target endpoint in {{ data-transfer-full-name }}"
description: "Following this guide you will learn how to configure {{ CH }} target endpoint in {{ data-transfer-full-name }}."
---

# Configuring a {{ CH }} target endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mch-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ mch-name }} cluster {#managed-service}

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

   Example configuration file structure:

   
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

   Example configuration file structure:

   
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

   * **{{ CH}} cluster name**: Specify the name of the cluster that the data will be transferred to.

   * **Override table names**: Fill in if you need to rename source tables when transferring to the target database.

   * **Shard column**: The name of the column in tables that data will be [sharded](../../../../managed-clickhouse/concepts/sharding.md) by. A uniform distribution across shards will be determined by a hash from this column value. For sharding by specific column values, specify them in the **Shard mapping** field.

   * **Shard by transfer ID**: Data will be distributed across shards based on the transfer ID value. The transfer will ignore the **Sharding column** and **Shard mapping** settings, and will only shard the data based on the transfer ID.

      {% note warning %}

      If you omit the sharding columns and the **Shard by transfer ID** setting, all the data will be moved to the same shard.

      {% endnote %}

   * **Shard mapping** defines the mapping between values in the column set as the **Shard column** and the shard index (the sequential number of the shard in the name-sorted list of shards), to enable sharding by specific data values.

   * **Upload data in JSON format**: For optional values, default values will be used (if any). Enable this setting if the transfer connects to the target via the HTTP port rather than the native one.

   * **Write interval**: Specify the delay with which the data should arrive at the target cluster. Increase the value in this field if ClickHouse fails to merge data parts.

   * {% include [Field Cleanup Policy Disabled/Drop/Truncate](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-disabled-drop-truncate.md) %}

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
