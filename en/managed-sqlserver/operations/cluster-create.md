---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating {{ MS }} clusters

A {{ MS }} cluster is one or more database hosts that replication can be configured between. Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests, then duplicates changes synchronously in the primary replica and asynchronously in all the others.

{% note info %}

If database storage is 95% full, the cluster switches to read-only mode. Plan and increase the required storage size in advance.

{% endnote %}


The number of hosts that can be created together with a {{ MS }} cluster depends on the selected [type of storage](../concepts/storage.md):

* With **local storage**, you can create a cluster with 3 or more hosts (to ensure fault tolerance, a minimum of 3 hosts is necessary).
* When using network storage:
    * If you select **standard** or **fast network storage**, you can add any number of hosts within the [current quota](../concepts/limits.md).
    * If you select **non-replicated network storage**, you can create a cluster with 3 or more hosts (to ensure fault tolerance, a minimum of 3 hosts is necessary).

After creating a cluster, you can add extra hosts to it if there are enough available [folder resources](../concepts/limits.md).

## How to create a {{ MS }} cluster {#create-cluster}

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create a database cluster.

  1. Select **{{ mms-name }}**.

  1. Click **Create cluster**.

  1. Enter a name for the cluster in the **Cluster name** field. The cluster name must be unique within the folder.

  1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      - `PRODUCTION`: For stable versions of your apps.
      - `PRESTABLE`: For testing, including the {{ mms-short-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

  1. Select the DBMS version. Currently, we support `2016 ServicePack 2` of the following editions:
     * Standard Edition.
     * Enterprise Edition.

     For more information, see [{#T}](../concepts/index.md).

  1. Select the host class to define the technical specifications of the VMs where the database hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing hosts change, too.

  1. Under **Storage size**:

      
      - Choose the [type of storage](../concepts/storage.md), either a more flexible network type (`network-hdd`, `network-ssd`, or `network-ssd-nonreplicated`) or faster local SSD storage (`local-ssd`).

        When selecting a storage type, remember that:
        - The size of the local storage can only be changed in 100 GB increments.
        - The size of non-replicated network storage can only be changed in 93 GB increments.

      - Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

  1. Under **Database**, specify the database attributes:
      - Database name. This name must be unique within the folder and contain only Latin letters, numbers, and underscores.
      - Username of the database owner. This name may only contain Latin letters, numbers, and underscores. By default, the new user is assigned 50 connections to each host in the cluster.
      - User password (from 8 to 128 characters).

  1. Under **Hosts**, select the parameters for the database hosts created with the cluster. You can add either one, three, or more hosts. By default, each host is created in a separate subnet. To select a specific subnet for the host, click ![image](../../_assets/pencil.svg) in the row of the host and select the desired availability zone and subnet.

     {% note warning %}
     * If you select **Standard Edition**, you can create a cluster from only one host. This cluster does not provide any fault tolerance. For more information, see [{#T}](../concepts/index.md).
     * At the moment, you can create an **Enterprise Edition** cluster with either one or three hosts. Please note that if you selected `local-ssd` or `network-ssd-nonreplicated` under **Storage**, you need to add at least 3 hosts to the cluster.

     {% endnote %}

  1. If necessary, configure the [DBMS settings](../concepts/settings-list.md).

  1. Click **Create cluster**.

- API

  To create a cluster, use the [create](../api-ref/Cluster/create.md) API method and pass the following in the request:
  - In the `folderId` parameter, the ID of the folder where the cluster should be placed.
  - The cluster name, in the `name` parameter.
  - Cluster configuration, in the `configSpec` parameter.
  - Configuration of the cluster hosts, in one or more `hostSpecs` parameters.
  - Cluster database configuration, in one or more `databaseSpecs` parameters.
  - Configuration of the accounts in the cluster database, in one or more `userSpecs` parameters.
  - Network ID, in the `networkId` parameter.

{% endlist %}

