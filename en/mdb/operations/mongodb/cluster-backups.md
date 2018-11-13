# Managing backups

You can create backups and restore clusters from existing backups.

## Getting a list of backups {#list-backups}

---

**[!TAB Management console]**

1. Go to the folder page and click on the tile **Yandex Managed Databases**.
1. Click on the name of the cluster you need and select the tab **Backup copies**.

---

## Creating backups {#create-backup}

---

**[!TAB Management console]**

1. Go to the folder page and click on the tile **Yandex Managed Databases**.
1. Click on the name of the cluster you need and select the tab **Backup copies**.
1. Click **Create a backup**.

---

## Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the data from the backup. If the folder does not contain sufficient [resources](../../concepts/limits.md) to create the cluster, you won't be able to restore from the backup.

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type (a [!KEYREF MG] backup cannot be restored as a [!KEYREF PG] cluster).

