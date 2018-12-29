# Deleting a cluster

> [!IMPORTANT]

You cannot restore a DB cluster that has been deleted, because all the cluster's backups are removed with it.

---

**[!TAB Management console]**

1. Open the folder page in the management console.
1. Click on **[!KEYREF mch-name]**.
1. Click ![](../../_assets/vertical-ellipsis.svg) for the necessary cluster and select **Delete**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To delete a cluster, run the command:

```
$ [!KEYREF yc-mdb-ch] cluster delete <cluster name or ID>
```

The cluster name and ID can be requested with a [list of folder clusters](#list-clusters).

---

