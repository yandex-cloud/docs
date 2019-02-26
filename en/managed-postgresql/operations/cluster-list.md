# Information about existing clusters

You can request detailed information about each [!KEYREF mpg-short-name] cluster you created.

## Getting a list of DB clusters in a folder {#list-clusters}

---

**[!TAB Management console]**

Go to the folder page and click **[!KEYREF mpg-name]**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To request a list of [!KEYREF PG] clusters in the default folder, run the command:

```
$ [!KEYREF yc-mdb-pg] cluster list

+----------------------+---------------+-----------------------------+--------+---------+
|          ID          |     NAME      |         CREATED AT          | HEALTH | STATUS  |
+----------------------+---------------+-----------------------------+--------+---------+
| c9wlk4v14uq79r9cgcku | mypg          | 2018-11-02T10:04:14.645214Z | ALIVE  | RUNNING |
| ...                                                                                   |
+----------------------+---------------+-----------------------------+--------+---------+
```

---

## Getting detailed information about a cluster {#get-cluster}

---

**[!TAB Management console]**

1. Go to the folder page and click **[!KEYREF mpg-name]**.
1. Click on the name of the cluster you need.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To get information about a [!KEYREF PG] cluster, run the command:

```
$ [!KEYREF yc-mdb-pg] cluster get <cluster name or ID>
```

The cluster name and ID can be requested with a [list of folder clusters](#list-clusters).

---

