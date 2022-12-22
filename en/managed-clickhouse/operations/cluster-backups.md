---
title: "Managing {{ CH }} backups"
description: "You can create backups and restore clusters from existing {{ CH }} backups. When you restore a cluster from a backup, you create a new cluster with data from the backup. If the cloud does not have sufficient resources to create such a cluster, you will not be able to restore from a backup."
---

# Managing backups in {{ mch-name }}

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

## Creating a backup {#create-backup}

{% note warning %}

A random replica host is used to create a backup. If there is no cluster host data consistency, restoring clusters from backups does not guarantee complete data recovery. For more information, see [{#T}](../concepts/backup.md).

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. Click **Create backup**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster backup:

   1. View a description of the CLI create {{ CH }} backup command:

      ```bash
      {{ yc-mdb-ch }} cluster backup --help
      ```

   1. Request the creation of a backup specifying the cluster name or ID:

      ```bash
      {{ yc-mdb-ch }} cluster backup <cluster ID or name>
      ```

      You can get a cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [backup](../api-ref/Cluster/backup.md) API method and pass the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with data from the backup. If the cloud has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps per database core.

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type (a {{ CH }} backup cannot be restored as a {{ PG }} cluster). You can restore an individual [shard](../concepts/sharding.md) or the whole cluster. You can restore the whole cluster only by using the CLI or API.

{% include [mch-mergetree-conversion](../../_includes/mdb/mch-restore-tables-conversion-alert.md) %}

{% list tabs %}

- Management console

   To restore an existing cluster from a backup:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) for the desired backup and click **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. Click **Restore cluster**.

   To restore a previously deleted cluster from a backup:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mch-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.
   1. Find the desired backup using the backup creation time and cluster ID. The **Name** column contains the IDs in `<cluster ID>:<backup ID>` format.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) for the desired backup and click **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. Click **Restore cluster**.

   {{ mch-name }} launches the operation to create a cluster from the backup.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To restore a cluster from a backup:

   1. View a description of the CLI restore {{ CH }} cluster command:

      ```bash
      {{ yc-mdb-ch }} cluster restore --help
      ```

   1. Getting a list of available {{ CH }} cluster backups:

      ```bash
      {{ yc-mdb-ch }} backup list
      ```

      ```text
      +--------------------------+---------------------+----------------------+---------------------+-------------+
      |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      | SHARD NAMES |
      +--------------------------+---------------------+----------------------+---------------------+-------------+
      | c9qnfsq7tiscc7j281h0:... | 2022-03-09 14:24:55 | c9qnfsq7tiscc7j281h0 | 2022-03-09 14:23:55 | shard2      |
      | c9qnfsq7tiscc7j281h0:... | 2022-03-09 14:16:39 | c9qnfsq7tiscc7j281h0 | 2022-03-09 14:16:37 | shard1      |
      | ...                                                                                         |             |
      +--------------------------+---------------------+----------------------+---------------------+-------------+
      ```

   1. To restore an individual shard, pass the ID of a single backup:

      {% if audience == "internal" %}

      ```bash
      {{ yc-mdb-ch }} cluster restore \
         --backup-id=<backup ID> \
         --name=<cluster name> \
         --environment=<environment: PRESTABLE or PRODUCTION> \
         --network-name={{ network-name }} \
         --host type=<clickhouse or zookeeper>,`
               `zone-id=<availability zone> \
         --clickhouse-disk-size=<storage size in GB> \
         --clickhouse-disk-type=<disk type> \
         --clickhouse-resource-preset=<host class>
      ```

      {% else %}

      ```bash
      {{ yc-mdb-ch }} cluster restore \
         --backup-id=<backup ID> \
         --name=<cluster name> \
         --environment=<environment: PRESTABLE or PRODUCTION> \
         --network-name=<network name> \
         --host type=<host type: clickhouse or zookeeper>,`
               `zone-id=<availbility zone>,`
               `subnet-id=<subnet ID> \
         --clickhouse-disk-size=<storage size in GB> \
         --clickhouse-disk-type=<disk type> \
         --clickhouse-resource-preset=<host class>
      ```

      {% endif %}

      Where:

      * `--backup-id`: [backup](../concepts/backup.md) ID
      * `--name`: The cluster name.
      * `--environment`: Environment:

         * `PRODUCTION`: For stable versions of your apps.
         * `PRESTABLE`: For testing, including the {{ MS}} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.

      * `--network-name`: {% if audience != "internal" %}[Network name](../../vpc/concepts/network.md#network){% else %}Network name{% endif %}.
      * `--host`: Host parameters:

         * `type`: Host type: `clickhouse` or `zookeeper`.
         * `zone-id`: {% if audience != "internal" %}[Availability zone](../../overview/concepts/geo-scope.md){% else %}Availability zone{% endif %}.
            {% if audience != "internal" %}* `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). It is required if the selected availability zone includes two or more subnets.{% endif %}

      * `--resource-preset`: [host class](../concepts/instance-types.md#available-flavors).
      * `--disk-size`: Storage size in GB.
      * `--disk-type`: The [type of disk](../concepts/storage.md):
         {% if audience != "internal" %}

         * `network-hdd`
         * `network-ssd`
         * `local-ssd`
         * `network-ssd-nonreplicated`

         {% else %}

         * `local-ssd`
         * `local-hdd`
         {% endif %}

   1. To restore the whole cluster, pass backup IDs for all cluster shards:

      ```bash
      {{ yc-mdb-ch }} cluster restore \
         --backup-id=<list of backup IDs for all shards> \
         ...
      ```

- API

   Use the [restore](../api-ref/Cluster/restore.md) API method and pass the following in the request:

   * Backup ID of the appropriate shard in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
   * The name of the new cluster that will contain the data recovered from the backup, in the `name` parameter. The cluster name must be unique within the folder.
   * The environment of the cluster, in the `environment` parameter.
   * Cluster configuration, in the `configSpec` parameter.
   * Configuration of the cluster hosts, in one or more `hostSpecs` parameters.
   * Network ID, in the `networkId` parameter.

   To restore the whole cluster, pass backup IDs for the remaining cluster shards in the `additionalBackupIds`parameter:

{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

   To get a list of cluster backups:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.

   To get a list of all backups in a folder:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mch-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of {{ CH }} cluster backups available in the default folder, run the command:

   ```bash
   {{ yc-mdb-ch }} backup list
   ```

   ```text
   +--------------------------+---------------------+----------------------+---------------------+-------------+
   |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      | SHARD NAMES |
   +--------------------------+---------------------+----------------------+---------------------+-------------+
   | c9qnfsq7tiscc7j281h0:... | 2022-03-09 14:24:55 | c9qnfsq7tiscc7j281h0 | 2022-03-09 14:23:55 | shard2      |
   | c9qnfsq7tiscc7j281h0:... | 2022-03-09 14:16:39 | c9qnfsq7tiscc7j281h0 | 2022-03-09 14:16:37 | shard1      |
   | ...                                                                                         |             |
   +--------------------------+---------------------+----------------------+---------------------+-------------+
   ```

- API

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To get a list of backups for all the {{ mch-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) API method and pass the folder ID in the `folderId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}


## Getting information about backups {#get-backup}

{% list tabs %}

- Management console

   To get information about the backup of an existing cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.

   To get information about the backup of a previously deleted cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mch-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ CH }} cluster backup, run the command:

   ```bash
   {{ yc-mdb-ch }} backup get <backup ID>
   ```

   You can retrieve the backup ID with a [list of backups](#list-backups).

- API

   Use the [get](../api-ref/Backup/get.md) API method and pass the backup ID in the `backupId` request parameter.

   To find out the ID, [retrieve a list of backups](#list-backups).

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs %}

- Management console

   In the [management console]({{ link-console-main }}), you can set the backup start time when [creating](cluster-create.md) or [updating](update.md) a cluster.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To set a backup start time, pass the desired value in `HH:MM:SS` format in the `--backup-window-start` argument to the cluster update command:

   ```bash
   {{ yc-mdb-ch }} cluster update <cluster ID or name> \
      --backup-window-start=<backup start time>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. You can get it together [with a list of clusters in the folder](cluster-list.md#list-clusters).
   * The new backup start time, in the `configSpec.backupWindowStart` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (`configSpec.backupWindowStart` in this case).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
