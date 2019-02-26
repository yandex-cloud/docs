# How to manage backups

You can create backups and restore clusters from existing backups.

## Creating backups {#create-backup}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mch-name]**.

2. Click on the name of the cluster you need and select the tab **Backup copies**.

3. Click **Create a backup**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To create a cluster backup:

1. See the description of the CLI's create backup command [!KEYREF CH]:

    ```
    $ [!KEYREF yc-mdb-ch] cluster backup --help
    ```

2. Request creation of a backup specifying the cluster name or ID:

    ```
    $ [!KEYREF yc-mdb-ch] cluster backup my-ch-cluster
    ```

    The cluster name and ID can be obtained with a [list of clusters](cluster-list.md#list-clusters).

---

## Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the data from the backup. If the cloud has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup.

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type (a [!KEYREF CH] backup cannot be restored as a [!KEYREF PG] cluster).

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mch-name]**.

2. Click on the name of the cluster you need and select the tab **Backup copies**.

3. Click ![image](../../_assets/dots.svg) for the required backup and then click **Restore cluster**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To restore a cluster from a backup:

1. View the description of the CLI's restore cluster command [!KEYREF CH]:

    ```
    $ [!KEYREF yc-mdb-ch] cluster restore --help
    ```

2. Get a list of available backups for [!KEYREF CH] clusters:

    ```
    $ [!KEYREF yc-mdb-ch] backup list
    
    +--------------------------+----------------------+----------------------+----------------------+
    |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
    +--------------------------+----------------------+----------------------+----------------------+
    | c9qlk4v13uq79r9cgcku:... | 2018-11-02T10:08:38Z | c9qlk4v13uq79r9cgcku | 2018-11-02T10:08:37Z |
    | ...                                                                                           |
    +--------------------------+----------------------+----------------------+----------------------+
    ```

3. Request creation of a cluster from a backup:

    ```
    $ [!KEYREF yc-mdb-ch] cluster restore \
           --backup-id c9q22suuefrmrp2lrv9f:20181109T101204 \
           --name mynewch \
           --environment=PRODUCTION \
           --network-name [!KEYREF network-name] \
           --host type=clickhouse,zone-id=[!KEYREF zone-id],subnet-id=b0rcctk2rvtr8efcch63 \
           --clickhouse-disk-size 20 \
           --clickhouse-disk-type network-nvme \
           --clickhouse-resource-preset [!KEYREF host-class]
    ```

    This results in a new [!KEYREF CH] cluster with the following characteristics:

    * Named `mynewch`.

    * In the `PRODUCTION` environment.

    * In the network `[!KEYREF network-name]`.

    * With a single host of the `[!KEYREF host-class]` in the `b0rcctk2rvtr8efcch63` subnet and the ` availability zone[!KEYREF zone-id]`.

    * With the databases and users from the backup.

    * With SSD network storage of 20 GB.

---

## Getting a list of backups {#list-backups}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mch-name]**.

2. Click on the name of the cluster you need and select the tab **Backup copies**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To get a list of [!KEYREF CH] cluster backups available in the default folder, run the command:

```
$ [!KEYREF yc-mdb-ch] backup list

+----------+----------------------+----------------------+----------------------+
|    ID    |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
+----------+----------------------+----------------------+----------------------+
| c9qv4... | 2018-10-31T22:01:07Z | c9qv4ql6bd4hfo1cgc3o | 2018-10-31T22:01:03Z |
| c9qpm... | 2018-10-31T22:01:04Z | c9qpm90p3pcg71jm7tqf | 2018-10-31T22:01:04Z |
+----------+----------------------+----------------------+----------------------+
```

---

## Getting information about a backup {#get-backup}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mch-name]**.

2. Click on the name of the cluster you need and select the tab **Backup copies**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To get information about a [!KEYREF CH] cluster backup, run the command:

```
$ yc [!KEYREF yc-mdb-ch] backup get <backup ID>
```

The backup ID can be obtained from a [list of backups](#list-backups).

---

