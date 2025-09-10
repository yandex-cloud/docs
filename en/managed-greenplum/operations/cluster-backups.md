# Managing backups in {{ mgp-name }}

You can view your existing [backups](../concepts/backup.md) and restore clusters from them.

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

    To get a list of cluster backups:
    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}** tab.

    To get a list of all backups in a folder:
    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of {{ GP }} cluster backups, run the command:

    ```bash
    {{ yc-mdb-gp }} cluster list-backups <cluster_name_or_ID>
    ```

    You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

    Result:

    ```text
    +--------------------------+---------------------+----------------------+---------------------+
    |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
    +--------------------------+---------------------+----------------------+---------------------+
    | c9qgo11pud7k********:... | 2020-08-10 12:00:00 | c9qgo11pud7k******** | 2020-08-10 11:55:17 |
    | ...                                                                                         |
    +--------------------------+---------------------+----------------------+---------------------+
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. To get a list of cluster backups:

        1. Use the [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>/backups'
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        1. View the [server response](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsResponse) to make sure your request was successful.

    1. To get a list of backups for all the clusters in a folder:

        1. Use the [Backup.List](../api-ref/Backup/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/backups' \
                --url-query folderId=<folder_ID>
            ```

            
            You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. View the [server response](../api-ref/Backup/list.md#yandex.cloud.mdb.greenplum.v1.ListBackupsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. To get a list of cluster backups:

        1. Use the [ClusterService.ListBackups](../api-ref/grpc/Cluster/listBackups.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<cluster_ID>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.greenplum.v1.ClusterService.ListBackups
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        1. View the [server response](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.greenplum.v1.ListClusterBackupsResponse) to make sure your request was successful.

    1. To get a list of backups for all the clusters in a folder:

        1. Use the [BackupService.List](../api-ref/grpc/Backup/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/backup_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "folder_id": "<folder_ID>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.greenplum.v1.BackupService.List
            ```

            
            You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. View the [server response](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.greenplum.v1.ListBackupsResponse) to make sure your request was successful.

{% endlist %}

## Getting backup info {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

    To get information about a backup of an existing cluster:
    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}** tab.

    To get information about a backup of a previously deleted cluster:
    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}**.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Backup.Get](../api-ref/Backup/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/backups/<backup_ID>'
        ```

        You can request the backup ID with the [list of backups](#list-backups).

    1. View the [server response](../api-ref/Backup/get.md#yandex.cloud.mdb.greenplum.v1.Backup) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [BackupService.Get](../api-ref/grpc/Backup/get.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/backup_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "backup_id": "<backup_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.BackupService.Get
        ```

        You can request the backup ID with the [list of backups](#list-backups).

    1. View the [server response](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.greenplum.v1.Backup) to make sure your request was successful.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}** tab.
    1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

    {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Backup](../api-ref/Cluster/backup.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>:backup'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Backup](../api-ref/grpc/Cluster/backup.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Backup
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Restoring a cluster from a backup {#restore}


The Point-in-Time Recovery (PITR) technology enables you to restore cluster state to any recovery point created after saving a backup. For more information, see [Backups](../concepts/backup.md).

When you restore a cluster from a backup, you create a new cluster with the backup data. If the folder lacks [resources](../concepts/limits.md) to create such a cluster, data will not be restored from the backup.

For a new cluster, you should set all the parameters that are required at creation.

To migrate {{ mgp-name }} cluster hosts to a different availability zone, restore your cluster from a backup. During cluster recovery from a backup, specify a new availability zone. If your cluster operates as a [{{ data-transfer-full-name }} endpoint](../../data-transfer/concepts/index.md#endpoint), after recovering it from a backup, create the [endpoint](../../data-transfer/operations/endpoint/index.md#create) and the [transfer](../../data-transfer/operations/transfer.md#create) again.

{% note warning %}

Recovering from a backup imposes restrictions on parameters of the new cluster.

{% include [limits](../../_includes/mdb/mgp/restore-limits.md) %}

{% endnote %}

If you set the current time as the recovery time, the new cluster will match the state of the latest available recovery point.


Before you begin, [assign](../../iam/operations/roles/grant.md) the [{{ roles.mgp.editor }}](../../iam/roles-reference.md#managed-greenplum-editor) role or higher to your {{ yandex-cloud }} account for the backup folder and the new cluster folder.


{% list tabs group=instructions %}

- Management console {#console}

    To restore an existing cluster from a backup:

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
    1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
    1. In the **{{ ui-key.yacloud.mdb.forms.field_date }}** setting, specify the time point to which you want to restore the cluster. You can enter a value manually or select it from the drop-down calendar. The service will select the recovery point closest to that time.

       If you do not change the setting, the cluster state will be copied from a backup. Recovery points will not be used.

    1. If you want to restore only certain databases or tables, list them in the **{{ ui-key.yacloud.greenplum.field_restore-only }}** field. If you leave the field blank, the whole cluster will be restored.
    1. In the **{{ ui-key.yacloud.greenplum.field_hosts-count }}** setting, specify the number of segment hosts.
    1. In the **{{ ui-key.yacloud.greenplum.field_segments-in-host }}** setting, specify the number of [segments](../concepts/index.md) per host.

        {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

    
    1. Optionally, select groups of [dedicated hosts](../../compute/concepts/dedicated-host.md) to place master hosts or segment hosts on the dedicated hosts. You can assign groups to one or both of the two types of {{ GP }} hosts.

        You must first [create](../../compute/operations/dedicated-host/create-host-group.md) a group of dedicated hosts in {{ compute-full-name }}.

        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}


    1. Click **{{ ui-key.yacloud.common.create }}**.

    To restore a previously deleted cluster from a backup:
    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.switch_backups }}**.
    1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs in `<cluster_ID>:<backup_ID>` format.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
    1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
    1. In the **{{ ui-key.yacloud.mdb.forms.field_date }}** setting, specify the time point to which you want to restore the cluster. You can enter a value manually or select it from the drop-down calendar. The service will select the recovery point closest to that time.

       If you do not change the setting, the cluster state will be copied from a backup. Recovery points will not be used.

    1. If you want to restore only certain databases or tables, list them in the **{{ ui-key.yacloud.greenplum.field_restore-only }}** field. If you leave the field blank, the whole cluster will be restored.
    1. In the **{{ ui-key.yacloud.greenplum.field_hosts-count }}** setting, specify the number of segment hosts.
    1. In the **{{ ui-key.yacloud.greenplum.field_segments-in-host }}** setting, specify the number of [segments](../concepts/index.md) per host.

        {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

    
    1. Optionally, select groups of [dedicated hosts](../../compute/concepts/dedicated-host.md) to place master hosts or segment hosts on the dedicated hosts. You can assign groups to one or both of the two types of {{ GP }} hosts.

        You must first [create](../../compute/operations/dedicated-host/create-host-group.md) a group of dedicated hosts in {{ compute-full-name }}.

        {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}


    1. Click **{{ ui-key.yacloud.common.create }}**.

    {{ mgp-name }} will launch the operation to create a cluster from the backup.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To restore a cluster from a backup:

    1. View the description of the CLI command to restore a {{ GP }} cluster:

        ```bash
        {{ yc-mdb-gp }} cluster restore --help
        ```

    1. Make a request to create a cluster from a backup:

        
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
           --assign-public-ip=<enable_public_access_to_cluster> \
           --master-host-group-ids=<IDs_of_dedicated_host_groups_for_master_hosts> \
           --segment-host-group-ids=<IDs_of_dedicated_host_groups_for_segment_hosts> \
           --service-account <service_account_ID>
        ```


        Where:

        * `--backup-id`: [Backup](../concepts/backup.md) ID.
        * `--time`: Time point to restore the {{ GP }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` time format. By default, the cluster will be restored from a backup.
        * `--name`: Cluster name.
        * `--environment`: Environment:

            * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test the new versions for compatibility with your application.
            * `PRODUCTION`: For stable versions of your apps.

        * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
        * `--master-resource-preset`: [Master host class](../concepts/instance-types.md#available-flavors).
        * `--master-disk-size`: Size of master host storage in GB.
        * `--master-disk-type`: Master host [disk type](../concepts/storage.md).
        * `--segment-resource-preset`: [Segment host class](../concepts/instance-types.md#available-flavors).

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * `--segment-disk-size`: Size of segment host storage in GB.
        * `--segment-disk-type`: Segment host [disk type](../concepts/storage.md).
        * `--segment-host-count`: Number of segment hosts.
        * `--segment-in-host`: Number of [segments](../concepts/index.md) per host.
        * `--restore-only`: (Optional) Comma-separated list of DBs and tables to restore from the backup. Supported formats: `<DB>/<schema>/<table>`, `<DB>/<table>`, and `<DB>`. You may use the `*` wildcard symbol as well. If you omit this parameter, the whole cluster will be restored.
        * `--zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).

        
        * `--master-host-group-ids` and `--segment-host-group-ids`: IDs of [dedicated host](../../compute/concepts/dedicated-host.md) groups for master and segment hosts. This is an optional parameter.

            You must first [create](../../compute/operations/dedicated-host/create-host-group.md) a group of dedicated hosts in {{ compute-full-name }}.

            {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

        * `--subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify it if the selected availability zone has two or more subnets.
        * `--assign-public-ip`: Flag you set if the cluster needs access from the internet.
        * `--service-account`: Service account ID.


- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        
        ```json
        {
          "backupId": "<backup_ID>",
          "time": "<time>",
          "folderId": "<folder_ID>",
          "name": "<cluster_name>",
          "environment": "<environment>",
          "networkId": "<network_ID>",
          "config": {
            "zoneId": "<availability_zone>",
            "subnetId": "<subnet_ID>",
            "assignPublicIp": "<allow_public_access_to_cluster_hosts>"
          },
          "masterResources": {
            "resourcePresetId": "<host_class>",
            "diskSize": "<storage_size_in_bytes>",
            "diskTypeId": "<disk_type>"
          },
          "segmentResources": {
            "resourcePresetId": "<host_class>",
            "diskSize": "<storage_size_in_bytes>",
            "diskTypeId": "<disk_type>"
          },
          "segmentHostCount": "<number_of_segment_hosts>",
          "segmentInHost": "<number_of_segments_per_host>",
          "restoreOnly": [
            "<DB_and_table_1>",
            "<DB_and_table_2>",
            ...
            "<DB_and_table_N>"
          ],
          "masterHostGroupIds": [
            "string"
          ],
          "segmentHostGroupIds": [
            "string"
          ],
          "serviceAccountId": "<service_account_ID>",
          "logging": {
            "enabled": "<enable_transferring_logs>",
            "commandCenterEnabled": "<transfer_Yandex_Command_Center_logs>",
            "greenplumEnabled": "<transfer_{{ GP }}_logs>",
            "poolerEnabled": "<transfer_connection_pooler_logs>",
            "folderId": "<folder_ID>"
          }
        }
        ```


        Where:

        * `backupId`: [Backup](../concepts/backup.md) ID. You can request it with the [list of backups](#list-backups).
        * `time`: Time point to restore the {{ GP }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` time format. By default, the cluster will be restored from a backup.
        * `folderId`: ID of the folder you want to restore the cluster to. You can request the ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md). By default, the cluster is restored to the same folder the backup is in.
        * `name`: Name of the new cluster.
        * `environment`: Environment:

            * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test the new versions for compatibility with your application.
            * `PRODUCTION`: For stable versions of your apps.

        * `networkId`: [Network](../../vpc/concepts/network.md#network) ID.
        * `config`: Cluster settings:

            * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnetId`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
            * `assignPublicIp`: Public access to cluster hosts, `true` or `false`.

        * `masterResources`, `segmentResources`: Master and segment host configuration in the cluster:

            * `resourcePresetId`: [Host class](../concepts/instance-types.md).
            * `diskSize`: Disk size in bytes.
            * `diskTypeId`: [Disk type](../concepts/storage.md).

        * `segmentHostCount`: Number of segment hosts, from `2` to `32`.
        * `segmentInHost`: [Number of segments per host](../concepts/index.md). The maximum value of this parameter depends on the host class.

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * `restoreOnly`: (Optional) List of DBs and tables to restore from the backup. Supported formats: `<DB>/<schema>/<table>`, `<DB>/<table>`, and `<DB>`. You may use the `*` wildcard symbol as well. If you omit this parameter, the whole cluster will be restored.

        
        * `masterHostGroupIds` and `segmentHostGroupIds`: IDs of [dedicated host](../../compute/concepts/dedicated-host.md) groups for master and segment hosts. This is an optional parameter.

            You must first [create](../../compute/operations/dedicated-host/create-host-group.md) a group of dedicated hosts in {{ compute-full-name }}.

            {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

        * `serviceAccountId`: Service account ID.
        * `logging`: Settings for [transferring logs to {{ cloud-logging-full-name }}](mgp-to-cloud-logging.md):

            * `enabled`: Enables log transfer, `true` or `false`.
            * `commandCenterEnabled`: Transferring [Command Center](../concepts/command-center.md) logs, `true` or `false`.
            * `greenplumEnabled`: Transferring {{ GP }} logs, `true` or `false`.
            * `poolerEnabled`: Transferring [connection pooler](../concepts/pooling.md) logs, `true` or `false`.
            * `folderId`: Specify the ID of the folder whose log group you want to use.
            * `logGroupId`: ID of the log group to write logs to.

                Specify either `folderId` or `logGroupId`.


    1. Use the [Cluster.Restore](../api-ref/Cluster/restore.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters:restore' \
            --data "@body.json"
        ```

    1. View the [server response](../api-ref/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        
        ```json
        {
          "backup_id": "<backup_ID>",
          "time": "<time>",
          "folder_id": "<folder_ID>",
          "name": "<cluster_name>",
          "environment": "<environment>",
          "network_id": "<network_ID>",
          "config": {
            "zone_id": "<availability_zone>",
            "subnet_id": "<subnet_ID>",
            "assign_public_ip": "<allow_public_access_to_cluster_hosts>"
          },
          "master_resources": {
            "resource_preset_id": "<host_class>",
            "disk_size": "<storage_size_in_bytes>",
            "disk_type_id": "<disk_type>"
          },
          "segment_resources": {
            "resource_preset_id": "<host_class>",
            "disk_size": "<storage_size_in_bytes>",
            "disk_type_id": "<disk_type>"
          },
          "segment_host_count": "<number_of_segment_hosts>",
          "segment_in_host": "<number_of_segments_per_host>",
          "restore_only": [
            "<DB_and_table_1>",
            "<DB_and_table_2>",
            ...
            "<DB_and_table_N>"
          ],
          "master_host_group_ids": [
            "string"
          ],
          "segment_host_group_ids": [
            "string"
          ],
          "service_account_id": "<service_account_ID>"
        }
        ```


        Where:

        * `backup_id`: [Backup](../concepts/backup.md) ID. You can request it with the [list of backups](#list-backups).
        * `time`: Time point to restore the {{ GP }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` time format. By default, the cluster will be restored from a backup.
        * `folder_id`: ID of the folder you want to restore the cluster to. You can request the ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md). By default, the cluster is restored to the same folder the backup is in.
        * `name`: Name of the new cluster.
        * `environment`: Environment:

            * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test the new versions for compatibility with your application.
            * `PRODUCTION`: For stable versions of your apps.

        * `network_id`: [Network](../../vpc/concepts/network.md#network) ID.
        * `config`: Cluster settings:

            * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnet_id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
            * `assign_public_ip`: Public access to cluster hosts, `true` or `false`.

        * `master_resources`, `segment_resources`: Master and segment host configuration in the cluster:

            * `resource_preset_id`: [Host class](../concepts/instance-types.md).
            * `disk_size`: Disk size in bytes.
            * `disk_type_id`: [Disk type](../concepts/storage.md).

        * `segment_host_count`: Number of segment hosts, from `2` to `32`.
        * `segment_in_host`: [Number of segments per host](../concepts/index.md). The maximum value of this parameter depends on the host class.

            {% include [max-ram-each-process](../../_includes/mdb/mgp/max-ram-each-process.md) %}

        * `restore_only`: (Optional) List of DBs and tables to restore from the backup. Supported formats: `<DB>/<schema>/<table>`, `<DB>/<table>`, and `<DB>`. You may use the `*` wildcard symbol as well. If you omit this parameter, the whole cluster will be restored.

        
        * `master_host_group_ids` and `segment_host_group_ids`: IDs of [dedicated host](../../compute/concepts/dedicated-host.md) groups for master and segment hosts. This is an optional parameter.

            You must first [create](../../compute/operations/dedicated-host/create-host-group.md) a group of dedicated hosts in {{ compute-full-name }}.

            {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

        * `service_account_id`: Service account ID.



    1. Use the [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Restore \
            < body.json
        ```

    1. View the [server response](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
