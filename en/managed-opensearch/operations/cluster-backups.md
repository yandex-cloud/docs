---
title: "Managing {{ OS }} backups (snapshots)"
description: "{{ mos-name }} enables you to use the {{ OS }} snapshot mechanism to manage your data backups. To work with snapshots, use the {{ OS }} public API and a bucket in {{ objstorage-name }} to store them."
keywords:
  - OpenSearch backups
  - OpenSearch snapshots
  - OpenSearch
---

# Managing backups in {{ mos-name }}

{{ mos-short-name }} enables you to create [index](../concepts/indexing.md) backups using both {{ yandex-cloud }} tools and the {{ OS }} snapshot mechanism. To learn more about snapshots, see the [{{ OS }} documentation]({{ os.docs }}/opensearch/snapshots/snapshot-restore/).


## Creating backups with {{ yandex-cloud }} tools {#cloud-backups}

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{{ mos-name }} also creates automatic hourly backups.

### Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

   To get a list of cluster backups:

   1. Go to the folder page and select **{{ mos-name }}**.
   1. Click the name of the cluster you need and select ![backups](../../_assets/mdb/backup.svg) **Backups**.

   To get a list of all backups in a folder:

   1. Go to the folder page and select **{{ mos-name }}**.
   1. Click the ![backups](../../_assets/mdb/backup.svg) **Backups** tab.

- API

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

   To get a list of backups for all the {{ mos-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/List](../api-ref/grpc/backup_service.md#List) gRPC API call and provide the folder ID in the `folderId` request parameter.

{% endlist %}

### Getting information about backups {#get-backup}

{% list tabs %}

- Management console

   To get information about the backup of an existing cluster:

   1. Go to the folder page and select **{{ mos-name }}**.
   1. Click the name of the cluster you need and select ![backups](../../_assets/mdb/backup.svg) **Backups**.

   To get information about the backup of a previously deleted cluster:

   1. Go to the folder page and select **{{ mos-name }}**.
   1. Click the ![backups](../../_assets/mdb/backup.svg) **Backups** tab.

- API

   To get information about a backup, use the [get](../api-ref/Backup/get.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/Get](../api-ref/grpc/backup_service.md#Get) gRPC API call and provide the backup ID in the `backupId` request parameter.

   To find out the backup ID, [retrieve a list of backups](#list-backups).

{% endlist %}

### Creating a backup {#create-backup}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mos-name }}**.
   1. Click the name of the cluster you need and select ![backups](../../_assets/mdb/backup.svg) **Backups**.
   1. Click ![image](../../_assets/plus-sign.svg) **Create backup**.

   {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- API

   To create a backup, use the [backup](../api-ref/Cluster/backup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Backup](../api-ref/grpc/cluster_service.md#Backup) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

### Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup.

When creating a new cluster, set all required parameters.

{% list tabs %}

- Management console

   To restore an existing cluster from a backup:

   1. Go to the folder page and select **{{ mos-name }}**.
   1. Click the name of the cluster you need and select ![backups](../../_assets/mdb/backup.svg) **Backups**.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) for the desired backup and click **Restore cluster**.
   1. Set up the new cluster.
   1. Click **Restore cluster**.

   To restore a previously deleted cluster from a backup:

   1. Go to the folder page and select **{{ mos-name }}**.
   1. Click the ![backups](../../_assets/mdb/backup.svg) **Backups** tab.
   1. Find the desired backup using the backup creation time and cluster ID. The **Name** column contains the IDs in `<cluster ID>:<backup ID>` format.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) for the desired backup and click **Restore cluster**.
   1. Set up the new cluster.
   1. Click **Restore cluster**.

   {{ mos-name }} launches the operation to create a cluster from the backup.

- API

   To restore an existing cluster from a backup, use the [restore](../api-ref/Cluster/restore.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Restore](../api-ref/grpc/cluster_service.md#Restore) gRPC API call and provide the following in the request:

   * ID of the desired backup, in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
   * Name of the new cluster that will contain the data recovered from the backup, in the `name` parameter. It must be unique within the folder.
   * Cluster configuration in the `configSpec` parameter.
   * Network ID in the `networkId` parameter.
   * ID of the folder where the cluster should be placed, in the `folderId` parameter.

{% endlist %}

## Backups using snapshots {#snapshot-backups}

To work with snapshots, use the [public API {{ OS }}]({{ os.docs }}/api-reference/index/) and a bucket in {{ objstorage-name }} to store them.

### Retrieving a snapshot list {#list-snapshots}

1. Find the repository containing snapshot backups in the {{ OS }} repository list:

   ```http
   GET https://admin:<password>@<ID of the {{ OS }} host with the DATA role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/_all
   ```

   If the desired repository is not on the list, [connect it](s3-access.md).

1. Get a list of snapshots in the repository:

   ```http
   GET https://admin:<password>@<ID of the {{ OS }} host with the DATA role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository name>/_all
   ```

   Each snapshot is a single backup.

### Creating a snapshot {#create-snapshot}

1. In the {{ OS }} repository list, find the repository where you want to create the snapshot:

   ```http
   GET https://admin:<password>@<ID of the {{ OS }} host with the DATA role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/_all
   ```

   If the desired repository is not on the list, [connect it](s3-access.md).

1. [Create a snapshot]({{ os.docs }}/opensearch/snapshots/snapshot-restore/#take-snapshots) of the required data or an entire cluster in the selected repository:

   ```http
   PUT https://admin:<password>@<ID of the {{ OS }} host with the DATA role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository name>/<snapshot name>
   ```

### Restoring a cluster from a snapshot {#restore-from-snapshot}

{% note warning %}

When restoring a cluster from a snapshot, the {{ OS }} version in the cluster must be equal to or higher than the {{ OS }} version where the snapshot was taken.

{% endnote %}

1. [Create a new {{ OS }} cluster](cluster-create.md) in the desired configuration, but don't populate it with data.

   When creating a cluster, select:

   * The number and class of hosts as well as the size and type of storage based on snapshot size and performance requirements.

   * The {{ OS }} version used to make the snapshot or higher.

1. Close any open indices using the [{{ OS }} API]({{ os.docs }}/api-reference/index-apis/close-index/):

   ```http
   POST: https://admin:<password>@<ID of the {{ OS }} host with the DATA role>.{{ dns-zone }}:{{ port-mos }}/<index name>/_close
   ```

   To restore an entire cluster, close all open indices. To restore individual indices, close only those indices.

1. [Retrieve a list of backups](#list-snapshots) and find the desired snapshot.
1. [Start restoring]({{ os.docs }}/opensearch/snapshots/snapshot-restore/#restore-snapshots) the entire cluster or individual data indices and streams from the desired snapshot.
