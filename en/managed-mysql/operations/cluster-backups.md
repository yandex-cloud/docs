---
title: Managing MySQL backups
description: You can create backups and restore clusters from existing MySQL backups. The Point-in-Time Recovery (PITR) technology enables you to restore cluster state to any point in time starting with the moment a backup was created.
---

# Managing backups in {{ mmy-name }}

You can create backups and restore clusters from existing backups, including point-in-time recovery. For more information, see [Backups](../concepts/backup.md).

{{ mmy-name }} also creates automatic daily backups. You can [set the backup start time](#set-backup-window) and [retention period](#set-backup-retain).

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of cluster backups:
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.

  To get a list of all backups in a folder:
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ MY }} cluster backups available in the default folder, run the command:

  ```bash
  {{ yc-mdb-my }} backup list
  ```

  Result:

  ```text
  +--------------------------+---------------------+----------------------+---------------------+
  |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
  +--------------------------+---------------------+----------------------+---------------------+
  | c9qgo11pud7kb3c********  | 2020-08-10 12:00:00 | c9qgo11pud7k******** | 2020-08-10 11:55:17 |
  | ...                                                                                         |
  +--------------------------+---------------------+----------------------+---------------------+
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. To get a list of cluster backups:

      1. Use the [Cluster.listBackups](../api-ref/Cluster/listBackups.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

          ```bash
          curl \
              --request GET \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/backups'
          ```

          You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

      1. View the [server response](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.mysql.v1.ListClusterBackupsResponse) to make sure the request was successful.

  1. To get a list of backups for all the clusters in a folder:

      1. Use the [Backup.list](../api-ref/Backup/list.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

          ```bash
          curl \
              --request GET \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --url 'https://{{ api-host-mdb }}/managed-mysql/v1/backups' \
              --url-query folderId=<folder_ID>
          ```


          You can request the folder ID with a [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


      1. View the [server response](../api-ref/Backup/list.md#yandex.cloud.mdb.mysql.v1.ListBackupsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. To get a list of cluster backups:

      1. Use the [ClusterService/ListBackups](../api-ref/grpc/Cluster/listBackups.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

          ```bash
          grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d '{
                    "cluster_id": "<cluster_ID>"
                  }' \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.mysql.v1.ClusterService.ListBackups
          ```

          You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

      1. View the [server response](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.mysql.v1.ListClusterBackupsResponse) to make sure the request was successful.

  1. To get a list of backups for all the clusters in a folder:

      1. Use the [BackupService/List](../api-ref/grpc/Backup/list.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

          ```bash
          grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/backup_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d '{
                    "folder_id": "<folder_ID>"
                  }' \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.mysql.v1.BackupService.List
          ```


          You can request the folder ID with a [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


      1. View the [server response](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.mysql.v1.ListBackupsResponse) to make sure the request was successful.

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

  To get information about the backup of an existing cluster:
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.

  To get information about the backup of a previously deleted cluster:
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ MY }} cluster backup, run the command:

  ```bash
  {{ yc-mdb-my }} backup get <backup_ID>
  ```

  You can retrieve the backup ID with a [list of backups](#list-backups).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Backup.get](../api-ref/Backup/get.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/backups/<backup_ID>'
      ```

      You can get the backup ID together with a [list of backups](#list-backups).

  1. View the [server response](../api-ref/Backup/get.md#yandex.cloud.mdb.mysql.v1.Backup) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [BackupService/Get](../api-ref/grpc/Backup/get.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/backup_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "backup_id": "<backup_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.BackupService.Get
      ```

      You can get the backup ID together with a [list of backups](#list-backups).

  1. View the [server response](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.mysql.v1.Backup) to make sure the request was successful.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster backup:

  1. View a description of the CLI command to create a {{ MY }} cluster backup:

      ```bash
      {{ yc-mdb-my }} cluster backup --help
      ```

  1. Request a backup to be created by specifying the cluster name or ID:

      ```bash
      {{ yc-mdb-my }} cluster backup <cluster_name_or_ID>
      ```

      You can get the cluster ID and name with a [list of clusters](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.backup](../api-ref/Cluster/backup.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>:backup'
      ```

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Backup](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.mysql.v1.Backup) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Backup
      ```

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

In single-host clusters, you create a backup by reading data from the master host, whereas in multi-host clusters — from one of the replicas. At the same time, you can [specify host priorities when creating backups](#set-backup-priority).

## Restoring clusters from backups {#restore}

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type.

{% list tabs group=instructions %}

- Management console {#console}

  To restore an existing cluster from a backup:

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
  1. To restore the cluster [to a particular point in time](../concepts/backup.md) after creating this backup (Point-in-Time-Recovery), configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly.

     If you do not change the setting, the cluster will be restored to the state when the backup was completed.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  To restore a previously deleted cluster from a backup:
  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.
  1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs formatted as `<cluster_ID>:<backup_ID>`.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
  1. To restore the cluster to a particular point in time after creating this backup, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly. You can enter the date manually or select it from the drop-down calendar.

     If you do not change the setting, the cluster will be restored to the state when the backup was completed.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mmy-name }} will launch the operation to create a cluster from the backup.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore a cluster from a backup:

  1. View a description of the CLI restore {{ MY }} cluster command:

      ```bash
      {{ yc-mdb-my }} cluster restore --help
      ```

  1. Getting a list of available {{ MY }} cluster backups:

     ```bash
     {{ yc-mdb-my }} backup list
     ```

     Result:

     ```text
     +--------------------------+---------------------+----------------------+---------------------+
     |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
     +--------------------------+---------------------+----------------------+---------------------+
     | c9qgo11pud7kb3c********  | 2020-08-10 12:00:00 | c9qgo11pud7k******** | 2020-08-10 11:55:17 |
     | ...                                                                                         |
     +--------------------------+---------------------+----------------------+---------------------+
     ```

     The backup completion time is shown in the `CREATED AT` column of the list of available backups, in `yyyy-mm-dd hh:mm:ss` format (`2020-08-10 12:00:00` in the example above). You can restore a cluster to any point in time starting with the point when the backup is created.

  1. Request the creation of a cluster from a backup:


      ```bash
      {{ yc-mdb-my }} cluster restore \
         --backup-id=<backup_ID> \
         --time=<time> \
         --name=<cluster_name> \
         --environment=<environment> \
         --network-name=<network_name> \
         --host zone-id=<availability_zone>,`
               `subnet-name=<subnet_name>,`
               `assign-public-ip=<public_access_to_host> \
         --resource-preset=<host_class> \
         --disk-size=<storage_size_in_GB> \
         --disk-type=<disk_type>
      ```


      Where:

      * `--backup-id`: [Backup](../concepts/backup.md) ID.
      * `--time`: Time point to restore the {{ MY }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` time format.
      * `--name`: Cluster name.
      * `--environment`: Environment:

          * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
          * `PRODUCTION`: For stable versions of your apps.

      * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
      * `--host`: Host parameters:

          * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).


          * `subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
          * `assign-public-ip`: Flag used if [public access](../concepts/network.md#public-access-to-host) to the host is required, `true` or `false`.


      * `--resource-preset`: [Host class](../concepts/instance-types.md#available-flavors).
      * `--disk-size`: Storage size in GB.
      * `--disk-type`: [Disk type](../concepts/storage.md):


          * `network-hdd`
          * `network-ssd`
          * `local-ssd`
          * `network-ssd-nonreplicated`


- {{ TF }} {#tf}

  Use {{ TF }} to restore:

  * Existing cluster from a backup.
  * Cluster created and deleted via the management console, CLI, or API.

  To restore a cluster, you will need the backup ID. Get a list of available {{ MY }} cluster backups [using the CLI](#list-backups):

  ```bash
  {{ yc-mdb-my }} backup list
  ```

  Result:

  ```text
  +--------------------------+---------------------+----------------------+---------------------+
  |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |
  +--------------------------+---------------------+----------------------+---------------------+
  | c9qgo11pud7kb3c********  | 2020-08-10 12:00:00 | c9qgo11pud7k******** | 2020-08-10 11:55:17 |
  | ...                                                                                         |
  +--------------------------+---------------------+----------------------+---------------------+
  ```

  **To restore an existing cluster from a backup:**

  1. Create a [{{ TF }}](cluster-create.md#create-cluster) configuration file for the new cluster.

      Do not use the database (`yandex_mdb_mysql_database`) and user (`yandex_mdb_mysql_user`) resources: these will be restored from the backup.

  1. Add a `restore` section to this configuration file:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        restore {
          backup_id = "<backup_ID>"
          time      = "<time>"
        }
      }
      ```

      In the `time` parameter, specify the time point to restore the {{ MY }} cluster to in `yyyy-mm-ddThh:mm:ss` format starting from the selected backup's creation time.

      {% note info %}

      The `time` parameter is optional. If you do not specify it, the cluster will be restored to the state when the recovery process was started.

      {% endnote %}

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {{ TF }} will create a copy of the existing cluster. The databases and users are deployed from the selected backup.

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

  **To restore a previously deleted cluster from a backup**:

  1. Create a [{{ TF }}](cluster-create.md#create-cluster) configuration file for the new cluster.

      Do not use the database (`yandex_mdb_mysql_database`) and user (`yandex_mdb_mysql_user`) resources: these will be restored from the backup.

  1. In this configuration file, add a `restore` section with the name of the backup to restore the cluster from:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        restore {
            backup_id = "<backup_ID>"
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {{ TF }} will create the new cluster. The databases and users are deployed from the backup.

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and add the following contents to it:

      ```json
      {
          "backupId": "<backup_ID>",
          "time": "<time>",
          "folderId": "<folder_ID>",
          "name": "<cluster_name>",
          "environment": "<environment>",
          "networkId": "<network_ID>",
          "configSpec": {
              "version": "<{{ PG }}_version>",
              "resources": {
                  "resourcePresetId": "<host_class>",
                  "diskSize": "<storage_size_in_bytes>",
                  "diskTypeId": "<disk_type>"
              }
          },
          "hostSpecs": [
              {
                  "zoneId": "<availability_zone>",
                  "subnetId": "<subnet_ID>",
                  "assignPublicIp": <public_host_address:_true_or_false>
              }
          ]
      }
      ```

      Where:

      * `backupId`: [Backup](../concepts/backup.md) ID. You can get it with a [list of backups](#list-backups).
      * `time`: Time point to restore the {{ MY }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` time format.
      * `folderId`: ID of the folder you want to restore the cluster to. You can get the ID with a [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
      * `name`: Cluster name.
      * `environment`: Environment:

          * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
          * `PRODUCTION`: For stable versions of your apps.

      * `networkId`: [Network](../../vpc/concepts/network.md#network) ID.
      * `configSpec`: Cluster settings:

          * `version`: {{ MY }} version.
          * `resources`: Cluster resources:

              * `resourcePresetId`: [Host class](../concepts/instance-types.md).
              * `diskSize`: Disk size in bytes.
              * `diskTypeId`: [Disk type](../concepts/storage.md).

      * `hostSpecs`: Settings for the cluster hosts as an array of elements,  one for each host. Each element has the following structure:

          * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnetId`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
          * `assignPublicIp`: Permission to [connect](connect.md) to the host from the internet.

  1. Use the [Cluster.restore](../api-ref/Cluster/restore.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters:restore' \
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
          "time": "<time>",
          "folder_id": "<folder_ID>",
          "name": "<cluster_name>",
          "environment": "<environment>",
          "network_id": "<network_ID>",
          "config_spec": {
              "version": "<{{ MY }}_version>",
              "resources": {
                  "resource_preset_id": "<host_class>",
                  "disk_size": "<storage_size_in_bytes>",
                  "disk_type_id": "<disk_type>"
              }
          },
          "host_specs": [
              {
                  "zone_id": "<availability_zone>",
                  "subnet_id": "<subnet_ID>",
                  "assign_public_ip": <public_host_address:_true_or_false>
              }
          ]
      }
      ```

      Where:

      * `backup_id`: [Backup](../concepts/backup.md) ID. You can get it with a [list of backups](#list-backups).
      * `time`: Time point to restore the {{ MY }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` time format.
      * `folder_id`: ID of the folder you want to restore the cluster to. You can get the ID with a [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
      * `name`: Cluster name.
      * `environment`: Environment:

          * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
          * `PRODUCTION`: For stable versions of your apps.

      * `network_id`: [Network](../../vpc/concepts/network.md#network) ID.
      * `config_spec`: Cluster settings:

          * `version`: {{ MY }} version.
          * `resources`: Cluster resources:

              * `resource_preset_id`: [Host class](../concepts/instance-types.md).
              * `disk_size`: Disk size in bytes.
              * `disk_type_id`: [Disk type](../concepts/storage.md).

      * `host_specs`: Settings for the cluster hosts as an array of elements, one for each host. Each element has the following structure:

          * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnet_id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
          * `assign_public_ip`: Permission to [connect](connect.md) to the host from the internet.

  1. Use the [ClusterService/Restore](../api-ref/grpc/Cluster/restore.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Restore \
          < body.json
      ```

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs group=instructions %}

- Management console {#console}

  In the [management console]({{ link-console-main }}), you can set the backup start time when [creating](cluster-create.md) or [updating a cluster](update.md).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set the backup start time in an existing cluster, use the following `update` command:

  ```bash
  {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
     --backup-window-start=<time>
  ```

  Where `backup-window-start` is the backup start UTC time in `HH:MM:SS` format.

  You can get the cluster ID and name with a [list of clusters](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

  1. Add a `backup_window_start` block to the {{ mmy-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        backup_window_start {
          hours   = <hour>
          minutes = <minute>
        }
      }
      ```

      Where:

      * `hours`: Backup start hour (UTC).
      * `minutes`: Backup start minute (UTC).

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>' \
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

          In this case, only one parameter is provided.

      * `configSpec.backupWindowStart`: [Backup](../concepts/backup.md) window settings.

          In this parameter, specify the backup start time. Possible values:

          * `hours`: Between `0` and `23` hours.
          * `minutes`: Between `0` and `59` minutes.
          * `seconds`: Between `0` and `59` seconds.
          * `nanos`: Between `0` and `999999999` nanoseconds.

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
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
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.

          In this case, only one parameter is provided.

      * `config_spec.backup_window_start`: [Backup](../concepts/backup.md) window settings.

          In this parameter, specify the backup start time. Possible values:

          * `hours`: Between `0` and `23` hours.
          * `minutes`: Between `0` and `59` minutes.
          * `seconds`: Between `0` and `59` seconds.
          * `nanos`: Between `0` and `999999999` nanoseconds.

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.mysql.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Setting a retention period for automatic backups {#set-backup-retain}

{% list tabs group=instructions %}

- Management console {#console}

  In the [management console]({{ link-console-main }}), you can set a retention period for automatic backups when [creating](cluster-create.md) or [updating a cluster](update.md).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set a retention period for automatic backups, provide the required value in the `--backup-retain-period-days` argument of the `cluster update` command:

    ```bash
    {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
       --backup-retain-period-days=<retention_period_in_days>
    ```

  The possible values range from `7` to `60`. The default value is `7`.

  You can request the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mmy-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

    1. To set a retention period for automatic backups, add a `backup_retain_period_days` block to the {{ mmy-name }} cluster description:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
          ...
          backup_window_start: <retention_period_in_days>
        }
        ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }}  provider documentation]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "configSpec.backupRetainPeriodDays",
                    "configSpec": {
                      "backupRetainPeriodDays": <retention_period_in_days>
                    }
                  }'
      ```

      Where:

      * `updateMask`: List of parameters to update as a single string, separated by commas.

          In this case, only one parameter is provided.

      * `configSpec.backupRetainPeriodDays`: Automatic backup retention period.

          The values range from `7` to `60`. The default value is `7`.

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.


- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  
  1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
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
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.

          In this case, only one parameter is provided.

      * `config_spec.backup_retain_period_days`: Automatic backup retention period.

          The values range from `7` to `60`. The default value is `7`.

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.mysql.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Setting host priorities when creating backup {#set-backup-priority}

The minimum host priority when creating backups is `0`, the maximum is `100`, and the default is `0`. A replicated host with the highest priority serves as the backup source. For more information, see [Creating backups](../concepts/backup.md#size).

{% list tabs group=instructions %}

- Management console {#console}

  In the [management console]({{ link-console-main }}), a host's priority is set when [creating](cluster-create.md) a cluster, [adding](../operations/hosts.md#add) new hosts to it, or [updating the settings](../operations/hosts.md#update) of existing hosts.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set backup priority for a selected host, run this command:

  ```bash
  {{ yc-mdb-my }} host update <host_name> \
     --cluster-name=<cluster_name> \
     --backup-priority=<host_backup_priority>
  ```

  Where `backup-priority` is the host's backup priority, between `0` and `100`.

  You can request the host name with a [list of cluster hosts](hosts.md#list), and the cluster name, with a [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.updateHosts](../api-ref/Cluster/updateHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/hosts:batchUpdate' \
          --data '{
                    "updateHostSpecs": [
                      {
                        "updateMask": "backupPriority",
                        "hostName": "<host_FQDN>",
                        "backupPriority": "<host_backup_priority>"
                      }
                    ]
                  }'
      ```

      Where `update_host_specs` is the array of hosts you are prioritizing. One array element contains settings for a single host and has the following structure:

      * `updateMask`: List of parameters to update as a single string, separated by commas.
      * `hostName`: [FQDN of the host being changed](connect.md#fqdn).
      * `backupPriority`: [Host's backup priority](../concepts/backup.md#size), between `0` and `100`.

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "update_host_specs": [
                  {
                    "update_mask": {
                      "paths": [
                        "backup_priority"
                      ]
                    },
                    "host_name": "<host_FQDN>",
                    "backup_priority": "<host_backup_priority>"
                  }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.UpdateHosts
      ```

      Where `update_host_specs` is the array of hosts you are prioritizing. One array element contains settings for a single host and has the following structure:

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.
      * `host_name`: [FQDN of the host being changed](connect.md#fqdn).
      * `backup_priority`: [Host's backup priority](../concepts/backup.md#size), between `0` and `100`.

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}
