---
title: "SQL Server backup management"
description: "You can back up and restore clusters from your existing SQL Server backups. Point-in-Time Recovery (PITR) technology allows you to restore the state of the cluster to any point in time from the backup to the current moment."
---

# Managing backups

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{% note warning %}

You can't use SQL commands to change the [recovery model]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/relational-databases/backup-restore/recovery-models-sql-server?view=sql-server-2016){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/recovery-models-sql-server?view=sql-server-2016){% endif %} for backup and recovery operations.

{% endnote %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

  To get a list of cluster backups:
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  {% if audience != "external" %}

  To get a list of backups for all the **{{ mms-name }}** clusters in a folder:
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click the **Backups** tab.

{% endif %}

- API

  To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) API method and pass the cluster ID in the `clusterId` request parameter.

  To get a list of backups for all the **{{ mms-name }}** clusters in the folder, use the [list](../api-ref/Backup/list.md) API method and pass the folder ID in the `folderId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs %}

- Management console

  To get information about the backup of an existing cluster:
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.

{% if audience != "external" %}

  To get information about the backup of a previously deleted cluster:

  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click the **Backups** tab.

{% endif %}

- API

  To get information about a backup, use the [get](../api-ref/Backup/get.md) API method and pass the backup ID in the `backupId` request parameter. To find out the ID, [get a list of backups](#list-backups).

{% endlist %}

## Creating backups {#create-backup}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.
  1. Click **Create backup**.

  **{{ mms-name }}** launches the operation to create a backup.

- API

  Use the [backup](../api-ref/Cluster/backup.md) API method and pass the cluster ID in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Restoring clusters from backups {#restore}

Point-in-Time Recovery (PITR) technology lets you restore the cluster state to any point in time in the interval from its backup to archiving the most recent transaction log. For more information, see [{#T}](../concepts/backup.md).

For example, if the backup operation ended August 10, 2020, 12:00:00 UTC, the current date is August 15, 2020, 19:00:00 UTC, and the latest transaction log was saved August 15, 2020, 18:50:00 UTC, the cluster can be restored to any state between August 10, 2020, 12:00:01 UTC and August 15, 2020, 18:50:00 UTC inclusive.

When you restore a cluster from a backup, you create a new cluster with data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup.

For a new cluster, you need to set up all its [parameters required at creation](cluster-create.md#create-cluster).

{% list tabs %}

- Management console

  To restore an existing cluster from a backup:
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the backup and click **Restore cluster**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
  1. Click **Restore cluster**.

  {% if audience != "external" %}

  To restore a previously deleted cluster from a backup:
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click the **Backups** tab.
  1. Find the desired backup using the backup creation time and cluster ID. The **Name** column contains the IDs in `<cluster ID>:<backup ID>` format.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the backup and click **Restore cluster**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
  1. Click **Restore cluster**.

  {% endif %}

  **{{ mms-name }}** launches the operation to create a cluster from a backup.

- API

  Use the [restore](../api-ref/Cluster/restore.md) API method and pass the following in the request:
  - ID of the desired backup, in the `backupId` parameter. To find out the ID, [get a list of backups](#list-backups).
  - Timestamp of the moment to which the cluster should be restored, in the `time` parameter.
  - The name of the new cluster that will contain the data recovered from the backup. The cluster name must be unique within the folder.

{% endlist %}

## Editing the backup start time {#set-backup-window}

{% list tabs %}

{% if audience != "external" %}

- Management console
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Set the backup start time.
  1. Click **Save changes**.

{% endif %}

- API

  To change the backup start time for a cluster, use the [update](../api-ref/Cluster/update.md) method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The new backup start time, in the `configSpec.backupWindowStart` parameter.
  - List of cluster configuration fields to be changed (in this case, `configSpec.backupWindowStart`), in the `updateMask` parameter.

  {% note warning %}

  This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, in the `updateMask` parameter, list the settings you want to change (in a single line, separated by commas).

  {% endnote %}

{% endlist %}

