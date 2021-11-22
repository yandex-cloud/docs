---
title: "ClickHouse backup management"
description: "You can create backups and restore clusters from existing ClickHouse backups. When restoring a cluster from a backup, you create a new cluster with data from the backup. If the cloud does not have enough resources to create such a cluster, you will not be able to recover from the backup."
---

# Managing backups

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

## Creating backups {#create-backup}

{% note warning %}

A random replica host is used to create a backup. If there is no cluster host data consistency, restoring clusters from backups does not guarantee complete data recovery. For more information, see [{#T}](../concepts/backup.md).

{% endnote %}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  1. Click **Create backup**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster backup:

  1. View a description of the CLI create {{ CH }} backup command:

      ```
      $ {{ yc-mdb-ch }} cluster backup --help
      ```

  1. Request creation of a backup specifying the cluster name or ID:

      ```
      $ {{ yc-mdb-ch }} cluster backup my-ch-cluster
      ```

      The cluster name and ID can be retrieved with the [list of clusters](cluster-list.md#list-clusters).

{% endlist %}

## Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with data from the backup. If the cloud has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps per database core.

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type (a {{ CH }} backup cannot be restored as a {{ PG }} cluster).

{% include [mch-mergetree-conversion](../../_includes/mdb/mch-restore-tables-conversion-alert.md) %}

{% list tabs %}

- Management console

  To restore an existing cluster from a backup:
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the backup and click **Restore cluster**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
  1. Click **Restore cluster**.

  To restore a previously deleted cluster from a backup:
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click the **Backups** tab.
  1. Find the desired backup using the backup creation time and cluster ID. The **Name** column contains the IDs in `<cluster ID>:<backup ID>` format.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) for the backup and click **Restore cluster**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
  1. Click **Restore cluster**.

  {{ mch-name }} launches the operation to create a cluster from the backup.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore a cluster from the backup:

  1. View a description of the CLI restore {{ CH }} cluster command:

      ```
      $ {{ yc-mdb-ch }} cluster restore --help
      ```

  1. Getting a list of available {{ CH }} cluster backups:

      ```
      $ {{ yc-mdb-ch }} backup list
      
      +--------------------------+----------------------+----------------------+----------------------+
      |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
      +--------------------------+----------------------+----------------------+----------------------+
      | c9qlk4v13uq79r9cgcku:... | 2018-11-02T10:08:38Z | c9qlk4v13uq79r9cgcku | 2018-11-02T10:08:37Z |
      | ...                                                                                           |
      +--------------------------+----------------------+----------------------+----------------------+
      ```

  1. Request creation of a cluster from a backup:

      {% if audience == "internal" %}

      ```
      $ {{ yc-mdb-ch }} cluster restore \
             --backup-id c9q22suuefrmrp2lrv9f:20181109T101204 \
             --name mynewch \
             --environment=PRODUCTION \
             --network-id ' ' \
             --host type=clickhouse,zone-id={{ zone-id }} \
             --clickhouse-disk-size 20 \
             --clickhouse-disk-type local-ssd \
             --clickhouse-resource-preset {{ host-class }}
      ```

      {% else %}

      ```
      $ {{ yc-mdb-ch }} cluster restore \
             --backup-id c9q22suuefrmrp2lrv9f:20181109T101204 \
             --name mynewch \
             --environment=PRODUCTION \
             --network-name {{ network-name }} \
             --host type=clickhouse,zone-id={{ zone-id }},subnet-id=b0rcctk2rvtr8efcch63 \
             --clickhouse-disk-size 20 \
             --clickhouse-disk-type network-ssd \
             --clickhouse-resource-preset {{ host-class }}
      ```

      {% endif %}

      This results in a new {{ CH }} cluster with the following characteristics:

      {% if audience != "internal" %}
      - Named `mynewch`.
      - In the `PRODUCTION` environment.
      - In the `{{ network-name }}` network.
      - With a single `{{ host-class }}` class host in the `b0rcctk2rvtr8efcch63` subnet of the `{{ zone-id }}` availability zone.
      - With the databases and users from the backup.
      - With 20 GB of fast network storage (`{{ disk-type-example }}`).

      {% else %}
      - Named `mynewch`.
      - In the `PRODUCTION` environment.
      - With one `{{ host-class }}` class host in the `{{ zone-id }}` availability zone.
      - With the databases and users from the backup.
      - With 20 GB fast local storage (`local-ssd`).

      {% endif %}

{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

  To get a list of cluster backups:
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  To get a list of all backups in a folder:
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click the **Backups** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ CH }} cluster backups available in the default folder, run the command:

  ```
  $ {{ yc-mdb-ch }} backup list
  
  +----------+----------------------+----------------------+----------------------+
  |    ID    |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
  +----------+----------------------+----------------------+----------------------+
  | c9qv4... | 2018-10-31T22:01:07Z | c9qv4ql6bd4hfo1cgc3o | 2018-10-31T22:01:03Z |
  | c9qpm... | 2018-10-31T22:01:04Z | c9qpm90p3pcg71jm7tqf | 2018-10-31T22:01:04Z |
  +----------+----------------------+----------------------+----------------------+
  ```

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs %}

- Management console

  To get information about the backup of an existing cluster:
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  To get information about the backup of a previously deleted cluster:
  1. Go to the folder page and select **{{ mch-name }}**.
  1. Click the **Backups** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ CH }} cluster backup, run the command:

  ```bash
  {{ yc-mdb-ch }} backup get <backup ID>
  ```

  The backup ID can be retrieved with the [list of backups](#list-backups).

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs %}

- Management console

  When [creating](cluster-create.md) or [updating](update.md#change-clickhouse-config) a cluster, you can set the backup start time under **Additional settings**.

- CLI

  To set the backup start time, use the `-- backup-window-start` flag. Time is given in ``HH:MM:SS`` format.

  ```bash
  {{ yc-mdb-ch }} cluster create \
        --name <cluster name> \
        --environment <prestable or production> \
        --network-name <network name> \
        --host type=<clickhouse or zookeeper>,zone-id=<availability zone>,subnet-id=<subnet ID> \
        --resource-preset <host class> \
        --clickhouse-disk-type <network-hdd | network-ssd | local-ssd> \
        --clickhouse-disk-size <storage size in GB> \
        --user name=<username>,password=<user password> \
        --database name=<DB name> \
        --backup-window-start 10:00:00
  ```

  To change the backup start time in an existing cluster, use the `update` command:

  ```bash
  {{ yc-mdb-ch }} cluster update \
     --name <cluster name> \
     --backup-window-start 11:25:00
  ```

{% endlist %}

