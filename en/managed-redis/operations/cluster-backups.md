---
title: "Redis backup management"
description: "You can create backups and restore clusters from existing Redis backups. When restoring a cluster from a backup, you create a new cluster with data from the backup. If the cloud does not have enough resources to create such a cluster, you will not be able to recover from the backup."
---

# Managing backups

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

## Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps.

{% list tabs %}

- Management console

   To restore an existing cluster from a backup:

   1. In the [management console]({{ link-console-main }}), go to the folder to restore the cluster in.
   1. Select **{{ mrd-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. In the line of the appropriate backup, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. Click **Restore cluster**.

   To restore a previously deleted cluster from a backup:

   1. In the [management console]({{ link-console-main }}), go to the folder to restore the cluster in.
   1. Select **{{ mrd-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.
   1. Find the desired backup using the backup creation time and cluster ID. The **Name** column contains the IDs in `<cluster ID>:<backup ID>` format.
   1. In the line of the appropriate backup, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. Click **Restore cluster**.

   {{ mrd-name }} launches the operation to create a cluster from the backup.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To restore a cluster from a backup:

   1. View a description of the CLI restore {{ RD }} cluster command:

      ```
      {{ yc-mdb-rd }} cluster restore --help
      ```

   1. Getting a list of available {{ RD }} cluster backups:

      ```
      {{ yc-mdb-rd }} backup list
      ```

      Result:

      ```
      +--------------------------+----------------------+----------------------+----------------------+
      |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
      +--------------------------+----------------------+----------------------+----------------------+
      | c9qlk4v13uq79r9cgcku:... | 2018-11-02T10:08:38Z | c9qlk4v13uq79r9cgcku | 2018-11-02T10:08:37Z |
      | ...                                                                                           |
      +--------------------------+----------------------+----------------------+----------------------+
      ```

   1. Request the creation of a cluster from a backup:

      ```
      {{ yc-mdb-rd }} cluster restore \
         --backup-id c9q287aqv5rf11isjeql:20181113T133617 \
         --cluster-name mynewrd \
         --environment=PRODUCTION \
         --network-name default \
         --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr8efcch63 \
         --password P@ssWord \
         --disk-size 20
      ```

      This results in a new {{ RD }} cluster with the following characteristics:

      * With the `mynewrd` name.
      * In the `PRODUCTION` environment.
      * In the `default` network.
      * With a single host of the `hm1.nano` class in the `b0rcctk2rvtr8efcch63` subnet and the `{{ region-id }}-a` availability zone.
      * With 10 GB of SSD network storage (`{{ disk-type-example }}`).

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder to create a backup in.
   1. Select **{{ mrd-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. Click **Create backup**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster backup:

   1. View a description of the CLI create {{ RD }} backup command:

      ```
      {{ yc-mdb-rd }} cluster backup --help
      ```

   1. Request the creation of a backup specifying the cluster name or ID:

      ```
      {{ yc-mdb-rd }} cluster backup my-rd-cluster
      ```

      The cluster name and ID can be retrieved with the [list of clusters](cluster-list.md#list-clusters).

- API

   Use the [backup](../api-ref/Cluster/backup.md) API method and pass the cluster ID in the `clusterId` parameter.

   You can fetch the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

   To get a list of cluster backups:
   1. In the [management console]({{ link-console-main }}), go to Billing.
   1. Select **{{ mrd-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.

   To get a list of all backups in a folder:
   1. In the [management console]({{ link-console-main }}), go to Billing.
   1. Select **{{ mrd-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of {{ RD }} cluster backups available in the default folder, run the command:

   ```
   {{ yc-mdb-rd }} backup list
   ```
   Result:

   ```
   +----------+----------------------+----------------------+----------------------+
   |    ID    |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
   +----------+----------------------+----------------------+----------------------+
   | c9qv4... | 2018-10-31T22:01:07Z | c9qv4ql6bd4hfo1cgc3o | 2018-10-31T22:01:03Z |
   | c9qpm... | 2018-10-31T22:01:04Z | c9qpm90p3pcg71jm7tqf | 2018-10-31T22:01:04Z |
   +----------+----------------------+----------------------+----------------------+
   ```

- API

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) API method and pass the cluster ID in the `clusterId` parameter. You can fetch the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

   To get a list of all backups in the folder, use the [list](../api-ref/Backup/list.md) API method and pass the folder ID in the `folderId` parameter.

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs %}

- Management console

   To get information about the backup of an existing cluster:
   1. In the [management console]({{ link-console-main }}), go to the folder with the cluster to get backup information for.
   1. Select **{{ mrd-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.

   To get information about the backup of a previously deleted cluster:
   1. In the [management console]({{ link-console-main }}), go to the folder that contained the deleted cluster.
   1. Select **{{ mrd-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ RD }} cluster backup, run the command:

   ```bash
   {{ yc-mdb-rd }} backup get <backup ID>
   ```

   You can retrieve the backup ID with a [list of backups](#list-backups).

- API

   Use the [get](../api-ref/Backup/get.md) API method and pass the backup ID in the `backupId` parameter.

   You can retrieve the backup ID with the [backup list](#list-backups).

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs %}

- Management console

   When [creating](cluster-create.md) or [updating](update.md#change-redis-config) a cluster, you can set the backup start time under **Additional settings**.

- CLI

   To set the backup start time, use the `-- backup-window-start` flag. Time is given in ``HH:MM:SS`` format.

   ```bash
   {{ yc-mdb-rd }} cluster create \
     --cluster-name <cluster name> \
     --environment <environment, prestable or production> \
     --network-name <subnet name> \
     --host zone-id=<availability zone>,subnet-id=<subnet ID> \
     --backup-window-start 10:25:00
   ```

   To change the backup start time in an existing cluster, use the `update` command:

   ```bash
   {{ yc-mdb-rd }} cluster update \
      --cluster-name <cluster name> \
      --backup-window-start 11:25:00
   ```

{% endlist %}
