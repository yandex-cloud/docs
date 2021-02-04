# Managing backups

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

## Creating backups {#create-backup}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  1. Click **Create a backup**.

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

When you restore a cluster from a backup, you create a new cluster with the data from the backup. If the cloud has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps per database core.

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type (a {{ CH }} backup cannot be restored as a {{ PG }} cluster).

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

  1. Click ![image](../../_assets/dots.svg) for the required backup and then click **Restore cluster**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore a cluster from a backup:

  1. View the description of the CLI's restore cluster command {{ CH }}:

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

      This results in a new {{ CH }} cluster with the following characteristics:

      - Named `mynewch`.
      - In the `PRODUCTION` environment.
      - In the `{{ network-name }}` network.
      - With a single `{{ host-class }}` class host in the `b0rcctk2rvtr8efcch63` subnet of the `{{ zone-id }}` availability zone.
      - With the databases and users from the backup.
      - With 20 GB fast network storage (`{{ disk-type-example }}`).

{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mch-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

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

  1. Go to the folder page and select **{{ mch-name }}**.

  1. Click on the name of the cluster you need and select the tab **Backup copies**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ CH }} cluster backup, run the command:

  ```
  $ yc {{ yc-mdb-ch }} backup get <backup ID>
  ```

  The backup ID can be retrieved with the [list of backups](#list-backups) .

{% endlist %}

## Set the backup start time {#set-backup-window}

{% list tabs %}

- Management console

  When [creating](cluster-create.md) or [updating](update.md#change-clickhouse-config) a cluster, you can set the backup start time under **Additional settings**.

- CLI

  To set the backup start time, use the `-- backup-window-start` flag. Time is given in ``HH:MM:SS`` format.

  ```
  $ yc {{ yc-mdb-ch }} cluster create \
        --name <cluster name> \
        --environment <prestable or production> \
        --network-name <network name> \
        --host type=<clickhouse or zookeeper>,zone-id=<availability zone>,subnet-id=<subnet ID> \
        --resource-preset <host class> \
        --clickhouse-disk-type <network-hdd | network-ssd | local-ssd> \
        --clickhouse-disk-size <storage size in GB> \
        --user name=<username>,password=<user password> \
        --database name=<DB name>
        --backup-window-start 10:00:00
  ```

  To change the backup start time in an existing cluster, use the `update` command:

  ```
  $ yc {{ yc-mdb-ch }} cluster update \
     --name <cluster name> \
     --backup-window-start 11:25:00
  ```

{% endlist %}

