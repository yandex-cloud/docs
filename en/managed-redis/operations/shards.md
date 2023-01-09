# Managing cluster shards

You can add and remove cluster shards, request a list of shards in the selected cluster, and rebalance your cluster.

{% note warning %}

You can only manage shards in sharded clusters. Existing non-sharded clusters can't be sharded later. To create a sharded cluster, see [Creating clusters](cluster-create.md#create-cluster).

{% endnote %}

## Listing shards in a cluster {#list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the desired cluster.
   1. Select **{{ mrd-name }}**.
   1. Click the name of a cluster and open the **Shards** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of shards in a cluster, run the following command:

   ```bash
   {{ yc-mdb-rd }} shards list --cluster-name <cluster name>
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

- API

   Use the API [listShards](../api-ref/Cluster/listShards.md) method and pass the cluster ID in the `clusterId` parameter.

   You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Getting detailed information about a shard {#get}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a shard, run the following command:

   ```bash
   {{ yc-mdb-rd }} shards get <shard name> --cluster-name <cluster name>
   ```

- API

   Use the [getShard](../api-ref/Cluster/getShard.md) API method and pass the following in the request:
   * The cluster ID in the `clusterId` parameter.
   * In the `shardName` parameter, the name of the shard.

{% endlist %}

You can request the shard name with a [list of cluster shards](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md).

## Adding a shard {#add}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to add a shard to.
   1. Select **{{ mrd-name }}**.
   1. Click on the name of the cluster and go to the **Shards** tab.
   1. Click **Add shard**.
   1. Enter the **Shard name**.
   1. Under **Hosts**:
      * (optional) Edit the host settings.
      * Click **Add host**.
      * In the window that opens, select the **Availability zone** and **Subnet**, and enable the **Public access** option.
      * Click **Save**.
   1. Click **Create shard**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   View a description of the CLI command for adding a shard:

   ```bash
   {{ yc-mdb-rd }} shards add --help
   ```

   To add to a cluster a shard of two hosts, one with public access and the other with a [host priority](../concepts/replication.md#master-failover) of `50`:

   ```bash
   {{ yc-mdb-rd }} shards add --name=<new shard name> \
      --cluster-name=<cluster name> \
      --host zone-id=<availability zone>,`
            `subnet-name=<subnet name>,`
            `assign-public-ip=true \
      --host zone-id=<availability zone>,`
            `subnet-name=<subnet name>,`
            `replica-priority=50
   ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Add the required number of `host` blocks to the {{ mrd-name }} cluster description and specify the shard name in the `shard_name` parameter:

      ```hcl
      resource "yandex_mdb_redis_cluster" "<cluster name>" {
        ...
        host {
          zone             = "<availability zone>"
          subnet_id        = <subnet ID>
          assign_public_ip = <public host access: true or false>
          replica_priority = <host priority>
          shard_name       = "<shard name>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   Use the [addShard](../api-ref/Cluster/addShard.md) API method and pass the following in the request:
   * The cluster ID in the `clusterId` parameter.
   * In the `shardName` parameter, the name of the shard.
   * In the array of `hostSpecs` parameters, the shard host configuration.

   You can request the shard name with a [list of cluster shards](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

To be able to place data in the new shard, start [rebalancing](#rebalance-cluster) the {{ mrd-name }} cluster.

## Deleting a shard {#remove}

{% note alert %}

All the shard hosts are deleted with the shard.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to delete the shard from.
   1. Select **{{ mrd-name }}**.
   1. Click on the name of a cluster and open the **Shards** tab.
   1. In the line of the appropriate shard, click ![image](../../_assets/options.svg) and select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a shard from the cluster, run:

   ```bash
   {{ yc-mdb-rd }} shards delete <shard name> \
      --cluster-name=<cluster name>
   ```

   You can request the shard name with a [list of cluster shards](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).
   1. Delete all shard-related `host` blocks from the {{ mrd-name }} cluster description.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type the word `yes`, then press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   Use the [deleteShard](../api-ref/Cluster/deleteShard.md) API method and pass the following in the request:
   * The cluster ID in the `clusterId` parameter.
   * In the `shardName` parameter, the name of the shard to delete.

   You can request the shard name with a [list of cluster shards](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

## Rebalancing a cluster {#rebalance-cluster}

New shards are created without hash slots and can't accept data. To begin populating a new shard with data, rebalance the cluster to allocate some of its hash slots to the new shard. The cluster will move the data in the reassigned hash slots to the appropriate shard. Rebalancing can be performed on a running cluster and does not affect data availability or integrity.

For more information, see [{#T}](../concepts/sharding.md#scaling).

{% list tabs %}

- Management console

   To rebalance a cluster:
   1. In the [management console]({{ link-console-main }}), select the folder with the cluster in question.
   1. Select **{{ mrd-name }}**.
   1. Click on the name of the desired cluster.
   1. On the **Overview** tab, click **Rebalance**.

   {% note tip %}

   You can also rebalance a cluster using the **Rebalance cluster** button on the **Shards** tab.

   {% endnote %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To rebalance a cluster, run the command below:

   ```bash
   {{ yc-mdb-rd }} cluster rebalance \
     --name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

- API

   You can rebalance a cluster using the [rebalance](../api-ref/Cluster/rebalance.md) method.

{% endlist %}