# Database management

You can add and remove databases, as well as view information about them.

## Getting a list of databases in a cluster {#list-db}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mpg-name]**.
1. Click on the name of the cluster you need and select the **Databases** tab.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To get a list of cluster databases, run the command:

```
$ [!KEYREF yc-mdb-pg] database list
     --cluster-name=<cluster name>
```

The cluster name can be requested with a [list of folder clusters](#list-clusters).

**[!TAB API]**

To get a list of cluster databases, use the [list](../api-ref/Database/list.md) method.

---

## Creating a database {#add-db}

The number of databases in a cluster is unlimited.

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mpg-name]**.
1. Click on the name of the cluster you need.
1. If a new database should be owned by a non-existing user, [create a user](cluster-users.md#adduser).
1. Select the **Databases** tab.
1. Click **Add**.
1. Enter the database name and select its owner.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To create a database in a cluster:

1. See the description of the CLI's create database command:

   ```
   $ [!KEYREF yc-mdb-pg] database create --help
   ```

1. Request a list of cluster users to select the owner of the new database:

   ```
   $ [!KEYREF yc-mdb-pg] user list
        --cluster-name <cluster name>
   ```

   If the required user is not in the list, [create a user](cluster-users.md#adduser).

1. Run the create database command:

   ```
   $ [!KEYREF yc-mdb-pg] database create <DB name>
        --cluster-name <cluster name>
        --owner <username of the DB owner>
   ```

   [!KEYREF mpg-short-name] runs the create database operation.

The cluster name can be requested with a [list of folder clusters](#list-clusters).

**[!TAB API]**

You can create a new database in a cluster using the [create](../api-ref/Database/create.md) method.

---

## Removing a database {#remove-db}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mpg-name]**.
1. Click on the name of the cluster you need and select the **Databases** tab.
1. Click ![image](../../_assets/vertical-ellipsis.svg) in the line of the necessary DB and select **Delete**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To remove a database, run the command:

```
$ [!KEYREF yc-mdb-pg] database delete <DB name>
     --cluster-name=<cluster name>
```

The cluster name can be requested with a [list of folder clusters](#list-clusters).

**[!TAB API]**

You can delete a database using the [delete](../api-ref/Database/delete.md) method.

---

