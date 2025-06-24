---
title: Managing {{ CH }} backups
description: You can create backups and restore clusters from existing {{ CH }} backups. When you restore a cluster from a backup, you create a new cluster with the backup data. If the cloud does not have sufficient resources to create such a cluster, you will not be able to restore your data from a backup.
---

# Managing backups in {{ mch-name }}


You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{{ mch-name }} also creates automatic daily backups. You can [set the backup start time](#set-backup-window) and [retention period](#set-backup-retain).

## Creating a backup {#create-backup}

{% note warning %}

Backups are created based on a random replica host. If there is no cluster host data consistency, restoring clusters from backups does not guarantee complete data recovery. For more information, see [Backups](../concepts/backup.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. Navigate to the [catalog dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To create a cluster backup:
  
  1. View a description of the CLI create {{ CH }} backup command:
  
      ```bash
      {{ yc-mdb-ch }} cluster backup --help
      ```
  
  1. Request the creation of a backup specifying the cluster name or ID:
  
      ```bash
      {{ yc-mdb-ch }} cluster backup <cluster_name_or_ID>
      ```
  
      You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Backup](../api-ref/Cluster/backup.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>:backup'
        ```

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/backup.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Backup](../api-ref/grpc/Cluster/backup.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Backup
        ```

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the backup data. If the cloud does not have sufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore your data from a backup. The average backup recovery speed is 10 MBps per database core.

You can recover either a single [shard](../concepts/sharding.md) or the whole cluster. Recovering a single shard from a multi-shard backup can only be done from the console.


Before you begin, [assign](../../iam/operations/roles/grant.md) the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher to your {{ yandex-cloud }} account. You will need this role if the cluster you want to restore is linked to a [service account](../../iam/concepts/users/service-accounts.md).


{% include [mch-mergetree-conversion](../../_includes/mdb/mch-restore-tables-conversion-alert.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To restore an existing cluster from a backup:
  1. Navigate to the [catalog dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Change the settings of the new cluster if required. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.

      To restore a single shard, only that particular shard should be left checked under **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}**. Uncheck the rest of the shards.

      To restore the whole cluster, leave all shards checked under **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}**.

      You can set up a configuration of its own for each shard you restore.

  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  To restore a previously deleted cluster from a backup:
  1. Navigate to the [catalog dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.clickhouse.switch_backups }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Change the settings of the new cluster if required. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.

      To restore a single shard, only that particular shard should be left checked under **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}**. Uncheck the rest of the shards.

      To restore the whole cluster, leave all shards checked under **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}**.

      You can set up a configuration of its own for each shard you restore.

  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mch-name }} will launch the operation to create a cluster from the backup.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore a cluster from a backup:

  1. View a description of the CLI restore {{ CH }} cluster command:

      ```bash
      {{ yc-mdb-ch }} cluster restore --help
      ```

  1. Getting a list of available {{ CH }} cluster backups:

      ```bash
      {{ yc-mdb-ch }} backup list
      ```

      ```text
      +----------------------+---------------------+----------------------+---------------------+-------------+-------+-----------+
      |            ID        |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      | SHARD NAMES | SIZE  |   TYPE    |
      +----------------------+---------------------+----------------------+---------------------+-------------+-------+-----------+
      | mdb29m1kk9v2******** | 2023-12-08 00:09:17 | c9qud5etkq19******** | 2023-12-08 00:08:06 | shard1      | 30 KB | AUTOMATED |
      | ...                  |                     |                      |                     |             |       |           |
      +----------------------+---------------------+----------------------+---------------------+-------------+-------+-----------+
      ```

  1. To restore a cluster, run a command according to the backup type:

      * If the backup was originally made for all the cluster shards at once ([backup option currently used](../concepts/backup.md#size)), provide this backup's ID in the command:

          
          ```bash
          {{ yc-mdb-ch }} cluster restore \
             --backup-id=<cluster_ID>:<backup_ID> \
             --name=<cluster_name> \
             --environment=<environment> \
             --network-name=<network_name> \
             --host type=<host_type>,`
                   `zone-id=<availability_zone>,`
                   `subnet-id=<subnet_ID> \
             --clickhouse-disk-size=<storage_size_in_GB> \
             --clickhouse-disk-type=<disk_type> \
             --clickhouse-resource-preset=<host_class>
          ```


          Where:

          * `--backup-id`: Cluster and backup IDs.
          * `--name`: Cluster name.
          * `--environment`: Environment:

              * `PRODUCTION`: For stable versions of your apps.
              * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.

          * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
          * `--host`: Host parameters:

              * `type`: Host type: `clickhouse` or `zookeeper`.
              * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
              * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.

          * `--resource-preset`: [Host class](../concepts/instance-types.md#available-flavors).
          * `--disk-size`: Storage size in GB.
          * `--disk-type`: [Disk type](../concepts/storage.md):

              
              * `network-hdd`
              * `network-ssd`
              * `local-ssd`
              * `network-ssd-nonreplicated`
              * `network-ssd-io-m3`


      * If separate backups were created for each cluster shard ([legacy backup option](../concepts/backup.md#size)), provide the backup IDs of all the cluster shards to restore the whole cluster:

          ```bash
          {{ yc-mdb-ch }} cluster restore \
             --backup-id=<list_of_backup_IDs_for_all_shards> \
             ...
          ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Restore](../api-ref/Cluster/restore.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        1. Create a file named `body.json` and add the following contents to it:

            ```json
            {
              "backupId": "<cluster_ID>:<backup_ID>",
              "additionalBackupIds": [
                <list_of_additional_IDs_of_backups>
              ],
              "name": "<cluster_name>",
              "environment": "<environment>",
              "configSpec": { <cluster_configuration> },
              "hostSpecs": [
                {
                  "type": "<host_type>",
                  "zoneId": "<availability_zone>",
                  "subnetId": "<subnet_ID>",
                  "shardName": "<shard_name>",
                  "assignPublicIp": <public_access_to_host>
                },
                { <similar_configuration_for_host_2> },
                { ... },
                { <similar_configuration_for_host_N> }
              ],
              "folderId": "<folder_ID>",
              "networkId": "<network_ID>",
              "serviceAccountId": "<service_account_ID>",
              "securityGroupIds": [
                <list_of_security_group_IDs>
              ],
              "deletionProtection": <cluster_deletion_protection>
            }
            ```

            Where:

            * `backupId`: Cluster and backup IDs.

                This will restore your cluster as a whole.

            * `additionalBackupIds`: Array containing a list of additional IDs of your backups. Use this parameter if backups have been created separately for each shard (legacy backup option).

                The shards for which those backups were created will be restored. To restore the entire cluster, provide backup IDs for all cluster shards.

            * `name`: Cluster name.
            * `environment`: Environment:

                * `PRODUCTION`: For stable versions of your apps.
                * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.

            * `configSpec`: {{ CH }} cluster configuration. For a detailed description of the parameters, see the [Cluster.restore](../api-ref/Cluster/restore.md) method description.
            * `hostSpecs`: Array with settings for the new hosts. One array element contains settings for a single host and has the following structure:

                * `type`: Host type.
                * `zoneId`: Availability zone.
                * `subnetId`: Subnet ID.
                * `shardName`: Shard name.
                * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.

            * `folderId`: ID of the folder to create the cluster in.
            * `networkId`: ID of the network to create the cluster in.
            * `serviceAccountId`: Service account ID.
            * `securityGroupIds`: Array of security group IDs.
            * `deletionProtection`: Option to manage cluster protection against accidental deletion.

                {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

            You can request the cluster ID and backup ID together with the [list of backups in the folder](#list-backups).

        1. Run this request:

            ```bash
            curl \
                --request POST \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters:restore' \
                --data "@body.json"
            ```

    1. View the [server response](../api-ref/Cluster/restore.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        1. Create a file named `body.json` and add the following contents to it:

            ```json
            {
              "backup_id": "<cluster_ID>:<backup_ID>",
              "additional_backup_ids": [
                <list_of_additional_IDs_of_backups>
              ],
              "name": "<cluster_name>",
              "environment": "<environment>",
              "config_spec": { <cluster_configuration> },
              "host_specs": [
                {
                  "type": "<host_type>",
                  "zone_id": "<availability_zone>",
                  "subnet_id": "<subnet_ID>",
                  "shard_name": "<shard_name>",
                  "assign_public_ip": <public_access_to_host>
                },
                { <similar_configuration_for_host_2> },
                { ... },
                { <similar_configuration_for_host_N> }
              ],
              "folder_id": "<folder_ID>",
              "network_id": "<network_ID>",
              "service_account_id": "<service_account_ID>",
              "security_group_ids": [
                <list_of_security_group_IDs>
              ],
              "deletion_protection": <cluster_deletion_protection>
            }
            ```

            Where:

            * `backup_id`: Cluster and backup IDs.

                This will restore your cluster as a whole.

            * `additional_backup_ids`: Array containing a list of additional IDs of your backups. Use this parameter if backups have been created separately for each shard (legacy backup option).

                The shards for which those backups were created will be restored. To restore the entire cluster, provide backup IDs for all cluster shards.

            * `name`: Cluster name.
            * `environment`: Environment:

                * `PRODUCTION`: For stable versions of your apps.
                * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.

            * `config_spec`: {{ CH }} cluster configuration. For a detailed description of the parameters, see the [ClusterService/Restore](../api-ref/grpc/Cluster/restore.md) call description.
            * `host_specs`: Array with settings for the new hosts. One array element contains settings for a single host and has the following structure:

                * `type`: Host type.
                * `zone_id`: Availability zone.
                * `subnet_id`: Subnet ID.
                * `shard_name`: Shard name.
                * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.

            * `folder_id`: ID of the folder to create the cluster in.
            * `network_id`: ID of the network to create the cluster in.
            * `service_account_id`: Service account ID.
            * `security_group_ids`: Array of security group IDs.
            * `deletion_protection`: Option to manage cluster protection against accidental deletion.

                {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

            You can request the cluster ID and backup ID together with the [list of backups in the folder](#list-backups).

        1. Run this request:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d @ \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.clickhouse.v1.ClusterService.Restore \
                < body.json
            ```

    1. View the [server response](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of cluster backups:
  1. Navigate to the [catalog dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}** tab.

  To get a list of all backups in a folder:
  1. Navigate to the [catalog dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.clickhouse.switch_backups }}**.

  These lists contain the following information:

  * Backup ID.
  * Source shard names.
  * Backup size.
  * Backup type: Automatic (`Automated`) or manual (`Manual`).
  * Start time of backup creation in UTC (Coordinated Universal Time).
  * End time of backup creation in UTC.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ CH }} cluster backups available in the default folder, run this command:

  ```bash
  {{ yc-mdb-ch }} backup list
  ```

  ```text
  +----------------------+---------------------+----------------------+---------------------+-------------+-------+-----------+
  |            ID        |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      | SHARD NAMES | SIZE  |   TYPE    |
  +----------------------+---------------------+----------------------+---------------------+-------------+-------+-----------+
  | mdb29m1kk9v2******** | 2023-12-08 00:09:17 | c9qud5etkq19******** | 2023-12-08 00:08:06 | shard1      | 30 KB | AUTOMATED |
  | mdb9sds0ast2******** | 2023-12-07 08:17:04 | c9qud5etkq19******** | 2023-12-07 08:15:54 | shard1      | 30 KB | MANUAL    |
  +----------------------+---------------------+----------------------+---------------------+-------------+-------+-----------+
  ```

  The resulting table contains the following information:

  * ID of the backup.
  * End time of backup creation in UTC (Coordinated Universal Time).
  * ID of the cluster that the backup was created for.
  * Start time of backup creation in UTC.
  * Source shard names.
  * Backup size.
  * Backup type: Automatic (`AUTOMATED`) or manual (`MANUAL`).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. To get a list of {{ CH }} cluster backups:

        1. Use the [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/backups'
            ```

            You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

        1. View the [server response](../api-ref/Cluster/listBackups.md#responses) to make sure the request was successful.

    1. To get a list of backups for all the {{ CH }} clusters in a folder:

        1. Use the [Backup.List](../api-ref/Backup/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/backups' \
                --url-query folderId=<folder_ID>
            ```

            
            You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. View the [server response](../api-ref/Backup/list.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. To get a list of {{ CH }} cluster backups:

        1. Use the [ClusterService.ListBackups](../api-ref/grpc/Cluster/listBackups.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                        "cluster_id": "<cluster_ID>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.clickhouse.v1.ClusterService.ListBackups
            ```

            You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

        1. View the [server response](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.clickhouse.v1.ListClusterBackupsResponse) to make sure the request was successful.

    1. To get a list of backups for all the {{ CH }} clusters in a folder:

        1. Use the [BackupService.List](../api-ref/grpc/Backup/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/backup_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                        "folder_id": "<folder_ID>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.clickhouse.v1.BackupService.List
            ```

            
            You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. View the [server response](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.clickhouse.v1.ListBackupsResponse) to make sure the request was successful.

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

  To get information about the backup of an existing cluster:
  1. Navigate to the [catalog dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}** tab.

  To get information about the backup of a previously deleted cluster:
  1. Navigate to the [catalog dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.clickhouse.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ CH }} cluster backup, run this command:

  ```bash
  {{ yc-mdb-ch }} backup get <cluster_ID>:<backup_ID>
  ```

  You can get the cluster ID and backup ID together with the [list of backups](#list-backups).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Backup.Get](../api-ref/Backup/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/backups/<cluster_ID>:<backup_ID>'
        ```

        You can get the cluster ID and backup ID together with the [list of backups](#list-backups).

    1. View the [server response](../api-ref/Backup/get.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [BackupService.Get](../api-ref/grpc/Backup/get.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/backup_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "backup_id": "<cluster_ID>:<backup_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.BackupService.Get
        ```

        You can get the cluster ID and backup ID together with the [list of backups](#list-backups).

    1. View the [server response](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.clickhouse.v1.Backup) to make sure the request was successful.

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs group=instructions %}

- Management console {#console}

  In the [management console]({{ link-console-main }}), you can set the backup start time when [creating](cluster-create.md) or [updating a cluster](update.md).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set the backup start time, provide the required value in `HH:MM:SS` format in the `--backup-window-start` argument of the `cluster update` command:

  ```bash
  {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
     --backup-window-start=<backup_start_time>
  ```

  You can request the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
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

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Here only one parameter is specified: `configSpec.backupWindowStart`.

        * {% include [backup-windows-start-rest](../../_includes/mdb/api/backup-windows-start-rest.md) %}

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      "config_spec.backup_window_start"
                    ]
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
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Here only one parameter is specified: `config_spec.backup_window_start`.

        * {% include [backup-windows-start-grpc](../../_includes/mdb/api/backup-windows-start-grpc.md) %}

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Setting a retention period for automatic backups {#set-backup-retain}

{% list tabs group=instructions %}

- Management console {#console}
  
  In the [management console]({{ link-console-main }}), you can set the retention period for automatic backups when [creating](cluster-create.md) or [modifying a cluster](update.md).
  
- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set the retention period for automatic backups, provide the required value in `HH:MM:SS` format in the `--backup-retain-period-days` argument of the cluster update command:

  ```bash
  {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
     --backup-retain-period-days=<automatic_backup_retention_period_in_days>
  ```
  
  You can request the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "configSpec.backupRetainPeriodDays",
                    "configSpec": {
                      "backupRetainPeriodDays": <number_of_days>
                    }
                  }'
      ```

      Where:

      * `updateMask`: List of parameters to update as a single string, separated by commas.

        Here only one parameter is specified: `configSpec.backupRetainPeriodDays`.

      * `configSpec.backupRetainPeriodDays`: New automatic backup retention period in days.

      You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      "config_spec.backup_retain_period_days"
                    ]
                  },
                  "config_spec": {
                    "backup_retain_period_days": <number_of_days>
                  }
                }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.

        Here only one parameter is specified: `config_spec.backup_retain_period_days`.

      * `config_spec.backup_retain_period_days`: New automatic backup retention period in days.

      You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Deleting a backup {#delete-backup}

{% note warning %}

You can only delete manual backups.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [catalog dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_backups }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and then click **{{ ui-key.yacloud.mdb.cluster.backups.button_delete }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To delete a cluster backup:
  
  1. View the description of the CLI command to delete a {{ CH }} cluster backup:
  
      ```bash
      {{ yc-mdb-ch }} backup delete --help
      ```
  
  1. Request the deletion of a backup by specifying its ID:
  
      ```bash
      {{ yc-mdb-ch }} backup delete <cluster_ID>:<backup_ID>
      ```

      You can get the cluster ID and backup ID together with the [list of backups](#list-backups).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Backup.Delete](../api-ref/Backup/delete.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/backups/<cluster_ID>:<backup_ID>'
     ```

     You can get the cluster ID and backup ID together with the [list of backups](#list-backups).

  1. View the [server response](../api-ref/Backup/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [BackupService.Delete](../api-ref/grpc/Backup/delete.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/backup_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "backup_id": "<cluster_ID>:<backup_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.clickhouse.v1.BackupService.Delete
     ```

     You can get the cluster ID and backup ID together with the [list of backups](#list-backups).

  1. View the [server response](../api-ref/grpc/Backup/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}  

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}