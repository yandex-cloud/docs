# Creating a [!KEYREF CH] cluster

[!KEYREF CH] cluster is one or more database hosts that can have replication configured between them.

The number of hosts that can be created together with a [!KEYREF CH] cluster depends on the storage option selected:

  - When using network drives, you can request any number of hosts (from one to the limits of the current [quota](../../concepts/limits.md)).
  - When using SSDs, you can create at least two replicas along with the cluster (a minimum of two replicas is required to ensure fault tolerance). If after cluster creation [available folder resources](../../concepts/limits.md) are sufficient, you can create additional replicas.

---

**[!TAB Management console]**

1. In the management console, select the folder where you want to create a DB cluster.
1. Click on the tile **Managed Service for ClickHouse**.
1. Click **Create a cluster** and select the necessary DBMS. Once a cluster is created, you cannot change the DBMS.
1. Enter the cluster name in the **Cluster name** field. The cluster name must be unique within the folder.
1. Select the environment where you want to create the cluster (you cannot change the environment after cluster creation):
    - <q>production</q> — for stable versions of your apps.
    - <q>prestable</q> — to perform testing, including that of the [!KEYREF mdb-short-name] service itself. The prestable environment is updated more often, which means that known problems are fixed sooner in it, but this may cause backward incompatible changes.
1. Select the database class that will define the technical specifications of the VMs where the database hosts will be deployed. For the list of available classes, see the section [[!TITLE]](../../concepts/instance-types.md). When you change the database class for the cluster, the characteristics of all existing instances change, too.
1. In the **Storage size** section:
    - Select the type of storage, either a more flexible network type (**network-nvme**) or faster local SSD storage (**local-nvme**). The size of the local storage can only be changed in increments of 100 GB.
    - Select the size to be used for data and backups. For more information about how backups take up storage space, see [[!TITLE]](../../concepts/backup.md).
1. In the **Database** section, specify DB attributes:
    - DB name
    - User name
    - User password (a minimum of 8 characters).
1. In the **Hosts** section, specify parameters for database hosts created with the cluster (keep in mind that if you use SSDs when creating [!KEYREF CH] clusters, you can set at least two hosts). To change the added host, place the cursor on the host line and click ![](../../../_assets/pencil.svg).
1. Click **Create a cluster**.

---

