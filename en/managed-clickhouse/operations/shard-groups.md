# Managing shards in a {{ CH }} cluster

You can group several [shards](../concepts/sharding.md) of a {{ CH }} cluster in a _shard group_ and save tables in this group.

## Listing shard groups in a cluster {#list-shard-groups}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster and open the **Shard groups** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of shard groups in a cluster, run the command:

   ```bash
   {{ yc-mdb-ch }} shard-groups list \
      --cluster-name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of shard groups in a cluster, use the [listShardGroups](../api-ref/Cluster/listShardGroups.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListShardGroups](../api-ref/grpc/cluster_service.md#ListShardGroups) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Viewing detailed information about a shard group {#get-shard-group}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster and open the **Shard groups** tab.
   1. Select a shard group to view detailed information.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To view detailed information about a shard group in a cluster, run the command:

   ```bash
   {{ yc-mdb-ch }} shard-groups get \
      --cluster-name=<cluster name> \
      --name=<shard group name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get detailed information about a shard group, use the [getShardGroup](../api-ref/Cluster/getShardGroup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/GetShardGroup](../api-ref/grpc/cluster_service.md#GetShardGroup) gRPC API call and provide the following in the request:
   * The cluster ID, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Name of the shard group, in the `shardGroupName` parameter. To find out the name, [get a list of shard groups](#list-shard-groups) in the cluster.

{% endlist %}

## Creating a shard group {#create-shard-group}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster and open the **Shard groups** tab.
   1. Click **Create shard group**.
   1. Fill in the form fields and click **Apply**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a shard group in a cluster, run the command:

   ```bash
   {{ yc-mdb-ch }} shard-groups create \
      --cluster-name=<cluster name> \
      --name=<shard group name> \
      --description=<shard group description> \
      --shards=<names of shards to include in the group>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

   Shard names can be requested with a [list of shards in the cluster](shards.md#list-shards).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).
   1. Add a `shard_group` description block to the {{ mch-name }} cluster description.

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        shard_group {
          name        = "<shard group name>"
          description = "<optional shard group description>"
          shard_names = [
            # List of shards in the group
            "<name of shard 1>",
            ...
            "<shard name N>"
          ]
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To create a shard group, use the [createShardGroup](../api-ref/Cluster/createShardGroup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/CreateShardGroup](../api-ref/grpc/cluster_service.md#CreateShardGroup) gRPC API call and provide the following in the request:
   * The ID of the cluster where you want to create a group, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Name of the shard group, in the `shardGroupName` parameter.
   * A list of shard names to include in the group, in the `shardNames` parameter. To find out the names, [get a list of shards](shards.md#list-shards) in the cluster.
   * If necessary, a description of the shard group, in the `description` parameter.

{% endlist %}

## Changing a shard group {#update-shard-group}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster and open the **Shard groups** tab.
   1. Click ![image](../../_assets/options.svg) for the desired shard group and select **Edit**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change a shard group in a cluster, run the command:

   ```bash
   {{ yc-mdb-ch }} shard-groups update \
      --cluster-name=<cluster name> \
      --name=<shard group name> \
      --description=<new shard group description> \
      --shards=<new list of shards to include in the group>
   ```

   This command replaces the existing list of shards in the group with the new one that was passed to the command in the `--shards` parameter. Before running the command, make sure that you added all the appropriate shards in the new list.

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

   You can request the name of the shard group with a [list of shard groups in the cluster](#list-shard-groups).

   Shard names can be requested with a [list of shards in the cluster](shards.md#list-shards).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).
   1. In the {{ mch-name }} cluster description, change the `shard_group` block to the required shard group:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        shard_group {
          name        = "<new shard group name>"
          description = "<new shard group description>"
          shard_names = [
            # New list of shards in the group
            "<name of shard 1>",
            ...
            "<shard name N>"
          ]
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To update a shard group, use the [updateShardGroup](../api-ref/Cluster/updateShardGroup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/UpdateShardGroup](../api-ref/grpc/cluster_service.md#UpdateShardGroup) gRPC API call and provide the following in the request:
   * The ID of the cluster where you want to change a group, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Name of the shard group, in the `shardGroupName` parameter. To find out the name, [get a list of shard groups](#list-shard-groups) in the cluster.
   * If necessary, a new description of the shard group, in the `description` parameter.
   * If necessary, a new list of shard names to be included in the group, in the `shardNames` parameter. To find out the names, [get a list of shards](shards.md#list-shards) in the cluster. This list will replace the current one, so make sure that you added all the appropriate shards in the new list.
   * Names of parameters to change, in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a group of shards {#delete-shard-group}

Deleting a group of shards doesn't affect the shards in the group: they are kept in the cluster.

Tables created on the deleted group are kept, but they are disabled and attempts to query them result in errors. However, you can delete these tables before or after you delete the shard group.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster and open the **Shard groups** tab.
   1. Click ![image](../../_assets/options.svg) for the desired shard group and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a shard group in a cluster, run the command:

   ```bash
   {{ yc-mdb-ch }} shard-groups delete \
      --cluster-name=<cluster name> \
      --name=<shard group name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

   You can request the name of the shard group with a [list of shard groups in the cluster](#list-shard-groups).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).
   1. Delete the `shard_group` block describing the required group from the {{ mch-name }} cluster description.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type `yes` and press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To delete a shard group, use the [deleteShardGroup](../api-ref/Cluster/deleteShardGroup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteShardGroup](../api-ref/grpc/cluster_service.md#DeleteShardGroup) gRPC API call and provide the following in the request:
   * The ID of the cluster where you want to delete a group from, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Name of the shard group, in the `shardGroupName` parameter. To find out the name, [get a list of shard groups](#list-shard-groups) in the cluster.

{% endlist %}