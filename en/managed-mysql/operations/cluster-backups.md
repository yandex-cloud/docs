---
title: "Managing MySQL backups"
description: "You can create backups and restore clusters from existing MySQL backups. The Point-in-Time Recovery (PITR) technology enables you to restore cluster state to any point in time starting with the moment a backup was created."
---

# Managing backups in {{ mmy-name }}

You can create backups and restore clusters from existing backups, including point-in-time recovery. For more information, see [{#T}](../concepts/backup.md).

{{ mmy-name }} also creates automatic daily backups. You can set the [backup start time](#set-backup-window).

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

   To get a list of cluster backups:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.

   To get a list of all backups in a folder:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of {{ MY }} cluster backups available in the default folder, run the command:

   ```bash
   {{ yc-mdb-my }} backup list
   ```

   Result:

   ```text
   +--------------------------+---------------------+----------------------+---------------------+
   |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
   +--------------------------+---------------------+----------------------+---------------------+
   | c9qgo11pud7kb3c********  | 2020-08-10 12:00:00 | c9qgo11pud7k******** | 2020-08-10 11:55:17 |
   | ...                                                                                         |
   +--------------------------+---------------------+----------------------+---------------------+
   ```

- API {#api}

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To get a list of backups for all the {{ mmy-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/List](../api-ref/grpc/backup_service.md#List) gRPC API call and provide the folder ID in the `folderId` request parameter.

   {% include [note-api-get-cluster-id](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

   To get information about the backup of an existing cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.

   To get information about the backup of a previously deleted cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ MY }} cluster backup, run the command:

   ```bash
   {{ yc-mdb-my }} backup get <backup_ID>
   ```

   You can retrieve the backup ID with a [list of backups](#list-backups).

- API {#api}

   To get information about a backup, use the [get](../api-ref/Backup/get.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/Get](../api-ref/grpc/backup_service.md#Get) gRPC API call and provide the backup ID in the `backupId` request parameter.

   To find out the ID, [retrieve a list of backups](#list-backups).

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

   {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster backup:

   1. View a description of the CLI command to create a {{ MY }} cluster backup:

      ```bash
      {{ yc-mdb-my }} cluster backup --help
      ```

   1. Request a backup to be created by specifying the cluster name or ID:

      ```bash
      {{ yc-mdb-my }} cluster backup <cluster_name_or_ID>
      ```

      You can get the cluster ID and name with a [list of clusters](cluster-list.md#list-clusters).

- API {#api}

   To create a backup, use the [backup](../api-ref/Cluster/backup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Backup](../api-ref/grpc/cluster_service.md#Backup) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [note-api-get-cluster-id](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

In single-host clusters, you create a backup by reading data from the master host while the solution for multi-host clusters is to read one of the replicas. At the same time, you can [specify host priorities when creating backups](#set-backup-priority).

## Restoring clusters from backups {#restore}

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type.

{% list tabs group=instructions %}

- Management console {#console}

   To restore an existing cluster from a backup:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
   1. To restore the cluster state [to the required point in time](../concepts/backup.md) after creating this backup (Point-in-Time-Recovery), configure **{{ ui-key.yacloud.mdb.forms.field_date }}** as appropriate.

      If you do not change the setting, the cluster will be restored to the state when the backup was completed.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

   To restore a previously deleted cluster from a backup:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.
   1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.mdb.cluster.backups.column_name }}** column contains IDs in `<cluster_ID>:<backup_ID>` format.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
   1. To restore the cluster state to the required point in time after creating this backup, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** as appropriate. You can enter the value manually or select it from the drop-down calendar.

      If you do not change the setting, the cluster will be restored to the state when the backup was completed.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

   {{ mmy-name }} will launch the operation to create a cluster from the backup.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To restore a cluster from a backup:

   1. View a description of the CLI restore {{ MY }} cluster command:

      ```bash
      {{ yc-mdb-my }} cluster restore --help
      ```

   1. Getting a list of available {{ MY }} cluster backups:

      ```bash
      {{ yc-mdb-my }} backup list
      ```

      Result:

      ```text
      +--------------------------+---------------------+----------------------+---------------------+
      |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
      +--------------------------+---------------------+----------------------+---------------------+
      | c9qgo11pud7kb3c********  | 2020-08-10 12:00:00 | c9qgo11pud7k******** | 2020-08-10 11:55:17 |
      | ...                                                                                         |
      +--------------------------+---------------------+----------------------+---------------------+
      ```

      The time when the backup was completed is shown in the `CREATED AT` column with a list of available backups, in `yyyy-mm-dd hh:mm:ss` format (`2020-08-10 12:00:00` in the example above). You can restore a cluster to any point in time starting with the point when the backup is created.

   1. Request the creation of a cluster from a backup:

      
      ```bash
      {{ yc-mdb-my }} cluster restore \
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
      * `--time`: Time point to restore the {{ MY }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` format.
      * `--name`: Cluster name.
      * `--environment`: Environment:

         * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
         * `PRODUCTION`: For stable versions of your apps.

      * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
      * `--host`: Host parameters:

         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).

         
         * `subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
         * `assign-public-ip`: Flag to be set if [public access](../concepts/network.md#public-access-to-host) to the host is needed: `true` or `false`.


      * `--resource-preset`: [Host class](../concepts/instance-types.md#available-flavors).
      * `--disk-size`: Storage size in GB.
      * `disk-type`: [Disk type](../concepts/storage.md):

         
         * `network-hdd`
         * `network-ssd`
                  * `local-ssd`
         * `network-ssd-nonreplicated`


- {{ TF }} {#tf}

   Use {{ TF }} to restore:

   * Existing cluster from a backup.
   * Cluster created and deleted via the management console, CLI, or API.

   To restore a cluster, you will need the backup ID. Retrieve a list of available {{ MY }} cluster backups [using the CLI](#list-backups):

   ```bash
   {{ yc-mdb-my }} backup list
   ```

   Result:

   ```text
   +--------------------------+---------------------+----------------------+---------------------+
   |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
   +--------------------------+---------------------+----------------------+---------------------+
   | c9qgo11pud7kb3c********  | 2020-08-10 12:00:00 | c9qgo11pud7k******** | 2020-08-10 11:55:17 |
   | ...                                                                                         |
   +--------------------------+---------------------+----------------------+---------------------+
   ```

   **To restore an existing cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for the new cluster.

      Do not use resources of the databases (`yandex_mdb_mysql_database`) and users (`yandex_mdb_mysql_user`). They will be restored from the backup.

   1. Add a block named `restore` to this configuration file:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        restore {
          backup_id = "<backup_name>"
          time      = "<time>"
        }
      }
      ```

      In the `time` parameter, specify the time point, in the `yyyy-mm-ddThh:mm:ss` format, to which you want to restore the {{ MY }} cluster, starting from the creation of the selected backup.

      {% note info %}

      The `time` parameter is optional. If you do not specify it, the cluster will be restored to the state when the recovery process was started.

      {% endnote %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {{ TF }} will create a copy of the existing cluster. The databases and users are deployed from the selected backup.

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

   **To restore a previously deleted cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for the new cluster.

      Do not use resources of the databases (`yandex_mdb_mysql_database`) and users (`yandex_mdb_mysql_user`). They will be restored from the backup.

   1. In the configuration file, add a `restore` block with the name of the backup to restore the cluster from:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        restore {
            backup_id = "<backup_ID>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {{ TF }} will create the new cluster. The databases and users are deployed from the backup.

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API {#api}

   To restore a cluster from a backup, use the [restore](../api-ref/Cluster/restore.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Restore](../api-ref/grpc/cluster_service.md#Restore) gRPC API call and provide the following in the request:

   * Backup ID in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
   * Time point to which you want to restore the cluster, in the `time` parameter.
   * Name of the new cluster that will contain the data recovered from the backup, in the `name` parameter. It must be unique within the folder.

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs group=instructions %}

- Management console {#console}

   In the [management console]({{ link-console-main }}), you can set the backup start time when [creating](cluster-create.md) or [updating](update.md) a cluster.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To set the backup start time in an existing cluster, use the `update` command:

   ```bash
   {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
      --backup-window-start=<time>
   ```

   Where `backup-window-start` is the backup start UTC time in `HH:MM:SS` format.

   You can get the cluster ID and name with a [list of clusters](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add a block named `backup_window_start` to the {{ mmy-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        backup_window_start {
          hours   = <hour>
          minutes = <minute>
        }
      }
      ```

      Where:

      * `hours`: Backup start hour (UTC).
      * `minutes`: Backup start minute (UTC).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API {#api}

   To set the backup start time, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. You can get it together [with a list of clusters in the folder](cluster-list.md#list-clusters).
   * New backup start time in the `configSpec.backupWindowStart` parameter.
   * List of cluster configuration fields to be updated in the `updateMask` parameter (in this case, `configSpec.backupWindowStart`).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Setting host priorities when creating backup {#set-backup-priority}

The minimum host priority when creating backups is `0`, the maximum is `100`, and the default is `0`. A replicated host with the highest priority serves as the backup source. For more information, see [Creating backups](../concepts/backup.md#size).

{% list tabs group=instructions %}

- Management console {#console}

   In the [management console]({{ link-console-main }}), a host's priority is set when [creating](cluster-create.md) a cluster, [adding](../operations/hosts.md#add) new cluster hosts, or [updating the settings](../operations/hosts.md#update) of the existing hosts.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To set the backup priority of a selected host, run this command:

   ```bash
   {{ yc-mdb-my }} host update <host_name> \
      --cluster-name=<cluster_name> \
      --backup-priority=<host_backup_priority>
   ```

   Where `backup-priority` is host backup priority, between `0` and `100`.

   You can request the host name with a [list of cluster hosts](hosts.md#list), and the cluster name, with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To set the host priority, use the [updateHosts](../api-ref/Cluster/updateHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/UpdateHosts](../api-ref/grpc/cluster_service.md#UpdateHosts) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. You can retrieve it with a [list of clusters in the folder](cluster-list.md#list-clusters).
   * Host name in the `updateHostSpecs.hostName` parameter. It may be retrieved with a [list of hosts in the cluster](hosts.md#list).
   * New host priority value in the `updateHostSpecs.backupPriority` parameter.
   * List of cluster configuration fields to update (here, `updateHostSpecs.hostName` and `updateHostSpecs.backupPriority`) in the `updateMask` parameter.

   {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
