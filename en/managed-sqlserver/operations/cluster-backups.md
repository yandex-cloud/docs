---
title: "SQL Server backup management"
description: "You can back up and restore clusters from your existing SQL Server backups. Point-in-Time Recovery (PITR) technology allows you to restore the state of the cluster to any point in time from the backup to the current moment."
---

# Managing backups

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{% note warning %}

You cannot use SQL commands to modify the [recovery model](https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/recovery-models-sql-server?view=sql-server-2016) for backup and restore operations.

{% endnote %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console


  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.


- API

  To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) API method and pass the cluster ID in the `clusterId` request parameter.

  To get a list of backups for all the **{{ mms-name }}** clusters in the folder, use the [list](../api-ref/Backup/list.md) API method and pass the folder ID in the `folderId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs %}

- Management console


  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.


- API

  Use the [get](../api-ref/Backup/get.md) API method and pass the backup ID in the `backupId` request parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs %}

- Management console

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.
  1. Click **Create a backup**.

  **{{ mms-name }}** launches the operation to create a backup.

- API

  Use the [backup](../api-ref/Cluster/backup.md) API method and pass the cluster ID in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Restoring from backups {#restore}

Point-in-Time Recovery (PITR) technology lets you restore the state of a cluster or an individual database to any point in time between the oldest backup and archiving the most recent transaction log. For more information, see [{#T}](../concepts/backup.md).

For example, if a backup operation completed at 12:00:00 UTC on August 10, 2020, the current date is August 15, 2020 at 19:00:00 UTC, and the latest transaction log was saved at 18:50:00 UTC on August 15, 2020, you can restore the cluster to any of its states from 12:00:01 UTC on August 10, 2020  through 18:50:00 UTC on August 15, 2020.

When restoring to the current state, the new cluster or database will indicate:

* The state of the existing cluster or database at of the time of recovery.
* The state of the deleted cluster or database at the time the most recent transaction log was archived.

### Restoring clusters from backups {#restore-cluster}

When you restore a cluster from a backup, you create a new cluster with data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup.

For a new cluster, you need to set up all its [parameters required at creation](cluster-create.md#create-cluster).

{% list tabs %}

- Management console

  To restore an existing cluster from a backup:
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.
  1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon for the required backup and click **Restore cluster**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
  1. Click **Restore cluster**.


  **{{ mms-name }}** launches the operation to create a cluster from the backup.

- API

  Use the [restore](../api-ref/Cluster/restore.md) API method and pass the following in the request:
  * ID of the desired backup, in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
  * The timestamp of the point to which you want to recover the cluster, in the `time` parameter.
  * The name of the new cluster that will contain the data recovered from the backup. The cluster name must be unique within the folder.

{% endlist %}

### Restoring a database from a backup {#restore-db}

When restoring a database from a backup, you create a new database in the current cluster with data from the backup.

{% list tabs %}

- Management console

  To restore an existing database from a backup:
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the **Databases** tab.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the desired database, then click **Restore**.
  1. Specify a name for the new database and select the desired backup and time the database should be restored to.
  1. Click **Restore**.

  To restore a previously deleted database from a backup:
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.
  1. Find the correct backup by its time of creation and the required database. In the **Databases** column, there is a listing of the databases contained in each backup.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the desired backup, then click **Restore**.
  1. Specify a name for the new database and select the desired source database and time it should be restored to.
  1. Click **Restore**.

- API

  Use the [restore](../api-ref/Database/restore.md) API method and pass the following in the request:
  * ID of the desired backup, in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
  * The time the database should be restored to, in the `time` parameter.
  * The name of the source database that the new database will be restored from, in the `fromDatabase` parameter.
  * The name of the new database that will contain the data restored from the backup, in the `databaseName` parameter. A database name must be unique within the cluster.

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs %}

- Management console

  In the management console, you can set the backup start time when [creating](cluster-create.md) or [updating](update.md) a cluster.

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * The new backup start time, in the `configSpec.backupWindowStart` parameter.
  * List of cluster configuration fields to be edited (in this case, `configSpec.backupWindowStart`) in the `updateMask` parameter.

  {% note warning %}

  This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, list the settings you want to change in the `updateMask` parameter (in a single line, separated by commas).

  {% endnote %}

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [{#T}](cluster-create.md).

  1. Add a block named `backup_window_start` to the {{ mms-name }} cluster description under `config`:

      ```hcl
      resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
        ...
        config {
          backup_window_start {
            hours   = <backup start hour (UTC)>
            minutes = <backup start minute (UTC)>
          }
          ...
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mms }}).

{% endlist %}
