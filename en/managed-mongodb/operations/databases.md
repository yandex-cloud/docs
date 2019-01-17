# Database management

You can add and remove databases, as well as view information about them.

## Getting a list of databases in a cluster {#list-db}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mmg-name]**.
1. Click on the name of the cluster you need and select the **Databases** tab.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To get a list of cluster databases, run the command:

```
$ [!KEYREF yc-mdb-mg] database list
     --cluster-name=<cluster name>
```

The cluster name can be requested with a [list of folder clusters](#list-clusters).

**[!TAB API]**

To get a list of cluster databases, use the [list](../api-ref/Database/list.md) method.

---

## Creating a database {#add-db}

The number of databases in a cluster is unlimited.

> [!NOTE]
>
> Newly created databases are by default not accessible to any users of the database cluster. To connect to a new database, don't forget to grant necessary permissions to a user. 

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mmg-name]**.
1. Click on the name of the cluster you need.
1. Select the **Databases** tab.
1. Click **Add**.
1. Enter the DB name and click **Add**.
1. Don't forget to [grant access](cluster-users.md#updateuser) to the newly created database to a cluster user (available only through CLI and API).

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

Run the create database command and set the name of the new database:

```
$ [!KEYREF yc-mdb-mg] database create <DB name>
    --cluster-name <cluster name>
```

Don't forget to [grant access](cluster-users.md#updateuser) to the newly created database to a cluster user.

[!KEYREF mmg-short-name] runs the create database operation.

The cluster name can be requested with a [list of folder clusters](#list-clusters).

**[!TAB API]**

You can create a new database in a cluster using the [create](../api-ref/Database/create.md) method. Permissions for the new database can be set using the [update](../api-ref/User/update.md) method.

---

## Removing a database {#remove-db}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mmg-name]**.
1. Click on the name of the cluster you need and select the **Databases** tab.
1. Click ![](../../_assets/vertical-ellipsis.svg) in the line of the necessary DB and select **Delete**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To remove a database, run the command:

```
$ [!KEYREF yc-mdb-mg] database delete <DB name>
     --cluster-name=<cluster name>
```

The cluster name can be requested with a [list of folder clusters](#list-clusters).

**[!TAB API]**

You can delete a database using the [delete](../api-ref/Database/delete.md) method.

---

