---
title: "Managing {{ RD }} backups"
description: "You can create backups and restore clusters from existing {{ RD }} backups. When you restore a cluster from a backup, you create a new cluster with the backup data. If the cloud does not have sufficient resources to create such a cluster, you will not be able to restore your data from a backup."
---

# Managing backups in {{ mrd-name }}


You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{{ mrd-name }} also creates automatic daily backups. You can [set the backup start time](#set-backup-window):

## Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the backup data. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps.

If you chose the **local-ssd** disk type when restoring the cluster from a backup, add at least two hosts per shard.

{% list tabs group=instructions %}

- Management console {#console}

   To restore an existing cluster from a backup:

   1. In the [management console]({{ link-console-main }}), go to the folder to restore the cluster in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.redis.switch_backups }}** tab.
   1. In the line of the appropriate backup, click ![image](../../_assets/console-icons/ellipsis.svg)and select **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

   To restore a previously deleted cluster from a backup:

   1. In the [management console]({{ link-console-main }}), go to the folder to restore the cluster in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.redis.switch_backups }}**.
   1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs in `<cluster_ID>:<backup_ID>` format.
   1. In the line of the appropriate backup, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

   {{ mrd-name }} will launch the operation to create a cluster from the backup.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To restore a cluster from a backup:

   1. View a description of the CLI restore {{ RD }} cluster command:

      ```bash
      {{ yc-mdb-rd }} cluster restore --help
      ```

   1. Getting a list of available {{ RD }} cluster backups:

      ```bash
      {{ yc-mdb-rd }} backup list
      ```

      Result:

      ```text
      +--------------------------+---------------------+----------------------+---------------------+
      |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
      +--------------------------+---------------------+----------------------+---------------------+
      | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
      | ...                                                                                         |
      +--------------------------+---------------------+----------------------+---------------------+
      ```

   1. Request the [creation of a cluster](cluster-create.md) from a backup:

      ```bash
      {{ yc-mdb-rd }} cluster restore \
         --backup-id c9q287aqv5rf********:20181113T133617 \
         --name mynewrd \
         --environment=PRODUCTION \
         --network-name default \
         --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr********,assign-public-ip=true,replica-priority=50 \
         --password P@ssWord \
         --disk-size 20
      ```

      This results in a new {{ RD }} cluster with the following characteristics:

      * Name: `mynewrd`
      * Environment: `PRODUCTION`
      * Network: `default`
      * With a single `hm1.nano`-class host in the `b0rcctk2rvtr********` subnet in the `{{ region-id }}-a` availability zone with public access and a [replica priority](../concepts/replication.md#master-failover) of `50`.
      * Password: `P@ssWord`
      * Network SSD storage (`{{ disk-type-example }}`): 20 GB

      {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

- API {#api}

   To restore a cluster from a backup, use the [restore](../api-ref/Cluster/restore.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Restore](../api-ref/grpc/cluster_service.md#Restore) gRPC API call.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder to create a backup in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.redis.switch_backups }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

   {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster backup:

   1. View a description of the CLI create {{ RD }} backup command:

      ```bash
      {{ yc-mdb-rd }} cluster backup --help
      ```

   1. Request the creation of a backup specifying the cluster name or ID:

      ```bash
      {{ yc-mdb-rd }} cluster backup my-rd-cluster
      ```

      The cluster name and ID can be retrieved with the [list of clusters](cluster-list.md#list-clusters).

- API {#api}

   To create a backup, use the [backup](../api-ref/Cluster/backup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Backup](../api-ref/grpc/cluster_service.md#Backup) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

   To get a list of cluster backups:
   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.redis.switch_backups }}** tab.

   To get a list of all backups in a folder:
   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.redis.switch_backups }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of {{ RD }} cluster backups available in the default folder, run the command:

   ```bash
   {{ yc-mdb-rd }} backup list
   ```

   Result:

   ```text
   +--------------------------+---------------------+----------------------+---------------------+
   |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
   +--------------------------+---------------------+----------------------+---------------------+
   | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
   | c9qpm90p3pcg********:... | 2020-08-09 22:01:04 | c9qpm90p3pcg******** | 2020-08-09 21:30:00 |
   +--------------------------+---------------------+----------------------+---------------------+
   ```

- API {#api}

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

   To get a list of all the backups in a folder, use the [list](../api-ref/Backup/list.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/List](../api-ref/grpc/backup_service.md#List) gRPC API call and provide the folder ID in the `folderId` request parameter.

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

   To get information about the backup of an existing cluster:
   1. In the [management console]({{ link-console-main }}), go to the folder with the cluster to get backup information for.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.redis.switch_backups }}** tab.

   To get information about the backup of a previously deleted cluster:
   1. In the [management console]({{ link-console-main }}), go to the folder that contained the deleted cluster.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.redis.switch_backups }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ RD }} cluster backup, run the command:

   ```bash
   {{ yc-mdb-rd }} backup get <backup_ID>
   ```

   You can retrieve the backup ID with a [list of backups](#list-backups).

- API {#api}

   To get information about a backup, use the [get](../api-ref/Backup/get.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/Get](../api-ref/grpc/backup_service.md#Get) gRPC API call and provide the backup ID in the `backupId` request parameter.

   You can retrieve the backup ID with the [backup list](#list-backups).

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs group=instructions %}

- Management console {#console}

   When [creating](cluster-create.md) or [updating](update.md#change-redis-config) a cluster, you can set the backup start time under **{{ ui-key.yacloud.mdb.forms.section_additional }}**.

- CLI {#cli}

   To set the backup start time, use the `--backup-window-start` flag. Time is given in `HH:MM:SS` format.

   ```bash
   {{ yc-mdb-rd }} cluster create \
     --name <cluster_name> \
     --environment <environment> \
     --network-name <subnet_name> \
     --host zone-id=<availability_zone>,subnet-id=<subnet ID> \
     --backup-window-start 10:25:00
   ```

   Where `--environment` is either `prestable` or `production`.

   To change the backup start time in an existing cluster, use the `update` command:

   ```bash
   {{ yc-mdb-rd }} cluster update \
      --name <cluster_name> \
      --backup-window-start 11:25:00
   ```

- API {#api}

   To set the backup start time, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call.

{% endlist %}
