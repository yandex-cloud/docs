# How to perform database user management

You can add and remove users, as well as manage their individual settings.

## Getting a list of users {#list-users}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mmg-name]**.
1. Click on the name of the cluster you need and then select the **Users** tab.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To get a list of cluster users, run the command:

```
$ [!KEYREF yc-mdb-mg] user list
     --cluster-name=<cluster name>
```

The cluster name can be requested with a [list of folder clusters](#list-clusters).

---

## Adding users {#adduser}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mmg-name]**.
1. Click on the name of the cluster you need and select the tab **Users**.
1. Click **Add**.
1. Enter the database user name and password (from 8 to 128 characters).

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To create a user in a cluster, run the command:

```
$ [!KEYREF yc-mdb-mg] user create <user name>
     --cluster-name=<cluster name>
     --password=<user password>
     --permissions=<list of DBs the user can access>
```

The cluster name can be requested with a [list of folder clusters](#list-clusters).

---

## Updating users {#updateuser}

---

**[!TAB Management console]**

In the management console, you can only change the password of a database user:

1. Go to the folder page and click **[!KEYREF mmg-name]**.
1. Click on the name of the cluster you need and select the tab **Users**.
1. Click ![](../../_assets/vertical-ellipsis.svg) and select **Change password**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To change the user's password or the list of databases available to the user, run:

```
$ [!KEYREF yc-mdb-mg] user update <user name>
     --cluster-name=<cluster name>
     --password=<user password>
     --permissions=<list of DBs the user can access>
```

The cluster name can be requested with a [list of folder clusters](#list-clusters).

---

## Removing a user {#removeuser}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mmg-name]**.
1. Click on the name of the cluster you need and select the tab **Users**.
1. Click ![](../../_assets/vertical-ellipsis.svg) and select **Delete**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To remove a user, run:

```
$ [!KEYREF yc-mdb-mg] user delete <user name>
     --cluster-name=<cluster name>
```

The cluster name can be requested with a [list of folder clusters](#list-clusters).

---

