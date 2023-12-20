---
title: "Managing ClickHouse backups"
description: "You can create backups and restore clusters from existing ClickHouse backups. When you restore a cluster from a backup, you create a new cluster with the backup data. If the cloud does not have sufficient resources to create such a cluster, you will not be able to restore your data from a backup."
---

# Managing backups in {{ mch-name }}

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{{ mch-name }} also creates automatic daily backups. You can [set the backup start time](#set-backup-window).

## Creating a backup {#create-backup}

{% note warning %}

Backups are created based on a random replica host. If there is no cluster host data consistency, restoring clusters from backups does not guarantee complete data recovery. For more information, see [Backups](../concepts/backup.md).

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

   {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

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
      {{ yc-mdb-ch }} cluster backup <cluster_name_or_ID>
      ```

      You can get a cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To create a backup, use the [backup](../api-ref/Cluster/backup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Backup](../api-ref/grpc/cluster_service.md#Backup) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the backup data. If the cloud has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps per database core.

You can restore an individual [shard](../concepts/sharding.md) or the whole cluster. You can restore the whole cluster only by using the CLI or API.

{% include [mch-mergetree-conversion](../../_includes/mdb/mch-restore-tables-conversion-alert.md) %}

{% list tabs %}

- Management console

   To restore an existing cluster from a backup:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
   1. Change the settings of the new cluster if required. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

   To restore a previously deleted cluster from a backup:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.clickhouse.switch_backups }}**.
   1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.mdb.cluster.backups.column_name }}** column contains IDs in `<cluster_ID>:<backup_ID>` format.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
   1. Change the settings of the new cluster if required. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

   {{ mch-name }} will launch the operation to create a cluster from the backup.

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
      | c9qnfsq7tisc********:... | 2022-03-09 14:24:55 | c9qnfsq7tisc******** | 2022-03-09 14:23:55 | shard2      |
      | c9qnfsq7tisc********:... | 2022-03-09 14:16:39 | c9qnfsq7tisc******** | 2022-03-09 14:16:37 | shard1      |
      | ...                                                                                         |             |
      +--------------------------+---------------------+----------------------+---------------------+-------------+
      ```

   1. To restore an individual shard, pass the ID of a single backup:

      
      ```bash
      {{ yc-mdb-ch }} cluster restore \
         --backup-id=<backup_ID> \
         --name=<cluster_name> \
         --environment=<environment> \
         --network-name=<network_name> \
         --host type=<host_type>,`
               `zone-id=<availability_zone>,`
               `subnet-id=<subnet_ID> \
         --clickhouse-disk-size=<storage_size_GB> \
         --clickhouse-disk-type=<disk_type> \
         --clickhouse-resource-preset=<host_class>
      ```


      Where:

      * `--backup-id`: [Backup](../concepts/backup.md) ID.
      * `--name`: Cluster name.
      * `--environment`: Environment:

         * `PRODUCTION`: For stable versions of your apps.
         * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.

      * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
      * `--host`: Host parameters:

         * `type`: Host type: `clickhouse` or `zookeeper`.
         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.

      * `--resource-preset`: [Host class](../concepts/instance-types.md#available-flavors).
      * `--disk-size`: Storage size in GB.
      * `--disk-type`: [Disk type](../concepts/storage.md):

         
         * `network-hdd`
         * `network-ssd`

         
         * `local-ssd`
         * `network-ssd-nonreplicated`



   1. To restore the entire cluster, provide backup IDs for all cluster shards:

      ```bash
      {{ yc-mdb-ch }} cluster restore \
         --backup-id=<list_of_IDs_of_backups_of_all_shards> \
         ...
      ```

- API

   To restore a cluster from a backup, use the [restore](../api-ref/Cluster/restore.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Restore](../api-ref/grpc/cluster_service.md#Restore) gRPC API call and provide the following in the request:

   * Backup ID of the appropriate shard in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
   * Name of the new cluster that will contain the data recovered from the backup, in the `name` parameter. It must be unique within the folder.
   * Cluster environment in the `environment` parameter.
   * Cluster configuration in the `configSpec` parameter.
   * Configuration of the cluster hosts in one or more `hostSpecs` parameters.
   * Network ID in the `networkId` parameter.

   To restore the entire cluster, provide backup IDs for the remaining cluster shards in the `additionalBackupIds` parameter:

{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

   To get a list of cluster backups:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}** tab.

   To get a list of all backups in a folder:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.clickhouse.switch_backups }}**.

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
   | c9qnfsq7tisc********:... | 2022-03-09 14:24:55 | c9qnfsq7tisc******** | 2022-03-09 14:23:55 | shard2      |
   | c9qnfsq7tisc********:... | 2022-03-09 14:16:39 | c9qnfsq7tisc******** | 2022-03-09 14:16:37 | shard1      |
   | ...                                                                                         |             |
   +--------------------------+---------------------+----------------------+---------------------+-------------+
   ```

- API

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To get a list of backups for all the {{ mch-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/List](../api-ref/grpc/backup_service.md#List) gRPC API call and provide the folder ID in the `folderId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}


## Getting information about backups {#get-backup}

{% list tabs %}

- Management console

   To get information about the backup of an existing cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}** tab.

   To get information about the backup of a previously deleted cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.clickhouse.switch_backups }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ CH }} cluster backup, run the command:

   ```bash
   {{ yc-mdb-ch }} backup get <backup_ID>
   ```

   You can retrieve the backup ID with a [list of backups](#list-backups).

- API

   To get information about a backup, use the [get](../api-ref/Backup/get.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/Get](../api-ref/grpc/backup_service.md#Get) gRPC API call and provide the backup ID in the `backupId` request parameter.

   To find out the ID, [retrieve a list of backups](#list-backups).

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs %}

- Management console

   In the [management console]({{ link-console-main }}), you can set the backup start time when [creating](cluster-create.md) or [updating](update.md) a cluster.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To set a backup start time, provide the value you need in `HH:MM:SS` format in the `--backup-window-start` argument of the cluster update command:

   ```bash
   {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
      --backup-window-start=<backup_start_time>
   ```

   You can request the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To set the backup start time, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. You can get it together [with a list of clusters in the folder](cluster-list.md#list-clusters).
   * New backup start time in the `configSpec.backupWindowStart` parameter.
   * List of cluster configuration fields to be updated in the `updateMask` parameter (in this case, `configSpec.backupWindowStart`).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
