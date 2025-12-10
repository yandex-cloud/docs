# Managing shard groups in a {{ CH }} cluster

You can arrange several [shards](../concepts/sharding.md) of a {{ CH }} cluster into a _shard group_ and then place tables in that group.

## Getting a list of shard groups in a cluster {#list-shard-groups}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of shard groups in a cluster, run this command:

  ```bash
  {{ yc-mdb-ch }} shard-groups list \
     --cluster-name=<cluster_name>
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListShardGroups](../api-ref/Cluster/listShardGroups.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/shardGroups'
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/listShardGroups.md#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.ListShardGroups](../api-ref/grpc/Cluster/listShardGroups.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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
       yandex.cloud.mdb.clickhouse.v1.ClusterService.ListShardGroups
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/listShardGroups.md#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse) to make sure your request was successful.

{% endlist %}

## Getting detailed information about a shard group {#get-shard-group}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}** tab.
  1. Select a shard group to view detailed information.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To view detailed information about a shard group in a cluster, run this command:

  ```bash
  {{ yc-mdb-ch }} shard-groups get \
    --cluster-name=<cluster_name> \
    --name=<shard_group_name>
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.GetShardGroup](../api-ref/Cluster/getShardGroup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/shardGroups/<shard_group_name>'
     ```

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters), and the shard group name, with a [list of groups in the cluster](#list-shard-groups).

  1. View the [server response](../api-ref/Cluster/getShardGroup.md#yandex.cloud.mdb.clickhouse.v1.ShardGroup) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.GetShardGroup](../api-ref/grpc/Cluster/getShardGroup.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "shard_group_name": "<shard_group_name>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.GetShardGroup
     ```

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters), and the shard group name, with a [list of groups in the cluster](#list-shard-groups).

  1. View the [server response](../api-ref/grpc/Cluster/getShardGroup.md#yandex.cloud.mdb.clickhouse.v1.ShardGroup) to make sure your request was successful.

{% endlist %}

## Creating a shard group {#create-shard-group}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.shard-groups.button_add-group }}**.
  1. Fill in the form fields and click **{{ ui-key.yacloud.common.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a shard group in a cluster, run this command:

  ```bash
  {{ yc-mdb-ch }} shard-groups create \
    --cluster-name=<cluster_name> \
    --name=<shard_group_name> \
    --description=<shard_group_description> \
    --shards=<list_of_shard_names>
  ```

  Where `--shards` is the list of shard names to include in the group.

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

  You can get the shard names with a [list of shards in the cluster](shards.md#list-shards).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     Learn how to create this file in [Creating a cluster](cluster-create.md).
  1. Add the `shard_group` section to the {{ mch-name }} cluster description.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
       ...
       shard_group {
         name        = "<shard_group_name>"
         description = "<optional_description_for_shard_group>"
         shard_names = [
           # List of shards in the group
           "<shard_1_name>",
           ...
           "<shard_N_name>"
         ]
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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.CreateShardGroup](../api-ref/Cluster/createShardGroup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/shardGroups' \
       --data '{
                 "shardGroupName": "<shard_group_name>",
                 "description": "<shard_group_description>",
                 "shardNames": [
                   "<shard_1>", "<shard_2>", ... "<shard_N>"
                 ]
               }'
     ```

     Where:

     * `shardGroupName`: Shard group name.
     * `description`: Shard group description.
     * `shardNames`: List of shards to include in the new group.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/createShardGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.CreateShardGroup](../api-ref/grpc/Cluster/createShardGroup.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
               "cluster_id": "<cluster_ID>",
               "shard_group_name": "<shard_group_name>",
               "description": "<shard_group_description>",
               "shard_names": [
                 "<shard_1>", "<shard_2>", ... "<shard_N>"
               ]
             }' \
         {{ api-host-mdb }}:{{ port-https }} \
         yandex.cloud.mdb.clickhouse.v1.ClusterService.CreateShardGroup
     ```

     Where:

     * `shard_group_name`: Shard group name.
     * `description`: Shard group description.
     * `shard_names`: List of shards to include in the new group.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/createShardGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Updating a shard group {#update-shard-group}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the shard group in question and select **{{ ui-key.yacloud.common.edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update a shard group in a cluster, run this command:

  ```bash
  {{ yc-mdb-ch }} shard-groups update \
    --cluster-name=<cluster_name> \
    --name=<shard_group_name> \
    --description=<new_description_for_shard_group> \
    --shards=<new_list_of_shard_names>
  ```

  Where `--shards` is the new list of shard names to include in the group.

  This command replaces the existing list of shards in the group with the new one provided in the `--shards` parameter. Before running the command, make sure you have added all the required shards to the new list.

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

  You can get the shard group name with a [list of shard groups in the cluster](#list-shard-groups).

  You can get the shard names with a [list of shards in the cluster](shards.md#list-shards).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     Learn how to create this file in [Creating a cluster](cluster-create.md).
  1. In the {{ mch-name }} cluster description, update the `shard_group` section for the shard group you need:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
       ...
       shard_group {
         name        = "<new_name_for_shard_group>"
         description = "<new_description_for_shard_group>"
         shard_names = [
           # New list of shards in the group
           "<shard_1_name>",
           ...
           "<shard_N_name>"
         ]
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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.updateShardGroup](../api-ref/Cluster/updateShardGroup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/shardGroups/<shard_group_name>' \
       --data '{
                 "updateMask": "description,shardNames",
                 "description": "<shard_group_description>",
                 "shardNames": [
                   "<shard_1>", "<shard_2>", ... "<shard_N>"
                 ]
               }'
     ```

     Where:

     * `updateMask`: Comma-separated string of settings you want to update.
     * `description`: New description for the shard group.
     * `shardNames`: New list of shards to include in the group. To learn shard names, get a [list of shards](shards.md#list-shards) in the cluster. This list will replace the current one, so make sure you have added all the required shards to the new list.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters), and the shard group name, with a [list of groups in the cluster](#list-shard-groups).

  1. View the [server response](../api-ref/Cluster/updateShardGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.UpdateShardGroup](../api-ref/grpc/Cluster/updateShardGroup.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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
             "shard_group_name": "<shard_group_name>",
             "update_mask": {
               "paths": [
                 "description", "shard_names"
               ]
             },
             "description": "<shard_group_description>",
             "shard_names": [
               "<shard_1>", "<shard_2>", ... "<shard_N>"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.UpdateShardGroup
     ```

     Where:

     * `update_mask`: List of settings to update as an array of strings (`paths[]`).
     * `description`: New description for the shard group.
     * `shard_names`: New list of shards to include in the group. To learn shard names, get a [list of shards](shards.md#list-shards) in the cluster. This list will replace the current one, so make sure you have added all the required shards to the new list.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters), and the shard group name, with a [list of groups in the cluster](#list-shard-groups).

  1. View the [server response](../api-ref/grpc/Cluster/updateShardGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Deleting a shard group {#delete-shard-group}

Deleting a shard group does not affect the shards it contains, i.e., they remain in the cluster.

Tables created on the deleted group remain but become unusable: any attempts to query them will return errors. However, you can delete these tables before or after deleting the shard group.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the shard group in question and select **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a shard group in a cluster, run this command:

  ```bash
  {{ yc-mdb-ch }} shard-groups delete \
     --cluster-name=<cluster_name> \
     --name=<shard_group_name>
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

  You can get the shard group name with a [list of shard groups in the cluster](#list-shard-groups).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     Learn how to create this file in [Creating a cluster](cluster-create.md).
  1. Delete the `shard_group` section for the appropriate group from the {{ mch-name }} cluster description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.DeleteShardGroup](../api-ref/Cluster/deleteShardGroup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/shardGroups/<shard_group_name>'
     ```

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters), and the shard group name, with a [list of groups in the cluster](#list-shard-groups).

  1. View the [server response](../api-ref/Cluster/deleteShardGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.DeleteShardGroup](../api-ref/grpc/Cluster/deleteShardGroup.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "shard_group_name": "<shard_group_name>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteShardGroup
     ```

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters), and the shard group name, with a [list of groups in the cluster](#list-shard-groups).

  1. View the [server response](../api-ref/grpc/Cluster/deleteShardGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
