# Managing {{ MG }} shards

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

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
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

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

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

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.EnableSharding](../api-ref/Cluster/enableSharding.md) method send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>:enableSharding' \
            --data '{
                      "<{{ MG }}_host_type>": {
                        "resources": {
                          "resourcePresetId": "<host_class>",
                          "diskSize": "<storage_size_in_bytes>",
                          "diskTypeId": "<disk_type>"
                        }
                      },
                      "hostSpecs": [
                        {
                          "zoneId": "<availability_zone>",
                          "subnetId": "<subnet_ID>",
                          "assignPublicIp": <allow_public_access_to_host>,
                          "type": "<host_type>",
                          "shardName": "<shard_name>",
                          "hidden": <hide_host>,
                          "secondaryDelaySecs": "<lag_in_seconds>",
                          "priority": "<host_priority_for_assignment_as_master>",
                          "tags": "<host_labels>"
                        },
                        { <similar_configuration_for_host_2> },
                        { ... },
                        { <similar_configuration_for_host_N> }
                      ]
                    }'
        ```

        Where:

        * {{ MG }} host type depends on the [sharding type](../concepts/sharding.md). Possible values: `mongocfg`, `mongos`, and `mongoinfra`.
        
        * `hostSpecs` is an array of new hosts. One array element contains settings for a single host. The number of hosts depends on the [sharding type](../concepts/sharding.md#shard-management). 

          * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
          * `type`: Host type: `MONGOINFRA`, `MONGOS`, or `MONGOCFG`.
          * `shardName`: Shard name.
          * `hidden`: The host will either be visible (`false`) or hidden (`true`).
          * `secondaryDelaySecs`: Host's lag behind the master.
          * `priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
          * `tags`: Host labels.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/enableSharding.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.EnableSharding](../api-ref/grpc/Cluster/enableSharding.md) call and send a request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "<{{ MG }}_host_type>": {
                  "resources": {
                    "resource_preset_id": "<host_class>",
                    "disk_size": "<storage_size_in_bytes>",
                    "disk_type_id": "<disk_type>"
                  }
                },
                "host_specs": [
                  {
                    "zone_id": "<availability_zone>",
                    "subnet_id": "<subnet_ID>",
                    "assign_public_ip": <allow_public_access_to_host>,
                    "type": "<host_type>",
                    "shard_name": "<shard_name>",
                    "hidden": <hide_host>,
                    "secondary_delay_secs": "<lag_in_seconds>",
                    "priority": "<host_priority_for_assignment_as_master>",
                    "tags": "<host_labels>"
                  },
                  { <similar_configuration_for_host_2> },
                  { ... },
                  { <similar_configuration_for_host_N> }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.EnableSharding
      ```

      Where:
      
      * {{ MG }} host type depends on the [sharding type](../concepts/sharding.md). Possible values: `mongocfg`, `mongos`, and `mongoinfra`.
        
      * `host_specs` is an array of new hosts. One array element contains settings for a single host. The number of hosts depends on the [sharding type](../concepts/sharding.md#shard-management). 

        * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
        * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
        * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
        * `type`: Host type: `MONGOINFRA`, `MONGOS`, or `MONGOCFG`.
        * `shard_name`: Shard name.
        * `hidden`: The host will either be visible (`false`) or hidden (`true`).
        * `secondary_delay_secs`: Host's lag behind the master.
        * `priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
        * `tags`: Host labels.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/enableSharding.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Listing shards in a cluster {#list-shards}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
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

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.ListShards](../api-ref/Cluster/listShards.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/shards'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/listShards.md#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.ListShards](../api-ref/grpc/Cluster/listShards.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.ListShards
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/listShards.md#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse) to make sure the request was successful.

{% endlist %}

## Creating a shard {#add-shard}

The number of shards in {{ mmg-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources currently in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ mmg-full-name }}**.

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
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

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

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

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.AddShard](../api-ref/Cluster/addShard.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/shards' \
            --data '{
                      "shardName": "<shard_name>",
                      "hostSpecs": [
                        {
                          "zoneId": "<availability_zone>",
                          "subnetId": "<subnet_ID>",
                          "assignPublicIp": <allow_public_access_to_host>,
                          "type": "<host_type>",
                          "shardName": "<shard_name>",
                          "hidden": <hide_host>,
                          "secondaryDelaySecs": "<time_in_seconds>",
                          "priority": "<host_priority_for_assignment_as_master>",
                          "tags": "<labels>"
                        },
                        { <similar_configuration_for_host_2> },
                        { ... },
                        { <similar_configuration_for_host_N> }
                      ]
                    }'

        ```

        Where:

        * `shardName`: Name of the shard being created.
        * `hostSpecs`: Host parameters:

          * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
          * `type`: Host type. Specify `MONGOD`.
          * `shardName`: Shard name.
          * `hidden`: The host will either be visible (`false`) or hidden (`true`).
          * `secondaryDelaySecs`: Host's lag behind the master.
          * `priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
          * `tags`: Host labels.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/addShard.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.AddShard](../api-ref/grpc/Cluster/addShard.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "shard_name": "<shard_name>",
                  "host_specs": [
                    {
                      "zone_id": "<availability_zone>",
                      "subnet_id": "<subnet_ID>",
                      "assign_public_ip": <allow_public_access_to_host>,
                      "type": "<host_type>",
                      "shard_name": "<shard_name>",
                      "hidden": <hide_host>,
                      "secondary_delay_secs": "<time_in_seconds>",
                      "priority": "<host_priority_for_assignment_as_master>",
                      "tags": "<labels>"
                    },
                    { <similar_configuration_for_host_2> },
                    { ... },
                    { <similar_configuration_for_host_N> }
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.AddShard    
        ```

        Where:

        * `shard_name`: Name of the shard being created.
        * `host_specs`: Host parameters:

          * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
          * `type`: Host type. Specify `MONGOD`.
          * `shard_name`: Shard name.
          * `hidden`: The host will either be visible (`false`) or hidden (`true`).
          * `secondary_delay_secs`: Host's lag behind the master.
          * `priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
          * `tags`: Host labels.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/addShard.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Deleting a shard {#delete-shard}

You can delete a shard from a {{ MG }} cluster if it is not the only shard there. To replace the only shard in a cluster, first create a new shard and then remove the old one.

{% note info %}

The [removeShard](https://docs.mongodb.com/manual/reference/command/removeShard/) operation will be called for the shard being deleted and will safely transfer data to the remaining shards.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
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

  You can request the shard name with the [list of shards in the cluster](#list-shards) and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

     For information on how to create this file, see [Creating a cluster](cluster-create.md).

  1. Delete all shard-related `host` blocks from the {{ mmg-name }} cluster description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.DeleteShard](../api-ref/Cluster/deleteShard.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/shards/<shard_name>'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the shard name, with the [list of shards in the cluster](#list-shards).

    1. View the [server response](../api-ref/Cluster/deleteShard.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.DeleteShard](../api-ref/grpc/Cluster/deleteShard.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "shard_name": "<shard_name>" 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.DeleteShard
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the shard name, with the [list of shards in the cluster](#list-shards).

    1. View the [server response](../api-ref/grpc/Cluster/deleteShard.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}