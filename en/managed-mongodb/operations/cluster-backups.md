---
title: "Managing MongoDB backups"
description: "You can create backups and restore clusters from existing MongoDB backups. The Point-in-Time Recovery (PITR) technology enables you to restore cluster state to any point in time starting with the moment a backup was created."
---

# Managing backups in {{ mmg-name }}

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

## Restoring clusters from backups {#restore}

Point-in-Time Recovery (PITR) technology lets you restore the cluster state to any point in time between when the oldest backup was created and when the most recent oplog was archived. For more information, see [{#T}](../concepts/backup.md).

For example, if the backup operation ended August 10, 2020, 12:00:00 UTC, the current date is August 15, 2020, 19:00:00 UTC, and the latest oplog was saved August 15, 2020, 18:50:00 UTC, the cluster can be restored to any state between August 10, 2020, 12:00:01 UTC and August 15, 2020, 18:50:00 UTC inclusive.

{% note warning %}

* PITR only works for clusters with {{ MG }} version 4.2 and higher.
* PITR is not supported for clusters with [sharding](../tutorials/sharding.md) enabled. Such clusters can be restored only to the point in time when the selected backup was created.

{% endnote %}

When you restore a cluster from a backup, you create a new cluster with data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps.

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type (a {{ MG }} backup cannot be restored as a {{ PG }} cluster).

When restoring to the current state, the new cluster will reflect the state of:

* An existing cluster at the time of recovery.
* A deleted cluster at the time of archiving the last oplog.

{% include [mmg-pitr-preview-note](../../_includes/mdb/mmg-pitr-preview-note.md) %}

{% list tabs %}

- Management console

   To restore an existing cluster from a backup:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.

   1. Click on the name of the cluster you need and select ![image](../../_assets/mdb/backup.svg) **Backup copies**.

   1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the desired backup and then click **Restore cluster**.

   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.

   1. Click **Restore cluster**.

   To restore a previously deleted cluster from a backup:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.

   1. Find the desired backup using the backup creation time and cluster ID. The **Name** column contains the IDs in `<cluster ID>:<backup ID>` format.

   1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the desired backup and then click **Restore cluster**.

   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.

   1. Click **Restore cluster**.

   {{ mmg-name }} launches the operation to create a cluster from the backup.

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
      | c9qlk4v13uq79r9cgcku:... | 2020-08-10 12:00:00 | c9qlk4v13uq79r9cgcku | 2020-08-10 11:55:17 | 3.3 KB | AUTOMATED |
      | ...                                                                                         |                    |
      +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
      ```

      The time when the backup was completed is shown in the `CREATED AT` column with a list of available backups, in `yyyy-mm-dd hh:mm:ss` format (`2020-08-10 12:00:00` in the example above). You can restore a cluster to any point in time starting with creation of its backup.

   1. Run the command to create a new cluster from a backup (the example shows only some parameters):

      
      ```bash
       {{ yc-mdb-mg }} cluster restore \
          --backup-id <backup ID> \
          --recovery-target-timestamp <point in time> \
          --mongodb-version <{{ MG }} version> \
          --name <name of new cluster> \
          --environment <environment: PRESTABLE or PRODUCTION> \
          --network-name <network name> \
          --host zone-id=<availability zone>,`
                `subnet-id=<subnet ID> \
          --mongod-resource-preset <host class> \
          --mongod-disk-size <storage size in GB> \
          --mongod-disk-type <disk type: network-hdd, network-ssd, local-ssd, or network-ssd-nonreplicated>
      ```


      In the `--recovery-target-timestamp` parameter, specify the point in time to which you want to restore the {{ MG }} cluster in [UNIX time](https://en.wikipedia.org/wiki/Unix_time) format. If you don't specify the parameter, the cluster is restored to when the backup was completed.

- API

   Use the [restore](../api-ref/Cluster/restore.md) API method and pass the following in the request:

   * ID of the desired backup, in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
   * The name of the new cluster that will contain the data recovered from the backup, in the `name` parameter. The cluster name must be unique within the folder.

   In the `recoveryTargetSpec.timestamp` parameter, specify the point in time to which you want to restore the {{ MG }} cluster in [UNIX time](https://en.wikipedia.org/wiki/Unix_time) format. If you don't specify the parameter, the cluster is restored to when the backup was completed.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of the cluster you need and select ![image](../../_assets/mdb/backup.svg) **Backup copies**.
   1. Click **Create backup**.

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
      {{ yc-mdb-mg }} cluster backup <cluster ID or name>
      ```

      You can fetch the cluster ID and name with a [list of clusters](cluster-list.md#list-clusters).

- API

   Use the [backup](../api-ref/Cluster/backup.md) API method and pass the cluster ID in the `clusterId` request parameter.

   The cluster ID can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

   To get a list of cluster backups:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of the cluster you need and select ![image](../../_assets/mdb/backup.svg) **Backup copies**.

   To get a list of all backups in a folder:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.

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
   +----------+---------------------+----------------------+---------------------+--------+-----------+
   |    ID    |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |  SIZE  |   TYPE    |
   +----------+---------------------+----------------------+---------------------+--------+-----------+
   | c9qlk... | 2020-08-10 12:00:00 | c9qlk4v13uq79r9cgcku | 2020-08-10 11:55:17 | 3.3 KB | AUTOMATED |
   | c9qpm... | 2020-08-09 22:01:04 | c9qpm90p3pcg71jm7tqf | 2020-08-09 21:30:00 | 30 KB  | MANUAL    |
   +----------+---------------------+----------------------+---------------------+--------+-----------+
   ```

   The resulting table contains the following information:
   * ID of the backup.
   * End time of backup creation in UTC (Coordinated Universal Time).
   * ID of the cluster that the backup was created for.
   * Start time of backup creation in UTC.
   * Backup size.
   * Backup type: `Automated` or `Manual`.

- API

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) API method and pass the cluster ID in the `clusterId` request parameter. The cluster ID can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

   To get a list of backups for all the {{ mmg-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) API method and pass the folder ID in the `folderId` request parameter.

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs %}

- Management console

   To get information about the backup of an existing cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of the cluster you need and select ![image](../../_assets/mdb/backup.svg) **Backup copies**.

   To get information about the backup of a previously deleted cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ MG }} cluster backup, run the command:

   ```bash
   {{ yc-mdb-mg }} backup get <backup ID>
   ```

   You can retrieve the backup ID with a [list of backups](#list-backups).

- API

   Use the [get](../api-ref/Backup/get.md) API method and pass the backup ID in the `backupId` request parameter.

   To find out the ID, [retrieve a list of backups](#list-backups).

{% endlist %}

## Examples {#examples}

Create a new {{ mmg-name }} cluster from a backup with test characteristics:


* Backup for recovery: `c9qlk4v13uq79r9cgcku:...`.
* Point in time to restore to: `1597060810` (`2020-08-10 12:00:10`).
* Version: `4.2`.
* Name of the new cluster: `mynewmg`.
* Environment: `PRODUCTION`.
* Network: `{{ network-name }}`.
* One `{{ host-class }}` host in the `{{ region-id }}-a` availability zone and `b0rcctk2rvtr8efcch64` subnet.
* With 20 GB of SSD network storage (`{{ disk-type-example }}`).
* With databases and users that existed in the cluster at the time of recovery.


{% list tabs %}

- CLI

   Run the following command:

   
   ```bash
   {{ yc-mdb-mg }} cluster restore \
      --backup-id c9qlk4v13uq79r9cgcku:... \
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
