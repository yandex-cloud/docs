# Managing {{ SD }} shards

You can [create a sharded cluster](cluster-create.md#creating-a-sharded-cluster) or you can [enable sharding](#enable) later. Next, you can [add and configure shards](#add-shard).

To ensure high availability, each shard must consist of at least three `MONGOD` hosts. We do not recommend sharding small collections, as a standard replica set will process queries faster.

{% note alert %}

Once [cluster sharding](../concepts/sharding.md) is enabled:
* You cannot turn sharding off. The cluster will always maintain a minimum of `MONGOS`, `MONGOCFG`, or `MONGOINFRA` hosts, depending on the [sharding type](../concepts/sharding.md#shard-management).
* All database access must go through `MONGOS` or `MONGOINFRA` hosts, which route queries to the shards. Update the host addresses in your application code accordingly.

{% endnote %}

## Enabling sharding {#enable}

Using the {{ mmg-name }} interface, you can quickly set up a [{{ SD }}](../concepts/sharding.md#shard-management) sharding infrastructure.

For details on how to shard your {{ SD }} database and collections directly, see [Sharding collections](../tutorials/sharding.md).

To enable sharding, you need:
* At least three `MONGOINFRA` hosts for standard sharding.
* At least two `MONGOS` and three `MONGOCFG` hosts for advanced sharding.

{% note info %}

The **b1.medium** and **b2.medium** host classes [do not support](../concepts/sharding.md#shard-management) sharding. If you do not see the **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}** tab, [upgrade your cluster’s host class](update.md#change-resource-preset) to the supported level.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.shards.button_sharding-enable }}**.
  1. Select sharding type:
     * **{{ ui-key.yacloud.mongodb.EnableShardingForm.option_sharding-type-standard_ezqnu }}**: Based on `MONGOINFRA` hosts.
     * **{{ ui-key.yacloud.mongodb.EnableShardingForm.option_sharding-type-extended_8Vip4 }}**: Based on `MONGOS` and `MONGOCFG` hosts.

       For more information, see [Sharding](../concepts/sharding.md).

     {% note warning %}

     Once you enable sharding, you cannot change its type.

     {% endnote %}

  1. Configure the settings of the hosts that will provide access to the sharded data.
  1. Click **{{ ui-key.yacloud.mongodb.cluster.shards.button_enable_sharding }}**.

  The cluster will begin updating. During this process, the system will create the requested hosts and the cluster’s first shard.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  * To enable standard cluster sharding using `MONGOINFRA` hosts, run the command below. Note that this example does not show all available command options:

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
    * `--cluster-name`: Cluster name. You can get it from the [list of clusters in your folder](cluster-list.md#list).
    * `--host`: Host settings:
      * `type`: Type (`MONGOINFRA`).
      * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet).
    * `--mongoinfra`: `MONGOINFRA` host settings:
      * `resource-preset`: [Host class](../concepts/instance-types.md).
      * `disk-size`: Storage size, in GB.
      * `disk-type`: [Disk type](../concepts/storage.md).

  * To enable advanced cluster sharding using `MONGOS` and `MONGOCFG` hosts, run the command below. Note that this example does not show all available command options.

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
    * `--cluster-name`: Cluster name. You can get it from the [list of clusters in your folder](cluster-list.md#list).
    * `--host`: Host settings:
      * `type`: Type, `MONGOS` or `MONGOCFG`.
      * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet).
    * `--mongos`: `MONGOS` host settings:
      * `resource-preset`: [Host class](../concepts/instance-types.md).
      * `disk-size`: Storage size, in GB.
      * `disk-type`: [Disk type](../concepts/storage.md).
    * `--mongocfg`: `MONGOCFG` host settings:
      * `resource-preset`: [Host class](../concepts/instance-types.md).
      * `disk-size`: Storage size, in GB.
      * `disk-type`: [Disk type](../concepts/storage.md).

- {{ TF }} {#tf}

  1. {% include [update-provider-version](../../_includes/mdb/mmg/terraform/update-provider-version.md) %}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).

  1. Add new resources to the configuration file.

     {% cut "For standard cluster sharding using `MONGOINFRA` hosts" %}

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

     {% cut "For advanced cluster sharding using `MONGOS` and `MONGOCFG` hosts" %}

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

  1. Validate your configuration.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mmg }}).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.EnableSharding](../api-ref/Cluster/enableSharding.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>:enableSharding' \
            --data '{
                      "<Yandex_StoreDoc_host_type>": {
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
                        { <similar_settings_for_host_2> },
                        { ... },
                        { <similar_configuration_for_host_N> }
                      ]
                    }'
        ```

        Where:

        * {{ SD }} host type depends on the [sharding type](../concepts/sharding.md). The possible values are `mongocfg`, `mongos`, and `mongoinfra`.
        
        * `hostSpecs` is an array of new hosts, in which each element contains the settings for a single host. The number of hosts depends on the [sharding type](../concepts/sharding.md#shard-management). 

          * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp`: Controls whether the host is accessible via a public IP address, `true` or `false`.
          * `type`: Host type, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`.
          * `shardName`: Shard name.
          * `hidden`: Determines whether the host is hidden, `true` or `false`.
          * `secondaryDelaySecs`: Host’s replication lag behind the master.
          * `priority`: Host priority for master promotion during [failover](../concepts/replication.md#master-failover).
          * `tags`: Host tags.

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/enableSharding.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.EnableSharding](../api-ref/grpc/Cluster/enableSharding.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "<Yandex_StoreDoc_host_type>": {
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
                  { <similar_settings_for_host_2> },
                  { ... },
                  { <similar_configuration_for_host_N> }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.EnableSharding
      ```

      Where:
      
      * {{ SD }} host type depends on the [sharding type](../concepts/sharding.md). The possible values are `mongocfg`, `mongos`, and `mongoinfra`.
        
      * `host_specs` is an array of new hosts, in which each element contains the settings for a single host. The number of hosts depends on the [sharding type](../concepts/sharding.md#shard-management). 

        * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
        * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
        * `assign_public_ip`: Controls whether the host is accessible via a public IP address, `true` or `false`.
        * `type`: Host type, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`.
        * `shard_name`: Shard name.
        * `hidden`: Determines whether the host is hidden, `true` or `false`.
        * `secondary_delay_secs`: Host’s replication lag behind the master.
        * `priority`: Host priority for master promotion during [failover](../concepts/replication.md#master-failover).
        * `tags`: Host tags.

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/enableSharding.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Getting a list of cluster shards {#list-shards}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster shards, run this command:

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

  You can get the cluster name from the [list of clusters in your folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.ListShards](../api-ref/Cluster/listShards.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/shards'
        ```

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/listShards.md#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.ListShards](../api-ref/grpc/Cluster/listShards.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/listShards.md#yandex.cloud.mdb.mongodb.v1.ListClusterShardsResponse) to make sure your request was successful.

{% endlist %}

## Creating a shard {#add-shard}

The number of shards in {{ mmg-name }} clusters is limited by the CPU and RAM quotas available to database clusters in your cloud. To review current resource usage, open the [Quotas]({{ link-console-quotas }}) page and find the **{{ mmg-full-name }}** section.

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}**.
  1. Specify the shard name and add the required number of hosts.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_create-shard }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a shard, run the command below. Note that this example does not show all available command options.

  ```bash
  {{ yc-mdb-mg }} shards add <new_shard_name> \
    --cluster-name=<cluster_name> \
    --host zone-id=<availability_zone>,`
      `subnet-name=<subnet_name>
  ```

  Where:
  * `--cluster-name`: Cluster name. You can get it from the [list of clusters in your folder](cluster-list.md#list-clusters).
  * `--host`: Host settings:
    * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
    * `subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet).

- {{ TF }} {#tf}

  1. {% include [update-provider-version](../../_includes/mdb/mmg/terraform/update-provider-version.md) %}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).

  1. Add the required number of `host` blocks to the {{ mmg-name }} cluster description, with the `type` argument set to `MONGOD` and the `shard_name` argument set to the shard name:

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

  1. Validate your configuration.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mmg }}).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.AddShard](../api-ref/Cluster/addShard.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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
                        { <similar_settings_for_host_2> },
                        { ... },
                        { <similar_configuration_for_host_N> }
                      ]
                    }'

        ```

        Where:

        * `shardName`: New shard’s name.
        * `hostSpecs`: Host settings:

          * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp`: Controls whether the host is accessible via a public IP address, `true` or `false`.
          * `type`: Host type. Specify `MONGOD`.
          * `shardName`: Shard name.
          * `hidden`: Determines whether the host is hidden, `true` or `false`.
          * `secondaryDelaySecs`: Host’s replication lag behind the master.
          * `priority`: Host priority for master promotion during [failover](../concepts/replication.md#master-failover).
          * `tags`: Host tags.

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/addShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.AddShard](../api-ref/grpc/Cluster/addShard.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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
                    { <similar_settings_for_host_2> },
                    { ... },
                    { <similar_configuration_for_host_N> }
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.AddShard    
        ```

        Where:

        * `shard_name`: New shard’s name.
        * `host_specs`: Host settings:

          * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assign_public_ip`: Controls whether the host is accessible via a public IP address, `true` or `false`.
          * `type`: Host type. Specify `MONGOD`.
          * `shard_name`: Shard name.
          * `hidden`: Determines whether the host is hidden, `true` or `false`.
          * `secondary_delay_secs`: Host’s replication lag behind the master.
          * `priority`: Host priority for master promotion during [failover](../concepts/replication.md#master-failover).
          * `tags`: Host tags.

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/addShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.    

{% endlist %}

## Deleting a shard {#delete-shard}

You can delete a shard from a {{ SD }} cluster, provided it is not the only shard. To replace the only shard, first create a new shard and then delete the old one.

{% note info %}

The system will invoke the `removeShard` operation for the shard slated for removal. This operation will safely migrate its data to the remaining shards.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mongodb.cluster.switch_shards }}** tab.
  1. Find the shard you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in its row, and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.mdb.cluster.shards.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a shard from a cluster, run this command:

  ```bash
  {{ yc-mdb-mg }} shards delete <shard_name> \
    --cluster-name=<cluster_name>
  ```

  You can get the shard name from the [list of cluster shards](#list-shards), and the cluster name from the [list of clusters in your folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).

  1. Delete all shard-related `host` blocks from the {{ mmg-name }} cluster description.
  1. Validate your configuration.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mmg }}).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.DeleteShard](../api-ref/Cluster/deleteShard.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/shards/<shard_name>'
        ```

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters), and the shard name from the [list of cluster shards](#list-shards).

    1. Check the [server response](../api-ref/Cluster/deleteShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.DeleteShard](../api-ref/grpc/Cluster/deleteShard.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters), and the shard name from the [list of cluster shards](#list-shards).

    1. Check the [server response](../api-ref/grpc/Cluster/deleteShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}