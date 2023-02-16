---
title: "Managing PostgreSQL backups"
description: "You can create backups and restore clusters from existing PostgreSQL backups. The Point-in-Time Recovery (PITR) technology enables you to restore cluster state to any point in time starting with the moment a backup was created."
---

# Managing backups in {{ mpg-name }}

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{{ mpg-name }} also creates automatic daily backups. You can set the [backup start time](#set-backup-window) and [retention period](update.md#change-additional-settings).

## Restoring clusters from backups {#restore}

Point-in-Time Recovery (PITR) technology lets you restore the cluster state to any point in time in the interval from creating the oldest full backup to archiving the most recent write ahead log (WAL). For more information, see [{#T}](../concepts/backup.md).

For example, if the backup operation ended August 10, 2020, 12:00:00 UTC, the current date is August 15, 2020, 19:00:00 UTC, and the latest write ahead log was saved August 15, 2020, 18:50:00 UTC, the cluster can be restored to any state between August 10, 2020, 12:00:01 UTC and August 15, 2020, 18:50:00 UTC inclusive.

When you restore a cluster from a backup, you create a new cluster with data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps per database core.

When creating a new cluster, set all required parameters.

When restoring to the current state, the new cluster will reflect the state of:

* An existing cluster at the time of recovery.
* A deleted cluster at the time of archiving the last write ahead log.

{% list tabs %}

- Management console

   To restore an existing cluster from a backup:
   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon for the desired backup and click **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. To restore the cluster state from a desired point of time after creating this backup, configure the **Date and time of recovery (UTC) setting**. You can enter the value manually or select it from the drop-down calendar.

      If you don't change the setting, the cluster is restored to the state when the backup was completed.
   1. Click **Restore cluster**.

   To restore a previously deleted cluster from a backup:
   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click the **Backups** tab.
   1. Find the desired backup using the backup creation time and cluster ID. The **Name** column contains the IDs in `<cluster ID>:<backup ID>` format.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon for the desired backup and click **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. To restore the cluster state from a desired point of time after creating this backup, configure the **Date and time of recovery (UTC) setting**. You can enter the value manually or select it from the drop-down calendar.

      If you don't change the setting, the cluster is restored to the state when the backup was completed.
   1. Click **Restore cluster**.

   {{ mpg-name }} launches the operation to create a cluster from the backup.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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
      +-------------------------+---------------------+----------------------+---------------------+
      |            ID           |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
      +-------------------------+---------------------+----------------------+---------------------+
      | c9qlk4v13uq79r9cgcku... | 2020-08-10 12:00:00 | c9qlk4v13uq79r9cgcku | 2020-08-10 11:55:17 |
      | ...                                                                                        |
      +-------------------------+---------------------+----------------------+---------------------+
      ```

      The time when the backup was completed is shown in the `CREATED AT` column with a list of available backups, in `yyyy-mm-dd hh:mm:ss` format (`2020-08-10 12:00:00` in the example above). You can restore a cluster to any point in time starting with creation of its backup.

   1. Request the creation of a cluster from a backup:

      {% if audience == "internal" %}

      ```bash
      {{ yc-mdb-pg }} cluster restore \
         --backup-id=<backup ID> \
         --time=<point in time to restore the {{ PG }} cluster to> \
         --name=<cluster name> \
         --environment=<environment: PRESTABLE or PRODUCTION> \
         --network-id={{ network-name }} \
         --host zone-id=<availability zone> \
         --resource-preset=<host class> \
         --disk-size=<storage size in GB> \
         --disk-type=<disk type>
      ```

      {% else %}

      ```bash
      {{ yc-mdb-pg }} cluster restore \
         --backup-id=<backup ID> \
         --time=<point in time to restore the {{ PG }} cluster to> \
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

      {% endif %}

      Where:

      * `--backup-id`: [backup](../concepts/backup.md) ID
      * `--time`: Point in time to which you need to restore a {{ PG }} cluster's state, in `yyyy-mm-ddThh:mm:ssZ` format.
      * `--name`: The cluster name.
      * `--environment`: Environment:

         * `PRESTABLE`: For testing, including the {{ PG }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
         * `PRODUCTION`: For stable versions of your apps.

      * `--network-name`: {% if audience != "internal" %}[Network name](../../vpc/concepts/network.md#network){% else %}Network name{% endif %}.
      * `--host`: Host parameters:

         * `zone-id`: {% if audience != "internal" %}[Availability zone](../../overview/concepts/geo-scope.md){% else %}Availability zone{% endif %}.

         {% if audience != "internal" %}

         * `subnet-name`: [Name of the subnet](../../vpc/concepts/network.md#subnet). It must be specified if the selected availability zone includes two or more subnets.
         * `assign-public-ip`: Flag to specify if a host requires a [public IP address](../../vpc/concepts/address.md#public-addresses).

         {% endif %}

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
         * `local-hdd`.

         {% endif %}

- {{ TF }}

   Use {{ TF }} to restore:

   * An existing cluster from a backup.
   * A cluster created and deleted via the management console, CLI, or API.

   To restore a cluster, you'll need the backup ID. Retrieve a list of available {{ PG }} cluster backups [using the CLI](#list-backups):

   ```bash
   {{ yc-mdb-pg }} backup list
   ```

   ```text
   +--------------------------+---------------------+----------------------+---------------------+
   |            ID            |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
   +--------------------------+---------------------+----------------------+---------------------+
   | c9qlk4v13uq79r9cgcku...  | 2020-08-10 12:00:00 | c9qlk4v13uq79r9cgcku | 2020-08-10 11:55:17 |
   | ...                                                                                         |
   +--------------------------+---------------------+----------------------+---------------------+
   ```

   {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

   **To restore an existing cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for the new cluster.

      Don't use resources of the databases (`yandex_mdb_postgresql_database`) and users (`yandex_mdb_postgresql_user`). They will be restored from the backup.

   1. Add a block named `restore` to the configuration file:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        restore {
          backup_id = "<desired backup name>"
          time      = "<restore time stamp in yyyy-mm-ddThh:mm:ss format>"
        }
      }
      ```

      In the `time` parameter, specify the point in time to which you want to restore the {{ PG }} cluster, starting from when the selected backup was created.

      {% note info %}

      If you don't specify the `time` parameter, the cluster is restored to the state when the backup was completed.

      {% endnote %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {{ TF }} will create a copy of the existing cluster. The databases and users are deployed from the selected backup.

   **To restore a previously deleted cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for the new cluster.

      Don't use resources of the databases (`yandex_mdb_postgresql_database`) and users (`yandex_mdb_postgresql_user`). They will be restored from the backup.

   1. In the configuration file, add a `restore` block with the name of the backup to restore the cluster from:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        restore {
            backup_id = "<ID of the backup for the remote cluster>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {{ TF }} will create the new cluster. The databases and users are deployed from the backup.

- API

   Use the [restore](../api-ref/Cluster/restore.md) API method and pass the following in the request:

   * ID of the desired backup, in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
   * The timestamp of the point to which you want to recover the cluster, in the `time` parameter.
   * The name of the new cluster that will contain the data recovered from the backup, in the `name` parameter. The cluster name must be unique within the folder.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. Click **Create backup**.

- CLI

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

- API

   Use the [backup](../api-ref/Cluster/backup.md) API method and pass the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}


## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

   To get a list of cluster backups:
   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.

   To get a list of all backups in a folder:
   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click the **Backups** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of {{ PG }} cluster backups available in the default folder, run the command:

   ```
   {{ yc-mdb-pg }} backup list

   +----------+---------------------+----------------------+---------------------+
   |    ID    |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
   +----------+---------------------+----------------------+---------------------+
   | c9qlk... | 2020-08-10 12:00:00 | c9qlk4v13uq79r9cgcku | 2020-08-10 11:55:17 |
   | c9qpm... | 2020-08-09 22:01:04 | c9qpm90p3pcg71jm7tqf | 2020-08-09 21:30:00 |
   +----------+---------------------+----------------------+---------------------+
   ```

- API

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To get a list of backups for all the {{ mpg-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) API method and pass the folder ID in the `folderId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}


## Getting information about backups {#get-backup}

{% list tabs %}

- Management console

   To get information about the backup of an existing cluster:
   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.

   To get information about the backup of a previously deleted cluster:
   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click the **Backups** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ PG }} cluster backup, run the command:

   ```
   {{ yc-mdb-pg }} backup get <backup ID>
   ```

   You can retrieve the backup ID with a [list of backups](#list-backups).

- API

   Use the [get](../api-ref/Backup/get.md) API method and pass the backup ID in the `backupId` request parameter.

   You can retrieve the backup ID with the [backup list](#list-backups).

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs %}

- Management console

   In the management console, you can set the backup start time when [creating](cluster-create.md) or [updating a cluster](update.md).

- CLI

   To set the backup start time, use the `-- backup-window-`start flag. Time is given in `HH:MM:SS` format.

   ```bash
   {{ yc-mdb-pg }} cluster create \
      --cluster-name <cluster name> \
      --environment <environment, prestable or production> \
      --network-name <network name> \
      --host zone-id=<availability zone>,subnet-id=<subnet ID> \
      --resource-preset <host class> \
      --user name=<username>,password=<user password> \
      --database name=<database name>,owner=<database owner name> \
      --disk-size <storage size, GB>
      --backup-window-start 10:00:00
   ```

   To change the backup start time in an existing cluster, use the `update` command:

   ```bash
   {{ yc-mdb-pg }} cluster update \
      --cluster-name <cluster name> \
      --backup-window-start 11:25:00
   ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

   1. Add a block named `backup_window_start` to the {{ mpg-name }} cluster description under `config`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        config {
          ...
          backup_window_start {
            hours   = <Hour to start backup at (UTC)>
            minutes = <Minute to start backup at (UTC)>
          }
          ...
        }
        ...
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. You can retrieve it with a [list of clusters in the folder](cluster-list.md#list-clusters).
   * The new backup start time, in the `configSpec.backupWindowStart` parameter.
   * List of cluster configuration fields to be edited (in this case, `configSpec.backupWindowStart`) in the `updateMask` parameter.

   {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a backup {#delete}

You can only delete backups that were created manually.

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Select the {{ mpg-name }} cluster whose backup you want to delete.
   1. In the left panel, select **Backups**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) to the right of the backup you wish to delete.
   1. Select **Delete backup**.
   1. Confirm deletion and click **Delete**.

{% endlist %}
