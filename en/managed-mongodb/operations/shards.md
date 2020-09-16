# How to manage shards

You can enable sharding for clusters that have {{ MG }} version 4.0 or higher. You can also add and configure individual shards.

{% note alert %}

Once sharding is enabled, the only right way to access the database is over the mongos hosts that store and update shard data. Don't forget to change the host addresses in your app code.

{% endnote %}

Make sure that your shards consist of at least 3 hosts to ensure higher availability. We don't recommend sharding small collections: query processing is faster with a standard replica cluster.

## Enable sharding {#enable}

Using the {{ mmg-name }} interface, you can quickly create a {{ MG }} sharding infrastructure: the mongos and mongocfg hosts needed to run the sharded database.

To learn how to directly shard your {{ MG }} database and collections, see [{#T}](../tutorials/sharding.md).

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.

  1. Click the name of a cluster and open the **Shards** tab.

  1. Click **Enable**.

  1. Configure the mongocfg and mongos hosts that should provide access to the sharded data.

     To ensure continuous access to your data, {{ mmg-name }} lets you create at least 3 mongocfg hosts and 2 mongos hosts.

  1. Click **Enable sharding**.

  The cluster update starts. This operation creates the requested mongocfg and mongos hosts as well as the first shard of the cluster.

- API

  You can enable sharding for the cluster using the [enableSharding](../api-ref/Cluster/enableSharding.md) method.

{% endlist %}

## List shards in a cluster {#list-shards}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.

  1. Click the name of a cluster and open the **Shards** tab.

- API

  To list the shards in a cluster, use the [listShards](../api-ref/Cluster/listShards.md) method.

{% endlist %}

## Add a shard {#add-shard}

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

## Delete a shard {#delete-shard}

You can delete a shard from a {{ MG }} cluster provided that it's not the only shard in it. To replace the only shard in a cluster, first create a new shard and then remove the old one.

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.

  1. Click on the name of a cluster and open the **Shards** tab.

  1. Click ![image](../../_assets/horizontal-ellipsis.svg) in the line of the desired host and select **Delete**.

- API

  Use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) method to delete a host.

{% endlist %}

