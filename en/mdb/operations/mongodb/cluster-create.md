# Creating a [!KEYREF MG] cluster

[!KEYREF MG] cluster is one or more database hosts that can have replication configured between them. Replication is enabled by default in any cluster consisting of more than one host (the primary host accepts write requests and asynchronously duplicates changes in the secondary hosts).

The number of hosts that can be created together with a [!KEYREF MG] cluster depends on the storage option selected:

  - When using network drives, you can request any number of hosts (from one to the limits of the current [quota](../../concepts/limits.md)).
  - When using SSDs, you can create at least three replicas along with the cluster (a minimum of three replicas is required to ensure fault tolerance). If after cluster creation [available folder resources](../../concepts/limits.md) are sufficient, you can create additional replicas.

---

**[!TAB Management console]**

1. In the management console, select the folder where you want to create a DB cluster.
1. Click on the tile **Yandex Managed Databases**.
1. Click **Create a cluster** and select the necessary DBMS. Once a cluster is created, you cannot change the DBMS.
1. Enter the cluster name in the **Cluster name** field. The cluster name must be unique within the folder.
1. Select the environment where you want to create the cluster (you cannot change the environment after cluster creation):
    - <q>production</q> — for stable versions of your apps.
    - <q>prestable</q> — to perform testing, including that of the [!KEYREF mdb-short-name] service itself. The prestable environment is updated more often, which means that known problems are fixed sooner in it, but this may cause backward incompatible changes.
1. Select the DBMS version.
1. Select the database class that will define the technical specifications of the VMs where the database hosts will be deployed. When you change the DB class for the cluster, the characteristics of all existing hosts change, too.
1. In the **Storage size** section:
    - Select the type of storage, either a more flexible network type (**network-nvme**) or faster local SSD storage (**local-nvme**). The size of the local storage can only be changed in increments of 100 GB.
    - Select the size to be used for data and backups. For more information about how backups take up storage space, see [[!TITLE]](../../concepts/backup.md).
1. In the **Database** section, specify DB attributes:
    - DB name
    - User name
    - User password (a minimum of 8 characters).
1. In the **Hosts** section, select parameters for database hosts created with the cluster (keep in mind that if you use SSDs when creating [!KEYREF MG] clusters, you can set at least three hosts). If you open the **Advanced settings** section, you can choose specific subnets for each host. By default, each host is created in a separate subnet.
1. Click **Create a cluster**.

---

