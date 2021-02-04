# How to manage shards

You can enable sharding for a cluster as well as add and configure individual shards.

## Enable sharding {#enable}

{{ mch-name }} clusters are created in a configuration with one shard. To start sharding data, follow the guidelines in [{#T}](../tutorials/sharding.md).

## Change a shard {#shard-update}

You can change the shard weight as well as [host class](../concepts/instance-types.md) and storage size.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click the name of a cluster and open the **Shards** tab.
  1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Change**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change a shard in the cluster:

  1. View a description of the CLI's shard change command:

     ```bash
     {{ yc-mdb-ch }} shards update --help
     ```

  1. Start an operation, such as changing the shard weight:

     ```bash
     {{ yc-mdb-ch }} shards update --cluster-name clickhouse12 \
                                   --name shard1 \
                                   --weight 80
     ```

   When the operation is complete, the CLI displays information about the changed shard:

   ```
   name: shard1
   cluster_id: c9fmo2rf013t4q0ab8m1
   config:
     clickhouse:
       config:
         effective_config:
           log_level: INFORMATION
     ...
   
     weight: "80"
   ```

- API

  To change the shard settings, use the [updateShard](../api-ref/Cluster/updateShard.md) method.

{% endlist %}

## List shards in a cluster {#list-shards}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.

  1. Click the name of a cluster and open the **Shards** tab.

- API

  To list the shards in a cluster, use the [listShards](../api-ref/Cluster/listShards.md) method.

{% endlist %}

## Add a shard {#add-shard}

The number of shards in {{ mch-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find the **{{ mch-full-name }}** block.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and go to the **Hosts** tab.
  1. Click **Add shard**.
  1. Enter a name for the shard and add the desired number of hosts.
  1. Click **Create shard**.

- API

  To add a host to the cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) method.

{% endlist %}

## Delete a shard {#delete-shard}

You can delete a shard from a {{ CH }} cluster provided that it's not the only shard in it.

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.

  1. Click on the name of a cluster and open the **Shards** tab.

  1. Click ![image](../../_assets/horizontal-ellipsis.svg) in the line of the desired host and select **Delete**.

- API

  Use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) method to delete a host.

{% endlist %}