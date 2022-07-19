---
title: "PostgreSQL backup management"
description: "You can back up and restore clusters from your existing PostgreSQL backups. Point-in-Time Recovery (PITR) technology allows you to restore the state of the cluster to any point in time from the backup to the current moment."
---

# Managing backups

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

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

      ```
      {{ yc-mdb-pg }} cluster restore --help
      ```

   1. Getting a list of available {{ PG }} cluster backups:

      ```
      {{ yc-mdb-pg }} backup list

      +--------------------------+----------------------+----------------------+----------------------+
      |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
      +--------------------------+----------------------+----------------------+----------------------+
      | c9qlk4v13uq79r9cgcku... | 2020-08-10T12:00:00Z | c9qlk4v13uq79r9cgcku | 2020-08-10T11:55:17Z |
      | ...                                                                                           |
      +--------------------------+----------------------+----------------------+----------------------+
      ```
      The time when the backup was completed is shown in the `CREATED AT` column of a list of available backups, in `yyyy-mm-ddThh:mm:ssZ` format (`2020-08-10T12:00:00Z` in the example above). You can restore a cluster to any state from the specified point in time to the current time.

   1. Request the creation of a cluster from a backup:

      ```bash
      {{ yc-mdb-pg }} cluster restore \
             --backup-id c9qlk4v13uq79r9cgcku:base_000000010000000000000002 \
             --time 2020-08-10T12:00:10Z \
             --name mynewpg \
             --environment=PRODUCTION \
             --network-name {{ network-name }} \
             --host {{ host-net-example }} \
             --disk-size 20 \
             --disk-type {{ disk-type-example }} \
             --resource-preset {{ host-class }}
      ```

      In the `--time` parameter, specify the time point from which you want to restore the original state of the {{ PG }} cluster, in `yyyy-mm-ddThh:mm:ssZ` format.

      In the example above, the cluster will be restored to the state it was 10 seconds after the `c9qlk4v13uq79r9cgcku...` backup was created. This backup was selected as the starting point for recovery (the `--time 2020-08-10T12:00:10Z parameter`).

      This results in a new {{ PG }} cluster with the following characteristics:

      {% if audience != "internal" %}

      - Named `mynewpg`.
      - In the `PRODUCTION` environment.
      - In the `{{ network-name }}` network.
      - With a single `{{ host-class }}` class host in the `b0rcctk2rvtr8efcch63` subnet of the `{{ region-id }}-a` availability zone.
      - With databases and users that existed in the cluster at the time of recovery.
      - With a network SSD storage (`{{ disk-type-example }}`) of 20 GB.

      {% else %}

      - Named `mynewpg`.
      - In the `PRODUCTION` environment.
      - With a single `{{ host-class }}` class host in the `{{ region-id }}-a` availability zone.
      - With databases and users that existed in the cluster at the time of recovery.
      - With 20 GB of SSD network (`network-ssd`) storage.

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
   +--------------------------+----------------------+----------------------+----------------------+
   |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
   +--------------------------+----------------------+----------------------+----------------------+
   | c9qlk4v13uq79r9cgcku...  | 2020-08-10T12:00:00Z | c9qlk4v13uq79r9cgcku | 2020-08-10T11:55:17Z |
   | ...                                                                                           |
   +--------------------------+----------------------+----------------------+----------------------+
   ```

   {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

   **To restore an existing cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for a new cluster.

      Leave the settings under `database` and `user` empty, they will be restored from the backup:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
        ...
        }
        database {
          name  = ""
          owner = ""
        }
        user {
          name     = ""
          password = ""
        }
      ```

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

      In the `time` parameter, specify the time point from which you want to restore the state of the {{ PG }} cluster, starting from the time when the selected backup was created to the current time.

      {% note info %}

      If you don't specify the `time` parameter, the cluster is restored to the state when the backup was completed.

      {% endnote %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {{ TF }} creates a copy of the existing cluster. The databases and users are deployed from the selected backup.

   **To restore a previously deleted cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for a new cluster.

      Leave the settings under `database` and `user` empty, they will be restored from the backup:

      ```hcl
       resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
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
      resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
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

   +----------+----------------------+----------------------+----------------------+
   |    ID    |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
   +----------+----------------------+----------------------+----------------------+
   | c9qlk... | 2020-08-10T12:00:00Z | c9qlk4v13uq79r9cgcku | 2020-08-10T11:55:17Z |
   | c9qpm... | 2020-08-09T22:01:04Z | c9qpm90p3pcg71jm7tqf | 2020-08-09T21:30:00Z |
   +----------+----------------------+----------------------+----------------------+
   ```

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
      --user name=<user name>,password=<user password> \
      --database name=<database name>,owner=<DB owner name> \
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
            hours   = <backup start hour (UTC)>
            minutes = <backup start minute (UTC)>
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

{% endlist %}
