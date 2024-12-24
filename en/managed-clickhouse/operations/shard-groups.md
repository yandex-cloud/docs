# Managing shards in a {{ CH }} cluster

You can group several [shards](../concepts/sharding.md) of a {{ CH }} cluster in a _shard group_ and save tables in this group.

## Listing shard groups in a cluster {#list-shard-groups}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of shard groups in a cluster, run the command:

  ```bash
  {{ yc-mdb-ch }} shard-groups list \
     --cluster-name=<cluster_name>
  ```

  You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.ListShardGroups](../api-ref/Cluster/listShardGroups.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/shardGroups'
     ```

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/listShardGroups.md#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.ListShardGroups](../api-ref/grpc/Cluster/listShardGroups.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/listShardGroups.md#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse) to make sure the request was successful.

{% endlist %}

## Viewing detailed information about a shard group {#get-shard-group}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}** tab.
  1. Select a shard group to view detailed information.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To view detailed information about a shard group in a cluster, run the command:

  ```bash
  {{ yc-mdb-ch }} shard-groups get \
    --cluster-name=<cluster_name> \
    --name=<shard_group_name>
  ```

  You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.GetShardGroup](../api-ref/Cluster/getShardGroup.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/shardGroups/<shard_group_name>'
     ```

     You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the shard group name with a [list of groups in the cluster](#list-shard-groups).

  1. View the [server response](../api-ref/Cluster/getShardGroup.md#yandex.cloud.mdb.clickhouse.v1.ShardGroup) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.GetShardGroup](../api-ref/grpc/Cluster/getShardGroup.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

     You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the shard group name with a [list of groups in the cluster](#list-shard-groups).

  1. View the [server response](../api-ref/grpc/Cluster/getShardGroup.md#yandex.cloud.mdb.clickhouse.v1.ShardGroup) to make sure the request was successful.

{% endlist %}

## Creating a shard group {#create-shard-group}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.shard-groups.button_add-group }}**.
  1. Fill in the form fields and click **{{ ui-key.yacloud.common.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a shard group in a cluster, run the command:

  ```bash
  {{ yc-mdb-ch }} shard-groups create \
    --cluster-name=<cluster_name> \
    --name=<shard_group_name> \
    --description=<shard_group_description> \
    --shards=<list_of_shard_names>
  ```

  Where `--shards` is the list of list of shard names to include in the group.

  You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

  You can request a shard name with a [list of shards in the cluster](shards.md#list-shards).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Add the `shard_group` description section to the {{ mch-name }} cluster description.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
       ...
       shard_group {
         name        = "<shard_group_name>"
         description = "<optional_shard_group_description>"
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

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.CreateShardGroup](../api-ref/Cluster/createShardGroup.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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
     * `shardNames`: List of shards to include into the new group.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/createShardGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.CreateShardGroup](../api-ref/grpc/Cluster/createShardGroup.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
     * `shard_names`: List of shards to include into the new group.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/createShardGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing a shard group {#update-shard-group}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the shard group you need and select **{{ ui-key.yacloud.common.edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change a shard group in a cluster, run the command:

  ```bash
  {{ yc-mdb-ch }} shard-groups update \
    --cluster-name=<cluster_name> \
    --name=<shard_group_name> \
    --description=<new_description_for_shard_group> \
    --shards=<new_list_of_shard_names>
  ```

  Where `--shards` is the new list of shard names to include in the group.

  This command replaces the existing list of shards in the group with the new one provided in the `--shards` parameter. Before running the command, make sure that you have added all the required shards to the new list.

  You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

  You can request the name of the shard group with a [list of shard groups in the cluster](#list-shard-groups).

  You can request a shard name with a [list of shards in the cluster](shards.md#list-shards).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. In the {{ mch-name }} cluster description, change the `shard_group` section to include the required shard group:

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

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.updateShardGroup](../api-ref/Cluster/updateShardGroup.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

     * `updateMask`: List of parameters to update as a single string, separated by commas.
     * `description`: New description of the shard group.
     * `shardNames`: New list of shards to include in the group. To learn shard names, get a [list of shards](shards.md#list-shards) in the cluster. This list will replace the current one, so make sure you have added all the required shards to the new list.

     You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the shard group name with a [list of groups in the cluster](#list-shard-groups).

  1. View the [server response](../api-ref/Cluster/updateShardGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.UpdateShardGroup](../api-ref/grpc/Cluster/updateShardGroup.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.
     * `description`: New description of the shard group.
     * `shard_names`: New list of shards to include in the group. To learn shard names, get a [list of shards](shards.md#list-shards) in the cluster. This list will replace the current one, so make sure you have added all the required shards to the new list.

     You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the shard group name with a [list of groups in the cluster](#list-shard-groups).

  1. View the [server response](../api-ref/grpc/Cluster/updateShardGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Deleting a group of shards {#delete-shard-group}

Deleting a group of shards doesn't affect the shards in the group: they are kept in the cluster.

Tables created on the deleted group are kept, but they are disabled and attempts to query them result in errors. However, you can delete these tables before or after you delete the shard group.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_shard-groups }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the shard group you need and select **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a shard group in a cluster, run the command:

  ```bash
  {{ yc-mdb-ch }} shard-groups delete \
     --cluster-name=<cluster_name> \
     --name=<shard_group_name>
  ```

  You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

  You can request the name of the shard group with a [list of shard groups in the cluster](#list-shard-groups).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Delete the `shard_group` description section for the appropriate group from the {{ mch-name }} cluster description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.DeleteShardGroup](../api-ref/Cluster/deleteShardGroup.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/shardGroups/<shard_group_name>'
     ```

     You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the shard group name with a [list of groups in the cluster](#list-shard-groups).

  1. View the [server response](../api-ref/Cluster/deleteShardGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.DeleteShardGroup](../api-ref/grpc/Cluster/deleteShardGroup.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

     You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the shard group name with a [list of groups in the cluster](#list-shard-groups).

  1. View the [server response](../api-ref/grpc/Cluster/deleteShardGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}