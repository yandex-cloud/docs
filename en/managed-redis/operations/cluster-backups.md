# Managing backups

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

## Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps.

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mrd-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  1. Click ![image](../../_assets/dots.svg) for the required backup and then click **Restore cluster**.

  1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.

  1. Click **Restore cluster**.

  {{ mrd-name }} runs cluster restore from backup.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore a cluster from a backup:

  1. View the description of the CLI's restore cluster command {{ RD }}:

      ```
      $ {{ yc-mdb-rd }} cluster restore --help
      ```

  1. Getting a list of available {{ RD }} cluster backups:

      ```
      $ {{ yc-mdb-rd }} backup list
      
      +--------------------------+----------------------+----------------------+----------------------+
      |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
      +--------------------------+----------------------+----------------------+----------------------+
      | c9qlk4v13uq79r9cgcku:... | 2018-11-02T10:08:38Z | c9qlk4v13uq79r9cgcku | 2018-11-02T10:08:37Z |
      | ...                                                                                           |
      +--------------------------+----------------------+----------------------+----------------------+
      ```

  1. Request creation of a cluster from a backup:

      ```
      $ {{ yc-mdb-rd }} cluster restore \
           --backup-id c9q287aqv5rf11isjeql:20181113T133617 \
           --cluster-name mynewrd \
           --environment=PRODUCTION \
           --network-name default \
           --host zone-id=ru-central1-c,subnet-id=b0rcctk2rvtr8efcch63 \
           --password P@ssWord
           --disk-size 20
      ```

      This results in a new {{ RD }} cluster with the following characteristics:
      - With the `mynewrd` name.
      - In the `PRODUCTION` environment.
      - In the `default` network.
      - With a single host of the `hm1.nano` class in the `b0rcctk2rvtr8efcch63` subnet and the `ru-central1-c` availability zone.
      - With 20 GB fast network storage (`{{ disk-type-example }}`).

{% endlist %}

## Creating backups {#create-backup}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mrd-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  1. Click **Create a backup**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster backup:

  1. View a description of the CLI create {{ RD }} backup command:

      ```
      $ {{ yc-mdb-rd }} cluster backup --help
      ```

  1. Request creation of a backup specifying the cluster name or ID:

      ```
      $ {{ yc-mdb-rd }} cluster backup my-rd-cluster
      ```

      The cluster name and ID can be retrieved with the [list of clusters](cluster-list.md#list-clusters).

{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mrd-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ MG }} cluster backups available in the default folder, run the command:

  ```
  $ {{ yc-mdb-rd }} backup list
  
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

  1. Go to the folder page and select **{{ mrd-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ RD }} cluster backup, run the command:

  ```
  $ yc {{ yc-mdb-rd }} backup get <backup ID>
  ```

  The backup ID can be retrieved with the [list of backups](#list-backups) .

{% endlist %}

## Set the backup start time {#set-backup-window}

{% list tabs %}

- Management console

  In the management console, you can only set the backup start time when you edit the cluster.

- CLI

  To set the backup start time, use the `-- backup-window-start` flag. Time is given in ``HH:MM:SS`` format.

  ```
  $ yc {{ yc-mdb-rd }} cluster create \
     --cluster-name <cluster name>
     --environment <prestable or production> \
     --network-name <network name> \
     --host zone-id=<availability zone>,subnet-id=<subnet ID> \
     --backup-window-start 10:25:00
  ```

  To change the backup start time in an existing cluster, use the `update` command:

  ```
  $ yc {{ yc-mdb-rd }} cluster update \
     --cluster-name <cluster name>
     --backup-window-start 11:25:00
  ```

{% endlist %}

