---
title: Managing {{ VLK }} backups
description: You can create backups and restore clusters from existing {{ VLK }} backups. When you restore a cluster from a backup, you create a new cluster with the backup data. If your cloud does not have sufficient resources to create such a cluster, you will not be able to restore your data from the backup.
---

# Managing backups in {{ mrd-name }}


You can create [backups](../concepts/backup.md) and use the existing backups to restore clusters.

Additionally, {{ mrd-name }} creates automatic daily backups. You can [set the backup start time](#set-backup-window):

## Restoring a cluster from a backup {#restore}

When you restore a cluster from a backup, you create a new cluster with the backup data. If the folder lacks [resources](../concepts/limits.md) to create such a cluster, data will not be restored from the backup. The average backup recovery speed is 10 MBps.

If you chose the **local-ssd** disk type when restoring the cluster from a backup, add at least two hosts per shard.


Before you begin, [assign](../../iam/operations/roles/grant.md) to your {{ yandex-cloud }} account the [managed-redis.restorer](../../iam/roles-reference.md#managed-redis-restorer) role or higher for the backup folder and the new cluster folder.


{% list tabs group=instructions %}

- Management console {#console}

  To restore an existing cluster from a backup:

  1. In the [management console]({{ link-console-main }}), go to the folder to restore the cluster in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.redis.switch_backups }}** tab.
  1. In the line of the appropriate backup, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Configure the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  To restore a previously deleted cluster from a backup:

  1. In the [management console]({{ link-console-main }}), go to the folder to restore the cluster in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.redis.switch_backups }}**.
  1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs in `<cluster_ID>:<backup_ID>` format.
  1. In the line of the appropriate backup, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Configure the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mrd-name }} will initiate the process of creating a new cluster from the backup.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore a cluster from a backup:

  1. See the description of the CLI command for restoring a {{ VLK }} cluster:

      ```bash
      {{ yc-mdb-rd }} cluster restore --help
      ```

  1. Get the list of available {{ VLK }} cluster backups:

      ```bash
      {{ yc-mdb-rd }} backup list
      ```

      Result:

      ```text
      +--------------------------+---------------------+----------------------+---------------------+
      |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
      +--------------------------+---------------------+----------------------+---------------------+
      | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
      | ...                                                                                         |
      +--------------------------+---------------------+----------------------+---------------------+
      ```

  1. Send the following request [to create a cluster](cluster-create.md) from a backup:

      ```bash
      {{ yc-mdb-rd }} cluster restore \
         --backup-id c9q287aqv5rf********:20181113T133617 \
         --name mynewrd \
         --environment=PRODUCTION \
         --network-name default \
         --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr********,assign-public-ip=true,replica-priority=50 \
         --password P@ssWord \
         --disk-size 20
      ```

      This results in a new {{ VLK }} cluster with the following characteristics:

      * Name: `mynewrd`.
      * Environment: `PRODUCTION`.
      * Network: `default`.
      * Host class: `hm1.nano` (one host); subnet: `b0rcctk2rvtr********`; availability zone: `{{ region-id }}-a`; access: public; [replica priority](../concepts/replication.md#master-failover): `50`.
      * Password: `P@ssWord`.
      * Network SSD storage (`{{ disk-type-example }}`): 20 GB.

      {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Restore](../api-ref/Cluster/restore.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters:restore' \
            --data '{
                      "backupId": "<backup_ID>",
                      "name": "<cluster_name>",
                      "environment": "<environment>",
                      "configSpec": {
                        "redis": {
                          "password": "<user_password>"
                        }
                      },
                      "hostSpecs": [
                        {
                          "zoneId": "<availability_zone>",
                          "subnetId": "<subnet_ID>",
                          "replicaPriority": "<host_priority>",
                          "assignPublicIp": <public_access_to_cluster_host>
                        },
                        { <similar_settings_for_host_2> },
                        { ... },
                        { <similar_settings_for_host_N> }
                      ],
                      "networkId": "<network_ID>",
                      "tlsEnabled": <encrypted_TLS_connection_support>
                    }'
        ```

        Where:

        * `backupId`: Backup ID. To find out the ID, [get a list of folder backups](#list-backups).
        * `name`: Cluster name.
        * `environment`: Environment, `PRESTABLE` or `PRODUCTION`.
        * `configSpec.redis.password`: Password.
        * `hostSpecs`: Host settings:

             * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify it if the selected availability zone has two or more subnets.
            * `replicaPriority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
            * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`. You can enable public access only if the `tlsEnabled` parameter is set to `true`.

        * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) where the cluster will be deployed.

        * `tlsEnabled`: Support for encrypted TLS connections to the cluster, `true` or `false`.

            {% note warning %}

            You can only enable connection encryption when creating a new cluster. You cannot disable encryption for a cluster that it is enabled for.

            {% endnote %}

    1. Check the [server response](../api-ref/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [Cluster.Restore](../api-ref/grpc/Cluster/restore.md) call and send a request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "backup_id": "<backup_ID>",
                  "name": "<cluster_name>",
                  "environment": "<environment>",
                  "config_spec": {
                    "redis": {
                      "password": "<user_password>"
                    }
                  },
                  "host_specs": [
                    {
                      "zone_id": "<availability_zone>",
                      "subnet_id": "<subnet_ID>",
                      "replica_priority": "<host_priority>",
                      "assign_public_ip": <public_access_to_cluster_host>
                    },
                    { <similar_settings_for_host_2> },
                    { ... },
                    { <similar_settings_for_host_N> }
                  ],
                  "network_id": "<network_ID>",
                  "tls_enabled": <encrypted_TLS_connection_support>
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Restore
        ```

        Where:

        * `backup_id`: Backup ID. To find out the ID, [get a list of folder backups](#list-backups).
        * `name`: Cluster name.
        * `environment`: Environment, `PRESTABLE` or `PRODUCTION`.
        * `config_spec.redis.password`: Password.
        * `host_specs`: Host settings:

             * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify it if the selected availability zone has two or more subnets.
            * `replica_priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
            * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`. You can enable public access only if the `tlsEnabled` parameter is set to `true`.

        * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) where the cluster will be deployed.

        * `tls_enabled`: Support for encrypted TLS connections to the cluster, `true` or `false`.

            {% note warning %}

            You can only enable connection encryption when creating a new cluster. You cannot disable encryption for a cluster that it is enabled for.

            {% endnote %}

    1. Check the [server response](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder to create a backup in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.redis.switch_backups }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster backup:

  1. See the description of the CLI command for creating a {{ VLK }} backup:

      ```bash
      {{ yc-mdb-rd }} cluster backup --help
      ```

  1. Send a request to create a cluster backup, specifying the cluster name or ID:

      ```bash
      {{ yc-mdb-rd }} cluster backup my-rd-cluster
      ```

      You can get the cluster name and ID from the [list of clusters](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Backup](../api-ref/Cluster/backup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>:backup'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Backup
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

  To get the list of cluster backups:
  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.redis.switch_backups }}** tab.

  To get the list of all backups in the folder:
  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.redis.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get the list of {{ VLK }} cluster backups available in the default folder, run this command:

  ```bash
  {{ yc-mdb-rd }} backup list
  ```

  Result:

  ```text
  +--------------------------+---------------------+----------------------+---------------------+
  |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
  +--------------------------+---------------------+----------------------+---------------------+
  | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
  | c9qpm90p3pcg********:... | 2020-08-09 22:01:04 | c9qpm90p3pcg******** | 2020-08-09 21:30:00 |
  +--------------------------+---------------------+----------------------+---------------------+
  ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. To get a list of cluster backups:

        1. Call the [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/backups'
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        1. Check the [server response](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.redis.v1.ListClusterBackupsResponse) to make sure your request was successful.

    1. To get the list of backups for all clusters in the folder:

        1. Call the [Backup.List](../api-ref/Backup/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-redis/v1/backups' \
                --url-query folderId=<folder_ID>
            ```

            
            You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. Check the [server response](../api-ref/Backup/list.md#yandex.cloud.mdb.redis.v1.ListBackupsResponse) to make sure your request was successful.

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
                -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<cluster_ID>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.redis.v1.ClusterService.ListBackups
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        1. Check the [server response](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.redis.v1.ListClusterBackupsResponse) to make sure your request was successful.

    1. To get the list of backups for all clusters in the folder:

        1. Use the [BackupService.List](../api-ref/grpc/Backup/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/backup_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "folder_id": "<folder_ID>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.redis.v1.BackupService.List
            ```

            
            You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. Check the [server response](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.redis.v1.ListBackupsResponse) to make sure your request was successful.

{% endlist %}

## Getting backup info {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

  To get information about a backup of an existing cluster:
  1. In the [management console]({{ link-console-main }}), go to the folder with the cluster to get backup information for.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.redis.switch_backups }}** tab.

  To get information about a backup of a previously deleted cluster:
  1. In the [management console]({{ link-console-main }}), go to the folder the deleted cluster was in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.redis.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ VLK }} cluster backup, run this command:

  ```bash
  {{ yc-mdb-rd }} backup get <backup_ID>
  ```

  You can get the backup ID with the [list of backups](#list-backups).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Backup.Get](../api-ref/Backup/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/backups/<backup_ID>'
        ```

        You can request the backup ID together with the [list of backups](#list-backups).

    1. Check the [server response](../api-ref/Backup/get.md#yandex.cloud.mdb.redis.v1.Backup) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/backup_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "backup_id": "<backup_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.BackupService.Get
        ```

        You can request the backup ID together with the [list of backups](#list-backups).

    1. Check the [server response](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.redis.v1.Backup) to make sure your request was successful.

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs group=instructions %}

- Management console {#console}

  When [creating](cluster-create.md) or [updating](update.md#change-redis-config) a cluster, you can set the backup start time under **{{ ui-key.yacloud.mdb.forms.section_additional }}**.

- CLI {#cli}

  To set the backup start time, use the `--backup-window-start` flag. You must specify the time in `HH:MM:SS` format.

  ```bash
  {{ yc-mdb-rd }} cluster create \
    --name <cluster_name> \
    --environment <environment> \
    --network-name <network_name> \
    --host zone-id=<availability_zone>,subnet-id=<subnet_ID> \
    --backup-window-start 10:25:00
  ```

  Where `--environment` is the environment, either `prestable` or `production`.

  To change the backup start time for an existing cluster, use the `update` command:

  ```bash
  {{ yc-mdb-rd }} cluster update \
     --name <cluster_name> \
     --backup-window-start 11:25:00
  ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.backupWindowStart",
                      "configSpec": {
                        "backupWindowStart": {
                          "hours": "<hours>",
                          "minutes": "<minutes>",
                          "seconds": "<seconds>",
                          "nanos": "<nanoseconds>"
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated list of settings you want to update.

            Here, we provide only one setting.

        * `configSpec.backupWindowStart`: [Backup](../concepts/backup.md) window settings.

            Here, specify the backup start time:

            * `hours`: Between `0` and `23` hours.
            * `minutes`: Between `0` and `59` minutes.
            * `seconds`: Between `0` and `59` seconds.
            * `nanos`: Between `0` and `999999999` nanoseconds.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ "config_spec.backup_window_start" ]
                  },
                  "config_spec": {
                    "backup_window_start": {
                      "hours": "<hours>",
                      "minutes": "<minutes>",
                      "seconds": "<seconds>",
                      "nanos": "<nanoseconds>"
                    }
                  } 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

            Here, we provide only one setting.

        * `config_spec.backup_window_start`: [Backup](../concepts/backup.md) window settings.

            Here, specify the backup start time:

            * `hours`: Between `0` and `23` hours.
            * `minutes`: Between `0` and `59` minutes.
            * `seconds`: Between `0` and `59` seconds.
            * `nanos`: Between `0` and `999999999` nanoseconds.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
