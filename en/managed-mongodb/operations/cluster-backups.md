---
title: "Managing MongoDB backups"
description: "You can create backups and restore clusters from existing MongoDB backups. The Point-in-Time Recovery (PITR) technology enables you to restore cluster state to any point in time starting with the moment a backup was created."
---

# Managing backups in {{ mmg-name }}

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{{ mmg-name }} also creates automatic daily backups. You can [set the backup start time and retention period](update.md#change-additional-settings).

## Restoring clusters from backups {#restore}

Point-in-Time Recovery (PITR) technology lets you restore the cluster state to any point in time between when the oldest backup was created and when the most recent oplog was archived. For more information, see [{#T}](../concepts/backup.md).

For example, if the backup operation ended on August 10, 2020, 12:00 p.m. UTC, the current date is August 15, 2020, 7:00 p.m. UTC, and the latest `oplog` was saved on August 15, 2020, 6:50 p.m. UTC, the cluster can be restored to any state between August 10, 2020, 12:00:01 p.m. UTC and August 15, 2020, 6:50:00 p.m. UTC, inclusive.

{% note warning %}

* PITR only works for clusters with {{ MG }} version 4.2 and higher.
* PITR is not supported for clusters with [sharding](../tutorials/sharding.md) enabled. Such clusters can be restored only to the point in time when the selected backup was created.

{% endnote %}

When you restore a cluster from a backup, you create a new cluster with the backup data. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps.

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type (a {{ MG }} backup cannot be restored as a {{ PG }} cluster).

When restored to the current state, the new cluster will match the state of:

* Existing cluster at the time of recovery.
* Deleted cluster at the time of archiving the last oplog.

{% include [mmg-pitr-preview-note](../../_includes/mdb/mmg-pitr-preview-note.md) %}

{% list tabs %}

- Management console

   To restore an existing cluster from a backup:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

   1. Click the cluster name and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.

   1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

   1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.

   1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

   To restore a previously deleted cluster from a backup:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

   1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

   1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.mdb.cluster.backups.column_name }}** column contains IDs in `<cluster_ID>:<backup_ID>` format.

   1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

   1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.

   1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

   {{ mmg-name }} will launch the operation to create a cluster from the backup.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To restore a cluster from a backup:

   1. View a description of the CLI restore {{ MG }} cluster command:

      ```bash
      {{ yc-mdb-mg }} cluster restore --help
      ```

   1. Getting a list of available {{ MG }} cluster backups:

      ```bash
      {{ yc-mdb-mg }} backup list
      ```

      Result:

      ```text
      +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
      |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |  SIZE  |   TYPE    |
      +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
      | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 | 3.3 KB | AUTOMATED |
      | ...                                                                                         |                    |
      +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
      ```

      The time when the backup was completed is shown in the `CREATED AT` column with a list of available backups, in `yyyy-mm-dd hh:mm:ss` format (`2020-08-10 12:00:00` in the example above). You can restore a cluster to any point in time starting with creation of its backup.

   1. Run the command to create a new cluster from a backup (the example shows only some parameters):

      
      ```bash
       {{ yc-mdb-mg }} cluster restore \
          --backup-id <backup_ID> \
          --recovery-target-timestamp <timestamp> \
          --mongodb-version <{{ MG }}_version> \
          --name <new_cluster_name> \
          --environment <environment> \
          --network-name <network_name> \
          --host zone-id=<availability_zone>,`
                `subnet-id=<subnet_ID> \
          --mongod-resource-preset <host_class> \
          --mongod-disk-size <storage_size_GB> \
          --mongod-disk-type <disk_type> \
          --performance-diagnostics=<enable_diagnostics>
      ```


      Where:

      * `--recovery-target-timestamp`: Time point to which you want to restore the {{ MG }} cluster, in the [UNIX time](https://en.wikipedia.org/wiki/Unix_time) format. If you do not specify the parameter, the cluster will be restored to when the backup was completed.
      * `--environment`: Environment, `PRESTABLE` or `PRODUCTION`.

      
      * `--mongod-disk-type`: Disk type, `network-hdd` or `network-ssd`.


      * `--performance-diagnostics`: Enable performance diagnostics for the cluster, `true` or `false`.

- API

   To restore an existing cluster from a backup, use the [restore](../api-ref/Cluster/restore.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Restore](../api-ref/grpc/cluster_service.md#Restore) gRPC API call and provide the following in the request:

   * Backup ID in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
   * Name of the new cluster that will contain the data recovered from the backup, in the `name` parameter. It must be unique within the folder.

   In the `recoveryTargetSpec.timestamp` parameter, specify the point in time to which you want to restore the {{ MG }} cluster in the [UNIX time](https://en.wikipedia.org/wiki/Unix_time) format. If you do not specify the parameter, the cluster will be restored to when the backup was completed.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
   1. Click the cluster name and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

   {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster backup:

   1. View a description of the CLI create {{ MG }} backup command:

      ```bash
      {{ yc-mdb-mg }} cluster backup --help
      ```

   1. Request a backup to be created by specifying the cluster name or ID:

      ```bash
      {{ yc-mdb-mg }} cluster backup <cluster_name_or_ID>
      ```

      You can get the cluster ID and name with a [list of clusters](cluster-list.md#list-clusters).

- API

   To create a backup, use the [backup](../api-ref/Cluster/backup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Backup](../api-ref/grpc/cluster_service.md#Backup) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

   To get a list of cluster backups:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
   1. Click the cluster name and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.

   To get a list of all backups in a folder:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

   These lists contain the following information:

   * Backup name.
   * Source shard.
   * Backup size.
   * Backup type: `Automated` or `Manual`.
   * Start time of backup creation in UTC (Coordinated Universal Time).
   * End time of backup creation in UTC.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of {{ MG }} cluster backups available in the default folder, run the command:

   ```bash
   {{ yc-mdb-mg }} backup list
   ```

   Result:

   ```text
   +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
   |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |  SIZE  |   TYPE    |
   +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
   | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 | 3.3 KB | AUTOMATED |
   | c9qpm90p3pcg********:... | 2020-08-09 22:01:04 | c9qpm90p3pcg******** | 2020-08-09 21:30:00 | 30 KB  | MANUAL    |
   +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
   ```

   The resulting table contains the following information:
   * ID of the backup.
   * End time of backup creation in UTC (Coordinated Universal Time).
   * ID of the cluster that the backup was created for.
   * Start time of backup creation in UTC.
   * Backup size.
   * Backup type: `Automated` or `Manual`.

- API

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

   To get a list of backups for all the {{ mmg-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/List](../api-ref/grpc/backup_service.md#List) gRPC API call and provide the folder ID in the `folderId` request parameter.

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs %}

- Management console

   To get information about the backup of an existing cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
   1. Click the cluster name and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.

   To get information about the backup of a previously deleted cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ MG }} cluster backup, run the command:

   ```bash
   {{ yc-mdb-mg }} backup get <backup_ID>
   ```

   You can retrieve the backup ID with a [list of backups](#list-backups).

- API

   To get information about a backup, use the [get](../api-ref/Backup/get.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/Get](../api-ref/grpc/backup_service.md#Get) gRPC API call and provide the backup ID in the `backupId` request parameter.

   To find out the ID, [retrieve a list of backups](#list-backups).

{% endlist %}

## Examples {#examples}

Create a new {{ mmg-name }} cluster from a backup with the following test characteristics:


* Backup for recovery: `c9qlk4v13uq7********:...`.
* Point in time to restore to: `1597060810` (`2020-08-10 12:00:10`).
* Version: `4.2`.
* Name of the new cluster: `mynewmg`.
* Environment: `PRODUCTION`.
* Network: `{{ network-name }}`.
* One `{{ host-class }}` host in the `{{ region-id }}-a` availability zone and `b0rcctk2rvtr********` subnet.
* With 20 GB of SSD network storage (`{{ disk-type-example }}`).
* With databases and users that existed in the cluster at the time of recovery.


{% list tabs %}

- CLI

   Run the following command:

   
   ```bash
   {{ yc-mdb-mg }} cluster restore \
      --backup-id c9qlk4v13uq7********:... \
      --recovery-target-timestamp 1597060810 \
      --mongodb-version 4.2 \
      --name mynewmg \
      --environment PRODUCTION \
      --network-name {{ network-name }} \
      --host {{ host-net-example }} \
      --mongod-resource-preset {{ host-class }} \
      --mongod-disk-size 20 \
      --mongod-disk-type {{ disk-type-example }}
   ```


{% endlist %}
