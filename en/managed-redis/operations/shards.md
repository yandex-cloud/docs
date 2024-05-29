# Managing cluster shards

You can add and remove cluster shards, request a list of shards in the selected cluster, and rebalance your cluster.

{% note warning %}

You can only manage shards in sharded clusters. Existing non-sharded clusters can't be sharded later. To create a sharded cluster, see [Creating clusters](cluster-create.md#create-cluster).

{% endnote %}

## Listing shards in a cluster {#list}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Click the name of the cluster and select the **{{ ui-key.yacloud.redis.cluster.switch_shards }}** tab.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of shards in a cluster, run the following command:

   ```bash
   {{ yc-mdb-rd }} shards list --cluster-name <cluster_name>
   ```

   Result:

   ```text
   +--------------+
   |     NAME     |
   +--------------+
   | test-shard-1 |
   | test-shard-2 |
   | test-shard-3 |
   +--------------+
   ```

- API {#api}

   To get a list of cluster shards, use the [listShards](../api-ref/Cluster/listShards.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListShards](../api-ref/grpc/cluster_service.md#ListShards) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can request the cluster ID and name with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Getting detailed information about a shard {#get}

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a shard, run the following command:

   ```bash
   {{ yc-mdb-rd }} shards get <shard_name> --cluster-name <cluster_name>
   ```

- API {#api}

   To get shard details, use the [getShard](../api-ref/Cluster/getShard.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/GetShard](../api-ref/grpc/cluster_service.md#GetShard) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter.
   * Name of the shard you need in the `shardName` parameter.

{% endlist %}

You can request the shard name with a [list of cluster shards](#list) and the cluster name with a [list of clusters in a folder](cluster-list.md).

## Adding a shard {#add}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to add a shard to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Click the cluster name and go to the **{{ ui-key.yacloud.redis.cluster.switch_shards }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.shards.button_add }}**.
   1. Specify **{{ ui-key.yacloud.mdb.forms.base_field_shard-name }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**:
      * (Optional) Edit the host settings.
      * Click **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.
      * In the **{{ ui-key.yacloud.mdb.forms.host_column_zone }}** field, choose the availability zone, select **{{ ui-key.yacloud.mdb.forms.host_column_subnetwork }}**, and enable the **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}** option.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_create-shard }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   View a description of the CLI command for adding a shard:

   ```bash
   {{ yc-mdb-rd }} shards add --help
   ```

   To add to a cluster a shard of two hosts, one with public access and the other with a [host priority](../concepts/replication.md#master-failover) of `50`:

   ```bash
   {{ yc-mdb-rd }} shards add --name=<new_shard_name> \
      --cluster-name=<cluster_name> \
      --host zone-id=<availability_zone>,`
            `subnet-name=<subnet_name>,`
            `assign-public-ip=true \
      --host zone-id=<availability_zone>,`
            `subnet-name=<subnet_name>,`
            `replica-priority=50
   ```

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).
   1. Add the required number of `host` blocks to the {{ mrd-name }} cluster description and specify the shard name in the `shard_name` parameter:

      ```hcl
      resource "yandex_mdb_redis_cluster" "<cluster_name>" {
        ...
        host {
          zone             = "availability_zone>"
          subnet_id        = <subnet_ID>
          assign_public_ip = <public_access>
          replica_priority = <host_priority>
          shard_name       = "<shard_name>"
        }
      }
      ```

      Where `assign_public_ip` is public access to the host, `true` or `false`.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API {#api}

   To add a shard, use the [addShard](../api-ref/Cluster/addShard.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddShard](../api-ref/grpc/cluster_service.md#AddShard) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter.
   * Name of the shard in the `shardName` parameter.
   * Shard host configuration in the array of `hostSpecs` parameters.

   You can request the shard name with a [list of cluster shards](#list) and the cluster name with a [list of clusters in a folder](cluster-list.md).

{% endlist %}

To be able to place data in the new shard, start [rebalancing](#rebalance-cluster) the {{ mrd-name }} cluster.

## Deleting a shard {#remove}

{% note alert %}

All the shard hosts are deleted with the shard.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to delete the shard from.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.redis.cluster.switch_shards }}** tab.
   1. In the line of the appropriate shard, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.shards.button_action-remove }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.mdb.cluster.shards.popup-confirm_button_delete }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a shard from the cluster, run:

   ```bash
   {{ yc-mdb-rd }} shards delete <shard_name> \
     --cluster-name=<cluster_name>
   ```

   You can request the shard name with a [list of cluster shards](#list) and the cluster name with a [list of clusters in a folder](cluster-list.md).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).
   1. Delete all shard-related `host` sections from the {{ mrd-name }} cluster description.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type `yes` and press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API {#api}

   To delete a shard, use the [deleteShard](../api-ref/Cluster/deleteShard.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteShard](../api-ref/grpc/cluster_service.md#DeleteShard) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter.
   * Name of the shard to delete in the `shardName` parameter.

   You can request the shard name with a [list of cluster shards](#list) and the cluster name with a [list of clusters in a folder](cluster-list.md).

{% endlist %}

## Rebalancing a cluster {#rebalance-cluster}

New shards are created without hash slots and can't accept data. To begin populating a new shard with data, rebalance the cluster to allocate some of its hash slots to the new shard. The cluster will move the data in the reassigned hash slots to the appropriate shard. Rebalancing can be performed on a running cluster and does not affect data availability or integrity.

For more information, see [{#T}](../concepts/sharding.md#scaling).

{% list tabs group=instructions %}

- Management console {#console}

   To rebalance a cluster:
   1. In the [management console]({{ link-console-main }}), select the folder with the cluster in question.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Click the cluster name.
   1. In the **{{ ui-key.yacloud.common.overview }}** tab, click **{{ ui-key.yacloud.mdb.cluster.hosts.button_rebalance-cluster-short }}**.

   {% note tip %}

   You can also rebalance a cluster using the **{{ ui-key.yacloud.mdb.cluster.hosts.button_rebalance-cluster }}** button on the **{{ ui-key.yacloud.redis.cluster.switch_shards }}** tab.

   {% endnote %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To rebalance a cluster, run the command below:

   ```bash
   {{ yc-mdb-rd }} cluster rebalance \
     --name=<cluster_name>
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md).

- API {#api}

   To rebalance a cluster, use the [rebalance](../api-ref/Cluster/rebalance.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Rebalance](../api-ref/grpc/cluster_service.md#Rebalance) gRPC API call.

{% endlist %}