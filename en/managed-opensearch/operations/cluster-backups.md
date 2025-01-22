---
title: Managing {{ OS }} backups (snapshots)
description: '{{ mos-name }} enables you to use the {{ OS }} snapshot mechanism to manage your data backups. To work with snapshots, use the {{ OS }} public API and a bucket in {{ objstorage-name }} to store them.'
keywords:
  - OpenSearch backups
  - OpenSearch snapshots
  - OpenSearch
---

# Managing backups in {{ mos-name }}

{{ mos-short-name }} enables you to create [index](../concepts/indexing.md) backups using both {{ yandex-cloud }} tools and the {{ OS }} snapshot mechanism. For more information about snapshots, see the [{{ OS }} documentation]({{ os.docs }}/opensearch/snapshots/snapshot-restore/).


## Creating backups with {{ yandex-cloud }} tools {#cloud-backups}

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{{ mos-name }} also creates automatic hourly backups.

### Getting a list of backups {#list-backups}

You can get a list of backups created for the past 14 days.

{% list tabs group=instructions %}

- Management console {#console}

    To get a list of cluster backups:

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Click the name of the cluster you need and select the ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.

    To get a list of all backups in a folder:

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Select ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of all backups in the folder, run this command:

    ```bash
    {{ yc-mdb-os }} backup list
    ```

    Result:

    ```text
    +----------------------+---------------------+-------------------+---------------------+
    |          ID          |      CREATED AT     | SOURCE CLUSTER ID |      STARTED AT     |
    +----------------------+---------------------+-------------------+---------------------+
    | c9qlk4v13uq7******** | 2024-01-09 14:38:34 | c9qpm4i********   | 2024-01-09 14:38:28 |
    | c9qpm90p3pcg******** | 2024-01-09 13:38:31 | c9qpm4i********   | 2024-01-09 13:38:28 |
    +----------------------+---------------------+-------------------+---------------------+
    ```

    If you want to limit the backup list displayed after running the command, include the `--limit <number_of_records>` flag in the command. For example, if the output of the `{{ yc-mdb-os }} backup list` command takes up several screens, run the `{{ yc-mdb-os }} backup list --limit 5` command. In this case, the output will contain the list of five most recent backups.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. To get a list of cluster backups:

        1. Use the [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/backups'
            ```

            You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

        1. View the [server response](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsResponse) to make sure the request was successful.

    1. To get a list of backups for all the clusters in a folder:

        1. Use the [Backup.List](../api-ref/Backup/list.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/backups' \
                --url-query folderId=<folder_ID>
            ```

            
            You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. View the [server response](../api-ref/Backup/list.md#yandex.cloud.mdb.opensearch.v1.ListBackupsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. To get a list of cluster backups:

        1. Use the [ClusterService.ListBackups](../api-ref/grpc/Cluster/listBackups.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<cluster_ID>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.ListBackups
            ```

            You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

        1. View the [server response](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsResponse) to make sure the request was successful.

    1. To get a list of backups for all the clusters in a folder:

        1. Use the [BackupService.List](../api-ref/grpc/Backup/list.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/backup_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "folder_id": "<folder_ID>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.BackupService.List
            ```

            
            You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. View the [server response](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.opensearch.v1.ListBackupsResponse) to make sure the request was successful.

{% endlist %}

### Getting information about backups {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

    To get information about the backup of an existing cluster:

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Click the name of the cluster you need and select the ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.

    To get information about the backup of a previously deleted cluster:

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Select ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get information about the backup of a cluster:

    1. Retrieve the backup ID with a list of all backups in the folder:

        ```bash
        {{ yc-mdb-os }} backup list
        ```

        You will see the ID in the `ID` column of the command output.

    1. Get information about the backup you need:

        ```bash
        {{ yc-mdb-os }} backup get <backup_ID>
        ```

        Command output example:

        ```text
        id: c9qlk4v13uq7********
        folder_id: {{ folder-id-example }}
        source_cluster_id: c9qpm4i********
        started_at: "2024-01-09T10:38:28.683Z"
        created_at: "2024-01-09T10:38:31.685Z"
        indices:
          - .mdb-sli
          - .opendistro_security
          - .kibana_1
          - .opendistro-job-scheduler-lock
          - .opensearch-observability
          - .opendistro-ism-config
        opensearch_version: 2.8.0
        indices_total: "6"
        ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Backup.Get](../api-ref/Backup/get.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/backups/<backup_ID>'
        ```

        You can get the backup ID together with a [list of backups](#list-backups).

    1. View the [server response](../api-ref/Backup/get.md#yandex.cloud.mdb.opensearch.v1.Backup) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [BackupService.Get](../api-ref/grpc/Backup/get.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/backup_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "backup_id": "<backup_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.opensearch.v1.BackupService.Get
        ```

        You can get the backup ID together with a [list of backups](#list-backups).

    1. View the [server response](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.opensearch.v1.Backup) to make sure the request was successful.

{% endlist %}

### Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}
  
    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Click the name of the cluster you need and select the ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.
    1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

    {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a backup of cluster data, run this command:

    ```bash
    {{ yc-mdb-os }} cluster backup <cluster_name_or_ID>
    ```

    You can request the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Backup](../api-ref/Cluster/backup.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>:backup'
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [ClusterService.Backup](../api-ref/grpc/Cluster/backup.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.opensearch.v1.ClusterService.Backup
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

### Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the backup data. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup.

When creating a new cluster, set all required parameters.


Before you begin, [make sure](../../iam/operations/roles/get-assigned-roles.md) your {{ yandex-cloud }} account has the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher. You will need this role if the cluster you want to restore is linked to a [service account](../../iam/concepts/users/service-accounts.md).


{% list tabs group=instructions %}

- Management console {#console}

    To restore an existing cluster from a backup:

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Click the name of the cluster you need and select the ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
    1. Set up the new cluster.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

    To restore a previously deleted cluster from a backup:

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Select ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}**.
    1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs formatted as `<cluster_ID>:<backup_IP>`.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
    1. Set up the new cluster.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

    {{ mos-name }} will launch the operation to create a cluster from the backup.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To restore a cluster from a backup:

    1. Retrieve the backup ID with a list of all backups in the folder:

        ```bash
        {{ yc-mdb-os }} backup list
        ```

        Result:

        ```text
        +----------------------+---------------------+-------------------+---------------------+
        |          ID          |      CREATED AT     | SOURCE CLUSTER ID |      STARTED AT     |
        +----------------------+---------------------+-------------------+---------------------+
        | c9qlk4v13uq7******** | 2024-01-09 14:38:34 | c9qpm4i********   | 2024-01-09 14:38:28 |
        | ...                                                                                  |
        +----------------------+---------------------+-------------------+---------------------+
        ```

        You will see the backup ID in the `ID` column. The `CREATED AT` column shows the backup completion time in `yyyy-mm-dd hh:mm:ss` format.

    1. Request creating a cluster from a backup:

        ```bash
        {{ yc-mdb-os }} cluster restore --backup-id <backup_ID>
        ```

        You can also run the command with the parameters you use when creating a cluster. For the description of such parameters, see [Creating a cluster](cluster-create.md).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and add the following contents to it:

        ```json
        {
            "backupId": "<backup_ID>",
            "folderId": "<folder_ID>",
            "name": "<cluster_name>",
            "environment": "<environment>",
            "networkId": "<network_ID>",
            "configSpec": {
                "version": "<{{ OS }}_version>",
                "adminPassword": "<admin_user_password>",
                "opensearchSpec": {
                    "nodeGroups": [
                        {
                            "name": "<{{ OS }}_host_group_name>",
                            "resources": {
                                "resourcePresetId": "<host_class>",
                                "diskSize": "<storage_size_in_bytes>",
                                "diskTypeId": "<disk_type>"
                            },
                            "roles": ["<role_1>","<role_2>"],
                            "hostsCount": "<number_of_hosts>",
                            "zoneIds": [
                                "<availability_zone_1>",
                                "<availability_zone_2>",
                                "<availability_zone_3>"
                            ],
                            "subnetIds": [
                                "<subnet_1_ID>",
                                "<subnet_2_ID>",
                                "<subnet_3_ID>"
                            ]
                        }
                    ]
                },
                "dashboardsSpec": {
                    "nodeGroups": [
                        {
                            "name": "<Dashboards_host_group_name>",
                            "resources": {
                                "resourcePresetId": "<host_class>",
                                "diskSize": "<storage_size_in_bytes>",
                                "diskTypeId": "<disk_type>"
                            },
                            "hostsCount": "<number_of_hosts>",
                            "zoneIds": [
                                "<availability_zone_1>",
                                "<availability_zone_2>",
                                "<availability_zone_3>"
                            ],
                            "subnetIds": [
                                "<subnet_1_ID>",
                                "<subnet_2_ID>",
                                "<subnet_3_ID>"
                            ]
                        }
                    ]
                }
            }
        }
        ```

        Where:

        * `backupId`: ID of the backup copy you are restoring the cluster from. You can get the ID together with a [list of backups](#list-backups).
        * `folderId`: Folder ID. You can request it with a [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
        * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be in.
        * `configSpec`: Cluster settings:

            * `version`: {{ OS }} version.
            * `adminPassword`: `admin` user password.
            * `opensearchSpec`: Settings for `{{ OS }}` host groups. Contain an array of `nodeGroups` elements. one for each host group. Each element has the following structure:

                * `name`: Host group name.
                * `resources`: Cluster resources:

                    * `resourcePresetId`: [Host class](../concepts/instance-types.md).
                    * `diskSize`: Disk size in bytes.
                    * `diskTypeId`: [Disk type](../concepts/storage.md).

                * `roles`: List of [host roles](../concepts/host-roles.md). A cluster must include at least one group of `DATA` hosts and one group of `MANAGER` hosts. This can be a single group with the two roles, or different groups with the roles.
                * `hostsCount`: Number of hosts in the group. It must have at least one `DATA` host and at least three `MANAGER` hosts.
                * `zoneIds`: List of availability zones the cluster hosts are located in.
                * `subnetIds`: List of subnet IDs.

            * `dashboardsSpec`: Settings for `Dashboards` host groups. Contains an array of `nodeGroups` elements, the array structure matches `opensearchSpec.nodeGroups` structure. The `roles` parameter is the only exception: `Dashboards` hosts can only have one role, `DASHBOARDS`, so you do not need to specify it directly.

    1. Use the [Cluster.Restore](../api-ref/Cluster/restore.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters:restore' \
            --data "@body.json"
        ```

    1. View the [server response](../api-ref/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Create a file named `body.json` and add the following contents to it:

        ```json
        {
            "backup_id": "<backup_ID>",
            "folder_id": "<folder_ID>",
            "name": "<cluster_name>",
            "environment": "<environment>",
            "network_id": "<network_ID>",
            "config_spec": {
                "version": "<{{ OS }}_version>",
                "admin_password": "<admin_user_password>",
                "opensearch_spec": {
                    "node_groups": [
                        {
                            "name": "<{{ OS }}_host_group_name>",
                            "resources": {
                                "resource_preset_id": "<host_class>",
                                "disk_size": "<storage_size_in_bytes>",
                                "disk_type_id": "<disk_type>"
                            },
                            "roles": ["<role_1>","<role_2>"],
                            "hosts_count": "<number_of_hosts>",
                            "zone_ids": [
                                "<availability_zone_1>",
                                "<availability_zone_2>",
                                "<availability_zone_3>"
                            ],
                            "subnet_ids": [
                                "<subnet_1_ID>",
                                "<subnet_2_ID>",
                                "<subnet_3_ID>"
                            ]
                        }
                    ]
                },
                "dashboards_spec": {
                    "node_groups": [
                        {
                            "name": "<Dashboards_host_group_name>",
                            "resources": {
                                "resource_preset_id": "<host_class>",
                                "disk_size": "<storage_size_in_bytes>",
                                "disk_type_id": "<disk_type>"
                            },
                            "hosts_count": "<number_of_hosts>",
                            "zone_ids": [
                                "<availability_zone_1>",
                                "<availability_zone_2>",
                                "<availability_zone_3>"
                            ],
                            "subnet_ids": [
                                "<subnet_1_ID>",
                                "<subnet_2_ID>",
                                "<subnet_3_ID>"
                            ]
                        }
                    ]
                }
            }
        }
        ```

        Where:

        * `backup_id`: ID of the backup copy you are restoring the cluster from. You can get the ID together with a [list of backups](#list-backups).
        * `folder_id`: Folder ID. You can request it with a [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
        * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be in.
        * `config_spec`: Cluster settings:

            * `version`: {{ OS }} version.
            * `admin_password`: `admin` user password.
            * `opensearch_spec`: Settings for `{{ OS }}` host groups. Contain an array of `nodeGroups` elements. one for each host group. Each element has the following structure:

                * `name`: Host group name.
                * `resources`: Cluster resources:

                    * `resource_preset_id`: [Host class](../concepts/instance-types.md).
                    * `disk_size`: Disk size in bytes.
                    * `disk_type_id`: [Disk type](../concepts/storage.md).

                * `roles`: List of [host roles](../concepts/host-roles.md). A cluster must include at least one group of `DATA` hosts and one group of `MANAGER` hosts. This can be a single group with the two roles, or different groups with the roles.
                * `hosts_count`: Number of hosts in the group. It must have at least one `DATA` host and at least three `MANAGER` hosts.
                * `zone_ids`: List of availability zones the cluster hosts are located in.
                * `subnet_ids`: List of subnet IDs.

            * `dashboards_spec`: Settings for `Dashboards` host groups. Contains an array of `node_groups` elements, the array structure matches `opensearch_spec.node_groups` structure. The `roles` parameter is the only exception: `Dashboards` hosts can only have one role, `DASHBOARDS`, so you do not need to specify it directly.

    1. Use the [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.opensearch.v1.ClusterService.Restore \
            < body.json
        ```

    1. View the [server response](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Backups using snapshots {#snapshot-backups}

To work with snapshots, use the [public API {{ OS }}]({{ os.docs }}/api-reference/index/) and a bucket in {{ objstorage-name }} to store them.

### Retrieving a snapshot list {#list-snapshots}

1. Find the repository containing snapshot backups in the {{ OS }} repository list:

    ```http
    GET https://admin:<password>@<ID_of_{{ OS }}_host_with_DATA_role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/_all
    ```

   If the required repository is not on the list, [connect it](s3-access.md).

1. Get a list of snapshots in the repository:

    ```http
    GET https://admin:<password>@<ID_of_{{ OS }}_host_with_DATA_role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository_name>/_all
    ```

   Each snapshot is a single backup.

### Creating a snapshot {#create-snapshot}

1. In the {{ OS }} repository list, find the repository where you want to create the snapshot:

    ```http
    GET https://admin:<password>@<ID_of_{{ OS }}_host_with_DATA_role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/_all
    ```

    If the required repository is not on the list, [connect it](s3-access.md).

1. [Create a snapshot]({{ os.docs }}/opensearch/snapshots/snapshot-restore/#take-snapshots) of the required data or cluster in the selected repository:

    ```http
    PUT https://admin:<password>@<ID_of_{{ OS }}_host_with_DATA_role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository_name>/<snapshot_name>
    ```

### Restoring a cluster from a snapshot {#restore-from-snapshot}

{% note warning %}

When restoring a cluster from a snapshot, the {{ OS }} version in the cluster must be equal to or higher than the {{ OS }} version where the snapshot was taken.

{% endnote %}

1. [Create a new {{ OS }} cluster](cluster-create.md) in the required configuration, but do not populate it with data.

    When creating a cluster, select:

    * The number and class of hosts as well as the size and type of storage based on snapshot size and performance requirements.

    * The {{ OS }} version used to make the snapshot or higher.

1. Close the open indexes using the [{{ OS }} API]({{ os.docs }}/api-reference/index-apis/close-index/):

    ```http
    POST: https://admin:<password>@<ID_of_{{ OS }}_host_with_DATA_role>.{{ dns-zone }}:{{ port-mos }}/<index_name>/_close
    ```

    To restore an entire cluster, close all open indexes. To restore individual indexes, close only those indexes.

1. [Retrieve a list of backups](#list-snapshots) and find the required snapshot.
1. [Start restoring]({{ os.docs }}/opensearch/snapshots/snapshot-restore/#restore-snapshots) an entire cluster or individual data indexes and streams from the required snapshot.
