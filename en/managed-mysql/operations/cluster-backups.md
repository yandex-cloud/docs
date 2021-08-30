---
title: "MySQL backup management"
description: "You can back up and restore clusters from your existing MySQL backups. Point-in-Time Recovery (PITR) technology allows you to restore the state of the cluster to any point in time from the backup to the current moment."
---

# Managing backups

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

## Restoring clusters from backups {#restore}

Point-in-Time Recovery (PITR) technology lets you restore the cluster state to any point in time in the interval from its backup to the current time. If the cluster you are trying to restore is already deleted, the recovery interval is limited by the time point the last backup was created. To learn more about this technology, see [{#T}](../concepts/backup.md).

For example, if the backup operation ended August 10, 2020, 12:00:00 UTC and the current date is August 15, 2020, 19:00:00 UTC, the cluster can be restored to any state between August 10, 2020, 12:00:01 UTC and August 15, 2020, 18:59:59 UTC inclusive.

When you restore a cluster from a backup, you create a new cluster with data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps per database core.

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type (a {{ CH }} backup cannot be restored as a {{ MY }} cluster).

When restoring to the state from the current time point:

- The new cluster reflects the state of the cluster at the time of recovery if the cluster still exists.
- The new cluster reflects the state of the cluster at the time of the creation of the newest backup if the cluster is already deleted.

{% list tabs %}

- Management console

  To restore an existing cluster from a backup:

  1. Go to the folder page and select **{{ mmy-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the backup and click **Restore cluster**.

  1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.

  1. To restore the cluster state from a desired point of time after creating this backup, configure the **Date and time of recovery (UTC)** setting. You can enter the value manually or select it from the drop-down calendar.

     If you don't change the setting, the cluster is restored to the state when the backup was completed.

  1. Click **Restore cluster**.

  To restore a previously deleted cluster from a backup:

  1. Go to the folder page and select **{{ mmy-name }}**.

  1. Click the **Backups** tab.

  1. Find the desired backup using the backup creation time and cluster ID. The **Name** column contains the IDs in `<cluster ID>:<backup ID>` format.

  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the backup and click **Restore cluster**.

  1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.

  1. To restore the cluster state from a desired point of time after creating this backup, configure the **Date and time of recovery (UTC)** setting. You can enter the value manually or select it from the drop-down calendar.

     If you don't change the setting, the cluster is restored to the state when the backup was completed.

  1. Click **Restore cluster**.

  {{ mmy-name }} launches the operation to create a cluster from the backup.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore a cluster from a backup:

  1. View a description of the CLI restore {{ MY }} cluster command:

      ```
      $ {{ yc-mdb-my }} cluster restore --help
      ```

  1. Getting a list of available {{ MY }} cluster backups:

     ```
     $ {{ yc-mdb-my }} backup list
     
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
      $ {{ yc-mdb-my }} cluster restore \
             --backup-id c9qgo11pud7kb3cdomeg:stream_20190213T093643Z \
             --time 2020-08-10T12:00:10Z \
             --name=mynewmy \
             --environment=PRODUCTION \
             --network-id {{ network-name }} \
             --host zone-id={{ zone-id }},subnet-id=b0rcctk2rvtr8efcch63 \
             --disk-size 20 \
             --disk-type network-ssd \
             --resource-preset {{ host-class }}
      ```

      {% else %}

      ```
      $ {{ yc-mdb-my }} cluster restore \
             --backup-id c9qgo11pud7kb3cdomeg:stream_20190213T093643Z \
             --time 2020-08-10T12:00:10Z \
             --name=mynewmy \
             --environment=PRODUCTION \
             --network-name {{ network-name }} \
             --host zone-id={{ zone-id }},subnet-id=b0rcctk2rvtr8efcch63 \
             --disk-size 20 \
             --disk-type {{ disk-type-example }} \
             --resource-preset {{ host-class }}
      ```

      {% endif %}

      In the `--time` parameter, specify the time point from which you want to restore the original state of the {{ MY }} cluster, in the `yyyy-mm-ddThh:mm:ssZ` format.

      In the example above, the cluster will be restored to the state it was 10 seconds after the `c9qgo11pud7kb3cdomeg...` backup was created. This backup was selected as the starting point for recovery (the `--time 2020-08-10T12:00:10Z` parameter).

      This results in a new {{ MY }} cluster with the following characteristics:

      {% if audience == "internal" %}
      - With the name `mynewmy`.
      - In the `PRODUCTION` environment.
      - With one `{{ host-class }}` class host in the `{{ zone-id }}` availability zone.
      - With the databases and users from the backup.
      - With 20 GB fast network storage (`network-ssd`).

      {% endif %}

      {% if audience != "internal" %}
      - With the name `mynewmy`.
      - In the `PRODUCTION` environment.
      - In the `{{ network-name }}` network.
      - With a single `{{ host-class }}` class host in the `b0rcctk2rvtr8efcch63` subnet of the `{{ zone-id }}` availability zone.
      - With databases and users that existed in the cluster at the time of recovery.
      - With 20 GB fast network storage (`{{ disk-type-example }}`).

      {% endif %}

- Terraform

  Use Terraform to restore:

  * An existing cluster from a backup.
  * A cluster created and deleted via the management console, CLI, or API.

  To restore a cluster, you'll need the backup ID. Get a list of available {{ MY }} cluster backups [using the CLI]{% if lang == "ru" %}(https://cloud.yandex.ru/docs/managed-mysql/operations/cluster-backups#list-backups){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en/docs/managed-mysql/operations/cluster-backups#list-backups){% endif %}:

  ```bash
  {{ yc-mdb-my }} backup list
  
  +--------------------------+----------------------+----------------------+----------------------+
  |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
  +--------------------------+----------------------+----------------------+----------------------+
  | c9qgo11pud7kb3cdomeg...  | 2020-08-10T12:00:00Z | c9qgo11pud7kb3cdomeg | 2020-08-10T11:55:17Z |
  | ...                                                                                           |
  +--------------------------+----------------------+----------------------+----------------------+
  ```

  **To restore an existing cluster from a backup:**

  1. Create a [Terraform configuration file]{% if lang == "ru" %}(https://cloud.yandex.ru/docs/managed-mysql/operations/cluster-create#create-cluster){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en/docs/managed-mysql/operations/cluster-create#create-cluster){% endif %} for a new cluster.

     {% note info %}

     Do not specify DB and user settings under `database` and `user`, they will be restored from the backup.

     {% endnote %}

  1. Add a block named `restore` to this configuration file:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        restore {
          backup_id = "<name of the desired backup>"
          time      = "<timestamp of the time of recovery in yyyy-mm-ddThh:mm:ssZ format>"
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

  Terraform creates a copy of the existing cluster. The databases and users are deployed from the selected backup.

  **To restore a previously deleted cluster from a backup:**

  1. Create a [Terraform configuration file]{% if lang == "ru" %}(https://cloud.yandex.ru/docs/managed-mysql/operations/cluster-create#create-cluster){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en/docs/managed-mysql/operations/cluster-create#create-cluster){% endif %} for a new cluster.

     {% note info %}

     Do not specify DB and user settings under `database` and `user`, they will be restored from the backup.

     {% endnote %}

  1. In the configuration file, add a `restore` block with the name of the backup to restore the cluster from:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        restore {
            backup_id = "<ID of the deleted cluster's backup>"
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Terraform creates a new cluster. The databases and users are deployed from the backup.

  For more information, see [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.
  1. Click **Create backup**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster backup:

  1. View a description of the CLI command to create a {{ MY }} cluster backup:

      ```
      $ {{ yc-mdb-my }} cluster backup --help
      ```

  1. Request the creation of a backup specifying the cluster name or ID:

      ```
      $ {{ yc-mdb-my }} cluster backup <cluster name>
      ```

      The cluster name and ID can be retrieved with the [list of clusters](cluster-list.md#list-clusters).

{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

  To get a list of cluster backups:
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  To get a list of all backups in a folder:
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click the **Backups** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ MY }} cluster backups available in the default folder, run the command:

  ```
  $ {{ yc-mdb-my }} backup list
  
  +----------+----------------------+----------------------+----------------------+
  |    ID    |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
  +----------+----------------------+----------------------+----------------------+
  | c9qgo... | 2020-08-10T12:00:00Z | c9qgo11pud7kb3cdomeg | 2020-08-10T11:55:17Z |
  | c9qpm... | 2020-08-09T22:01:04Z | c9qpm90p3pcg71jm7tqf | 2020-08-09T21:30:00Z |
  +----------+----------------------+----------------------+----------------------+
  ```

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs %}

- Management console

  To get information about the backup of an existing cluster:
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  To get information about the backup of a previously deleted cluster:
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Click the **Backups** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ MY }} cluster backup, run the command:

  ```bash
  {{ yc-mdb-my }} backup get <backup ID>
  ```

  The backup ID can be retrieved with the [list of backups](#list-backups).

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs %}

- Management console

  In the management console, you can only set the start time for creating backups by [editing the cluster](update.md).

- CLI

  To change the backup start time in an existing cluster, use the `update` command:

  ```bash
  {{ yc-mdb-my }} cluster update \
     --name=<cluster name> \
     --backup-window-start 11:25:00
  ```

- Terraform

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For information about how to create this file, see [{#T}](cluster-create.md).

  1. Add a block named `backup_window_start` to the {{ mmy-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        backup_window_start {
          hours   = <backup starting hour (UTC)>
          minutes = <backup starting minute (UTC)>
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

{% endlist %}
