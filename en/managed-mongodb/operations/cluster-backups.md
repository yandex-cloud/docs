# Managing backups

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

## Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps.

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type (a {{ MG }} backup cannot be restored as a {{ PG }} cluster).

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  1. Click ![image](../../_assets/dots.svg) for the required backup and then click **Restore cluster**.

  1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.

  1. Click **Restore cluster**.

  {{ mmg-name }} runs cluster restore from backup.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore a cluster from a backup:

  1. View the description of the CLI's restore cluster command {{ MG }}:

      ```
      $ {{ yc-mdb-mg }} cluster restore --help
      ```

  1. Getting a list of available {{ MG }} cluster backups:

      ```
      $ {{ yc-mdb-mg }} backup list
      
      +--------------------------+----------------------+----------------------+----------------------+
      |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
      +--------------------------+----------------------+----------------------+----------------------+
      | c9qlk4v13uq79r9cgcku:... | 2018-11-02T10:08:38Z | c9qlk4v13uq79r9cgcku | 2018-11-02T10:08:37Z |
      | ...                                                                                           |
      +--------------------------+----------------------+----------------------+----------------------+
      ```

  1. Request creation of a cluster from a backup:


      ```
      $ {{ yc-mdb-mg }} cluster restore \
           --backup-id c9q287aqv5rf11isjeql:20181113T133617 \
           --cluster-name mynewmg \
           --environment=PRODUCTION \
           --network-name {{ network-name }} \
           --host zone-id=ru-central1-c,subnet-id=b0rcctk2rvtr8efcch63 \
           --mongod-disk-size 20 \
           --mongod-disk-type {{ disk-type-example }} \
           --mongod-resource-preset {{ host-class }}
      ```

      This results in a new {{ MG }} cluster with the following characteristics:


      - Named `mynewmg`.
      - In the `PRODUCTION` environment.
      - In the `{{ network-name }}` network.
      - With a single `{{ host-class }}` class host in the  `b0rcctk2rvtr8efcch63` subnet of the `{{ zone-id }}` availability zone.
      - With the databases and users from the backup.
      - With 20 GB fast network storage (`{{ disk-type-example }}`).

{% endlist %}

## Creating backups {#create-backup}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  1. Click **Create a backup**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster backup:

  1. View a description of the CLI create {{ MG }} backup command:

      ```
      $ {{ yc-mdb-mg }} cluster backup --help
      ```

  1. Request creation of a backup specifying the cluster name or ID:

      ```
      $ {{ yc-mdb-mg }} cluster backup my-mg-cluster
      ```

      The cluster name and ID can be retrieved with the [list of clusters](cluster-list.md#list-clusters).

{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ MG }} cluster backups available in the default folder, run the command:

  ```
  $ {{ yc-mdb-mg }} backup list
  
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

  1. Go to the folder page and select **{{ mmg-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ MG }} cluster backup, run the command:

  ```
  $ yc {{ yc-mdb-mg }} backup get <backup ID>
  ```

  The backup ID can be retrieved with the [list of backups](#list-backups) .

{% endlist %}

