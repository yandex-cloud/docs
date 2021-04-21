# Managing {{ ZK }} hosts

[A shard](../concepts/sharding.md) with a single host in the {{ mch-name }} cluster isn't fault tolerant and doesn't provide [data replication](../concepts/replication.md). To make a cluster with this shard more reliable, you can [add additional {{ CH }} hosts](hosts.md) to the shard, but before managing them, first you need to [enable fault tolerance](#add-zk) (as a result, the minimum number of {{ ZK }} hosts, which is 3, will be added to the cluster).

You can [add](#add-zk-host) and [delete](#delete-zk-host) {{ ZK }} hosts in a fault-tolerant cluster. A fault-tolerant cluster can contain a total of 3 to 5 {{ ZK }} hosts.

{% note warning %}

Note:

* You can't enable fault tolerance or manage your {{ ZK }} hosts if the cluster uses [hybrid storage](../concepts/storage.md#hybrid-storage-features) at the [Preview](https://cloud.yandex.com/docs/overview/concepts/launch-stages) stage. This restriction is removed at the General Availability stage.
* If fault tolerance is already enabled for the cluster and {{ ZK }} hosts are created, you can't delete all these hosts because there are always at least 3 {{ ZK }} hosts in the cluster.

{% endnote %}

## Enabling fault tolerance for the cluster {#add-zk}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the **Hosts** tab.
  1. Click **Set up {{ ZK }} hosts**.
  1. Specify the [host class](../concepts/instance-types.md).
  1. Set up the storage settings.
  1. Change the settings of a {{ ZK }} host if necessary. 
    To do this, hover the cursor over the line of the required host and click ![image](../../_assets/pencil.svg).
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To enable fault tolerance for a cluster:

  1. View a description of the CLI command for adding {{ ZK }} hosts:

     ```
     $ {{ yc-mdb-ch }} cluster add-zookeeper --help
     ```

  1. Run the operation with the default host characteristics:

     ```bash
     $ {{ yc-mdb-ch }} cluster add-zookeeper <cluster name> \
                             --host zone-id=ru-central1-c,subnet-name=default-c \
                             --host zone-id=ru-central1-a,subnet-name=default-a \
                             --host zone-id=ru-central1-b,subnet-name=default-b
     ```

     If the network hosting the cluster contains exactly 3 subnets, each per availability zone, you do not have to explicitly specify subnets for the hosts: {{ mch-name }} automatically distributes hosts over the subnets.

     You can query the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  Use the [addZookeeper](../api-ref/Cluster/addZookeeper.md) method. For the added hosts, specify the settings for the 3 {{ ZK }} hosts by listing them in the `hostSpecs` parameter.

{% endlist %}

{% note info %}

The following characteristics are set for the {{ ZK }} hosts by default:

* The `b2.medium` host class.
* 10 GB disk size.
* [Storage type](../concepts/storage.md): Fast network storage.

{% endnote %}

## Adding a {{ ZK }} host {#add-zk-host}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the **Hosts** tab.
  1. Click **Add {{ ZK }} hosts**.
  1. If necessary, change the host settings.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add a host to a cluster:

  1. Collect the necessary information:
     - Request the subnet ID by running the command:

       ```
       $ yc vpc subnet list
       ```

       If the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).
     - You can get the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. See the description of the CLI command for adding a host:

     ```
     $ {{ yc-mdb-ch }} host add --help
     ```

  1. Run the add {{ ZK }} host command:

     ```
     $ {{ yc-mdb-ch }} hosts add \
          --cluster-name <cluster name>
          --host zone-id=<availability zone>,subnet-id=<subnet ID>,type=zookeeper
     ```

- API

  Use the [addHosts](../api-ref/Cluster/addHosts.md) method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where you want to locate the host. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Settings for the host, in the `hostSpecs` parameter (in addition, specify the `ZOOKEEPER` type in the `hostSpecs.type` parameter). Do not specify settings for multiple hosts in this parameter because {{ ZK }} hosts are added to the cluster one by one unlike [{{ CH }} hosts](hosts.md#add-host), which can be added several at a time.

{% endlist %}

## Deleting a {{ ZK }} host {#delete-zk-host}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the **Hosts** tab.
  1. Hover the cursor over the line of the required host and click ![image](../../_assets/cross.svg).
  1. Confirm the deletion of the host.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a host from the cluster, run:

  ```
  $ {{ yc-mdb-ch }} hosts delete <host name> \
       --cluster-name=<cluster name>
  ```

  The host name can be requested with a [list of cluster hosts](hosts.md#list-hosts), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  Use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) method and pass the following in the request:
  - The ID of the cluster where the host is located, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Host name, in the `hostNames` parameter. To find out the name, request a [list of hosts in the cluster](hosts.md#list-hosts).

{% endlist %}

