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

You can get a list of backups created for the past 14 days.

{% list tabs group=instructions %}

- Management console {#console}

   To get a list of cluster backups:

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Click the cluster name and select the ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.

   To get a list of all backups in a folder:

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Select the ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of all backups in the folder, run this command:

   ```bash
   {{ yc-mdb-os }} backup list
   ```

   Result:

   ```text
   +----------------------+---------------------+-------------------+---------------------+
   |          ID          |      CREATED AT     | SOURCE CLUSTER ID |      STARTED AT     |
   +----------------------+---------------------+-------------------+---------------------+
   | c9qlk4v13uq7******** | 2024-01-09 14:38:34 | c9qpm4i********   | 2024-01-09 14:38:28 |
   | c9qpm90p3pcg******** | 2024-01-09 13:38:31 | c9qpm4i********   | 2024-01-09 13:38:28 |
   +----------------------+---------------------+-------------------+---------------------+
   ```

   If you want to limit the backup list displayed after running the command, include the `--limit <number_of_records>` flag in the command. For example, if the output of the `{{ yc-mdb-os }} backup list` command takes up several screens, run the `{{ yc-mdb-os }} backup list --limit 5` command. In this case, the output will contain the list of five most recent backups.

- API {#api}

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

   To get a list of backups for all the {{ mos-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/List](../api-ref/grpc/backup_service.md#List) gRPC API call and provide the folder ID in the `folderId` request parameter.

{% endlist %}

### Getting information about backups {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

   To get information about the backup of an existing cluster:

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Click the cluster name and select the ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.

   To get information about the backup of a previously deleted cluster:

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Select the ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about the backup of a cluster:

   1. Retrieve the backup ID with a list of all backups in the folder:

      ```bash
      {{ yc-mdb-os }} backup list
      ```

      You will see the ID in the `ID` column of the command output.

   1. Get information about the backup you need:

      ```bash
      {{ yc-mdb-os }} backup get <backup_ID>
      ```

      Command output example:

      ```text
      id: c9qlk4v13uq7********
      folder_id: {{ folder-id-example }}
      source_cluster_id: c9qpm4i********
      started_at: "2024-01-09T10:38:28.683Z"
      created_at: "2024-01-09T10:38:31.685Z"
      indices:
        - .mdb-sli
        - .opendistro_security
        - .kibana_1
        - .opendistro-job-scheduler-lock
        - .opensearch-observability
        - .opendistro-ism-config
      opensearch_version: 2.8.0
      indices_total: "6"
      ```

- API {#api}

   To get information about a backup, use the [get](../api-ref/Backup/get.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/Get](../api-ref/grpc/backup_service.md#Get) gRPC API call and provide the backup ID in the `backupId` request parameter.

   To find out the backup ID, [retrieve a list of backups](#list-backups).

{% endlist %}

### Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Click the cluster name and select the ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

   {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a backup of cluster data, run this command:

   ```bash
   {{ yc-mdb-os }} cluster backup <cluster_name_or_ID>
   ```

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To create a backup, use the [backup](../api-ref/Cluster/backup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Backup](../api-ref/grpc/cluster_service.md#Backup) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

### Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the backup data. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup.

When creating a new cluster, set all required parameters.

{% list tabs group=instructions %}

- Management console {#console}

   To restore an existing cluster from a backup:

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Click the cluster name and select the ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
   1. Set up the new cluster.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

   To restore a previously deleted cluster from a backup:

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Select the ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.
   1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs in `<cluster_ID>:<backup_ID>` format.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
   1. Set up the new cluster.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

   {{ mos-name }} will launch the operation to create a cluster from the backup.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To restore a cluster from a backup:

   1. Retrieve the backup ID with a list of all backups in the folder:

      ```bash
      {{ yc-mdb-os }} backup list
      ```

      Result:

      ```text
      +----------------------+---------------------+-------------------+---------------------+
      |          ID          |      CREATED AT     | SOURCE CLUSTER ID |      STARTED AT     |
      +----------------------+---------------------+-------------------+---------------------+
      | c9qlk4v13uq7******** | 2024-01-09 14:38:34 | c9qpm4i********   | 2024-01-09 14:38:28 |
      | ...                                                                                  |
      +----------------------+---------------------+-------------------+---------------------+
      ```

      You will see the backup ID in the `ID` column. The `CREATED AT` column shows the time when the backup was completed in `yyyy-mm-dd hh:mm:ss` format.

   1. Request the creation of a cluster from a backup:

      ```bash
      {{ yc-mdb-os }} cluster restore --backup-id <backup_ID>
      ```

      You can also run the command with the parameters you use when creating a cluster. For the description of such parameters, see [Creating a cluster](cluster-create.md).

- API {#api}

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
   GET https://admin:<password>@<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_snapshot/_all
   ```

   If the required repository is not on the list, [connect it](s3-access.md).

1. Get a list of snapshots in the repository:

   ```http
   GET https://admin:<password>@<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository_name>/_all
   ```

   Each snapshot is a single backup.

### Creating a snapshot {#create-snapshot}

1. In the {{ OS }} repository list, find the repository where you want to create the snapshot:

   ```http
   GET https://admin:<password>@<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_snapshot/_all
   ```

   If the required repository is not on the list, [connect it](s3-access.md).

1. [Create a snapshot]({{ os.docs }}/opensearch/snapshots/snapshot-restore/#take-snapshots) of the required data or an entire cluster in the selected repository:

   ```http
   PUT https://admin:<password>@<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository_name>/<snapshot_name>
   ```

### Restoring a cluster from a snapshot {#restore-from-snapshot}

{% note warning %}

When restoring a cluster from a snapshot, the {{ OS }} version in the cluster must be equal to or higher than the {{ OS }} version where the snapshot was taken.

{% endnote %}

1. [Create a new {{ OS }} cluster](cluster-create.md) in the required configuration, but do not populate it with data.

   When creating a cluster, select:

   * The number and class of hosts as well as the size and type of storage based on snapshot size and performance requirements.

   * The {{ OS }} version used to make the snapshot or higher.

1. Close any open indexes using the [{{ OS }} API]({{ os.docs }}/api-reference/index-apis/close-index/):

   ```http
   POST: https://admin:<password>@<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/<index_name>/_close
   ```

   To restore an entire cluster, close all open indexes. To restore individual indexes, close only those indexes.

1. [Retrieve a list of backups](#list-snapshots) and find the required snapshot.
1. [Start restoring]({{ os.docs }}/opensearch/snapshots/snapshot-restore/#restore-snapshots) the entire cluster or individual data indexes and streams from the appropriate snapshot.
