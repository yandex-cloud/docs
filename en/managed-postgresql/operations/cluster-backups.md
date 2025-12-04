---
title: Managing {{ PG }} backups
description: You can create {{ PG }} backups and use the existing backups to restore clusters. Point-in-time recovery, or PITR, enables you to restore your cluster to the state it was in at any point in time after the backup was created.
---

# Managing backups in {{ mpg-name }}


You can create [backups](../concepts/backup.md) and use the existing backups to restore clusters.

Additionally, {{ mpg-name }} creates automatic daily backups. You can specify the [backup start time](#set-backup-window) and configure its [retention period](#set-backup-retain).

## Restoring a cluster from a backup {#restore}

Point-in-Time Recovery (PITR) technology allows you to restore the cluster’s state to any point in time within the interval from the creation of the oldest full backup to the archiving of the most recent write ahead log (WAL). For more information, see [Backups](../concepts/backup.md).

When you restore a cluster from a backup, you create a new cluster with the backup data. Insufficient folder [resources](../concepts/limits.md) will prevent the restoration of the cluster from the backup. The average backup recovery speed is 10 MBps per database core.

When restored from a backup, the cluster is recovered as a whole, with all its databases. You cannot select specific databases.

For the new cluster, you must specify all the settings required for its creation.

When restored to the current point in time, the new cluster will reflect the state of:

* Existing cluster at the time of recovery.
* Deleted cluster at the time of archiving its most recent WAL.


Before you begin, [assign](../../iam/operations/roles/grant.md) to your {{ yandex-cloud }} account the [managed-postgresql.restorer](../../iam/roles-reference.md#managed-postgresql-restorer) role or higher for the backup folder and the new cluster folder.


{% include [manual-backup-restore](../../_includes/mdb/mpg/note-warn-restore-manual-backup.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  **To restore an existing cluster from a backup**:

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need, then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
  1. To restore the cluster state to a specific point in time after the backup was created, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly. You can either enter the date manually or select it from the drop-down calendar.

     If you leave this setting as is, the cluster will be restored to the state when the backup was completed.

  1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  **To restore a previously deleted cluster from a backup**:

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select the **{{ ui-key.yacloud.postgresql.switch_backups }}** tab.
  1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs in `<cluster_ID>:<backup_ID>` format.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need, then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
  1. To restore the cluster state to a specific point in time after the backup was created, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly. You can either enter the date manually or select it from the drop-down calendar.

     If you leave this setting as is, the cluster will be restored to the state when the backup was completed.

  1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  
  {{ mpg-name }} will initiate the process of creating a new cluster from the backup.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  By default, the cluster will be restored to the same folder where the backup is located. To restore the cluster to a different folder, specify its ID in the `--folder-id` parameter.
  
  To restore a cluster from a backup:
  
  1. See the description of the CLI command for restoring a {{ PG }} cluster:
  
      ```bash
      {{ yc-mdb-pg }} cluster restore --help
      ```
  
  1. Get a list of available {{ PG }} cluster backups:
  
      ```bash
      {{ yc-mdb-pg }} backup list
      ```
  
      ```text
      +--------------------------+---------------------+----------------------+---------------------+
      |              ID          |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
      +--------------------------+---------------------+----------------------+---------------------+
      | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
      | ...                                                                                         |
      +--------------------------+---------------------+----------------------+---------------------+
      ```

      The `CREATED AT` column in the list of available backups shows the backup completion time in `yyyy-mm-dd hh:mm:ss` format (`2020-08-10 12:00:00` in the example above). You can restore your cluster to the state it was in at any point in time after the backup was created.

  1. Make the following request to create a cluster from a backup:

      
      ```bash
      {{ yc-mdb-pg }} cluster restore \
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
      * `--time`: Point in time to restore the {{ PG }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` format.
      * `--name`: Cluster name.
      * `--environment`: Environment:

          * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by an SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test the new versions for compatibility with your application.
          * `PRODUCTION`: For stable versions of your apps.

      * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
      * `--host`: Host settings:

          * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).

          
          * `subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet). Specify it if the selected availability zone has two or more subnets.
          * `assign-public-ip`: Flag to add if [public access to the host](../concepts/network.md#public-access-to-a-host) is required (`true` or `false`).


      * `--resource-preset`: [Host class](../concepts/instance-types.md#available-flavors).
      * `--disk-size`: Storage size, in GB.
      * `--disk-type`: [Disk type](../concepts/storage.md):

          
          * `network-hdd`
          * `network-ssd`
          * `local-ssd`
          * `network-ssd-nonreplicated`          * `network-ssd-io-m3`


- {{ TF }} {#tf}

  Use {{ TF }} to restore:

   * Existing cluster from a backup.
   * Cluster created and then deleted via the management console, CLI, or API.

   {% note info %}

   The cluster will be restored to the folder specified by its `folder_id` in the [provider settings]({{ tf-provider-link }}).

   {% endnote %}

   You will need the backup ID for the restoration. Get a list of available {{ PG }} cluster backups [using the CLI](#list-backups):

   ```bash
   {{ yc-mdb-pg }} backup list
   ```

   ```text
   +--------------------------+---------------------+----------------------+---------------------+
   |            ID            |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
   +--------------------------+---------------------+----------------------+---------------------+
   | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 |
   | ...                                                                                         |
   +--------------------------+---------------------+----------------------+---------------------+
   ```

   {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

   **To restore an existing cluster from a backup:**

   1. Create a [{{ TF }} configuration file](cluster-create.md#create-cluster) for the new cluster.

       Do not specify database (`yandex_mdb_postgresql_database`) and user (`yandex_mdb_postgresql_user`) resources as they will be restored from the backup.

   1. Add the `restore` section to the configuration file:

       ```hcl
       resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
         ...
         restore {
           backup_id = "<backup_ID>"
           time      = "<time>"
         }
       }
       ```

       Where:

       * `backup_id`: Backup ID.
       * `time`: Point in time to restore the {{ PG }} cluster to, starting from the selected backup's creation time. Format: `yyyy-mm-ddThh:mm:ss`.

       {% note info %}

       If you omit the `time` setting, the cluster will be restored to the backup’s completion time.

       {% endnote %}

   1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {{ TF }} will create a copy of the existing cluster. The databases and users will be deployed from the selected backup.

  **To restore a previously deleted cluster from a backup**:

   1. Create a [{{ TF }}](cluster-create.md#create-cluster) configuration file for the new cluster.

       Do not specify database (`yandex_mdb_postgresql_database`) and user (`yandex_mdb_postgresql_user`) resources as they will be restored from the backup.

   1. In this configuration file, add the `restore` section with the name of the backup for restoration:

       ```hcl
       resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
         ...
         restore {
             backup_id = "<backup_ID>"
         }
       }
       ```

       Where `backup-id` is the ID of the deleted cluster’s backup.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {{ TF }} will create the new cluster. The databases and users will be deployed from the backup.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

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
           "assignPublicIp": <allow_public_access_to_host>
         }
       ]
     }
     ```

     Where:

     * `backupId`: [Backup](../concepts/backup.md) ID. You can get it from the [backup list](#list-backups).
     * `time`: Point in time to restore the {{ PG }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` format.
     * `folderId`: ID of the target folder to restore the cluster. You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
     * `name`: Cluster name.
     * `environment`: Environment:

       * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by an SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test the new versions for compatibility with your application.
       * `PRODUCTION`: For stable versions of your apps.

     * `networkId`: [Network](../../vpc/concepts/network.md#network) ID.
     * `configSpec`: Cluster settings:

       * `version`: {{ PG }} version.
       * `resources`: Cluster resources:

         * `resourcePresetId`: [Host class](../concepts/instance-types.md).
         * `diskSize`: Disk size, in bytes.
         * `diskTypeId`: [Disk type](../concepts/storage.md).

     * `hostSpecs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

       * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
       * `subnetId`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
       * `assignPublicIp`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.

  1. Call the [Cluster.Restore](../api-ref/Cluster/restore.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters:restore' \
       --data "@body.json"
     ```

  1. Check the [server response](../api-ref/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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
       "config_spec": {
         "version": "<{{ PG }}_version>",
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
     * `time`: Point in time to restore the {{ PG }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` format.
     * `folder_id`: ID of the target folder to restore the cluster. You can request the ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
     * `name`: Cluster name.
     * `environment`: Environment:

       * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by an SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test the new versions for compatibility with your application.
       * `PRODUCTION`: For stable versions of your apps.

     * `network_id`: [Network](../../vpc/concepts/network.md#network) ID.
     * `config_spec`: Cluster settings:

       * `version`: {{ PG }} version.
       * `resources`: Cluster resources:

         * `resource_preset_id`: [Host class](../concepts/instance-types.md).
         * `disk_size`: Disk size, in bytes.
         * `disk_type_id`: [Disk type](../concepts/storage.md).

     * `host_specs`: Cluster host settings as an array of elements, one for each host. Each element has the following structure:

       * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
       * `subnet_id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
       * `assign_public_ip`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.

  1. Use the [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Restore \
       < body.json
     ```

  1. Check the [server response](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To create a cluster backup:
  
  1. See the description of the CLI command for creating a {{ PG }} backup:
  
      ```
      {{ yc-mdb-pg }} cluster backup --help
      ```
  1. Send a request to create a cluster backup, specifying the cluster name or ID:
  
      ```
      {{ yc-mdb-pg }} cluster backup my-pg-cluster
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
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>:backup'
     ```

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Backup](../api-ref/grpc/Cluster/backup.md#yandex.cloud.mdb.postgresql.v1.Backup) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Backup
     ```

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of cluster backups:
  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.

  To get a list of all backups in a folder:
  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select the **{{ ui-key.yacloud.postgresql.switch_backups }}** tab.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To get a list of {{ PG }} cluster backups available in the default folder, run this command:
  
  ```
  {{ yc-mdb-pg }} backup list
  
  +--------------------------+---------------------+----------------------+---------------------+
  |            ID            |      CREATED AT     |  SOURCE CLUSTER ID   |      STARTED AT     |
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
           --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/backups'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

     1. Check the [server response](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsResponse) to make sure your request was successful.

  1. To get a list of backups for all clusters in a folder:

     1. Call the [Backup.List](../api-ref/Backup/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
           --request GET \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/backups' \
           --url-query folderId=<folder_ID>
        ```

        
        You can get the folder ID from the [cloud’s folder list](../../resource-manager/operations/folder/get-id.md).


     1. Check the [server response](../api-ref/Backup/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse) to make sure your request was successful.

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
          -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.postgresql.v1.ClusterService.ListBackups
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

     1. Check the [server response](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsResponse) to make sure your request was successful.

  1. To get the list of backups for all clusters in the folder:

     1. Use the [BackupService.List](../api-ref/grpc/Backup/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "folder_id": "<folder_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.postgresql.v1.BackupService.List
        ```

        
        You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


     1. Check the [server response](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse) to make sure your request was successful.

{% endlist %}

## Getting backup information {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

  To get information about an existing cluster’s backup:
  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.

  To get information about a previously deleted cluster’s backup:
  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select the **{{ ui-key.yacloud.postgresql.switch_backups }}** tab.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To get information about a {{ PG }} cluster backup, run this command:
  
  ```
  {{ yc-mdb-pg }} backup get <backup_ID>
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
        --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/backups/<backup_ID>'
     ```

     You can get the backup ID from the [backup list](#list-backups).

  1. Check the [server response](../api-ref/Backup/get.md#yandex.cloud.mdb.postgresql.v1.Backup) to make sure your request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "backup_id": "<backup_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.BackupService.Get
     ```

     You can get the backup ID with the [list of backups](#list-backups).

  1. Check the [server response](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.postgresql.v1.Backup) to make sure your request was successful.

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs group=instructions %}

- Management console {#console}
  
  In the management console, you can set the backup start time when [creating](cluster-create.md) or [updating a cluster](update.md).

- CLI {#cli}

  To set the backup start time, use the `--backup-window-start` flag. You must specify the time in `HH:MM:SS` format.

  ```bash
  {{ yc-mdb-pg }} cluster create \
     --cluster-name <cluster_name> \
     --environment <environment> \
     --network-name <network_name> \
     --host zone-id=<availability_zone>,subnet-id=<subnet_ID> \
     --resource-preset <host_class> \
     --user name=<username>,password=<user_password> \
     --database name=<DB_name>,owner=<DB_owner_name> \
     --disk-size <storage_size_in_GB>
     --backup-window-start 10:00:00
  ```

  Where `environment` is the environment, either `prestable` or `production`.

  To change the backup start time for an existing cluster, use the `update` command:

  ```bash
  {{ yc-mdb-pg }} cluster update \
     --cluster-name <cluster_name> \
     --backup-window-start 11:25:00
  ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

        For a complete list of editable {{ mpg-name }} cluster configuration fields, refer to the [{{ TF }} provider guides]({{ tf-provider-mpg }}).

    1. Add the `backup_window_start` block to the `config` section of the {{ mpg-name }} cluster description:

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
          ...
          config {
            ...
            backup_window_start {
              hours   = <hour>
              minutes = <minute>
            }
            ...
          }
          ...
        ```

        Where:

        * `hours`: Backup start hour (UTC).
        * `minutes`: Backup start minute (UTC).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

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
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>' \
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

       In this setting, specify the backup start time. Allowed values:

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
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
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `config_spec.backup_window_start`: [Backup](../concepts/backup.md) window settings.

       In this setting, specify the backup start time. Allowed values:

       * `hours`: Between `0` and `23` hours.
       * `minutes`: Between `0` and `59` minutes.
       * `seconds`: Between `0` and `59` seconds.
       * `nanos`: Between `0` and `999999999` nanoseconds.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Setting a retention period for automatic backups {#set-backup-retain}

{% list tabs group=instructions %}

- Management console {#console}

  In the [management console]({{ link-console-main }}), you can set the retention period for automatic backups when [creating](cluster-create.md) or [updating the cluster](update.md).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set the retention period for automatic backups, provide the required value in the `--backup-retain-period-days` argument of the `cluster update` command:

    ```bash
    {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
       --backup-retain-period-days=<retention_period_in_days>
    ```

  The valid values range from `7` to `60`. The default value is `7`.

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

        For a complete list of {{ mpg-name }} cluster configuration fields you can update, see this [{{ TF }} provider article]({{ tf-provider-mpg }}).

    1. Add the `backup_retain_period_days` block to the `config` section of the {{ mpg-name }} cluster description:

        ```hcl
          resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
            ...
            config {
              ...
              backup_retain_period_days = <retention_period_in_days>
              }
              ...
            }
            ...
        ```

       Where `backup_retain_period_days` is the automatic backup retention period. 
       
       The valid values range from `7` to `60`. The default value is `7`.

  1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

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
         --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>' \
         --data '{
                   "updateMask": "configSpec.backupRetainPeriodDays",
                   "configSpec": {
                     "backupRetainPeriodDays": <retention_period_in_days>
                   }
                 }'
       ```

       Where:

       * `updateMask`: Comma-separated list of settings you want to update.

         Here, we provide only one setting.

       * `configSpec.backupRetainPeriodDays`: Automatic backup retention period.
 
         The valid values range from `7` to `60`. The default value is `7`.

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
        -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
                "cluster_id": "<cluster_ID>",
                "update_mask": {
                "paths": [
                    "config_spec.backup_retain_period_days"
                ]
                },
                "config_spec": {
                "backup_retain_period_days": <retention_period_in_days>
                }
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.postgresql.v1.ClusterService.Update
        ```

     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `config_spec.backup_retain_period_days`: Automatic backup retention period.

       The valid values range from `7` to `60`. The default value is `7`.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Deleting a backup {#delete}

You can only delete backups that were created manually.

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Select the {{ mpg-name }} cluster whose backup you want to delete.
    1. In the left-hand panel, select **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the backup you want to delete.
    1. Select **{{ ui-key.yacloud.mdb.cluster.backups.button_delete }}**.
    1. Confirm deletion and click **{{ ui-key.yacloud.mdb.cluster.backups.action_delete-backup }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete a backup:

    1. See the description of the CLI command for deleting a {{ PG }} backup:

        ```bash
        {{ yc-mdb-pg }} backup delete --help
        ```

    1. Send a request to delete a backup, specifying the backup ID:

        ```bash
        {{ yc-mdb-pg }} backup delete <backup_ID>
        ```

    You can get the backup ID with the [list of backups](#list-backups).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Backup.Delete](../api-ref/Backup/delete.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/backups/<backup_ID>'
     ```

     You can request the backup ID with the [list of backups](#list-backups).

  1. Check the [server response](../api-ref/Backup/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [BackupService.Delete](../api-ref/grpc/Backup/delete.md) call to execute the following request via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "backup_id": "<backup_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.BackupService.Delete
     ```

     You can get the backup ID with the [list of backups](#list-backups).

  1. Check the [server response](../api-ref/grpc/Backup/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
