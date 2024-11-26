---
title: Managing Elasticsearch backups (snapshots)
description: Elasticsearch enables you to use the Elasticsearch snapshot mechanism to manage your data backups. To work with snapshots, use the Elasticsearch public API and a bucket in {{ objstorage-name }} to store them.
keywords:
  - Elasticsearch backups
  - Elasticsearch snapshots
  - Elasticsearch
---

# Managing backups in {{ mes-name }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}


{{ mes-short-name }} enables you to create [index](../concepts/indexing.md) backups using both {{ yandex-cloud }} tools and the {{ ES }} snapshot mechanism. For more information about snapshots, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html).

## Creating backups with {{ yandex-cloud }} tools {#cloud-backups}


You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{{ mes-name }} also creates automatic hourly backups.


### Getting a list of backups {#list-backups}


{% list tabs group=instructions %}

- Management console {#console}

  To get a list of cluster backups:
  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.

  To get a list of all backups in a folder:
  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Select the **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of {{ ES }} cluster backups available in the default folder, run the command:

    ```bash
    {{ yc-mdb-es }} backup list
    ```

    Result:

    ```text
    +----------------------+----------------------+----------------------+----------------------+
    |          ID          |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
    +----------------------+----------------------+----------------------+----------------------+
    | c9qlk4v13uq7******** | 2020-08-10T12:00:00Z | c9qlk4v13uq7******** | 2020-08-10T11:55:17Z |
    | c9qpm90p3pcg******** | 2020-08-09T22:01:04Z | c9qpm90p3pcg******** | 2020-08-09T21:30:00Z |
    +----------------------+----------------------+----------------------+----------------------+
    ```

- API {#api}

    To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListBackups](../api-ref/grpc/Cluster/listBackups.md) gRPC API call and provide the cluster ID in the `clusterId` parameter of your request.

    To get a list of backups for all the {{ mes-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/List](../api-ref/grpc/Backup/list.md) gRPC API call and provide the folder ID in the `folderId` parameter of your request.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}


### Getting information about backups {#get-backup}


{% list tabs group=instructions %}

- Management console {#console}

  To get information about the backup of an existing cluster:
  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.

  To get information about the backup of a previously deleted cluster:
  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Select the **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get information about a {{ ES }} cluster backup, run the command:

    ```bash
    {{ yc-mdb-es }} backup get <backup_ID>
    ```

    You can retrieve the backup ID with a [list of backups](#list-backups).

- API {#api}

    To get information about a backup, use the [get](../api-ref/Backup/get.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/Get](../api-ref/grpc/Backup/get.md) gRPC API call and provide the backup ID in the `backupId` parameter of your request.

    To find out the ID, [retrieve a list of backups](#list-backups).

{% endlist %}


### Creating a backup {#create-backup}


{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a cluster backup:

    1. View a description of the CLI create {{ ES }} backup command:

        ```bash
        {{ yc-mdb-es }} cluster backup --help
        ```

    1. Request a backup to be created by specifying the cluster name or ID:

        ```bash
        {{ yc-mdb-es }} cluster backup <cluster_name_or_ID>
        ```

        You can get the cluster ID and name with a [list of clusters](cluster-list.md#list-clusters).

- API {#api}

    To create a backup, use the [backup](../api-ref/Cluster/backup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Backup](../api-ref/grpc/Cluster/backup.md) gRPC API call and provide the cluster ID in the `clusterId` parameter of your request.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}


### Restoring clusters from backups {#restore}


When you restore a cluster from a backup, you create a new cluster with the backup data. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. You can manage the restore speed using [{{ ES }} tools](https://www.elastic.co/guide/en/elasticsearch/reference/current/recovery.html).

When creating a new cluster, set all required parameters.

{% list tabs group=instructions %}

- Management console {#console}

  To restore an existing cluster from a backup:
  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need, then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.common.folder }}** list.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  To restore a previously deleted cluster from a backup:
  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Select the **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.
  1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.name }}** column contains IDs formatted as `<cluster_ID>:<backup_ID>`.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need, then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.common.folder }}** list.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mes-name }} will launch the operation to create a cluster from the backup.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To restore a cluster from a backup:

    1. View a description of the CLI restore {{ ES }} cluster command:

        ```bash
        {{ yc-mdb-es }} cluster restore --help
        ```

    1. Getting a list of available {{ ES }} cluster backups:

        ```bash
        {{ yc-mdb-es }} backup list
        ```

        Result:

        ```text
        +--------------------------+----------------------+----------------------+----------------------+
        |            ID            |      CREATED AT      |  SOURCE CLUSTER ID   |      STARTED AT      |
        +--------------------------+----------------------+----------------------+----------------------+
        | c9qlk4v13uq79r9********  | 2020-08-10T12:00:00Z | c9qlk4v13uq7******** | 2020-08-10T11:55:17Z |
        | ...                                                                                           |
        +--------------------------+----------------------+----------------------+----------------------+
        ```

        The backup completion time is shown in the `CREATED AT` column of the list of available backups, in `yyyy-mm-ddThh:mm:ssZ` format (`2020-08-10T12:00:00Z` in the example above).

    1. Request the creation of a cluster from a backup:


        ```bash
        {{ yc-mdb-es }} cluster restore \
           --backup-id=<backup_ID> \
           --name=<cluster_name> \
           --environment=<environment> \
           --network-name=<network_name> \
           --host zone-id=<availability_zone>,`
                 `subnet-id=<subnet_ID>,`
                 `assign-public-ip=<public_access>,`
                 `type=<host_role> \
           --datanode-resource-preset=<Data_node_host_class> \
           --datanode-disk-size=<Data_node_storage_size_in_GB> \
           --datanode-disk-type=<Data_node_disk_type> \
           --masternode-resource-preset=<Master_node_host_class> \
           --masternode-disk-size=<Master_node_storage_size_in_GB> \
           --masternode-disk-type=<Master_node_disk_type> \
           --admin-password=<admin_user_password>
        ```


        Where:

        * `--backup-id`: [Backup](../concepts/backup.md) ID.
        * `--name`: Cluster name.
        * `--environment`: Environment:

            * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
            * `PRODUCTION`: For stable versions of your apps.

        * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
        * `--host`: Host parameters:

            * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).


            * `subnet-name`: [Subnet](../../vpc/concepts/network.md#subnet) name. Specify if two or more subnets are created in the selected availability zone.
            * `assign-public-ip`: Flag indicating that the host requires [public access](../concepts/network.md#public-access-to-a-host), `true` or `false`.


            * `type`: [Host role](../concepts/hosts-roles.md): `datanode` or `masternode`.

        * `--datanode-resource-preset`: [Class of hosts](../concepts/instance-types.md#available-flavors) with the Data node role.
        * `--datanode-disk-size`: Storage size in GB for hosts with the Data node role.
        * `--datanode-disk-type`: [Disk type](../concepts/storage.md) for hosts with the Data node role:


            * `network-hdd`
            * `network-ssd`
            * `local-ssd`
            * `network-ssd-nonreplicated`


        * `--masternode-resource-preset`: [Class of hosts](../concepts/instance-types.md#available-flavors) with the Master node role.
        * `--masternode-disk-size`: Storage size in GB for hosts with the Master node role.
        * `--masternode-disk-type`: [Disk type](../concepts/storage.md) for hosts with the Master node role. Only `network-ssd` is available.

        * `--admin-password`: `admin` user password.

            {% include [mes-superuser](../../_includes/mdb/mes-superuser.md) %}


- API {#api}

    To restore a cluster from a backup, use the [restore](../api-ref/Cluster/restore.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Restore](../api-ref/grpc/Cluster/restore.md) gRPC API call and provide the following in the request:

    * ID of the backup you need, in the `backupId` parameter. To find out the ID, [get a list of cluster backups](#list-backups).
    * Name of the new cluster that will contain the data recovered from the backup, in the `name` parameter. It must be unique within the folder.
    * Cluster environment in the `environment` parameter.
    * Cluster configuration in the `configSpec` parameter.
    * Configuration of the cluster hosts in one or more `hostSpecs` parameters.
    * Network ID in the `networkId` parameter.

{% endlist %}



## Backups using snapshots {#snapshot-backups}

To work with snapshots, use the [{{ ES }} public API](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore-apis.html) and a bucket in {{ objstorage-name }} to store them.

### Retrieving a snapshot list {#list-snapshots}

1. Find the repository containing snapshot backups in the {{ ES }} repository list:

    ```http
    GET https://admin:<password>@<host_FQDN>:9200/_snapshot/_all
    ```

    If the repository you need is not on the list, [connect it](./s3-access.md).

1. Get a list of snapshots in the repository:

    ```http
    GET https://admin:<password>@<host_FQDN>:9200/_snapshot/<repository>/_all
    ```

    Each snapshot is a single backup.


### Creating a snapshot {#create-snapshot}

1. In the {{ ES }} repository list, find the repository where you want to create the snapshot:

    ```http
    GET https://admin:<password>@<host_FQDN>:9200/_snapshot/_all
    ```

    If the repository you need is not on the list, [connect it](./s3-access.md).

1. [Create a snapshot](https://www.elastic.co/guide/en/elasticsearch/reference/current/create-snapshot-api.html) of the required data or cluster in the selected repository:

    ```http
    PUT https://admin:<password>@<host_FQDN>:9200/_snapshot/<repository>/<snapshot>
    ```

### Restoring a cluster from a snapshot {#restore-from-snapshot}

{% note warning %}

When restoring from snapshots, the following restrictions apply:

* The {{ ES }} version in the cluster must be equal to or higher than the {{ ES }} version where the snapshot was taken.
* To restore the indexes, be sure that the major {{ ES }} version in the cluster is no more than one unit higher than the major {{ ES }} version where the snapshot was taken. For example, you can use version 6.0 (but not 7.0) to recover indexes created in version 5.0.

{% endnote %}

1. [Create a new {{ ES }} cluster](./cluster-create.md) in the required configuration, but do not populate it with data.

    When creating a cluster, select:

    * The number and class of hosts as well as the storage size and disk type based on snapshot size and performance requirements. If necessary, [upgrade your host class](./cluster-update.md#change-resource-preset) or [increase cluster storage size](./cluster-update.md#change-disk-size).

    * The {{ ES }} version used to make the snapshot or higher.

1. Close the open indexes using the [{{ ES }} API](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-close.html):

    ```http
    POST: https://admin:<password>@<host_FQDN>:9200/<index>/_close
    ```

    To restore an entire cluster, close all open indexes. To restore individual indexes, close only those indexes.

1. [Retrieve a list of backups](#list-snapshots) and find the required snapshot.
1. [Start restoring](https://www.elastic.co/guide/en/elasticsearch/reference/current/restore-snapshot-api.html) an entire cluster or individual data indexes and streams from the required snapshot.

For more information about restoring from snapshots, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html).

