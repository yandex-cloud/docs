---
title: Managing PostgreSQL backups
description: You can create backups and restore clusters from existing PostgreSQL backups. The Point-in-Time Recovery (PITR) technology enables you to restore cluster state to any point in time starting with the moment a backup was created.
---

# Managing backups in {{ mpg-name }}


You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{{ mpg-name }} also creates automatic daily backups. You can set the [backup start time](#set-backup-window) and [retention period](update.md#change-additional-settings).

## Restoring clusters from backups {#restore}

Point-in-Time Recovery (PITR) technology allows you to restore the cluster state to any point in time in the interval from the creation of the oldest full backup to the archiving of the most recent write ahead log (WAL). For more information, see [Backups](../concepts/backup.md).

When you restore a cluster from a backup, you create a new cluster with the backup data. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps per database core.

When creating a new cluster, set all required parameters.

When restored to the current state, the new cluster will match the state of:

* Existing cluster at the time of recovery.
* Deleted cluster at the time of archiving the most recent WAL.

{% include [manual-backup-restore](../../_includes/mdb/mpg/note-warn-restore-manual-backup.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   **To restore an existing cluster from a backup:**

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
   1. To restore the cluster state to the required point in time after creating this backup, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** as appropriate. You can enter the value manually or select it from the drop-down calendar.

      If you do not change the setting, the cluster will be restored to the state when the backup was completed.

   1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

   **To restore a previously deleted cluster from a backup:**

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Select the **{{ ui-key.yacloud.postgresql.switch_backups }}** tab.
   1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs in `<cluster_ID>:<backup_ID>` format.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
   1. To restore the cluster state to the required point in time after creating this backup, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** as appropriate. You can enter the value manually or select it from the drop-down calendar.

      If you do not change the setting, the cluster will be restored to the state when the backup was completed.

   1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

   {{ mpg-name }} will launch the operation to create a cluster from the backup.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   By default, the cluster is restored to the same folder where the backup is stored. To restore the cluster to a different folder, specify its ID in the `--folder-id` parameter.

   To restore a cluster from a backup:

   1. View a description of the CLI restore {{ PG }} cluster command:

      ```bash
      {{ yc-mdb-pg }} cluster restore --help
      ```

   1. Getting a list of available {{ PG }} cluster backups:

      ```bash
      {{ yc-mdb-pg }} backup list
      ```

      ```text
      +--------------------------+---------------------+----------------------+---------------------+
      |              ID          |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
      +--------------------------+---------------------+----------------------+---------------------+
      | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
      | ...                                                                                         |
      +--------------------------+---------------------+----------------------+---------------------+
      ```

      The time when the backup was completed is shown in the `CREATED AT` column with a list of available backups, in `yyyy-mm-dd hh:mm:ss` format (`2020-08-10 12:00:00` in the example above). You can restore a cluster to any point in time starting with the point when the backup is created.

   1. Request the creation of a cluster from a backup:


      ```bash
      {{ yc-mdb-pg }} cluster restore \
         --backup-id=<backup_ID> \
         --time=<time> \
         --name=<cluster_name> \
         --environment=<environment> \
         --network-name=<network_name> \
         --host zone-id=<availability_zone>,`
               `subnet-name=<subnet_name>,`
               `assign-public-ip=<public_access_to_host> \
         --resource-preset=<host_class> \
         --disk-size=<storage_size_in_GB> \
         --disk-type=<disk_type>
      ```


      Where:

      * `--backup-id`: [Backup](../concepts/backup.md) ID.
      * `--time`: Time point to restore the {{ PG }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` format.
      * `--name`: Cluster name.
      * `--environment`: Environment:

         * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
         * `PRODUCTION`: For stable versions of your apps.

      * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
      * `--host`: Host parameters:

         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).


         * `subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
         * `assign-public-ip`: Flag to be set if [public access to the host](../concepts/network.md#public-access-to-a-host) is required, `true` or `false`.


      * `--resource-preset`: [Host class](../concepts/instance-types.md#available-flavors).
      * `--disk-size`: Storage size in GB.
      * `--disk-type`: [Disk type](../concepts/storage.md):


         * `network-hdd`
         * `network-ssd`
         * `local-ssd`
         * `network-ssd-nonreplicated`


- {{ TF }} {#tf}

   Use {{ TF }} to restore:

   * Existing cluster from a backup.
   * Cluster created and deleted via the management console, CLI, or API.

   {% note info %}

   The cluster is restored to the folder, the ID of which is specified in the `folder_id` parameter of [provider settings]({{ tf-provider-link }}).

   {% endnote %}

   To restore a cluster, you will need the backup ID. Get a list of available {{ PG }} cluster backups [using the CLI](#list-backups):

   ```bash
   {{ yc-mdb-pg }} backup list
   ```

   ```text
   +--------------------------+---------------------+----------------------+---------------------+
   |            ID            |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
   +--------------------------+---------------------+----------------------+---------------------+
   | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
   | ...                                                                                         |
   +--------------------------+---------------------+----------------------+---------------------+
   ```

   {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

   **To restore an existing cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for the new cluster.

      Do not use resources of the databases (`yandex_mdb_postgresql_database`) and users (`yandex_mdb_postgresql_user`). They will be restored from the backup.

   1. Add a block named `restore` to the configuration file:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
        ...
        restore {
          backup_id = "<backup_ID>"
          time      = "<time>"
        }
      }
      ```

      Where:

      * `backup_id`: Backup ID.
      * `time`: Time point to restore the {{ PG }} cluster to, starting from the selected backup's creation time, in `yyyy-mm-ddThh:mm:ss` format.

      {% note info %}

      If you omit the `time` parameter, the cluster will be restored to the state when the backup was completed.

      {% endnote %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {{ TF }} will create a copy of the existing cluster. The databases and users are deployed from the selected backup.

   **To restore a previously deleted cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for the new cluster.

      Do not use resources of the databases (`yandex_mdb_postgresql_database`) and users (`yandex_mdb_postgresql_user`). They will be restored from the backup.

   1. In this configuration file, add a `restore` block with the name of the backup to restore the cluster from:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
        ...
        restore {
            backup_id = "<backup_ID>"
        }
      }
      ```

      Where `backup-id` is the ID of the remote cluster's backup.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {{ TF }} will create the new cluster. The databases and users are deployed from the backup.

- API {#api}

   To restore a cluster from a backup, use the [restore](../api-ref/Cluster/restore.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Restore](../api-ref/grpc/cluster_service.md#Restore) gRPC API call and provide the following in the request:

   * Backup ID in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
   * Time point to which you want to restore the cluster, in the `time` parameter.
   * Name of the new cluster that will contain the data recovered from the backup, in the `name` parameter. It must be unique within the folder.

   By default, the cluster is restored to the same folder where the backup is stored. To restore the cluster to a different folder, specify its ID in the `folderId` parameter.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

   {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster backup:

   1. View a description of the CLI create {{ PG }} backup command:

      ```
      {{ yc-mdb-pg }} cluster backup --help
      ```
   1. Request the creation of a backup specifying the cluster name or ID:

      ```
      {{ yc-mdb-pg }} cluster backup my-pg-cluster
      ```

      The cluster name and ID can be retrieved with the [list of clusters](cluster-list.md#list-clusters).

- API {#api}

   To create a cluster backup, use the [backup](../api-ref/Cluster/backup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Backup](../api-ref/grpc/cluster_service.md#Backup) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

   To get a list of cluster backups:
   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.

   To get a list of all backups in a folder:
   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Select the **{{ ui-key.yacloud.postgresql.switch_backups }}** tab.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of {{ PG }} cluster backups available in the default folder, run the command:

   ```
   {{ yc-mdb-pg }} backup list

   +--------------------------+---------------------+----------------------+---------------------+
   |            ID            |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
   +--------------------------+---------------------+----------------------+---------------------+
   | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
   | c9qpm90p3pcg********:... | 2020-08-09 22:01:04 | c9qpm90p3pcg******** | 2020-08-09 21:30:00 |
   +--------------------------+---------------------+----------------------+---------------------+
   ```

- API {#api}

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To get a list of backups for all the {{ mpg-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/List](../api-ref/grpc/backup_service.md#List) gRPC API call and provide the folder ID in the `folderId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}


## Getting information about backups {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

   To get information about the backup of an existing cluster:
   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.

   To get information about the backup of a previously deleted cluster:
   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Select the **{{ ui-key.yacloud.postgresql.switch_backups }}** tab.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ PG }} cluster backup, run the command:

   ```
   {{ yc-mdb-pg }} backup get <backup_ID>
   ```

   You can retrieve the backup ID with a [list of backups](#list-backups).

- API {#api}

   To get information about a cluster backup, use the [get](../api-ref/Backup/get.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/Get](../api-ref/grpc/backup_service.md#Get) gRPC API call and provide the backup ID in the `backupId` request parameter.

   You can retrieve the backup ID with the [backup list](#list-backups).

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs group=instructions %}

- Management console {#console}

   In the management console, you can set the backup start time when [creating](cluster-create.md) or [updating a cluster](update.md).

- CLI {#cli}

   To set the backup start time, use the `-- backup-window-`start flag. Time is given in `HH:MM:SS` format.

   ```bash
   {{ yc-mdb-pg }} cluster create \
      --cluster-name <cluster_name> \
      --environment <environment> \
      --network-name <network_name> \
      --host zone-id=<availability_zone>,subnet-id=<subnet_ID> \
      --resource-preset <host_class> \
      --user name=<username>,password=<user_password> \
      --database name=<DB_name>,owner=<DB_owner_name> \
      --disk-size <storage_size_in_GB>
      --backup-window-start 10:00:00
   ```

   Where `environment` is either `prestable` or `production`.

   To change the backup start time in an existing cluster, use the `update` command:

   ```bash
   {{ yc-mdb-pg }} cluster update \
      --cluster-name <cluster_name> \
      --backup-window-start 11:25:00
   ```

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. Add a block named `backup_window_start` to the {{ mpg-name }} cluster description under `config`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
        ...
        config {
          ...
          backup_window_start {
            hours   = <hour>
            minutes = <minute>
          }
          ...
        }
        ...
      ```

      Where:

      * `hours`: Backup start hour (UTC).
      * `minutes`: Backup start minute (UTC).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API {#api}

   To set the backup start time, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. You can retrieve it with a [list of clusters in the folder](cluster-list.md#list-clusters).
   * New backup start time in the `configSpec.backupWindowStart` parameter.
   * List of cluster configuration fields to be edited (in this case, `configSpec.backupWindowStart`) in the `updateMask` parameter.

   {% include [Note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a backup {#delete}

You can only delete backups that were created manually.

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Select the {{ mpg-name }} cluster whose backup you want to delete.
   1. In the left-hand panel, select **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the backup you want to delete.
   1. Select **{{ ui-key.yacloud.mdb.cluster.backups.button_delete }}**.
   1. Confirm deletion and click **{{ ui-key.yacloud.mdb.cluster.backups.action_delete-backup }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a backup:

   1. View a description of the CLI command to delete a {{ PG }} cluster backup:

      ```bash
      {{ yc-mdb-pg }} backup delete --help
      ```

   1. Request the deletion of a backup by specifying its ID:

      ```bash
      {{ yc-mdb-pg }} backup delete <backup_ID>
      ```

   You can retrieve the backup ID with a [list of backups](#list-backups).

- API {#api}

   To delete a backup, use the [delete](../api-ref/Backup/delete.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/Delete](../api-ref/grpc/backup_service.md#Delete) gRPC API call and provide the backup ID in the `backupId` request parameter.

   You can retrieve the backup ID with a [list of backups](#list-backups).

{% endlist %}
