---
title: Managing {{ MY }} backups
description: You can back up {{ MY }} clusters and restore them from existing backups. Point-in-time recovery (PITR) allows you to restore your cluster’s state to any point in time starting from when the backup was created.
---

# Managing backups in {{ mmy-name }}

You can create backups and use the existing backups to restore clusters, including to a specific point in time. For more information, see [Backups](../concepts/backup.md).

{{ mmy-name }} automatically takes a daily backup as well. You can [set the backup start time](#set-backup-window) and [retention period](#set-backup-retain).

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of cluster backups:
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** service.
  1. Click the cluster name and open the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.

  To get a list of all backups in your folder:
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** service.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ MY }} cluster backups available in the default folder, run this command:

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. To get a list of cluster backups:

      1. Call the [Cluster.listBackups](../api-ref/Cluster/listBackups.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

          ```bash
          curl \
              --request GET \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/backups'
          ```

          You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

      1. Check the [server response](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.mysql.v1.ListClusterBackupsResponse) to make sure your request was successful.

  1. To get the list of backups for all clusters in the folder:

      1. Call the [Backup.list](../api-ref/Backup/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

          ```bash
          curl \
              --request GET \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --url 'https://{{ api-host-mdb }}/managed-mysql/v1/backups' \
              --url-query folderId=<folder_ID>
          ```

          
          You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


      1. Check the [server response](../api-ref/Backup/list.md#yandex.cloud.mdb.mysql.v1.ListBackupsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. To get a list of cluster backups:

      1. Call the [ClusterService/ListBackups](../api-ref/grpc/Cluster/listBackups.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

          You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

      1. Check the [server response](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.mysql.v1.ListClusterBackupsResponse) to make sure your request was successful.

  1. To list backups for all clusters in your folder:

      1. Call the [BackupService/List](../api-ref/grpc/Backup/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

          
          You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


      1. Check the [server response](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.mysql.v1.ListBackupsResponse) to make sure your request was successful.

{% endlist %}

## Getting backup information {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

  To get backup details for an existing cluster:
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** service.
  1. Click the cluster name and open the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.

  To get backup details for a previously deleted cluster:
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** service.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get backup details for a {{ MY }} cluster, run this command:

  ```bash
  {{ yc-mdb-my }} backup get <backup_ID>
  ```

  You can get the backup ID with the [list of backups](#list-backups).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Backup.get](../api-ref/Backup/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/backups/<backup_ID>'
      ```

      You can get the backup ID with the [list of backups](#list-backups).

  1. Check the [server response](../api-ref/Backup/get.md#yandex.cloud.mdb.mysql.v1.Backup) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [BackupService/Get](../api-ref/grpc/Backup/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      You can get the backup ID with the [list of backups](#list-backups).

  1. View the [server response](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.mysql.v1.Backup) to make sure your request was successful.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** service.
  1. Click the cluster name and open the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster backup:

  1. See the description of the CLI command for creating a {{ MY }} cluster backup:

      ```bash
      {{ yc-mdb-my }} cluster backup --help
      ```

  1. Send the following request to create a backup, specifying the cluster ID or name:

      ```bash
      {{ yc-mdb-my }} cluster backup <cluster_name_or_ID>
      ```

      You can get the cluster name and ID from the [list of clusters](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.backup](../api-ref/Cluster/backup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>:backup'
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService/Backup](../api-ref/grpc/Cluster/backup.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

In single-host clusters, backups are created by reading data from the master host, while in multi-host clusters, from one of the replicas. You can also [set the host's backup priority](#set-backup-priority).

## Restoring a cluster from a backup {#restore}

{% note warning %}

{% include [deprecated-note](../../_includes/mdb/backups/deprecated-note.md) %}

{% endnote %}

For a new cluster, make sure to set all the required parameters except for the cluster type.


Before you begin, [assign](../../iam/operations/roles/grant.md) to your {{ yandex-cloud }} account the [managed-mysql.restorer](../../iam/roles-reference.md#managed-mysql-restorer) role or higher for the backup folder and the new cluster folder.


{% list tabs group=instructions %}

- Management console {#console}

  To restore an existing cluster from a backup:

  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** service.
  1. Click the cluster name and open the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and then click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
  1. Configure the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
  1. To restore the cluster state [to a specific point in time](../concepts/backup.md) after the backup was created, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly.

     If you leave this setting as is, the cluster will be restored to the state it had when the backup was completed.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  To restore a previously deleted cluster from a backup:
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** service.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mysql.cluster.switch_backups }}**.
  1. Find your backup using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs in `<cluster_ID>:<backup_ID>` format.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and then click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.
  1. Configure the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
  1. To restore the cluster state to a specific point in time after the backup was created, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly. You can either specify the date manually or select it using the date picker.

     If you leave this setting unchanged, the cluster will be restored to the state when the backup was completed.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mmy-name }} will start creating the cluster from the backup.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore a cluster from a backup:

  1. View the description of the CLI command for restoring a {{ MY }} cluster:

      ```bash
      {{ yc-mdb-my }} cluster restore --help
      ```

  1. Get the list of available {{ MY }} cluster backups:

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

     The `CREATED AT` column in the list of available backups shows the backup completion time in `yyyy-mm-dd hh:mm:ss` format (`2020-08-10 12:00:00` in the example above). You can restore your cluster to the state it was in at any point in time after the backup was created.

  1. Send the following request to create a cluster from a backup:

      
      ```bash
      {{ yc-mdb-my }} cluster restore \
         --backup-id=<backup_ID> \
         --time=<time> \
         --name=<cluster_name> \
         --environment=<environment> \
         --network-name=<network_name> \
         --host zone-id=<availability_zone>,`
               `subnet-name=<subnet_name>,`
               `assign-public-ip=<allow_public_access_to_host> \
         --resource-preset=<host_class> \
         --disk-size=<storage_size_in_GB> \
         --disk-type=<disk_type>
      ```


      Where:

      * `--backup-id`: [Backup](../concepts/backup.md) ID.
      * `--time`: Point in time to restore the {{ MY }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` format.
      * `--name`: Cluster name.
      * `--environment`: Environment:

          * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and is also covered by an SLA. However, it receives new features, improvements, and bug fixes earlier. In the prestable environment, you can test new versions for compatibility with your application.
          * `PRODUCTION`: For stable versions of your applications.

      * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
      * `--host`: Host settings:

          * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).

          
          * `subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet). You must specify this setting if the selected availability zone has more than one subnet.
          * `assign-public-ip`: Flag to set if [public access](../concepts/network.md#public-access-to-host) to the host is required, `true` or `false`.


      * `--resource-preset`: [Host class](../concepts/instance-types.md#available-flavors).
      * `--disk-size`: Storage size, in GB.
      * `--disk-type`: [Disk type](../concepts/storage.md):

          
          * `network-hdd`
          * `network-ssd`
          * `local-ssd`
          * `network-ssd-nonreplicated`
          * `network-ssd-io-m3`


- {{ TF }} {#tf}

  Use {{ TF }} to restore:

  * Existing cluster from a backup.
  * Cluster created and then deleted via the management console, CLI, or API.

  To restore a cluster, you will need the backup ID. Get the list of available {{ MY }} cluster backups [using the CLI](#list-backups):

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

  1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for the new cluster.

      Do not specify database (`yandex_mdb_mysql_database`) and user (`yandex_mdb_mysql_user`) resources as they will be restored from the backup.

  1. Add the `restore` section to the configuration file:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        restore {
          backup_id = "<backup_ID>"
          time      = "<time>"
        }
      }
      ```

      In the `time` parameter, specify the point in time to which the {{ MY }} cluster's state should be restored, starting from the selected backup's creation time, in `yyyy-mm-ddThh:mm:ss` format.

      {% note info %}

      The `time` parameter is optional. If you skip it, the cluster state will be restored to the point in time when the recovery process was initiated.

      {% endnote %}

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {{ TF }} will create a copy of the existing cluster. The databases and users will be deployed from the selected backup.

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

  **To restore a previously deleted cluster from a backup:**

  1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for the new cluster.

      Do not specify database (`yandex_mdb_mysql_database`) and user (`yandex_mdb_mysql_user`) resources as they will be restored from the backup.

  1. In this configuration file, add the `restore` section with the name of the backup to restore the data from:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        restore {
            backup_id = "<backup_ID>"
        }
      }
      ```

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {{ TF }} will create the new cluster. The databases and users will be deployed from the backup.

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

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
          "configSpec": {
              "version": "<{{ MY }}_version>",
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
                  "assignPublicIp": <allow_public_access_to_host>
              }
          ]
      }
      ```

      Where:

      * `backupId`: [Backup](../concepts/backup.md) ID. You can get it with the [list of backups](#list-backups).
      * `time`: Point in time to restore the {{ MY }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` format.
      * `folderId`: ID of the folder where you want to restore the cluster. You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
      * `name`: Cluster name.
      * `environment`: Environment:

          * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and is also covered by an SLA. However, it receives new features, improvements, and bug fixes earlier. In the prestable environment, you can test new versions for compatibility with your application.
          * `PRODUCTION`: For stable versions of your applications.

      * `networkId`: [Network](../../vpc/concepts/network.md#network) ID.
      * `configSpec`: Cluster settings:

          * `version`: {{ MY }} version.
          * `resources`: Cluster resources:

              * `resourcePresetId`: [Host class](../concepts/instance-types.md).
              * `diskSize`: Disk size, in bytes.
              * `diskTypeId`: [Disk type](../concepts/storage.md).

      * `hostSpecs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

          * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnetId`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
          * `assignPublicIp`: Permission to [connect](./connect/index.md) to the host from the internet, `true` or `false`.

  1. Call the [Cluster.restore](../api-ref/Cluster/restore.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters:restore' \
          --data "@body.json"
      ```

  1. Check the [server response](../api-ref/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

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
                  "assign_public_ip": <allow_public_access_to_host>
              }
          ]
      }
      ```

      Where:

      * `backup_id`: [Backup](../concepts/backup.md) ID. You can get it with the [list of backups](#list-backups).
      * `time`: Point in time to restore the {{ MY }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` format.
      * `folder_id`: ID of the folder where you want to restore the cluster. You can request the ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
      * `name`: Cluster name.
      * `environment`: Environment:

          * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and is also covered by an SLA. However, it receives new features, improvements, and bug fixes earlier. In the prestable environment, you can test new versions for compatibility with your application.
          * `PRODUCTION`: For stable versions of your applications.

      * `network_id`: [Network](../../vpc/concepts/network.md#network) ID.
      * `config_spec`: Cluster settings:

          * `version`: {{ MY }} version.
          * `resources`: Cluster resources:

              * `resource_preset_id`: [Host class](../concepts/instance-types.md).
              * `disk_size`: Disk size, in bytes.
              * `disk_type_id`: [Disk type](../concepts/storage.md).

      * `host_specs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

          * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnet_id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
          * `assign_public_ip`: Permission to [connect](./connect/index.md) to the host from the internet, `true` or `false`.

  1. Call the [ClusterService/Restore](../api-ref/grpc/Cluster/restore.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

  1. Check the [server response](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs group=instructions %}

- Management console {#console}

  In the [management console]({{ link-console-main }}), you can set the backup start time when [creating](cluster-create.md) or [updating a cluster](update.md).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set the backup start time for an existing cluster, use the `update` command:

  ```bash
  {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
     --backup-window-start=<time>
  ```

  Where `backup-window-start` is the backup start UTC time in `HH:MM:SS` format.

  You can get the cluster ID and name with the [list of clusters](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      To learn how to create this file, see [Creating a cluster](cluster-create.md).

  1. Add the `backup_window_start` section to the {{ mmy-name }} cluster description:

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

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider article]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

      * `updateMask`: Comma-separated string of settings you want to update.

          Here, we provide only one setting.

      * `configSpec.backupWindowStart`: [Backup](../concepts/backup.md) window settings.

          In this setting, specify the backup start time. Allowed values:

          * `hours`: From `0` to `23` hours.
          * `minutes`: From `0` to `59` minutes.
          * `seconds`: From `0` to `59` seconds.
          * `nanos`: From `0` to `999999999` nanoseconds.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      * `update_mask`: List of settings to update as an array of strings (`paths[]`).

          Here, we provide only one setting.

      * `config_spec.backup_window_start`: [Backup](../concepts/backup.md) window settings.

          Here, specify the backup start time. Allowed values:

          * `hours`: From `0` to `23` hours.
          * `minutes`: From `0` to `59` minutes.
          * `seconds`: From `0` to `59` seconds.
          * `nanos`: From `0` to `999999999` nanoseconds.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.mysql.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Setting a retention period for automatic backups {#set-backup-retain}

{% list tabs group=instructions %}

- Management console {#console}

  You can set the retention period for automatic backups when you [create](cluster-create.md) or [update](update.md) the cluster via the [management console]({{ link-console-main }}).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set the retention period for automatic backups, provide the required value for the `--backup-retain-period-days` argument of the `cluster update` command:

    ```bash
    {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
       --backup-retain-period-days=<retention_period_in_days>
    ```

  Allowed values range from `7` to `60`. The default value is `7`.

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

        For a complete list of {{ mmy-name }} cluster configuration fields you can update, see [this {{ TF }} provider guide]({{ tf-provider-mpg }}).

    1. To set the retention period for automatic backups, add the `backup_retain_period_days` section to the {{ mmy-name }} cluster description:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
          ...
          backup_window_start: <retention_period_in_days>
        }
        ```

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

      * `updateMask`: Comma-separated string of settings you want to update.

          Here, we provide only one setting.

      * `configSpec.backupRetainPeriodDays`: Automatic backup retention period.

          The valid values range from `7` to `60`. The default value is `7`.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.


- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  
  1. Call the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      * `update_mask`: List of settings to update as an array of strings (`paths[]`).

          Here, we provide only one setting.

      * `config_spec.backup_retain_period_days`: Automatic backup retention period.

          Allowed values range from `7` to `60`. The default value is `7`.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.mysql.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Setting a host's backup priority {#set-backup-priority}

The minimum value of the host's backup priority is `0`, and the maximum, `100`. The default value is `0`. The replica host with the highest priority is selected as the backup source. For more information, see [Creating backups](../concepts/backup.md#size).

{% list tabs group=instructions %}

- Management console {#console}

  In the [management console]({{ link-console-main }}), the host's priority is set when [creating](cluster-create.md) a cluster, [adding](../operations/hosts.md#add) new hosts to it, or [updating the settings](../operations/hosts.md#update) of existing hosts.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set a backup priority for a selected host, run this command:

  ```bash
  {{ yc-mdb-my }} host update <host_name> \
     --cluster-name=<cluster_name> \
     --backup-priority=<host_backup_priority>
  ```

  Where `backup-priority` is the host's backup priority, between `0` and `100`.

  You can get the host name with the [list of cluster hosts](hosts.md#list), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.updateHosts](../api-ref/Cluster/updateHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

      Where `updateHostSpecs` is the array of hosts you are prioritizing. Each array element contains the configuration for a single host and has the following structure:

      * `updateMask`: Comma-separated string of settings you want to update.
      * `hostName`: [FQDN of the host you are updating](./connect/fqdn.md).
      * `backupPriority`: [Host's backup priority](../concepts/backup.md#size), between `0` and `100`.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService/UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      Where `update_host_specs` is the array of hosts you are prioritizing. Each array element contains the configuration for a single host and has the following structure:

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).
      * `host_name`: [FQDN of the host you are updating](./connect/fqdn.md).
      * `backup_priority`: [Host's backup priority](../concepts/backup.md#size), between `0` and `100`.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
