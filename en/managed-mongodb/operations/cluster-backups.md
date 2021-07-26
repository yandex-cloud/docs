---
title: "MongoDB backup management"
description: "You can back up and restore clusters from your existing MongoDB backups. Point-in-Time Recovery (PITR) technology allows you to restore the state of the cluster to any point in time from the backup to the current moment."
---

# Managing backups

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

## Restoring clusters from backups {#restore}

Point-in-Time Recovery (PITR) technology lets you restore the cluster state to any point in time in the interval from its backup to the current point. For example, if the backup operation ended August 10, 2020, 12:00:00 UTC and the current date is August 15, 2020, 19:00:00 UTC, the cluster can be restored to any state between August 10, 2020, 12:00:01 UTC and August 15, 2020, 18:59:59 UTC inclusive.

If the cluster is already deleted, the interval where you can use PITR for recovery is limited to the time of the first and last backup creation. If you attempt to restore such a cluster to a point in time when it was deleted, it is the same as restoring from the latest backup.

{% note warning %}

Note:

- PITR only works for clusters with version 4.2 and higher.
- PITR is not supported for clusters with [sharding](../tutorials/sharding.md) enabled. Such clusters can be restored only to the point in time when the selected backup was created.

To learn more about this technology, see [{#T}](../concepts/backup.md).

{% endnote %}

When you restore a cluster from a backup, you create a new cluster with the data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps.

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type (a {{ MG }} backup cannot be restored as a {{ PG }} cluster).

{% include [mmg-pitr-preview-note](../../_includes/mdb/mmg-pitr-preview-note.md) %}

{% list tabs %}

- Management console

  To restore an existing cluster from a backup:
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the backup and click **Restore cluster**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
  1. Click **Restore cluster**.

  To restore a previously deleted cluster from a backup:
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Click the **Backups** tab.
  1. Find the desired backup using the backup creation time and cluster ID. The **Name** column contains the IDs in `<cluster ID>:<backup ID>` format.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the backup and click **Restore cluster**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
  1. Click **Restore cluster**.

  {{ mmg-name }} launches the operation to create a cluster from a backup.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore a cluster from a backup:

  1. View the description of the CLI's restore cluster command {{ MG }}:

      ```
      $ {{ yc-mdb-mg }} cluster restore --help
      ```

  1. Getting a list of available {{ MG }} cluster backups:

     ```
     $ {{ yc-mdb-mg }} backup list
     
     +--------------------------+----------------------+----------------------+----------------------+--------+-----------+
     |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |  SIZE  |   TYPE    |
     +--------------------------+----------------------+----------------------+----------------------+--------+-----------+
     | c9qlk4v13uq79r9cgcku:... | 2020-08-10T12:00:00Z | c9qlk4v13uq79r9cgcku | 2020-08-10T11:55:17Z | 3.3 KB | AUTOMATED |
     | ...                                                                                           |                    |
     +--------------------------+----------------------+----------------------+----------------------+--------+-----------+
     ```

     The time when the backup was completed is shown in the `CREATED AT` column of a list of available backups, in `yyyy-mm-ddThh:mm:ssZ` format (`2020-08-10T12:00:00Z` in the example above). You can restore a cluster to any state from the specified point in time to the current time.

  1. Run the command to create a new cluster from a backup (the example shows only some parameters):

     {% if audience != "internal" %}

     ```
      $ {{ yc-mdb-mg }} cluster restore \
           --backup-id <backup ID> \
           --recovery-target-timestamp <point in time> \
           --mongodb-version "<version {{ MG }}>" \
           --cluster-name  <new cluster name> \
           --environment <environment, PRESTABLE, or PRODUCTION> \
           --network-name <network name> \
           --host zone-id=<availability zone>,subnet-id=<subnet ID> \
           --mongod-resource-preset <host class> \     
           --mongod-disk-size <storage size in GB> \
           --mongod-disk-type <storage type: network-hdd, network-ssd, or local-ssd>
     ```

      {% else %}

      ```
      $ {{ yc-mdb-mg }} cluster restore \
           --backup-id <backup ID> \
           --recovery-target-timestamp <point in time> \
           --mongodb-version "<version {{ MG }}>" \
           --cluster-name  <new cluster name> \
           --environment <environment, PRESTABLE, or PRODUCTION> \
           --network-id <network name> \
           --host zone-id=<availability zone> \
           --mongod-resource-preset <host class> \    
           --mongod-disk-size <storage size in GB> \
           --mongod-disk-type <storage type: network-hdd, network-ssd, or local-ssd>
      ```

      {% endif %}

      In the `--recovery-target-timestamp` parameter, specify the point in time to which you want to restore the {{ MG }} cluster, in [UNIX time](https://en.wikipedia.org/wiki/Unix_time) format. If you want to restore the cluster state to the backup creation time, you may omit this option.

{% endlist %}

## Creating backups {#create-backup}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  1. Click **Create a backup**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster backup:

  1. View a description of the CLI create {{ MG }} backup command:

      ```
      $ {{ yc-mdb-mg }} cluster backup --help
      ```

  1. Request creation of a backup specifying the cluster name or ID:

      ```
      $ {{ yc-mdb-mg }} cluster backup my-mg-cluster
      ```

      The cluster name and ID can be retrieved with the [list of clusters](cluster-list.md#list-clusters).

{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

  To get a list of cluster backups:
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  To get a list of all backups in a folder:
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Click the **Backups** tab.

  These lists contain the following information:
  - Backup name.
  - Source shard.
  - Backup size.
  - Backup type: `Automated` or `Manual`.
  - Start time of backup creation in UTC (Coordinated Universal Time).
  - End time of backup creation in UTC.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ MG }} cluster backups available in the default folder, run the command:

  ```
  $ {{ yc-mdb-mg }} backup list
  
  +----------+----------------------+----------------------+----------------------+--------+-----------+
  |    ID    |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |  SIZE  |   TYPE    |
  +----------+----------------------+----------------------+----------------------+--------+-----------+
  | c9qlk... | 2020-08-10T12:00:00Z | c9qlk4v13uq79r9cgcku | 2020-08-10T11:55:17Z | 3.3 KB | AUTOMATED |
  | c9qpm... | 2020-08-09T22:01:04Z | c9qpm90p3pcg71jm7tqf | 2020-08-09T21:30:00Z | 30 KB  | MANUAL    |
  +----------+----------------------+----------------------+----------------------+--------+-----------+
  ```

  The resulting table contains the following information:
  - ID of the backup.
  - End time of backup creation in UTC (Coordinated Universal Time).
  - ID of the cluster that the backup was created for.
  - Start time of backup creation in UTC.
  - Backup size.
  - Backup type: `Automated` or `Manual`.

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs %}

- Management console

  To get information about the backup of an existing cluster:
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  To get information about the backup of a previously deleted cluster:
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Click the **Backups** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ MG }} cluster backup, run the command:

  ```bash
  {{ yc-mdb-mg }} backup get <backup ID>
  ```

  The backup ID can be retrieved with the [list of backups](#list-backups) .

{% endlist %}

## Examples {#examples}

Let's say we need to create a new {{ MG }} cluster from a backup with the following characteristics:

{% if audience != "internal" %}

- Backup for recovery: `c9qlk4v13uq79r9cgcku:...:stream_20200810T120000Z`.
- Point in time you want to recover to: `1597035610` (`2020-08-10T12:00:10Z`).
- Version: `4.2`.
- Name of the new cluster: `mynewmg`.
- Environment: `PRODUCTION`.
- Network: `{{ network-name }}`.
- One `{{ host-class }}` host in the `{{ zone-id }}` availability zone and `b0rcctk2rvtr8efcch63` subnet.
- Storage: fast network storage (`{{ disk-type-example }}`) 20 GB in size.
- With databases and users that existed in the cluster at the time of recovery.

{% else %}

- Backup for recovery: `c9qlk4v13uq79r9cgcku:...:stream_20200810T120000Z`.
- Point in time you want to recover to: `1597035610` (`2020-08-10T12:00:10Z`).
- Version: `4.2`.
- Name of the new cluster: `mynewmg`.
- Environment: `PRODUCTION`.
- Network: `{{ network-name }}`.
- One `{{ host-class }}` host in the `{{ zone-id }}` availability zone.
- Storage: fast local storage (`{{ disk-type-example }}`) with 20 GB.
- With databases and users that existed in the cluster at the time of recovery.

{% endif %}

{% list tabs %}

- CLI

  To recover from a backup, run the following command:

  {% if audience != "internal" %}

  ```
  $ {{ yc-mdb-mg }} cluster restore \
           --backup-id c9qlk4v13uq79r9cgcku:...:stream_20200810T120000Z \
           --recovery-target-timestamp 1597035610 \
           --mongodb-version "4.2" \
           --cluster-name mynewmg \
           --environment PRODUCTION \
           --network-name {{ network-name }} \
           --host {{ host-net-example }} \
           --mongod-resource-preset {{ host-class }} \ 
           --mongod-disk-size 20 \
           --mongod-disk-type {{ disk-type-example }}
  ```

  {% else %}

  ```
  $ {{ yc-mdb-mg }} cluster restore \
           --backup-id c9qlk4v13uq79r9cgcku:...:stream_20200810T120000Z \
           --recovery-target-timestamp=1597035610 \
           --mongodb-version="4.2" \
           --cluster-name mynewmg \
           --environment=PRODUCTION \
           --network-id {{ network-name }} \
           --host zone-id={{ zone-id }} \
           --mongod-resource-preset {{ host-class }} \  
           --mongod-disk-size 20 \
           --mongod-disk-type {{ disk-type-example }} 
  ```

  {% endif %}

{% endlist %}

