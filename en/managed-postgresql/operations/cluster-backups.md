# Managing backups

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

## Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps per database core.

For a new cluster, you should set all the parameters that are required at creation.

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mpg-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  1. Click ![image](../../_assets/dots.svg) for the required backup and then click **Restore cluster**.

  1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.

  1. Click **Restore cluster**.

  {{ mpg-name }} runs cluster restore from backup.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore a cluster from a backup:

  1. View the description of the CLI's restore cluster command {{ PG }}:

      ```
      $ {{ yc-mdb-pg }} cluster restore --help
      ```

  1. Getting a list of available {{ PG }} cluster backups:

      ```
      $ {{ yc-mdb-pg }} backup list
      
      +--------------------------+----------------------+----------------------+----------------------+
      |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
      +--------------------------+----------------------+----------------------+----------------------+
      | c9qlk4v13uq79r9cgcku:... | 2018-11-02T10:08:38Z | c9qlk4v13uq79r9cgcku | 2018-11-02T10:08:37Z |
      | ...                                                                                           |
      +--------------------------+----------------------+----------------------+----------------------+
      ```

      You can restore a {{ PG }} cluster at any time after creating a backup (time in the `CREATED AT` column).

  1. Request creation of a cluster from a backup:

      ```bash
      $ {{ yc-mdb-pg }} cluster restore \
             --backup-id c9qlk4v13uq79r9cgcku:base_000000010000000000000002 \
             --time 2018-11-02T10:09:38Z \
             --cluster-name mynewpg \
             --environment=PRODUCTION \
             --network-name {{ network-name }} \
             --host {{ host-net-example }} \
             --disk-size 20 \
             --disk-type {{ disk-type-example }} \
             --resource-preset {{ host-class }}
      ```

      This results in a new {{ PG }} cluster with the following characteristics:
      - Named `mynewpg`.
      - In the `PRODUCTION` environment.
- In the `{{ network-name }}` network.
      - With a single `{{ host-class }}` class host in the `b0rcctk2rvtr8efcch63` subnet, in the `{{ zone-id }}` availability zone.
      - With the databases and users from the backup.
      - With 20 GB fast network storage (`{{ disk-type-example }}`).

{% endlist %}

## Creating backups {#create-backup}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.
  1. Click **Create a backup**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster backup:

  1. View a description of the CLI create {{ PG }} backup command:

      ```
      $ {{ yc-mdb-pg }} cluster backup --help
      ```

  1. Request creation of a backup specifying the cluster name or ID:

      ```
      $ {{ yc-mdb-pg }} cluster backup my-pg-cluster
      ```

      The cluster name and ID can be retrieved with the [list of clusters](cluster-list.md#list-clusters).

{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ PG }} cluster backups available in the default folder, run the command:

  ```
  $ {{ yc-mdb-pg }} backup list
  
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
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ PG }} cluster backup, run the command:

  ```
  $ {{ yc-mdb-pg }} backup get <backup ID>
  ```

  The backup ID can be retrieved with the [list of backups](#list-backups) .

{% endlist %}

## Set the backup start time {#set-backup-window}

{% list tabs %}

- Management console

  In the management console, you can only set the start time for creating backups by [editing the cluster](update.md).

- CLI

  To set the backup start time, use the `-- backup-window-start` flag. Time is given in ``HH:MM:SS`` format.

  ```bash
  $ {{ yc-mdb-pg }} cluster create \
     --cluster-name <cluster name> \
     --environment <prestable or production> \
     --network-name <network name> \
     --host zone-id=<availability zone>,subnet-id=<subnet ID> \
     --resource-preset <host class> \
     --user name=<username>,password=<user password> \
     --database name=<database name>,owner=<database owner name> \
     --disk-size <storage size in GB> \
     --backup-window-start 10:00:00
  ```

  To change the backup start time in an existing cluster, use the  `update` command:

  ```
  $ yc {{ yc-mdb-pg }} cluster update \
     --cluster-name <cluster name> \
     --backup-window-start 11:25:00
  ```

{% endlist %}

