---
title: "MySQL backup management"
description: "You can back up and restore clusters from your existing MySQL backups. Point-in-Time Recovery (PITR) technology allows you to restore the state of the cluster to any point in time from the backup to the current moment."
---

# Managing backups

You can create backups and restore clusters from existing backups, including point-in-time recovery. For more information, see [{#T}](../concepts/backup.md).

## Restoring clusters from backups {#restore}

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type.

{% list tabs %}

- Management console

   To restore an existing cluster from a backup:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon for the desired backup and click **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. To restore the cluster state [at the required point in time](../concepts/backup.md) after creating this backup (Point-in-Time-Recovery), set the desired setting value **Recovery date and time (UTC)**.

      If you don't change the setting, the cluster is restored to the state when the backup was completed.
   1. Click **Restore cluster**.

   To restore a previously deleted cluster from a backup:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.
   1. Find the desired backup using the backup creation time and cluster ID. The **Name** column contains the IDs in `<cluster ID>:<backup ID>` format.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon for the desired backup and click **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. To restore the cluster state from a desired point of time after creating this backup, configure the **Date and time of recovery (UTC) setting**. You can enter the value manually or select it from the drop-down calendar.

      If you don't change the setting, the cluster is restored to the state when the backup was completed.
   1. Click **Restore cluster**.

   {{ mmy-name }} launches the operation to create a cluster from the backup.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To restore a cluster from a backup:

   1. View a description of the CLI restore {{ MY }} cluster command:

      ```
      {{ yc-mdb-my }} cluster restore --help
      ```

   1. Getting a list of available {{ MY }} cluster backups:

      ```
      {{ yc-mdb-my }} backup list
      ```

      Result:

      ```
      +--------------------------+----------------------+----------------------+----------------------+
      |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
      +--------------------------+----------------------+----------------------+----------------------+
      | c9qgo11pud7kb3cdomeg...  | 2020-08-10T12:00:00Z | c9qgo11pud7kb3cdomeg | 2020-08-10T11:55:17Z |
      | ...                                                                                           |
      +--------------------------+----------------------+----------------------+----------------------+
      ```

      The time when the backup was completed is shown in the `CREATED AT` column of a list of available backups, in `yyyy-mm-ddThh:mm:ssZ` format (`2020-08-10T12:00:00Z` in the example above). You can restore a cluster to any state from the specified point in time to the current time.

   1. Request the creation of a cluster from a backup:

      {% if audience == "internal" %}

      ```
      {{ yc-mdb-my }} cluster restore \
        --backup-id c9qgo11pud7kb3cdomeg:stream_20190213T093643Z \
        --time 2020-08-10T12:00:10Z \
        --name=mynewmy \
        --environment=PRODUCTION \
        --network-id {{ network-name }} \
        --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr8efcch63 \
        --disk-size 20 \
        --disk-type network-ssd \
        --resource-preset {{ host-class }}
      ```

      {% else %}

      ```
      {{ yc-mdb-my }} cluster restore \
        --backup-id c9qgo11pud7kb3cdomeg:stream_20190213T093643Z \
        --time 2020-08-10T12:00:10Z \
        --name=mynewmy \
        --environment=PRODUCTION \
        --network-name {{ network-name }} \
        --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr8efcch63 \
        --disk-size 20 \
        --disk-type {{ disk-type-example }} \
        --resource-preset {{ host-class }}
      ```

      {% endif %}

      In the `--time` parameter, specify the time point from which you want to restore the original state of the {{ MY }} cluster, in `yyyy-mm-ddThh:mm:ssZ` format.

      In the example above, the cluster will be restored to the state it was 10 seconds after the `c9qgo11pud7kb3cdomeg...` backup was created. This backup was selected as the starting point for recovery (the `--time 2020-08-10T12:00:10Z` parameter).

      This results in a new {{ MY }} cluster with the following characteristics:

      {% if audience == "internal" %}

      * With the name `mynewmy`.
      * In the `PRODUCTION` environment.
      * With a single `{{ host-class }}` class host in the `{{ region-id }}-a` availability zone.
      * With the databases and users from the backup.
      * With 20 GB of SSD network (`network-ssd`) storage.

      {% endif %}

      {% if audience != "internal" %}

      * With the name `mynewmy`.
      * In the `PRODUCTION` environment.
      * In the `{{ network-name }}` network.
      * With a single `{{ host-class }}` class host in the `b0rcctk2rvtr8efcch63` subnet of the `{{ region-id }}-a` availability zone.
      * With databases and users that existed in the cluster at the time of recovery.
      * With 20 GB of SSD network storage (`{{ disk-type-example }}`).

      {% endif %}

- {{ TF }}

   Use {{ TF }} to restore:

   * An existing cluster from a backup.
   * A cluster created and deleted via the management console, CLI, or API.

   To restore a cluster, you'll need the backup ID. Retrieve a list of available {{ MY }} cluster backups [using the CLI](#list-backups):

   ```bash
   {{ yc-mdb-my }} backup list
   ```

   Result:

   ```
   +--------------------------+----------------------+----------------------+----------------------+
   |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
   +--------------------------+----------------------+----------------------+----------------------+
   | c9qgo11pud7kb3cdomeg...  | 2020-08-10T12:00:00Z | c9qgo11pud7kb3cdomeg | 2020-08-10T11:55:17Z |
   | ...                                                                                           |
   +--------------------------+----------------------+----------------------+----------------------+
   ```

   **To restore an existing cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for a new cluster.

      Leave the settings under `database `and `user` empty, they will be restored from the backup:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        database {
          name  = ""
          owner = ""
        }
        user {
          name     = ""
          password = ""
        }
      }
      ```

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

      In the `time` parameter, specify the time point from which you want to restore the state of the {{ MY }} cluster, starting from the time when the selected backup was created to the current time.

      {% note info %}

      The `time` parameter is optional. If you don't specify it, the cluster is restored to the state when the backup was completed.

      {% endnote %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {{ TF }} creates a copy of the existing cluster. The databases and users are deployed from the selected backup.

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

   **To restore a previously deleted cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for a new cluster.

      Leave the settings under `database` and `user` empty, they will be restored from the backup:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        database {
          name  = ""
          owner = ""
        }
        user {
          name     = ""
          password = ""
        }
      }
      ```

   1. In the configuration file, add a `restore` block with the name of the backup to restore the cluster from:

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

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {{ TF }} creates a new cluster. The databases and users are deployed from the backup.

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   Use the [restore](../api-ref/Cluster/restore.md) API method and pass the following in the request:

   * ID of the desired backup, in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
   * The timestamp of the point to which you want to recover the cluster, in the `time` parameter.
   * The name of the new cluster that will contain the data recovered from the backup, in the `name` parameter. The cluster name must be unique within the folder.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. Click **Create backup**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster backup:

   1. View a description of the CLI command to create a {{ MY }} cluster backup:

      ```
      {{ yc-mdb-my }} cluster backup --help
      ```

   1. Request the creation of a backup specifying the cluster name or ID:

      ```
      {{ yc-mdb-my }} cluster backup <cluster name>
      ```

      The cluster name and ID can be retrieved with the [list of clusters](cluster-list.md#list-clusters).

- API

   Use the [backup](../api-ref/Cluster/backup.md) API method and pass the cluster ID in the `clusterId` request parameter.

   {% include [Getting the Cluster ID](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

In single-host clusters, you create a backup by reading data from the master host while the solution for multi-host clusters is to read one of the replicas. At the same time, you can [specify host priorities when creating backups](#set-backup-priority).

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

   To get a list of cluster backups:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.

   To get a list of all backups in a folder:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of {{ MY }} cluster backups available in the default folder, run the command:

   ```
   {{ yc-mdb-my }} backup list
   ```

   Result:

   ```
   +----------+----------------------+----------------------+----------------------+
   |    ID    |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
   +----------+----------------------+----------------------+----------------------+
   | c9qgo... | 2020-08-10T12:00:00Z | c9qgo11pud7kb3cdomeg | 2020-08-10T11:55:17Z |
   | c9qpm... | 2020-08-09T22:01:04Z | c9qpm90p3pcg71jm7tqf | 2020-08-09T21:30:00Z |
   +----------+----------------------+----------------------+----------------------+
   ```

- API

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To get a list of backups for all the **{{ mmy-name }}** clusters in the folder, use the [list](../api-ref/Backup/list.md) API method and pass the folder ID in the `folderId` request parameter.

   {% include [Getting the Cluster ID](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs %}

- Management console

   To get information about the backup of an existing cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.

   To get information about the backup of a previously deleted cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ MY }} cluster backup, run the command:

   ```bash
   {{ yc-mdb-my }} backup get <backup ID>
   ```

   You can retrieve the backup ID with a [list of backups](#list-backups).

- API

   Use the [get](../api-ref/Backup/get.md) API method and pass the backup ID in the `backupId` request parameter.

   To find out the ID, [retrieve a list of backups](#list-backups).

{% endlist %}


## Setting the backup start time {#set-backup-window}

{% list tabs %}

- Management console

   In the [management console]({{ link-console-main }}), you can only set the backup start time when [updating a cluster](update.md).

- CLI

   To change the backup start time in an existing cluster, use the `update` command:

   ```bash
   {{ yc-mdb-my }} cluster update \
     --name=<cluster name> \
     --backup-window-start 11:25:00
   ```

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

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. You can get it together [with a list of clusters in the folder](cluster-list.md#list-clusters).
   * The new backup start time, in the `configSpec.backupWindowStart` parameter.
   * List of cluster configuration fields to be edited (in this case, `configSpec.backupWindowStart`) in the `updateMask` parameter.

   {% include [Resetting the settings of the object being modified](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

## Setting host priorities when creating backup {#set-backup-priority}

The minimum host priority when creating backups is `0`, the maximum is `100`, and the default is `0`. A replicated host with the highest priority serves as the backup source. For more information, see [Creating backups](../concepts/backup.md#size).

{% list tabs %}

- Management console

   In the [management console]({{ link-console-main }}), a host's priority is set when [creating](cluster-create.md) a cluster, [adding](../operations/hosts.md#add) new cluster hosts, or [updating the settings](../operations/hosts.md#update) of the existing hosts.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To modify the backup priority of a selected host, run the command below:

   ```bash
   {{ yc-mdb-my }} host update <host name> \
     --cluster-name=<cluster name> \
     --backup-priority=<host priority for backups: 0 to 100>
   ```

   The host name can be requested with a [list of cluster hosts](hosts.md#list), and the cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To modify a host's priority, use the [updateHosts](../api-ref/Cluster/updateHosts.md) method and pass the following in in the request:

   * The cluster ID in the `clusterId` parameter. You can retrieve it with a [list of clusters in the folder](cluster-list.md#list-clusters).
   * Host name in the `updateHostSpecs.hostName` parameter. It may be retrieved with a [list of hosts in the cluster](hosts.md#list).
   * New host priority value in the `updateHostSpecs.backupPriority` parameter.
   * List of cluster configuration fields to update (here, `updateHostSpecs.hostName` and `updateHostSpecs.backupPriority`) in the `updateMask` parameter.

   {% include [Resetting the settings of the object being modified](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}
