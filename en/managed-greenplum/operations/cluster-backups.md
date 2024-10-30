# Managing backups in {{ mgp-name }}

You can view your existing [backups](../concepts/backup.md) and restore clusters from them.

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

    To get a list of cluster backups:
    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}** tab.

    To get a list of all backups in a folder:
    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of {{ GP }} cluster backups, run the command:

    ```bash
    {{ yc-mdb-gp }} cluster list-backups <cluster_name_or_ID>
    ```

    You can get the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

    Result:

    ```text
    +--------------------------+---------------------+----------------------+---------------------+
    |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
    +--------------------------+---------------------+----------------------+---------------------+
    | c9qgo11pud7k********:... | 2020-08-10 12:00:00 | c9qgo11pud7k******** | 2020-08-10 11:55:17 |
    | ...                                                                                         |
    +--------------------------+---------------------+----------------------+---------------------+
    ```

- API {#api}

    To get a list of cluster backups, use the [listBackups](../api-ref/Cluster/listBackups.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListBackups](../api-ref/grpc/Cluster/listBackups.md) gRPC API call and provide the cluster ID in the `clusterId` parameter of your request.

    To get a list of backups for all the {{ mgp-name }} clusters in the folder, use the [list](../api-ref/Backup/list.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/List](../api-ref/grpc/Backup/list.md) gRPC API call and provide the folder ID in the `folderId` parameter of your request.

    You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

    To get information about the backup of an existing cluster:
    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}** tab.

    To get information about the backup of a previously deleted cluster:
    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}**.

- API {#api}

    To get information about a backup, use the [get](../api-ref/Backup/get.md) REST API method for the [Backup](../api-ref/Backup/index.md) resource or the [BackupService/Get](../api-ref/grpc/Backup/get.md) gRPC API call and provide the backup ID in the `backupId` parameter of your request.

    To find out the ID, [retrieve a list of backups](#list-backups).

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}** tab.
    1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

    {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Restoring clusters from backups {#restore}

The Point-in-Time Recovery (PITR) technology enables you to restore cluster state to any recovery point created after saving a backup. For more information, see [Backups](../concepts/backup.md).

When you restore a cluster from a backup, you create a new cluster with the backup data. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup.

For a new cluster, you should set all the parameters that are required at creation.

To migrate {{ mgp-name }} cluster hosts to a different availability zone, restore your cluster from a backup. You may need to do this, for example, if your cluster hosts reside in the `{{ region-id }}-c` zone which is to be [deprecated](/blog/posts/2023/08/new-availability-zone). During cluster recovery from a backup, specify a new availability zone. If your cluster operates as a [{{ data-transfer-full-name }} endpoint](../../data-transfer/concepts/index.md#endpoint), familiarize yourself with the [migration process in {{ data-transfer-name }}](hosts/host-migration.md#data-transfer) before recovering from a backup.

{% note warning %}

Recovering from a backup imposes restrictions on parameters of the new cluster.

{% include [limits](../../_includes/mdb/mgp/restore-limits.md) %}

{% endnote %}

If you set the current time as the recovery time, the new cluster will match the state of the latest available recovery point.

{% list tabs group=instructions %}

- Management console {#console}

    To restore an existing cluster from a backup:

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
    1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
    1. In the **{{ ui-key.yacloud.mdb.forms.field_date }}** setting, specify the time point to which you want to restore the cluster. You can enter a value manually or select it from the drop-down calendar. The service will select the recovery point closest to that time.

       If you do not change the setting, the cluster state will be copied from a backup. Recovery points will not be used.

    1. If you want to restore only certain databases or tables, list them in the **{{ ui-key.yacloud.greenplum.field_restore-only }}** field. If you leave the field blank, the whole cluster will be restored.
    1. In the **{{ ui-key.yacloud.greenplum.field_hosts-count }}** setting, specify the number of segment hosts.
    1. In the **{{ ui-key.yacloud.greenplum.field_segments-in-host }}** setting, specify the number of [segments](../concepts/index.md) per host.
    1. Click **{{ ui-key.yacloud.common.create }}**.

    To restore a previously deleted cluster from a backup:
    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}**.
    1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs formatted as `<cluster_ID>:<backup_ID>`.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
    1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
    1. In the **{{ ui-key.yacloud.mdb.forms.field_date }}** setting, specify the time point to which you want to restore the cluster. You can enter a value manually or select it from the drop-down calendar. The service will select the recovery point closest to that time.

       If you do not change the setting, the cluster state will be copied from a backup. Recovery points will not be used.

    1. If you want to restore only certain databases or tables, list them in the **{{ ui-key.yacloud.greenplum.field_restore-only }}** field. If you leave the field blank, the whole cluster will be restored.
    1. In the **{{ ui-key.yacloud.greenplum.field_hosts-count }}** setting, specify the number of segment hosts.
    1. In the **{{ ui-key.yacloud.greenplum.field_segments-in-host }}** setting, specify the number of [segments](../concepts/index.md) per host.
    1. Click **{{ ui-key.yacloud.common.create }}**.

    {{ mgp-name }} will launch the operation to create a cluster from the backup.

- CLI {#cli}

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
           --backup-id=<backup_ID> \
           --time=<time_point> \
           --name=<cluster_name> \
           --environment=<environment> \
           --network-name={{ network-name }} \
           --master-resource-preset=<host_class> \
           --master-disk-size=<storage_size_in_GB> \
           --master-disk-type=<disk_type> \
           --segment-resource-preset=<host_class> \
           --segment-disk-size=<storage_size_in_GB> \
           --segment-disk-type=<disk_type> \
           --segment-host-count <number_of_segment_hosts> \
           --segment-in-host <number_of_segments_per_host> \
           --restore-only=<list_of_DBs_and_tables_to_restore> \
           --zone-id=<availability_zone> \
           --subnet-id=<subnet_ID> \
           --assign-public-ip=<public_access_to_cluster>
        ```


        Where:

        * `--backup-id`: [Backup](../concepts/backup.md) ID.
        * `--time`: Time point to restore the {{ GP }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` time format. By default, the cluster will be restored from a backup.
        * `--name`: Cluster name.
        * `--environment`: Environment:

            * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
            * `PRODUCTION`: For stable versions of your apps.

        * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
        * `--master-resource-preset`: [Master host class](../concepts/instance-types.md#available-flavors).
        * `--master-disk-size`: Size of master host storage in GB.
        * `--master-disk-type`: Master host [disk type](../concepts/storage.md).
        * `--segment-resource-preset`: [Segment host class](../concepts/instance-types.md#available-flavors).
        * `--segment-disk-size`: Size of segment host storage in GB.
        * `--segment-disk-type`: Segment host [disk type](../concepts/storage.md).
        * `--segment-host-count`: Number of segment hosts.
        * `--segment-in-host`: Number of [segments](../concepts/index.md) per host.
        * `--restore-only`: (Optional) Comma-separated list of DBs and tables to restore from the backup. Supported formats: `<DB>/<schema>/<table>`, `<DB>/<table>` and `<DB>`. You may use the `*` wildcard symbol as well. If you omit this parameter, the whole cluster will be restored.
        * `--zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).


        * `--subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
        * `--assign-public-ip`: Flag you set if the cluster needs access from the internet.


- API {#api}

    To restore a cluster from a backup, use the [restore](../api-ref/Cluster/restore.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Restore](../api-ref/grpc/Cluster/restore.md) gRPC API call and provide the following in the request:

    * Backup ID in the `backupId` parameter. To find out the ID, [retrieve a list of cluster backups](#list-backups).
    * Time point to which you want to restore the cluster, in the `time` parameter. By default, the cluster will be restored from a backup.
    * Number of segment hosts in the `segmentHostCount` parameter.
    * Number of [segments](../concepts/index.md) per host in the `segmentInHost` parameter.
    * Name of the new cluster that will contain the data recovered from the backup, in the `name` parameter. It must be unique within the folder.
    * (Optional) Comma-separated list of DBs and tables to restore from the backup, in the `restoreOnly` parameter. Supported formats: `<DB>/<schema>/<table>`, `<DB>/<table>` and `<DB>`. You may use the `*` wildcard symbol as well. If you omit this parameter, the whole cluster will be restored.

    By default, the cluster is restored to the same folder where the backup is stored. To restore the cluster to a different folder, specify its ID in the `folderId` parameter.

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
