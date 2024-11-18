# Managing shards {{ MG }}

You can [create a sharded](cluster-create.md#creating-a-sharded-cluster) cluster or [enable sharding](#enable) later. After that, you can [add and configure shards](#add-shard).

Make sure your shards consist of at least three `MONGOD` hosts for higher availability. We do not recommend sharding small collections: query processing is faster with a standard replica cluster.

{% note alert %}

After [cluster sharding](../concepts/sharding.md) is enabled:
* There is no way to disable sharding. The cluster will always maintain a minimum number of `MONGOS`, `MONGOCFG`, or `MONGOINFRA` hosts depending on the [sharding type](../concepts/sharding.md#shard-management).
* To access databases, use only the `MONGOS` or `MONGOINFRA` hosts that route queries to shards. For this purpose, edit host addresses in your application code accordingly.

{% endnote %}

## Enabling sharding {#enable}

The {{ mmg-name }} interface lets you quickly create a [{{ MG }} sharding infrastructure](../concepts/sharding.md#shard-management).

To learn how to directly shard your {{ MG }} database and collections, see [Sharding collections](../tutorials/sharding.md).

To enable sharding, you need:
* At least 3 `MONGOINFRA` hosts for standard sharding.
* At least 2 `MONGOS` and 3 `MONGOCFG` hosts for advanced sharding.

{% note info %}

Sharding is [not supported](../concepts/sharding.md#shard-management) for hosts of **b1.medium** and **b2.medium** classes. If you do not see the **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}** tab, [upgrade the cluster host class](update.md#change-resource-preset) to the supported value.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.shards.button_sharding-enable }}**.
  1. Select a sharding type:
     * **{{ ui-key.yacloud.mongodb.cluster.shards.label_standard }}**: Based on `MONGOINFRA` hosts.
     * **{{ ui-key.yacloud.mongodb.cluster.shards.label_custom }}**: Based on `MONGOS` and `MONGOCFG` hosts.

       For more information, see [Sharding](../concepts/sharding.md).

     {% note warning %}

     After you enable sharding, you can't change its type.

     {% endnote %}

  1. Set the parameters of the hosts that will provide access to the sharded data.
  1. Click **{{ ui-key.yacloud.mongodb.cluster.shards.button_enable_sharding }}**.

  The cluster will start updating, with the requested hosts and first shard of the cluster created.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  * To enable standard cluster sharding using `MONGOINFRA` hosts, run this command (the list of supported parameters in the example is not exhaustive):

    ```bash
    {{ yc-mdb-mg }} cluster enable-sharding \
      --cluster-name=<cluster_name> \
      --host type=mongoinfra,`
        `zone-id=<availability_zone>,`
        `subnet-name=<subnet_name> \
      --host type=mongoinfra,`
        `zone-id=<availability_zone>,`
        `subnet-name=<subnet_name> \
      --host type=mongoinfra,`
        `zone-id=<availability_zone>,`
        `subnet-name=<subnet_name> \
      --mongoinfra resource-preset=<host_class>,`
        `disk-size=<storage_size_in_GB>,`
        `disk-type=<disk_type>
    ```

    Where:
    * `--cluster-name`: Cluster name you can get with a [list of clusters in the folder](cluster-list.md#list).
    * `--host`: Host parameters:
      * `type`: Type (`MONGOINFRA`).
      * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet).
    * `--mongoinfra`: `MONGOINFRA` host parameters:
      * `resource-preset`: [Host class](../concepts/instance-types.md).
      * `disk-size`: Storage size in GB.
      * `disk-type`: [Disk type](../concepts/storage.md).

  * To enable advanced cluster sharding using `MONGOS` and `MONGOCFG` hosts, run this command (the list of supported parameters in the example is not exhaustive):

    ```bash
    {{ yc-mdb-mg }} cluster enable-sharding \
      --cluster-name=<cluster_name> \
      --host type=mongos,`
        `zone-id=<availability_zone>,`
        `subnet-name=<subnet_name> \
      --host type=mongos,`
        `zone-id=<availability_zone>,`
        `subnet-name=<subnet_name> \
      --mongos resource-preset=<host_class>,`
        `disk-size=<storage_size_in_GB>,`
        `disk-type=<disk_type> \
      --host type=mongocfg,`
        `zone-id=<availability_zone>,`
        `subnet-name=<subnet_name> \
      --host type=mongocfg,`
        `zone-id=<availability_zone>,`
        `subnet-name=<subnet_name> \
      --host type=mongocfg,`
        `zone-id=<availability_zone>,`
        `subnet-name=<subnet_name> \
      --mongocfg resource-preset=<host_class>,`
        `disk-size=<storage_size_in_GB>,`
        `disk-type=<disk_type>
    ```

    Where:
    * `--cluster-name`: Cluster name you can get with a [list of clusters in the folder](cluster-list.md#list).
    * `--host`: Host parameters:
      * `type`: Type (`MONGOS` or `MONGOCFG`).
      * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet).
    * `--mongos`: `MONGOS` host parameters:
      * `resource-preset`: [Host class](../concepts/instance-types.md).
      * `disk-size`: Storage size in GB.
      * `disk-type`: [Disk type](../concepts/storage.md).
    * `--mongocfg`: `MONGOCFG` host parameters:
      * `resource-preset`: [Host class](../concepts/instance-types.md).
      * `disk-size`: Storage size in GB.
      * `disk-type`: [Disk type](../concepts/storage.md).

- {{ TF }} {#tf}

  1. {% include [update-provider-version](../../_includes/mdb/mmg/terraform/update-provider-version.md) %}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For information on how to create this file, see [Creating a cluster](cluster-create.md).

  1. Add additional resources to the configuration file.

     {% cut "For standard sharding of the cluster using `MONGOINFRA` hosts" %}

        ```hcl
        resources_mongoinfra {
          resource_preset_id = "<host_class>"
          disk_type_id       = "<disk_type>"
          disk_size          = <storage_size_in_GB>
        }

        host {
          zone_id   = "<availability_zone>"
          subnet_id = "<subnet_ID>"
          type      = "mongoinfra"
        }

        host {
          zone_id   = "<availability_zone>"
          subnet_id = "<subnet_ID>"
          type      = "mongoinfra"
        }

        host {
          zone_id   = "<availability_zone>"
          subnet_id = "<subnet_ID>"
          type      = "mongoinfra"
        }
        ```

     {% endcut %}

     {% cut "For advanced sharding of the cluster using `MONGOS` and `MONGOCFG` hosts" %}

        ```hcl
        resources_mongos {
          resource_preset_id = "<host_class>"
          disk_type_id       = "<disk_type>"
          disk_size          = <storage_size_in_GB>
        }

        resources_mongocfg {
          resource_preset_id = "<host_class>"
          disk_type_id       = "<disk_type>"
          disk_size          = <storage_size_in_GB>
        }

        host {
          zone_id   = "<availability_zone>"
          subnet_id = "<subnet_ID>"
          type      = "mongos"
        }

        host {
          zone_id   = "<availability_zone>"
          subnet_id = "<subnet_ID>"
          type      = "mongos"
        }

        host {
          zone_id   = "<availability_zone>"
          subnet_id = "<subnet_ID>"
          type      = "mongocfg"
        }

        host {
          zone_id   = "<availability_zone>"
          subnet_id = "<subnet_ID>"
          type      = "mongocfg"
        }

        host {
          zone_id   = "<availability_zone>"
          subnet_id = "<subnet_ID>"
          type      = "mongocfg"
        }
        ```

     {% endcut %}

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

- API {#api}

  To enable cluster sharding, use the [enableSharding](../api-ref/Cluster/enableSharding.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/EnableSharding](../api-ref/grpc/Cluster/enableSharding.md) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

  You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Listing shards in a cluster {#list-shards}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of shards in a cluster, run the following command:

  ```bash
  {{ yc-mdb-mg }} shards list --cluster-name <cluster_name>
  ```

  Result:

  ```text
  +------+
  | NAME |
  +------+
  | rs01 |
  | rs02 |
  +------+
  ```

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

  To get a list of cluster shards, use the [listShards](../api-ref/Cluster/listShards.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListShards](../api-ref/grpc/Cluster/listShards.md) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

  You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Creating a shard {#add-shard}

The number of shards in {{ mmg-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources currently in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ mmg-full-name }}**.

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}**.
  1. Enter a name for the shard and add the number of hosts you need.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_create-shard }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a shard, run the command below (not all the supported parameters are listed):

  ```bash
  {{ yc-mdb-mg }} shards add <new_shard_name> \
    --cluster-name=<cluster_name> \
    --host zone-id=<availability_zone>,`
      `subnet-name=<subnet_name>
  ```

  Where:
  * `--cluster-name`: Cluster name you can get with a [list of clusters in the folder](cluster-list.md#list-clusters).
  * `--host`: Host parameters:
    * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
    * `subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet).

- {{ TF }} {#tf}

  1. {% include [update-provider-version](../../_includes/mdb/mmg/terraform/update-provider-version.md) %}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For information on how to create this file, see [Creating a cluster](cluster-create.md).

  1. Add to the {{ mmg-name }} cluster description the required number of `host` blocks with `MONGOD` in the `type` parameter and shard name in the `shard_name` parameter:

     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
       ...
       host {
         zone_id    = "<availability_zone>"
         subnet_id  = "<subnet_ID>"
         type       = "mongod"
         shard_name = "<shard_name>"
       }
     }
     ```

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

- API {#api}

  To create a shard, use the [addShard](../api-ref/Cluster/addShard.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddShard](../api-ref/grpc/Cluster/addShard.md) gRPC API call and provide the following in the request:

  * Cluster ID in the `clusterId` parameter.
  * Shard name in the `shardName` parameter.
  * Shard host configuration in the array of `hostSpecs` parameters.

  You can get the shard name with a [list of cluster shards](#list-shards) and the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Deleting a shard {#delete-shard}

You can delete a shard from a {{ MG }} cluster if it is not the only shard there. To replace the only shard in a cluster, first create a new shard and then remove the old one.

{% note info %}

The [removeShard](https://docs.mongodb.com/manual/reference/command/removeShard/) operation will be called for the shard being deleted and will safely transfer data to the remaining shards.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}** tab.
  1. Click the ![image](../../_assets/console-icons/ellipsis.svg) icon in the shard row and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.mdb.cluster.shards.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a shard from the cluster, run:

  ```bash
  {{ yc-mdb-mg }} shards delete <shard_name> \
    --cluster-name=<cluster_name>
  ```

  You can request the shard name with a [list of cluster shards](#list-shards) and the cluster name with a [list of clusters in a folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For information on how to create this file, see [Creating a cluster](cluster-create.md).

  1. Delete all shard-related `host` blocks from the {{ mmg-name }} cluster description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

- API {#api}

  To delete a shard, use the [deleteShard](../api-ref/Cluster/deleteShard.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteShard](../api-ref/grpc/Cluster/deleteShard.md) gRPC API call and provide the following in the request:

  * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * Name of the shard you are deleting in the `shardName` parameter.

{% endlist %}