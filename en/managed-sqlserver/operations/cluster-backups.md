---
title: "SQL Server backup management"
description: "You can back up and restore clusters from your existing SQL Server backups. Point-in-Time Recovery (PITR) technology allows you to restore the state of the cluster to any point in time from the backup to the current moment."
---

# Managing backups

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{% note warning %}

You can't use SQL commands to modify the [recovery model]({{ ms.docs }}/sql/relational-databases/backup-restore/recovery-models-sql-server?view=sql-server-2016) for backup and restore operations.

{% endnote %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console


  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.


- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of {{ MS }} cluster backups available in a folder, run the command:

   ```bash
   {{ yc-mdb-ms }} backup list
   ```

- API

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To get a list of backups for all the {{ mms-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) API method and pass the folder ID in the `folderId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs %}

- Management console


   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.


- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ MS }} cluster backup, run the command:

   ```bash
   {{ yc-mdb-ms }} backup get <backup ID>
   ```

   You can retrieve the backup ID with a [list of backups](#list-backups).

- API

   Use the [get](../api-ref/Backup/get.md) API method and pass the backup ID in the `backupId` request parameter. To find out the ID, [retrieve a list of backups](#list-backups).

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. Click **Create backup**.

   **{{ mms-name }}** launches the operation to create a backup.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster backup:

   1. View a description of the CLI create {{ MS }} backup command:

      ```bash
      {{ yc-mdb-ms }} cluster backup --help
      ```

   1. Request a backup to be created by specifying the cluster name or ID:

      ```bash
      {{ yc-mdb-ms }} cluster backup <cluster ID or name>
      ```

      You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [backup](../api-ref/Cluster/backup.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Restoring from backups {#restore}

Point-in-Time Recovery (PITR) technology lets you restore the state of a cluster or an individual database to any point in time between the oldest full backup and archiving the most recent transaction log. For more information, see [{#T}](../concepts/backup.md).

For example, if a backup operation completed at 12:00:00 UTC on August 10, 2020, the current date is August 15, 2020 at 19:00:00 UTC, and the latest transaction log was saved at 18:50:00 UTC on August 15, 2020, you can restore the cluster to any of its states from 12:00:01 UTC on August 10, 2020  through 18:50:00 UTC on August 15, 2020.

When restoring to the current state, the new cluster or database will indicate:

* The state of the existing cluster or database at of the time of recovery.
* The state of the deleted cluster or database at the time the most recent transaction log was archived.

### Restoring clusters from backups {#restore-cluster}

When you restore a cluster from a backup, you create a new cluster with data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup.

For a new cluster, you need to set up all [its parameters required at creation](cluster-create.md#create-cluster).

{% list tabs %}

- Management console

   To restore an existing cluster from a backup:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon for the desired backup and click **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. Click **Restore cluster**.


   **{{ mms-name }}** launches the operation to create a cluster from the backup.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To restore a cluster from a backup:

   1. View a description of the CLI restore {{ MS }} cluster command:

      ```bash
      {{ yc-mdb-ms }} cluster restore --help
      ```

   1. Getting a list of available {{ MS }} cluster backups:

      ```bash
      {{ yc-mdb-ms }} backup list
      ```

      Result:

      ```text
      +-------------------+---------------------+----------------------+---------------------+-----------+
      |        ID         |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      | DATABASES |
      +-------------------+---------------------+----------------------+---------------------+-----------+
      | c9qk4hml9r9ng0... | 2022-01-13 13:59:57 | c9qk4hml9r9ng00hd0v3 | 2022-01-13 13:59:55 | [db1 db2] |
      | ...               |                     |                      |                     |           |
      +-------------------+---------------------+----------------------+---------------------+-----------+
      ```

      The time the backup was completed is shown in the `CREATED AT` column containing a list of available backups in `yyyy-mm-dd hh:mm:ss` format (`2022-01-13 13:59:57` in the example above). You can restore a cluster to any point in time starting with the point when the backup is created.

   1. Request that a cluster be restored from a backup (the parameter list in the example is not exhaustive):

      ```bash
      {{ yc-mdb-ms }} cluster restore \
         --backup-id=<backup ID> \
         --time=<point in time to restore {{ MS }} cluster to> \
         --name=<cluster name> \
         --sqlserver-version=<{{ MS }} version> \
         --environment=<environment: PRESTABLE or PRODUCTION> \
         --network-name=<network name> \
         --host zone-id=<availability zone>,`
               `subnet-id=<subnet ID>,`
               `assign-public-ip=<host access via public IP: true or false> \
         --resource-preset=<host class> \
         --disk-size=<storage size, GB> \
         --disk-type=<storage type>
      ```

      Where:

      * `--backup-id`: [backup](../concepts/backup.md) ID
      * `--time`: Point in time to which you need to restore a {{ MS }} cluster's state, in `yyyy-mm-ddThh:mm:ssZ` format.
      * `--name`: The cluster name.
      * `--sqlserver-version`: The {{ MS }} version.
      * `--environment`: Environment:
         * `PRODUCTION`: For stable versions of your apps.
         * `PRESTABLE`: For testing, including the {{ MS}} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
      * `--network-name`: The [name of the network](../../vpc/concepts/network.md#network).
      * `--host`: Host parameters:
         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
         * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). It is required if the selected availability zone includes 2 or more subnets.
         * `assign-public-ip`: Flag to specify if a host requires a [public IP address](../../vpc/concepts/address.md#public-addresses).
      * `--resource-preset`: [host class](../concepts/instance-types.md#available-flavors).
      * `--disk-size`: Storage size in GB.
      * `--disk-type`: [Storage type](../concepts/storage.md):
         * `network-hdd`
         * `network-ssd`
         * `local-ssd`
         * `network-ssd-nonreplicated`

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

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To restore a database from a backup:

   1. View a description of the CLI command to restore a {{ MS }} database:

      ```bash
      {{ yc-mdb-ms }} database restore --help
      ```

   1. Getting a list of available {{ MS }} cluster backups:

      ```bash
      {{ yc-mdb-ms }} backup list
      ```

      Result:

      ```text
      +-------------------+---------------------+----------------------+---------------------+-----------+
      |        ID         |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      | DATABASES |
      +-------------------+---------------------+----------------------+---------------------+-----------+
      | c9qk4hml9r9ng0... | 2022-01-13 13:59:57 | c9qk4hml9r9ng00hd0v3 | 2022-01-13 13:59:55 | [db1 db2] |
      | ...               |                     |                      |                     |           |
      +-------------------+---------------------+----------------------+---------------------+-----------+
      ```

      The time the backup was completed is shown in the `CREATED AT` column containing a list of available backups in `yyyy-mm-dd hh:mm:ss` format (`2022-01-13 13:59:57` in the example above). You can restore a database to any point in time starting with the point when the backup is created.

   1. Restore a database from a backup (the parameter list in the example is not exhaustive):

      ```bash
      {{ yc-mdb-ms }} database restore <new database name> \
         --cluster-name=<cluster name> \
         --backup-id=<backup ID> \
         --from-database=<database name> \
         --time=<point in time to which you need to restore your database>
      ```

      Where:

      * `--cluster-name` is the name of a cluster.
         The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).
      * `--backup-id`: [backup](../concepts/backup.md) ID
      * `--from-database`: Name of database whose backup you will be restoring.
      * `--time`: Point in time to which you need to restore a database, in `yyyy-mm-ddThh:mm:ssZ` format.

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

   In the management console, you can set the backup start time when [creating](cluster-create.md) or [updating a cluster](update.md).

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To set a backup start time, pass the desired value in `HH:MM:SS` format in the `--backup-window-start` argument to the cluster update command:

   ```bash
   {{ yc-mdb-ms }} cluster update <cluster ID or name> \
       --backup-window-start=<backup start time>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add a block named `backup_window_start` to the {{ mms-name }} cluster description under `config`:

      ```hcl
      resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
        ...
        config {
          backup_window_start {
            hours   = <Backup start hour (UTC)>
            minutes = <Backup start minute (UTC)>
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

   {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   - The new backup start time, in the `configSpec.backupWindowStart` parameter.
   - List of cluster configuration fields to update in the `updateMask` parameter (`uiProxy` in this case).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


## Exporting a database backup to {{ objstorage-full-name }} {#objstorage-export}

{% note info %}

The most recent backup is exported rather than the current database state. If you are looking to export up-to-date information, [create a new backup](#create-backup) first.

{% endnote %}

To export a database backup to a [{{ objstorage-name }} bucket](../../storage/concepts/bucket.md):

1. Prepare the infrastructure:

   1. [Create a bucket](../../storage/operations/buckets/create.md) in {{ objstorage-name }}. By default, buckets are created with [restricted access](../../storage/concepts/bucket.md#bucket-access). We don't recommend editing access parameters because backups are exported in unencrypted form.
   1. [Create a service account](../../iam/quickstart-sa#create-sa) and [link it to your cluster](./update.md#service-account). Any actions applicable to {{ objstorage-name }} will use this account.
   1. Grant the service account read and write permissions to the bucket using one of the methods below:

      * [Configure an ACL for the bucket](../../storage/operations/buckets/edit-acl.md) by adding a service account to the list and granting it `READ and WRITE` permissions (recommended).
      * [Assign the service account](../../iam/operations/sa/assign-role-for-sa.md) the `storage.uploader` role.

1. Perform the export:

   {% list tabs %}

   - Management console

      1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
      1. Click on the name of the cluster you need and select the **Databases** tab.
      1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the desired database and select **Export**.
      1. Specify the settings for the export operation:

         * **Bucket name**: Name of the bucket in {{ objstorage-name }} where the database files will be saved.
         * **Bucket directory**: Path to the bucket folder. The path must be specified in absolute terms and must start with `/`. The folder must be empty.
         * **Backup name prefix**: Arbitrary file name prefix. For large databases, several files will be created in the folder with names like `<prefix>_000.bak`, `<prefix>_001.bak`, and so on.

      1. Click **Export**.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run the command:

      ```bash
      {{ yc-mdb-ms }} database backup-export \
         --cluster-name <cluster name> \
         --bucket=<bucket name> \
         --path=<folder path> \
         --prefix=<filename prefix> \
         <database name>
      ```

      Where:

      * `--cluster-name` is the name of a {{ mms-name }} cluster.
      * `--bucket`: The name of bucket in {{ objstorage-name }} to save database files.
      * `--path`: The path to the file in the bucket. The path must be absolute and must begin with a `/`. The folder must be empty.
      * `--prefix`: The filename prefix, freeform. For large databases, several files will be created in the folder with names like `<prefix>_000.bak`, `<prefix>_001.bak`, and so on.
      * `<database name>`: The name of the database to export a backup of. To find out the name, [get a list of databases in the cluster](databases.md#list-db).

   - API

      Use the API [exportBackup](../api-ref/Database/exportBackup.md) method and pass the following in the request:

      * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
      * Name of the database being exported, in `databaseName` parameter. To find out the name, [get a list of databases in the cluster](databases.md#list-db).
      * Name of the bucket in {{ objstorage-name }} to use to export the backup to, in the `s3Bucket` parameter.
      * Path to the file to save backup files in, in the `s3Path` parameter. The path must be absolute and must begin with a `/`. The folder must be empty.
      * Prefix for backup filenames, in the `prefix` parameter. For large databases, several files will be created in the folder with names like `<prefix>_000.bak`, `<prefix>_001.bak`, and so on.

   {% endlist %}

The database backup will be saved in the specified {{ objstorage-name }} bucket folder.

## Restoring a database from a backup stored in {{ objstorage-full-name }} {#objstorage-import}

In a cluster, to restore a database from a backup stored in a [{{ objstorage-name }} bucket](../../storage/concepts/bucket.md):

1. Prepare the infrastructure:

   1. [Create a service account](../../iam/quickstart-sa#create-sa) and [link it to your cluster](./update.md#service-account). Any actions applicable to {{ objstorage-name }} will use this account.
   1. Grant the service account read permissions to the bucket using one of the methods below:

      * [Configure an ACL for the bucket](../../storage/operations/buckets/edit-acl.md) by adding a service account to the list and granting it `READ` (recommended) permission.
      * [Assign the service account](../../iam/operations/sa/assign-role-for-sa.md) the `storage.viewer` role.

1. Perform a restore:

   {% list tabs %}

   - Management console

      1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
      1. Click on the name of the cluster you need and select the **Databases** tab.
      1. Click ![image](../../_assets/plus-sign.svg) **Import**.
      1. Specify the settings for the import operation:

         * **New database name**: Name of the database to restore from a backup in the cluster. At the time of the restore, the cluster should have no databases with the same name.
         * **Bucket name**: Name of the bucket in {{ objstorage-name }} storing the database backup.
         * **Bucket folder**: Path to the folder storing the backup files. The path must be absolute and must begin with a `/`.
         * **Backup file list**: Backup file name in the directory. Click **Add** and enter all the backup file names if there are more than one. All the files specified must exist.

      1. Click **Import**.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run the command:

      ```bash
      {{ yc-mdb-ms }} database backup-import \
         --cluster-name <cluster name> \
         --bucket=<bucket name> \
         --path=<absolute bucket folder path> \
         --files=<file1>.bak,<file2>.bak,... \
         <database name>
      ```

      Where:

      * `--cluster-name` is the name of a {{ mms-name }} cluster.
      * `--bucket`: The name of the bucket in {{ objstorage-name }} storing database backup.
      * `--path`: The path to the folder storing backup files. The path must be absolute and must begin with a `/`.
      * `--files`: The list of backup files in the `--path` folder. All the files specified must exist.
      * `<database name>`: The name of the cluster database to restore from a backup. At the time of the restore, the cluster should have no databases with the same name.

         {% include [database-name-limits](../../_includes/mdb/mms/note-info-db-name-limits.md) %}

   - API

      Use the API [importBackup](../api-ref/Database/importBackup.md) method and pass the following in the call:

      * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
      * Name of the database to be restored in the `databaseName` parameter. At the time of the restore, the cluster should have no databases with the same name.

         {% include [database-name-limits](../../_includes/mdb/mms/note-info-db-name-limits.md) %}

      * Name of the bucket in {{ objstorage-name }} storing the backup, in the `s3Bucket` parameter.
      * Path to the folder storing backup files, in the `s3Path` parameter. The path must be absolute and must begin with a `/`.
      * List of backup files in the `files[]` array.
      * List of cluster configuration fields to update in the `UpdateMask` parameter.

      {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

   {% endlist %}

The database will be restored from the backup in the {{ mms-name }} cluster.

To grant users access to the restored database, [follow the instructions](cluster-users.md#update-settings).

