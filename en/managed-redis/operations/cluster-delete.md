# Deleting a cluster

> [!IMPORTANT]
>
> Backups of deleted clusters are stored for seven days.
>

---

**[!TAB Management console]**

1. Open the folder page in the management console.
1. Click **[!KEYREF mrd-name]**.
1. Click ![image](../../_assets/options.svg) for the necessary cluster and select **Delete**.
1. In the window that opens, check **Delete cluster** and click **Delete**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To delete a cluster, run the command:

```
$ [!KEYREF yc-mdb-rd] cluster delete <cluster name or ID>
```

The cluster name and ID can be requested with a [list of clusters in the folder](cluster-list.md).

---

