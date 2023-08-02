# Managing backups in {{ mgp-name }}

You can view your existing [backups](../concepts/backup.md) and restore clusters from them.

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

   To get a list of cluster backups:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Click the name of the desired cluster and select ![image](../../_assets/mdb/backup.svg) **Backups**.

   To get a list of all backups in a folder:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of {{ GP }} cluster backups, run the command:

   ```bash
   {{ yc-mdb-gp }} cluster list-operations <cluster ID or name>
   ```

   You can find out the cluster ID and name in the [list of clusters in the folder](cluster-list.md#list-clusters).

   Result:

   ```text
   +--------------------------+---------------------+----------------------+---------------------+
   |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
   +--------------------------+---------------------+----------------------+---------------------+
   | c9qgo11pud7kb3cdomeg...  | 2020-08-10 12:00:00 | c9qgo11pud7kb3cdomeg | 2020-08-10 11:55:17 |
   | ...                                                                                         |
   +--------------------------+---------------------+----------------------+---------------------+
   ```

- API

   To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListBackups](../api-ref/grpc/cluster_service.md#ListBackups) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To get a list of backups for all the {{ mgp-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/List](../api-ref/grpc/backup_service.md#List) gRPC API call and provide the folder ID in the `folderId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs %}

- Management console

   To get information about the backup of an existing cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Click the name of the desired cluster and select ![image](../../_assets/mdb/backup.svg) **Backups**.

   To get information about the backup of a previously deleted cluster:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.

- API

   To get information about a backup, use the [get](../api-ref/Backup/get.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/Get](../api-ref/grpc/backup_service.md#Get) gRPC API call and provide the backup ID in the `backupId` request parameter.

   To find out the ID, [retrieve a list of backups](#list-backups).

{% endlist %}

## Restoring clusters from backups {#restore}

For a new cluster, you should set all the parameters that are required at creation.

{% list tabs %}

- Management console

   To restore an existing cluster from a backup:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Click the name of the desired cluster and select ![image](../../_assets/mdb/backup.svg) **Backups**.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) for the desired backup and click **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. Click **Create**.

   To restore a previously deleted cluster from a backup:
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/mdb/backup.svg) **Backups**.
   1. Find the desired backup using the backup creation time and cluster ID. The **Name** column contains the IDs in `<cluster ID>:<backup ID>` format.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) for the desired backup and click **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. Click **Create**.

   {{ mgp-name }} launches the operation to create a cluster from the backup.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To restore a cluster from a backup:

   1. View a description of the CLI restore {{ GP }} cluster command:

      ```bash
      {{ yc-mdb-gp }} cluster restore --help
      ```

   1. Request the creation of a cluster from a backup:

      
      ```bash
      {{ yc-mdb-gp }} cluster restore \
         --backup-id=<backup ID> \
         --name=<cluster name> \
         --environment=<environment: PRESTABLE or PRODUCTION> \
         --network-name={{ network-name }} \
         --master-resource-preset=<host class> \
         --master-disk-size=<storage size, GB> \
         --master-disk-type=<disk type> \
         --segment-resource-preset=<host class> \
         --segment-disk-size=<storage size, GB> \
         --segment-disk-type=<disk type> \
         --segment-host-count=<number of segment hosts> \
         --segment-in-host=<number of segments on host> \
         --zone-id=<availability zone> \
         --subnet-id=<subnet ID> \
         --assign-public-ip=<public access to the cluster: true or false>
      ```


      Where:

      * `--backup-id`: [Backup](../concepts/backup.md) ID.
      * `--name`: Cluster name.
      * `--environment`: Environment:

         * `PRESTABLE`: For testing, including the {{ GP }} service itself. The prestable environment is updated first with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
         * `PRODUCTION`: For stable versions of your apps.

      * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
      * `--master-resource-preset`: [Master host class](../concepts/instance-types.md#available-flavors).
      * `--master-disk-size`: Master host storage size in GB.
      * `--master-disk-type`: [Disk type](../concepts/storage.md) on the master hosts.
      * `--segment-resource-preset`: [Segment host class](../concepts/instance-types.md#available-flavors).
      * `--segment-disk-size`: Segment host storage size in GB.
      * `--segment-disk-type`: [Disk type](../concepts/storage.md) on the segment hosts.
      * `--segment-host-count`: Number of segment hosts.
      * `--segment-in-host`: Number of segments on host.
      * `--zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).

      
      * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). It must be specified if the selected availability zone includes two or more subnets.
      * `--assign-public-ip`: Flag that is specified if the cluster needs to be accessed from the internet.


- API

   To restore a cluster from a backup, use the [restore](../api-ref/Cluster/restore.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Restore](../api-ref/grpc/cluster_service.md#Restore) gRPC API call and provide the following in the request:

   * ID of the desired backup, in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
   * Name of the new cluster that will contain the data recovered from the backup, in the `name` parameter. It must be unique within the folder.

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
