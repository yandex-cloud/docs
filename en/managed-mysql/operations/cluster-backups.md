---
title: "Managing MySQL backups"
description: "You can create backups and restore clusters from existing MySQL backups. The Point-in-Time Recovery (PITR) technology enables you to restore cluster state to any point in time starting with the moment a backup was created."
---

# Managing backups in {{ mmy-name }}

You can create backups and restore clusters from existing backups, including point-in-time recovery. For more information, see [{#T}](../concepts/backup.md).

{{ mmy-name }} also creates automatic daily backups. You can set the [backup start time](#set-backup-window).

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

   To get a list of cluster backups:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and select the ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.

   To get a list of all backups in a folder:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. In the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.

- CLI

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
   | c9qgo11pud7kb3cdomeg...  | 2020-08-10 12:00:00 | c9qgo11pud7kb3cdomeg | 2020-08-10 11:55:17 |
   | ...                                                                                         |
   +--------------------------+---------------------+----------------------+---------------------+
   ```

- API

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To get a list of backups for all the {{ mmy-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/List](../api-ref/grpc/backup_service.md#List) gRPC API call and provide the folder ID in the `folderId` request parameter.

   {% include [note-api-get-cluster-id](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs %}

- Management console

   To get information about the backup of an existing cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and select the ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.

   To get information about the backup of a previously deleted cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. In the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ MY }} cluster backup, run the command:

   ```bash
   {{ yc-mdb-my }} backup get <backup ID>
   ```

   You can retrieve the backup ID with a [list of backups](#list-backups).

- API

   To get information about a backup, use the [get](../api-ref/Backup/get.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/Get](../api-ref/grpc/backup_service.md#Get) gRPC API call and provide the backup ID in the `backupId` request parameter.

   To find out the ID, [retrieve a list of backups](#list-backups).

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and select the ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.
   1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

   {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster backup:

   1. View a description of the CLI command to create a {{ MY }} cluster backup:

      ```bash
      {{ yc-mdb-my }} cluster backup --help
      ```

   1. Request a backup to be created by specifying the cluster name or ID:

      ```bash
      {{ yc-mdb-my }} cluster backup <cluster ID or name>
      ```

      You can fetch the cluster ID and name with a [list of clusters](cluster-list.md#list-clusters).

- API

   To create a backup, use the [backup](../api-ref/Cluster/backup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Backup](../api-ref/grpc/cluster_service.md#Backup) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [note-api-get-cluster-id](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

In single-host clusters, you create a backup by reading data from the master host while the solution for multi-host clusters is to read one of the replicas. At the same time, you can [specify host priorities when creating backups](#set-backup-priority).

## Restoring clusters from backups {#restore}

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type.

{% list tabs %}

- Management console

   To restore an existing cluster from a backup:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and select the ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) for the desired backup and click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
   1. To restore the cluster state [to the required point in time](../concepts/backup.md) after creating this backup (Point-in-Time-Recovery), configure **{{ ui-key.yacloud.mdb.forms.field_date }}** as appropriate.

      If you do not change the setting, the cluster will be restored to the state when the backup was completed.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

   To restore a previously deleted cluster from a backup:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. In the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.
   1. Find the desired backup using the backup creation time and cluster ID. The **{{ ui-key.yacloud.mdb.cluster.backups.column_name }}** column contains the IDs in `<cluster ID>:<backup ID>` format.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) for the desired backup and click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
   1. To restore the cluster state to the required point of time after creating this backup, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** as appropriate. You can enter the value manually or select it from the drop-down calendar.

      If you do not change the setting, the cluster will be restored to the state when the backup was completed.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

   {{ mmy-name }} will launch the operation to create a cluster from the backup.

- CLI

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
      | c9qgo11pud7kb3cdomeg...  | 2020-08-10 12:00:00 | c9qgo11pud7kb3cdomeg | 2020-08-10 11:55:17 |
      | ...                                                                                         |
      +--------------------------+---------------------+----------------------+---------------------+
      ```

      The time when the backup was completed is shown in the `CREATED AT` column with a list of available backups, in `yyyy-mm-dd hh:mm:ss` format (`2020-08-10 12:00:00` in the example above). You can restore a cluster to any point in time starting with creation of its backup.

   1. Request the creation of a cluster from a backup:

      
      ```bash
      {{ yc-mdb-my }} cluster restore \
         --backup-id=<backup ID> \
         --time=<point in time to restore the {{ MY }} cluster to> \
         --name=<cluster name> \
         --environment=<environment: PRESTABLE or PRODUCTION> \
         --network-name=<network name> \
         --host zone-id=<availability zone>,`
               `subnet-name=<subnet name>`
               `assign-public-ip=<host access via public IP: true or false> \
         --resource-preset=<host class> \
         --disk-size=<storage size in GB> \
         --disk-type=<disk type>
      ```


      Where:

      * `--backup-id`: [Backup](../concepts/backup.md) ID.
      * `--time`: Point in time to which you need to restore a {{ MY }} cluster's state, in `yyyy-mm-ddThh:mm:ssZ` format.
      * `--name`: Cluster name.
      * `--environment`: Environment:

         * `PRESTABLE`: For testing, including the {{ MY }} service itself. The prestable environment is updated first with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
         * `PRODUCTION`: For stable versions of your apps.

      * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
      * `--host`: Host parameters:

         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).

         
         * `subnet-name`: [Name of the subnet](../../vpc/concepts/network.md#subnet). It must be specified if the selected availability zone includes two or more subnets.
         * `assign-public-ip`: Flag to specify if a host requires a [public IP address](../../vpc/concepts/address.md#public-addresses).


      * `--resource-preset`: [host class](../concepts/instance-types.md#available-flavors).
      * `--disk-size`: Storage size in GB.
      * `--disk-type`: The [type of disk](../concepts/storage.md):

         
         * `network-hdd`.
         * `network-ssd`.
                  * `local-ssd`.
         * `network-ssd-nonreplicated`.


- {{ TF }}

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
   | c9qgo11pud7kb3cdomeg...  | 2020-08-10 12:00:00 | c9qgo11pud7kb3cdomeg | 2020-08-10 11:55:17 |
   | ...                                                                                         |
   +--------------------------+---------------------+----------------------+---------------------+
   ```

   **To restore an existing cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for the new cluster.

      Don't use resources of the databases (`yandex_mdb_mysql_database`) and users (`yandex_mdb_mysql_user`). They will be restored from the backup.

   1. Add a block named `restore` to this configuration file:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        restore {
          backup_id = "<desired backup name>"
          time      = "<restore time stamp in yyyy-mm-ddThh:mm:ss format>"
        }
      }
      ```

      In the `time` parameter, specify the point in time to which you want to restore the {{ MY }} cluster, starting from the creation of the selected backup.

      {% note info %}

      The `time` parameter is optional. If you don't specify it, the cluster is restored to the state when the recovery process was started.

      {% endnote %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {{ TF }} will create a copy of the existing cluster. The databases and users are deployed from the selected backup.

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

   **To restore a previously deleted cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for the new cluster.

      Don't use resources of the databases (`yandex_mdb_mysql_database`) and users (`yandex_mdb_mysql_user`). They will be restored from the backup.

   1. In the configuration file, add a `restore` section with the name of the backup to restore the cluster from:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        restore {
            backup_id = "<remote cluster backup ID>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {{ TF }} will create the new cluster. The databases and users are deployed from the backup.

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   To restore a cluster from a backup, use the [restore](../api-ref/Cluster/restore.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Restore](../api-ref/grpc/cluster_service.md#Restore) gRPC API call and provide the following in the request:

   * ID of the desired backup, in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
   * Timestamp of the point to which you want to recover the cluster, in the `time` parameter.
   * Name of the new cluster that will contain the data recovered from the backup, in the `name` parameter. It must be unique within the folder.

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs %}

- Management console

   In the [management console]({{ link-console-main }}), you can only set the backup start time when [updating a cluster](update.md).

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To set the backup start time in an existing cluster, use the `update` command:

   ```bash
   {{ yc-mdb-my }} cluster update <cluster ID or name> \
      --backup-window-start=<backup start time, UTC in `HH:MM:SS` format>
   ```

   You can fetch the cluster ID and name with a [list of clusters](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add a block named `backup_window_start` to the {{ mmy-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        backup_window_start {
          hours   = <backup start hour (UTC)>
          minutes = <backup start minute (UTC)>
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   To set the backup start time, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. You can get it together [with a list of clusters in the folder](cluster-list.md#list-clusters).
   * New backup start time in the `configSpec.backupWindowStart` parameter.
   * List of the updated cluster configuration fields in the `updateMask` parameter (in this case, `configSpec.backupWindowStart`).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Setting host priorities when creating backup {#set-backup-priority}

The minimum host priority when creating backups is `0`, the maximum is `100`, and the default is `0`. A replicated host with the highest priority serves as the backup source. For more information, see [Creating backups](../concepts/backup.md#size).

{% list tabs %}

- Management console

   In the [management console]({{ link-console-main }}), a host's priority is set when [creating](cluster-create.md) a cluster, [adding](../operations/hosts.md#add) new cluster hosts, or [updating the settings](../operations/hosts.md#update) of the existing hosts.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To set the backup priority of a selected host, run this command:

   ```bash
   {{ yc-mdb-my }} host update <host name> \
      --cluster-name=<cluster name> \
      --backup-priority=<host priority for backups: 0 to 100>
   ```

   The host name can be requested with a [list of cluster hosts](hosts.md#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To set the host priority, use the [updateHosts](../api-ref/Cluster/updateHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/UpdateHosts](../api-ref/grpc/cluster_service.md#UpdateHosts) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. You can retrieve it with a [list of clusters in the folder](cluster-list.md#list-clusters).
   * Host name in the `updateHostSpecs.hostName` parameter. It may be retrieved with a [list of hosts in the cluster](hosts.md#list).
   * New host priority value in the `updateHostSpecs.backupPriority` parameter.
   * List of cluster configuration fields to update (here, `updateHostSpecs.hostName` and `updateHostSpecs.backupPriority`) in the `updateMask` parameter.

   {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
