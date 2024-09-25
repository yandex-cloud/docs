# Managing shards in a {{ CH }} cluster

You can enable sharding for a cluster as well as add and configure individual shards.

## Enabling sharding {#enable}

{{ mch-name }} clusters are created with one shard. To start sharding data, [add](#add-shard) one or more shards and [create](../tutorials/sharding.md#example) a distributed table.

## Creating a shard {#add-shard}

The number of shards in {{ mch-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources currently in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}**.
  1. Specify the shard parameters:
     * Name and weight
     * To copy the schema from a random replica of one of the shards to the hosts of the new shard, select the **{{ ui-key.yacloud.mdb.forms.field_copy_schema }}** option.
     * Required number of hosts
  1. Click **{{ ui-key.yacloud.mdb.forms.button_create-shard }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a shard, run the command below (not all the supported parameters are listed):

  ```bash
  {{ yc-mdb-ch }} shards add <new_shard_name> \
    --cluster-name=<cluster_name> \
    --host zone-id=<availability_zone>,`
      `subnet-name=<subnet_name>
  ```

  Where:

  
  * `<new_shard_name>`: Must be unique within the cluster.

    It may contain Latin letters, numbers, hyphens, and underscores. The maximum length is 63 characters.
  * `--cluster-name`: Cluster name.

    You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).
  * `--host`: Host parameters:
    * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
    * `subnet-name`: Name of the [subnet](../../vpc/concepts/network.md#subnet).


- {{ TF }} {#tf}

  {% note info %}

  {{ TF }} does not allow specifying shard weight.

  {% endnote %}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Add the `CLICKHOUSE` type `host` block with the `shard_name` field filled to the {{ mch-name }} cluster description or change existing hosts:

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

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

  To create a shard, use the [addShard](../api-ref/Cluster/addShard.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddShard](../api-ref/grpc/cluster_service.md#AddShard) gRPC API call.

  To copy the data schema from a random replica of one of the shards to the hosts of the new shard, include the `copySchema` parameter set to `true` in the request.

{% endlist %}

{% note warning %}

Use the copy data schema option only if the schema is the same on all cluster shards.

{% endnote %}

## Listing shards in a cluster {#list-shards}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of shards in a cluster, run the following command:

  ```bash
  {{ yc-mdb-ch }} shards list --cluster-name=<cluster_name>
  ```

  You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

  To get a list of cluster shards, use the [listShards](../api-ref/Cluster/listShards.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListShards](../api-ref/grpc/cluster_service.md#ListShards) gRPC API call.

{% endlist %}

## Changing a shard {#shard-update}

You can change the shard weight as well as [host class](../concepts/instance-types.md) and storage size.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}** tab.
  1. Click ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change a shard in the cluster:
  1. View a description of the CLI's shard change command:

     ```bash
     {{ yc-mdb-ch }} shards update --help
     ```

  1. Start an operation, e.g., changing shard weight:

     ```bash
     {{ yc-mdb-ch }} shards update <shard_name> \
       --cluster-name=<cluster_name> \
       --weight=<shard_weight>
     ```

     Where:
     * `<shard_name>`: Can be requested with a [list of shards in the cluster](#list-shards).
     * `--cluster-name`: Cluster name.

       You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).
     * `--weight`: Shard weight. The minimum value is `0`.

     When the operation is complete, the CLI displays information about the changed shard.

- API {#api}

  To update a shard, use the [updateShard](../api-ref/Cluster/updateShard.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/UpdateShard](../api-ref/grpc/cluster_service.md#UpdateShard) gRPC API call and provide the following in the request:
  * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * Shard name in the `shardName` parameter.
  * Shard settings in the `configSpec` parameter.
  * List of settings to update, in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a shard {#delete-shard}

You can delete a shard from a {{ CH }} cluster in case:
* It is not the only shard.
* It is not the only shard in a [shard group](shard-groups.md).

When you delete a shard, all tables and data that are saved on that shard are deleted.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_shards }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host row and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a shard from the cluster, run:

  ```bash
  {{ yc-mdb-ch }} shards delete <shard_name> \
    --cluster-name=<cluster_name>
  ```

  You can request the shard name with a [list of cluster shards](#list-shards) and the cluster name with a [list of clusters in a folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Remove the `host` section with the shard description from the {{ mch-name }} cluster description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

  To delete a shard, use the [deleteShard](../api-ref/Cluster/deleteShard.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteShard](../api-ref/grpc/cluster_service.md#DeleteShard) gRPC API call.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}