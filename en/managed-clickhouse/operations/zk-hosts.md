# Enabling cluster fault tolerance

A {{ mch-name }} cluster with one host doesn't ensures fault tolerance or data replication. To make the cluster more reliable, you can add more {{ CH }} hosts, but to be able to manage them, you first need to add {{ ZK }} hosts to the cluster.

{% note warning %}

You can add exactly 3 {{ ZK }} hosts to the cluster.

{% endnote %}

## Add hosts {{ ZK }} {#add-zk}

For the {{ ZK }} hosts you add, you can indicate the computing power ([host class](../concepts/instance-types.md)) and subnets to accommodate your hosts.

The following characteristics are set for the {{ ZK }} hosts by default:

* The `b2.medium` host class.
* 10 GB disk size.
* [Storage type](../concepts/storage.md): Fast network storage.

To add {{ ZK }} hosts:

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.

  1. Click on the name of the cluster you need and select the **Hosts** tab.

  1. Click **Add {{ ZK }} hosts**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command for adding {{ ZK }} hosts:

     ```
     $ {{ yc-mdb-ch }} cluster add-zookeeper --help
     ```

  1. Run the operation with the default host characteristics:

     ```bash
     $ {{ yc-mdb-ch }} cluster add-zookeeper clickhouse417 \
                             --host zone-id=ru-central1-c,subnet-name=default-c \
                             --host zone-id=ru-central1-a,subnet-name=default-a \
                             --host zone-id=ru-central1-b,subnet-name=default-b
     ```

     If the network hosting the cluster contains exactly 3 subnets, each per availability zone, you do not have to explicitly specify subnets for the hosts: {{ mch-name }} automatically distributes hosts over the subnets.

     You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  To add {{ ZK }} hosts to the cluster, use the [addZookeeper](../api-ref/Cluster/addZookeeper.md) method.

{% endlist %}

