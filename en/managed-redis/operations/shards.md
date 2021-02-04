# Managing cluster shards

You can add and remove cluster shards, request a list of shards in your cluster, and rebalance your cluster.

{% note warning %}

You can only manage shards in sharded clusters. Existing non-sharded clusters can't be sharded later. To create a sharded cluster, see [Creating clusters](cluster-create.md#create-cluster).

{% endnote %}

## List shards in a cluster {#list}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mrd-name }}**.

  1. Click the name of a cluster and open the **Shards** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of databases in a cluster, run the command:

  ```
  $ yc managed-redis shards list --cluster-name <cluster name>
  +--------------+
  |     NAME     |
  +--------------+
  | test-shard-1 |
  | test-shard-2 |
  | test-shard-3 |
  | test-shard-4 |
  | test-shard-5 |
  +--------------+
  ```

{% endlist %}

## Getting detailed information about a shard {#get}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

To get information about a shard, run the following command:

```
$ {{ yc-mdb-rd }} shards get <shard name> --cluster-name <cluster name>
```

The cluster name and ID can be requested with a [list of clusters in the folder](cluster-list.md).

## Add a shard {#add}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mrd-name }}**.

  1. Click on the name of the cluster and go to the **Shards** tab.

  1. Click **Add shard**.

  1. Specify the shard parameters:
      * Name of the shard.
      * Availability zones.
      * Add more hosts to the shard if needed.

  1. Click **Create shard**.

  After adding a new shard, you must [rebalance your cluster](../concepts/sharding.md#scaling):
  1. Wait until the cluster status changes to `Running`.
  1. Open the **Hosts** tab and click **Rebalance cluster**. Click **OK**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add a two-host shard to the cluster:

  ```
  $ yc managed-redis shards add --name <name of the new shard> --cluster-name <cluster name> \
    --host zone-id=<availability zone>,subnet-name=<subnet name> \
    --host zone-id=<availability zone>,subnet-name=<subnet name>
  ```

  After adding a new shard, you must rebalance your cluster:

  ```
  $ yc managed-redis cluster --cluster-name test-sharding-2 rebalance 
  ```

{% endlist %}

## Delete a shard {#remove}

{% note alert %}

All the shard hosts are deleted with the shard.

{% endnote %}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mrd-name }}**.

  1. Click on the name of a cluster and open the **Shards** tab.

  1. Click ![image](../../_assets/options.svg) in the row of the shard, then click **Delete** in the menu that opens.

  1. In the window that opens, click **Delete**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a shard from the cluster, run:

  ```
  $ {{ yc-mdb-rd }} shards delete <shard name>
       --cluster-name=<cluster name>
  ```

  The shard name can be requested with a [list of cluster shards](#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md).

{% endlist %}

