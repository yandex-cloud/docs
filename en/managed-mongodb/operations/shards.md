# Managing shards

You can enable [sharding](../concepts/sharding.md) for clusters as well as add and configure individual shards.

{% note alert %}

After [cluster sharding](../concepts/sharding.md) is enabled:

- You can't disable sharding: the cluster will always maintain a minimum number of `MONGOS`, `MONGOCFG`, or `MONGOINFRA` hosts depending on the [sharding type](../concepts/sharding.md#shard-management).
- For accessing the databases, only use the `MONGOS` or `MONGOINFRA` hosts that route queries to shards. For this purpose, edit host addresses in your application code accordingly.

{% endnote %}

Make sure that your shards consist of at least 3 hosts to ensure higher availability. We don't recommend sharding small collections: query processing is faster with a standard replica cluster.

## Enabling sharding {#enable}

The {{ mmg-name }} interface lets you quickly create a [{{ MG }} sharding infrastructure](../concepts/sharding.md#shard-management).

To learn how to directly shard your {{ MG }} database and collections, see [{#T}](../tutorials/sharding.md).

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ mmg-name }}**.

    1. Click the name of a cluster and open the **Shards** tab.

        {% note info %}

         Sharding is [not supported](../concepts/sharding.md#shard-management) for hosts with the classes **b1.nano**, **b1.micro**, **b1.medium**, **b2.nano**, **b2.micro**, or **b2.medium**. If you don't see the **Shards** tab, [increase the cluster host class](update.md#change-resource-preset) to the supported value.

        {% endnote %}

    1. Click **Enable**.

    1. Select a sharding type:

       - **Standard**: Using a `MONGOINFRA` host.
          To ensure continuous access to data, {{ mmg-name }} requires at least three `MONGOINFRA` hosts.

       - **Advanced**: Using `MONGOS` and `MONGOCFG` hosts.
          To ensure continuous access to data, {{ mmg-name }} requires at least two `MONGOS` hosts and at least three `MONGOCFG` hosts.

          For more information, see [{#T}](../concepts/sharding.md).

       {% note warning %}

       After you enable sharding, you can't change its type.

       {% endnote %}

    1. Set the parameters of the hosts that will provide access to the sharded data.

    1. Click **Enable sharding**.

    The cluster will start updating, with the requested hosts and first shard of the cluster created.

- API

    You can enable sharding for the cluster using the [enableSharding](../api-ref/Cluster/enableSharding.md) method.

{% endlist %}

## Listing shards in a cluster {#list-shards}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.

  1. Click the name of a cluster and open the **Shards** tab.

- API

  To list the shards in a cluster, use the [listShards](../api-ref/Cluster/listShards.md) method.

{% endlist %}

## Adding a shard {#add-shard}

The number of shards in {{ mmg-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find the **{{ mmg-full-name }}** block.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Click on the name of the cluster you need and go to the **Hosts** tab.
  1. Click **Add shard**.
  1. Enter a name for the shard and add the desired number of hosts.
  1. Click **Create shard**.

- API

  To add a host to the cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) method.

{% endlist %}

## Deleting a shard {#delete-shard}

You can delete a shard from a {{ MG }} cluster provided that it's not the only shard in it. To replace the only shard in a cluster, first create a new shard and then remove the old one.

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.

  1. Click on the name of a cluster and open the **Shards** tab.

  1. Click ![image](../../_assets/horizontal-ellipsis.svg) in the line of the desired host and select **Delete**.

- API

  Use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) method to delete a host.

{% endlist %}
