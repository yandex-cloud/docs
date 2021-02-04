# Creating clusters

A cluster in {{ mkf-name }} is one or more broker hosts where topics and their partitions are located. Producers and consumers can work with these topics by connecting to cluster hosts.

{% include [mkf-zk-hosts](../../_includes/mdb/mkf-zk-hosts.md) %}

{% list tabs %}

- Management console

  To create a cluster, follow these steps:

  1. In the management console, select the folder where you want to create a cluster.

  1. Select **{{ mkf-name }}**.

  1. Click **Create cluster**.

  1. Under **Basic parameters**:
     1. Enter a name for the cluster and, if necessary, a description. The cluster name must be unique within the folder.
     1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
        - `PRODUCTION`: For stable versions of your apps.
        - `PRESTABLE`: For testing, including the {{ mkf-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
     1. Select the {{ KF }} version.

  1. Under **Host class**, select the platform, host type, and host class.

     The host class defines the technical specifications of the VMs where the [{{ KF }} brokers](../concepts/brokers.md) will be deployed. All available options are listed in [Host classes](../concepts/instance-types.md).

     When you [change the host class](cluster-update.md#update-cluster) for the cluster, the characteristics of all existing instances change.

  1. Under **Storage**:
     1. Choose the [type of storage](../concepts/storage.md), either a more flexible network type (**network-hdd** or **network-ssd**) or faster local SSD storage (**local-ssd**).
     1. Select the size of storage to be used for data. The size of the local storage can only be changed in 100 GB increments.

  1. Under **Network settings**:

     1. Select one or more [availability zones](../../overview/concepts/geo-scope.md) where the {{ KF }} brokers will reside.

     1. Select the [network](../../vpc/concepts/network.md).

     1. Select subnets in each availability zone for this network. To [create a new subnet](../../vpc/operations/subnet-create.md), click **Create new subnet** next to the desired availability zone.

        {% note info %}

        For a cluster with multiple broker hosts, you need to specify subnets in each availability zone even if you plan to host brokers only in some of them. These subnets are required to host three {{ ZK }} hosts — one in each availability zone. For more information, see [{#T}](../concepts/index.md).

        {% endnote %}

     1. To access broker hosts from the internet, select **Public access**. In this case, you can only connect to them over an SSL connection. For more information, see [{#T}](connect.md).

        {% note warning %}

        You can't request public access after creating a cluster.

        {% endnote %}

  1. Under **Hosts**, specify the number of [broker hosts](../concepts/brokers.md) {{ KF }} to be located in each of the selected availability zones.

     When choosing the number of hosts, keep in mind that:
     - The {{ KF }} cluster hosts will be evenly deployed in the selected availability zones. Decide on the number of zones and hosts per zone based on the required fault tolerance model and cluster load.
     - Replication is possible if there are at least two hosts in the cluster.
     - Adding more than one host to the cluster automatically adds three {{ ZK }} hosts.

  1. If you specify two or more broker hosts, under **Host class {{ ZK }}**, specify the characteristics of the [hosts{{ ZK }}](../concepts/index.md) to be located in each of the selected availability zones.

  1. Click **Create cluster**.

  1. Wait until the cluster is ready: its status on the {{ mkf-short-name }} dashboard changes to `Running` and its state to `Alive`. This may take some time.


- API

  To create a cluster, use the [create](../api-ref/Cluster/create.md) API method and pass the following in the request:
  - In the `folderId` parameter, the ID of the folder where  the cluster should be placed.
  - The cluster name in the `name` parameter.

{% endlist %}
