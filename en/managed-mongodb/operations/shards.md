# Managing shards {{ MG }}

You can [create a sharded](cluster-create.md#creating-a-sharded-cluster) cluster or [enable sharding](#enable) later. After that, you can [add and configure shards](#add-shard).

Make sure that your shards consist of at least three `MONGOD` hosts to ensure higher availability. We do not recommend sharding small collections: query processing is faster with a standard replica cluster.

{% note alert %}

After [cluster sharding](../concepts/sharding.md) is enabled:
* You can't disable sharding: the cluster will always maintain a minimum number of `MONGOS`, `MONGOCFG`, or `MONGOINFRA` hosts depending on the [sharding type](../concepts/sharding.md#shard-management).
* For accessing the databases, only use the `MONGOS` or `MONGOINFRA` hosts that route queries to shards. For this purpose, edit host addresses in your application code accordingly.

{% endnote %}

## Enabling sharding {#enable}

The {{ mmg-name }} interface lets you quickly create a [{{ MG }} sharding infrastructure](../concepts/sharding.md#shard-management).

To learn how to directly shard your {{ MG }} database and collections, see [{#T}](../tutorials/sharding.md).

To enable sharding, you need:
* At least 3 `MONGOINFRA` hosts for standard sharding.
* At least 2 `MONGOS` and 3 `MONGOCFG` hosts for advanced sharding.

{% note info %}

Sharding is [not supported](../concepts/sharding.md#shard-management) for hosts of **b1.medium** and **b2.medium** classes. If you don't see the **Shards** tab, [increase the cluster host class](update.md#change-resource-preset) to the supported value.

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of a cluster and open the **Shards** tab.
   1. Click **Enable**.
   1. Select a sharding type:
      * **Standard**: Using a `MONGOINFRA` host.

      * **Advanced**: Using `MONGOS` and `MONGOCFG` hosts.


         For more information, see [{#T}](../concepts/sharding.md).

      {% note warning %}

      After you enable sharding, you can't change its type.

      {% endnote %}

   1. Set the parameters of the hosts that will provide access to the sharded data.
   1. Click **Enable sharding**.

   The cluster will start updating, with the requested hosts and first shard of the cluster created.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   * To enable standard cluster sharding using `MONGOINFRA` hosts, run the command (the list of supported parameters in the example is not exhaustive):

      ```bash
      {{ yc-mdb-mg }} cluster enable-sharding \
         --cluster-name=<cluster name> \
         --host type=mongoinfra,`
               `zone-id=<availability zone>,`
               `subnet-name=<subnet name> \
         --host type=mongoinfra,`
               `zone-id=<availability zone>,`
               `subnet-name=<subnet name> \
         --host type=mongoinfra,`
               `zone-id=<availability zone>,`
               `subnet-name=<subnet name> \
         --mongoinfra resource-preset=<host class>,`
                     `disk-size=<storage size, GB>,`
                     `disk-type=<disk type>
      ```

      Where:
      * `--cluster-name`: Cluster name that you can request with a [list of clusters in the folder](cluster-list.md#list).
      * `--host`: Host parameters:
         * `type`: Host type (`MONGOINFRA`).
         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
         * `subnet-name`: [Name of the subnet](../../vpc/concepts/network.md#subnet).
      * `--mongoinfra`: `MONGOINFRA` host parameters:
         * `resource-preset`: [Host class](../concepts/instance-types.md).
         * `disk-size`: Storage size in GB.
         * `disk-type`: The [type of disk](../concepts/storage.md).

   * To enable advanced cluster sharding using `MONGOS` and `MONGOCFG` hosts, run the command (the list of supported parameters in the example is not exhaustive):

      ```bash
      {{ yc-mdb-mg }} cluster enable-sharding \
         --cluster-name=<cluster name> \
         --host type=mongos,`
               `zone-id=<availability zone>,`
               `subnet-name=<subnet name> \
         --host type=mongos,`
               `zone-id=<availability zone>,`
               `subnet-name=<subnet name> \
         --mongos resource-preset=<host class>,`
                 `disk-size=<storage size, GB>,`
                 `disk-type=<disk type> \
         --host type=mongocfg,`
               `zone-id=<availability zone>,`
               `subnet-name=<subnet name> \
         --host type=mongocfg,`
               `zone-id=<availability zone>,`
               `subnet-name=<subnet name> \
         --host type=mongocfg,`
               `zone-id=<availability zone>,`
               `subnet-name=<subnet name> \
         --mongocfg resource-preset=<host class>,`
                   `disk-size=<storage size, GB>,`
                   `disk-type=<disk type>
      ```

      Where:
      * `--cluster-name`: Cluster name that you can request with a [list of clusters in the folder](cluster-list.md#list).
      * `--host`: Host parameters:
         * `type`: The type (`MONGOS` or `MONGOCFG`).
         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
         * `subnet-name`: [Name of the subnet](../../vpc/concepts/network.md#subnet).
      * `--mongos`: `MONGOS` host parameters:
         * `resource-preset`: [Host class](../concepts/instance-types.md).
         * `disk-size`: Storage size in GB.
         * `disk-type`: The [type of disk](../concepts/storage.md).
      * `--mongocfg`: `MONGOCFG` host parameters:
         * `resource-preset`: [Host class](../concepts/instance-types.md).
         * `disk-size`: Storage size in GB.
         * `disk-type`: The [type of disk](../concepts/storage.md).

- {{ TF }}

   1. {% include [update-provider-version](../../_includes/mdb/mmg/terraform/update-provider-version.md) %}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information on how to create this file, see [{#T}](cluster-create.md).

   1. Add additional resources to the configuration file.

      {% cut "For standard sharding of the cluster using `MONGOINFRA` hosts" %}

      ```hcl
      resources_mongoinfra {
        resource_preset_id = "<host class>"
        disk_type_id       = "<disk type>"
        disk_size          = <storage size in GB>
      }

      host {
        zone_id   = "<availability zone>"
        subnet_id = "<subnet ID>"
        type      = "mongoinfra"
      }

      host {
        zone_id   = "<availability zone>"
        subnet_id = "<subnet ID>"
        type      = "mongoinfra"
      }

      host {
        zone_id   = "<availability zone>"
        subnet_id = "<subnet ID>"
        type      = "mongoinfra"
      }
      ```

      {% endcut %}

      {% cut "For advanced sharding of the cluster using `MONGOS` and `MONGOCFG` hosts" %}


      ```hcl
      resources_mongos {
        resource_preset_id = "<host class>"
        disk_type_id       = "<disk type>"
        disk_size          = <storage size in GB>
      }

      resources_mongocfg {
        resource_preset_id = "<host class>"
        disk_type_id       = "<disk type>"
        disk_size          = <storage size in GB>
      }

      host {
        zone_id   = "<availability zone>"
        subnet_id = "<subnet ID>"
        type      = "mongos"
      }

      host {
        zone_id   = "<availability zone>"
        subnet_id = "<subnet ID>"
        type      = "mongos"
      }

      host {
        zone_id   = "<availability zone>"
        subnet_id = "<subnet ID>"
        type      = "mongocfg"
      }

      host {
        zone_id   = "<availability zone>"
        subnet_id = "<subnet ID>"
        type      = "mongocfg"
      }

      host {
        zone_id   = "<availability zone>"
        subnet_id = "<subnet ID>"
        type      = "mongocfg"
      }
      ```

      {% endcut %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

- API

   To enable cluster sharding, use the [enableSharding](../api-ref/Cluster/enableSharding.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/EnableSharding](../api-ref/grpc/cluster_service.md#EnableSharding) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Listing shards in a cluster {#list-shards}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of a cluster and open the **Shards** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of shards in a cluster, run the following command:

   ```bash
   {{ yc-mdb-mg }} shards list --cluster-name <cluster name>
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

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of cluster shards, use the [listShards](../api-ref/Cluster/listShards.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListShards](../api-ref/grpc/cluster_service.md#ListShards) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Adding a shard {#add-shard}

The number of shards in {{ mmg-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ mmg-full-name }}**.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of a cluster and open the **Shards** tab.
   1. Click **Add shard**.
   1. Enter a name for the shard and add the number of hosts you need.
   1. Click **Create shard**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a shard to a cluster, run the command below (the parameter list in the example is not exhaustive):

   ```bash
   {{ yc-mdb-mg }} shards add <new shard name> \
      --cluster-name=<cluster name> \
      --host zone-id=<availability zone>,`
            `subnet-name=<subnet name>
   ```

   Where:
   * `--cluster-name`: Cluster name that you can request with a [list of clusters in the folder](cluster-list.md#list-clusters).
   * `--host`: Host parameters:
      * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `subnet-name`: [Name of the subnet](../../vpc/concepts/network.md#subnet).

- {{ TF }}

   1. {% include [update-provider-version](../../_includes/mdb/mmg/terraform/update-provider-version.md) %}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information on how to create this file, see [{#T}](cluster-create.md).

   1. Add to the {{ mmg-name }} cluster description the required number of `host` blocks of the `MONGOD` type set in the `type` parameter and the shard name specified in the `shard_name` parameter:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
        ...
        host {
          zone_id    = "<availability zone>"
          subnet_id  = "<subnet ID>"
          type       = "mongod"
          shard_name = "<shard name>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

- API

   To add a shard to a cluster, use the [addShard](../api-ref/Cluster/addShard.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddShard](../api-ref/grpc/cluster_service.md#AddShard) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter.
   * Name of the shard in the `shardName` parameter.
   * In the array of `hostSpecs` parameters, the shard host configuration.

   You can get the shard name with a [list of cluster shards](#list-shards) and the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Deleting a shard {#delete-shard}

You can delete a shard from a {{ MG }} cluster provided that it's not the only shard in it. To replace the only shard in a cluster, first create a new shard and then remove the old one.

{% note info %}

The [removeShard](https://docs.mongodb.com/manual/reference/command/removeShard/) operation will be called for the shard being deleted and will safely transfer data to the remaining shards.

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of a cluster and open the **Shards** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon in the same row as the desired shard and select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a shard from the cluster, run:

   ```bash
   {{ yc-mdb-mg }} shards delete <shard name> \
      --cluster-name=<cluster name>
   ```

   You can request a shard name with a [list of cluster shards](#list-shards) and a cluster name with a [list of clusters in a folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information on how to create this file, see [{#T}](cluster-create.md).

   1. Delete all shard-related `host` blocks from the {{ mmg-name }} cluster description.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type `yes` and press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

- API

   To delete a shard, use the [deleteShard](../api-ref/Cluster/deleteShard.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteShard](../api-ref/grpc/cluster_service.md#DeleteShard) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Name of the shard to delete in the `shardName` parameter.

{% endlist %}