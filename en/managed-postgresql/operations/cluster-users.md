# How to manage database users

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mpg-name]**.
1. Click on the name of the cluster you need and then select the **Users** tab.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To get a list of cluster users, run the command:

```
$ [!KEYREF yc-mdb-pg] user list
     --cluster-name=<cluster name>
```

The cluster name can be requested with a [list of folder clusters](#list-clusters).

---

## Adding users {#adduser}

When adding a user, [!KEYREF mpg-short-name] reserves 50 connections to a [!KEYREF PG] cluster (the `connlimit` parameter) by default. The minimum number of connections per user is 10.

[!INCLUDE [note-pg-user-connections.md](../../_includes/mdb/note-pg-user-connections.md)]

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mpg-name]**.
1. Click on the name of the cluster you need and select the tab **Users**.
1. Click **Add**.
1. Enter the database user name and password (from 8 to 128 characters).

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To create a user in a cluster, run the command:

```
$ [!KEYREF yc-mdb-pg] user create <user name>
     --cluster-name=<cluster name>
     --password=<DB user password>
     --permissions=<list of DBs the user can access>
     --conn-limit=<number of connections available to the user>
```

The cluster name can be requested with a [list of folder clusters](#list-clusters).

---

## Updating users {#updateuser}

For the user, you can change:

- Name and password.
- List of databases the user can access.
- Limitation on the number of DB connections.

---

**[!TAB Management console]**

In the management console, you can only change the password of a database user:

1. Go to the folder page and click **[!KEYREF mpg-name]**.
1. Click on the name of the cluster you need and select the tab **Users**.
1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Change password**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To change the user's password or the list of databases available to the user, run:

```
$ [!KEYREF yc-mdb-pg] user update <user name>
     --cluster-name=<cluster name>
     --password=<DB user password>
     --permissions=<list of DBs the user can access>
     --conn-limit=<number of connections available to the user>
```

The cluster name can be requested with a [list of folder clusters](#list-clusters).

---

## Removing a user {#removeuser}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mpg-name]**.
1. Click on the name of the cluster you need and select the tab **Users**.
1. Click ![image](../../_assets/vertical-ellipsis.svg) and select **Delete**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To remove a user, run:

```
$ [!KEYREF yc-mdb-pg] user delete <user name>
     --cluster-name=<cluster name>
```

The cluster name can be requested with a [list of folder clusters](#list-clusters).

---

