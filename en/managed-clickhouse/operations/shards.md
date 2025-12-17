# Managing shards in a {{ CH }} cluster

You can enable sharding for a cluster, as well as add and configure individual shards.

## Enabling sharding {#enable}

{{ mch-name }} clusters are created with a single shard. To start sharding data, [add](#add-shard) one or more shards and [create](../tutorials/sharding.md#example) a distributed table.

## Creating a shard {#add-shard}

The number of shards in {{ mch-name }} clusters is limited by the CPU and RAM quotas available to database clusters in your cloud. To check the resources currently in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and navigate to the **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}**.
  1. Specify the following shard properties:
     * Name and weight.
     * To copy the schema from a random replica of one of the shards to the hosts of the new shard, select **{{ ui-key.yacloud.mdb.forms.field_copy_schema }}**.
     * Required number of hosts.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_create-shard }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a shard, run the command below (our example does not use all available parameters):

  ```bash
  {{ yc-mdb-ch }} shards add <new_shard_name> \
    --cluster-name=<cluster_name> \
    --host zone-id=<availability_zone>,`
      `subnet-name=<subnet_name>
  ```

  Where:

  
  * `<new_shard_name>`: New shard name that must be unique within the cluster.

    It may include Latin letters, numbers, hyphens, and underscores. The name may be up to 63 characters long.
  * `--cluster-name`: Cluster name.

    You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).
  * `--host`: Host settings:
    * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
    * `subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet).


- {{ TF }} {#tf}

  {% note info %}

  {{ TF }} does not support specifying a shard weight.

  {% endnote %}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     For information on how to create such a file, see [Creating a cluster](cluster-create.md).
  1. Add the `CLICKHOUSE`-type `host` section with the `shard_name` field filled to the {{ mch-name }} cluster description or update existing hosts:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
       ...
       host {
         type       = "CLICKHOUSE"
         zone       = "<availability_zone>"
         subnet_id  = yandex_vpc_subnet.<subnet_in_availability_zone>.id
         shard_name = "<shard_name>"
       }
     }
     ```

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.AddShard](../api-ref/Cluster/addShard.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "shardName": "<shard_name>",
          "configSpec": {
            "clickhouse": {
              "resources": {
                "resourcePresetId": "<host_class>",
                "diskSize": "<storage_size_in_bytes>",
                "diskTypeId": "<disk_type>"
              },
              "weight": "<shard_weight>"
            }
          },
          "hostSpecs": [
            {
              "zoneId": "<availability_zone>",
              "type": "CLICKHOUSE",
              "subnetId": "<subnet_ID>",
              "assignPublicIp": <public_access_to_host>,
              "shardName": "<shard_name>"
            }
          ],
          "copySchema": <copying_data_schema>
        }
        ```

        Where:

        * `shardName`: Shard name.
        * `configSpec.clickhouse.resources`: Host resources to add to the new shard:

          * `resourcePresetId`: [Host class](../concepts/instance-types.md) ID. You can get the list of available host classes with their IDs using the [ResourcePreset.List](../api-ref/ResourcePreset/list.md) method.
          * `diskSize`: Disk size, in bytes.
          * `diskTypeId`: [Disk type](../concepts/storage.md).

        * `configSpec.clickhouse.weight`: Shard weight.

          By default, each shard is assigned a weight of `1`. If you assign a greater value to a single shard, the data will be distributed among the shards according to their weights.

          To calculate the shard priority for data distribution, the system adds up the weights of all shards and then divides each shard's weight by the total. For example, if one shard has a weight of `1` and another has a weight of `3`, then the first shard's priority is `1/4` and the second shard's priority is `3/4`. The higher the priority, the more data the shard will get.

          For more information, see [this {{ CH }} guide]({{ ch.docs }}/engines/table-engines/special/distributed).

        * `hostSpecs`: Settings of hosts to add to the shard. The settings appear as an array of elements, one per host. Each element has the following structure:

          * `zoneId`: Availability zone.
          * `type`: Host type. You can only add `CLICKHOUSE` hosts to your shards.
          * `subnetId`: Subnet ID.
          * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
          * `shardName`: Shard name.

        * `copySchema`: Copying the data schema from a random replica of one of the shards to the hosts of the new shard. The possible values are `true` or `false`.

     1. Run this query:

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/shards' \
          --data '@body.json'
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/addShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.AddShard](../api-ref/grpc/Cluster/addShard.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "shard_name": "<shard_name>",
          "config_spec": {
            "clickhouse": {
              "resources": {
                "resource_preset_id": "<host_class>",
                "disk_size": "<storage_size_in_bytes>",
                "disk_type_id": "<disk_type>"
              },
              "weight": "<shard_weight>"
            }
          },
          "host_specs": [
            {
              "zone_id": "<availability_zone>",
              "type": "CLICKHOUSE",
              "subnet_id": "<subnet_ID>",
              "assign_public_ip": <public_access_to_host>,
              "shard_name": "<shard_name>"
            }
          ],
          "copy_schema": <copying_data_schema>
        }
        ```

        Where:

        * `shard_name`: Shard name.
        * `config_spec.clickhouse.resources`: Host resources to add to the new shard:

          * `resource_preset_id`: [Host class](../concepts/instance-types.md) ID. You can get the list of available host classes with their IDs using the [ResourcePresetService.List](../api-ref/grpc/ResourcePreset/list.md) method.
          * `disk_size`: Disk size, in bytes.
          * `disk_type_id`: [Disk type](../concepts/storage.md).

        * `config_spec.clickhouse.weight`: Shard weight.

          By default, each shard is assigned a weight of `1`. If you assign a greater value to a single shard, the data will be distributed among the shards according to their weights.

          To calculate the shard priority for data distribution, the system adds up the weights of all shards and then divides each shard's weight by the total. For example, if one shard has a weight of `1` and another has a weight of `3`, then the first shard's priority is `1/4` and the second shard's priority is `3/4`. The higher the priority, the more data the shard will get.

          For more information, see [this {{ CH }} guide]({{ ch.docs }}/engines/table-engines/special/distributed).

        * `host_specs`: Settings of hosts to add to the shard as an array of elements, one per host. Each element has the following structure:

          * `zone_id`: Availability zone.
          * `type`: Host type. You can only add `CLICKHOUSE` hosts to your shards.
          * `subnet_id`: Subnet ID.
          * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
          * `shard_name`: Shard name.

        * `copy_schema`: Copying the data schema from a random replica of one of the shards to the hosts of the new shard. The possible values are `true` or `false`.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

     1. Run this query:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.clickhouse.v1.ClusterService.AddShard \
          < body.json
        ```

  1. View the [server response](../api-ref/grpc/Cluster/addShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note warning %}

Use the copy data schema option only if the schema is the same across all cluster shards.

{% endnote %}

## Getting a list of shards in a cluster {#list-shards}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of shards in a cluster, run this command:

  ```bash
  {{ yc-mdb-ch }} shards list --cluster-name=<cluster_name>
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListShards](../api-ref/Cluster/listShards.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/shards'
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/listShards.md#yandex.cloud.mdb.clickhouse.v1.ListClusterShardsResponse) to make sure your request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
               "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.ListShards
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/listShards.md#yandex.cloud.mdb.clickhouse.v1.ListClusterShardsResponse) to make sure your request was successful.

{% endlist %}

## Updating a shard {#shard-update}

You can edit the shard weight as well as the [host class](../concepts/instance-types.md), [disk type](../concepts/storage.md), and storage size.

{% note info %}

To change the disk type to `local-ssd`, contact [support]({{ link-console-support }}).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}** tab.
  1. Click ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update a shard in a cluster:

  1. View the description of the CLI command for updating a shard:

     ```bash
     {{ yc-mdb-ch }} shards update --help
     ```

  1. Provide the parameters you want to edit to the command:

     ```bash
     {{ yc-mdb-ch }} shards update <shard_name> \
       --cluster-name <cluster_name> \
       --weight <shard_weight> \
       --clickhouse-resource-preset <host_class> \
       --clickhouse-disk-size <storage_size> \
       --clickhouse-disk-type <disk_type>
     ```

     Where:

     * `--cluster-name`: Cluster name. You can get it with a [list of clusters in a folder](cluster-list.md#list-clusters).
     * `--weight`: Shard weight. The minimum value is `0`.
     * `--clickhouse-resource-preset`: [Host class](../concepts/instance-types.md).
     * `--clickhouse-disk-size`: Storage size, in GB.
     * `--clickhouse-disk-type`: [Disk type](../concepts/storage.md).

     You can get the shard name with a [list of shards in the cluster](#list-shards).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.UpdateShard](../api-ref/Cluster/updateShard.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/shards/<shard_name>' \
         --data '{
                   "updateMask": "configSpec.clickhouse.config.<{{ CH }}_setup>,configSpec.clickhouse.resources,configSpec.clickhouse.weight",
                   "configSpec": {
                     "clickhouse": {
                       "config": {
                         <{{ CH }}_settings>
                       },
                       "resources": {
                         "resourcePresetId": "<host_class>",
                         "diskSize": "<storage_size_in_bytes>",
                         "diskTypeId": "<disk_type>"
                       },
                       "weight": "<shard_weight>"
                     }
                   }
                 }'
     ```

     Where:

     * `updateMask`: Comma-separated list of settings you want to update.
     * `configSpec.clickhouse`: Shard parameters to update:

       * `config`: [{{ CH }} settings](../concepts/settings-list.md). For a list of available settings, see the [method description](../api-ref/Cluster/updateShard.md#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardRequest).

       * `resources`: Host resources to add to the new shard:

         * `resourcePresetId`: [Host class](../concepts/instance-types.md) ID. You can get the list of available host classes with their IDs using the [ResourcePreset.List](../api-ref/ResourcePreset/list.md) method.
         * `diskSize`: Disk size, in bytes.
         * `diskTypeId`: [Disk type](../concepts/storage.md).

       * `weight`: Shard weight.

         By default, each shard is assigned a weight of `1`. If you assign a greater value to a single shard, the data will be distributed among the shards according to their weights.

         To calculate the shard priority for data distribution, the system adds up the weights of all shards and then divides each shard's weight by the total. For example, if one shard has a weight of `1` and another has a weight of `3`, then the first shard's priority is `1/4` and the second shard's priority is `3/4`. The higher the priority, the more data the shard will get.

         For more information, see [this {{ CH }} guide]({{ ch.docs }}/engines/table-engines/special/distributed).

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the shard name, with the [list of shards in the cluster](#list-shards).

  1. View the [server response](../api-ref/Cluster/updateShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.UpdateShard](../api-ref/grpc/Cluster/updateShard.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "shard_name": "<shard_name>",
             "update_mask": {
               "paths": [
                 "config_spec.clickhouse.config.<{{ CH }}_setup>",
                 "config_spec.clickhouse.resources",
                 "config_spec.clickhouse.weight"
               ]
             },
             "config_spec": {
               "clickhouse": {
                 "config": {
                   <{{ CH }}_settings>
                 },
                 "resources": {
                   "resource_preset_id": "<host_class>",
                   "disk_size": "<storage_size_in_bytes>",
                   "disk_type_id": "<disk_type>"
                 },
                 "weight": "<shard_weight>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.UpdateShard
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).
     * `config_spec.clickhouse`: Shard parameters to update:

       * `config`: [{{ CH }} settings](../concepts/settings-list.md). For a list of available settings, see the [method description](../api-ref/Cluster/updateShard.md#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardRequest).

       * `resources`: Host resources to add to the new shard:

         * `resource_preset_id`: [Host class](../concepts/instance-types.md) ID. You can get the list of available host classes with their IDs using the [ResourcePreset.List](../api-ref/ResourcePreset/list.md) method.
         * `disk_size`: Disk size, in bytes.
         * `disk_type_id`: [Disk type](../concepts/storage.md).

       * `weight`: Shard weight.

         By default, each shard is assigned a weight of `1`. If you assign a greater value to a single shard, the data will be distributed among the shards according to their weights.

         To calculate the shard priority for data distribution, the system adds up the weights of all shards and then divides each shard's weight by the total. For example, if one shard has a weight of `1` and another has a weight of `3`, then the first shard's priority is `1/4` and the second shard's priority is `3/4`. The higher the priority, the more data the shard will get.

         For more information, see [this {{ CH }} guide]({{ ch.docs }}/engines/table-engines/special/distributed).

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the shard name, with the [list of shards in the cluster](#list-shards).

  1. View the [server response](../api-ref/grpc/Cluster/updateShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Deleting a shard {#delete-shard}

You can delete a shard from a {{ CH }} cluster in case:
* It is not the only shard.
* It is not the only shard in a [shard group](shard-groups.md).

Deleting a shard will delete all tables and data stored on that shard.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host row and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a shard from a cluster, run this command:

  ```bash
  {{ yc-mdb-ch }} shards delete <shard_name> \
    --cluster-name=<cluster_name>
  ```

  You can get the shard name with the [list of shards in the cluster](#list-shards), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     For information on how to create such a file, see [Creating a cluster](cluster-create.md).
  1. Remove the `host` section with the shard description from the {{ mch-name }} cluster description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.DeleteShard](../api-ref/Cluster/deleteShard.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/shards/<shard_name>'
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the shard name, with the [list of shards in the cluster](#list-shards).

  1. View the [server response](../api-ref/Cluster/deleteShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "shard_name": "<shard_name>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteShard
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the shard name, with the [list of shards in the cluster](#list-shards).

  1. View the [server response](../api-ref/grpc/Cluster/deleteShard.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
