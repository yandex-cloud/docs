---
title: Managing PostgreSQL backups
description: You can create backups and restore clusters from existing PostgreSQL backups. The Point-in-Time Recovery (PITR) technology enables you to restore cluster state to any point in time starting with the moment a backup was created.
---

# Managing backups in {{ mpg-name }}


You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{{ mpg-name }} also creates automatic daily backups. You can set the [backup start time](#set-backup-window) and [retention period](#set-backup-retain).

## Restoring a cluster from a backup {#restore}

Point-in-Time Recovery (PITR) technology allows you to restore the cluster state to any point in time in the interval from the creation of the oldest full backup to the archiving of the most recent write ahead log (WAL). For more information, see [Backups](../concepts/backup.md).

When you restore a cluster from a backup, you create a new cluster with the backup data. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps per database core.

The backup recovers the whole cluster with all its databases. You cannot select specific databases.

When creating a new cluster, set all required parameters.

When restored to the current state, the new cluster will match the state of:

* Existing cluster at the time of recovery.
* Deleted cluster at the time of archiving the most recent WAL.


Before you begin, [assign](../../iam/operations/roles/grant.md) the [{{ roles.mpg.editor }}](../../iam/roles-reference.md#managed-postgresql-editor) role or higher to your {{ yandex-cloud }} account for the backup folder and the new cluster folder.


{% include [manual-backup-restore](../../_includes/mdb/mpg/note-warn-restore-manual-backup.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  **To restore an existing cluster from a backup**:

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need, then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
  1. To restore the cluster to a particular point in time after creating this backup, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly. You can enter the date manually or select it from the drop-down calendar.

     If you do not change the setting, the cluster will be restored to the state it was in when the backup was completed.

  1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  **To restore a previously deleted cluster from a backup**:

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select the **{{ ui-key.yacloud.postgresql.switch_backups }}** tab.
  1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs formatted as `<cluster_ID>:<backup_IP>`.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need, then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.
  1. To restore the cluster to a particular point in time after creating this backup, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly. You can enter the date manually or select it from the drop-down calendar.

     If you do not change the setting, the cluster will be restored to the state it was in when the backup was completed.

  1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  
  {{ mpg-name }} will launch the operation to create a cluster from the backup.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  By default, the cluster is restored to the same folder where the backup is stored. To restore the cluster to a different folder, specify its ID in the `--folder-id` parameter.
  
  To restore a cluster from a backup:
  
  1. View a description of the CLI restore {{ PG }} cluster command:
  
      ```bash
      {{ yc-mdb-pg }} cluster restore --help
      ```
  
  1. Getting a list of available {{ PG }} cluster backups:
  
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

      The backup completion time is shown in the `CREATED AT` column of the list of available backups, in `yyyy-mm-dd hh:mm:ss` format (`2020-08-10 12:00:00` in the example above). You can restore a cluster to any point in time starting with the point when the backup is created.

  1. Request creating a cluster from a backup:

      
      ```bash
      {{ yc-mdb-pg }} cluster restore \
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
      * `--time`: Time point to restore the {{ PG }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` time format.
      * `--name`: Cluster name.
      * `--environment`: Environment:

          * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test the compatibility of new versions with your application.
          * `PRODUCTION`: For stable versions of your apps.

      * `--network-name`: [Network name](../../vpc/concepts/network.md#network).
      * `--host`: Host parameters:

          * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).

          
          * `subnet-name`: [Subnet name](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
          * `assign-public-ip`: Flag to add if [public access to the host](../concepts/network.md#public-access-to-a-host) is required (`true` or `false`).


      * `--resource-preset`: [Host class](../concepts/instance-types.md#available-flavors).
      * `--disk-size`: Storage size in GB.
      * `--disk-type`: [Disk type](../concepts/storage.md):

          
          * `network-hdd`
          * `network-ssd`
          * `local-ssd`
          * `network-ssd-nonreplicated`          * `network-ssd-io-m3`


- {{ TF }} {#tf}

  Use {{ TF }} to restore:

   * Existing cluster from a backup.
   * Cluster created and deleted via the management console, CLI, or API.

   {% note info %}

   The cluster will be restored to the folder whose ID is specified in the `folder_id` parameter of [provider settings]({{ tf-provider-link }}).

   {% endnote %}

   To restore a cluster, you will need the backup ID. Get a list of available {{ PG }} cluster backups [using the CLI](#list-backups):

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

       Do not use the database (`yandex_mdb_postgresql_database`) and user (`yandex_mdb_postgresql_user`) resources: these will be restored from the backup.

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

       If you omit the `time` parameter, the cluster will be restored to the backup completion time.

       {% endnote %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  {{ TF }} will create a copy of the existing cluster. The databases and users are deployed from the selected backup.

  **To restore a previously deleted cluster from a backup**:

   1. Create a [{{ TF }}](cluster-create.md#create-cluster) configuration file for the new cluster.

       Do not use the database (`yandex_mdb_postgresql_database`) and user (`yandex_mdb_postgresql_user`) resources: these will be restored from the backup.

   1. In this configuration file, add a `restore` section with the name of the backup to restore the cluster from:

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

  {{ TF }} will create the new cluster. The databases and users are deployed from the backup.

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
     * `time`: Time point to restore the {{ PG }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` time format.
     * `folderId`: ID of the folder you want to restore the cluster to. You can request the ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
     * `name`: Cluster name.
     * `environment`: Environment:

       * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test the compatibility of new versions with your application.
       * `PRODUCTION`: For stable versions of your apps.

     * `networkId`: [Network](../../vpc/concepts/network.md#network) ID.
     * `configSpec`: Cluster settings:

       * `version`: {{ PG }} version.
       * `resources`: Cluster resources:

         * `resourcePresetId`: [Host class](../concepts/instance-types.md).
         * `diskSize`: Disk size in bytes.
         * `diskTypeId`: [Disk type](../concepts/storage.md).

     * `hostSpecs`: Cluster host settings as an array of elements, one for each host. Each element has the following structure:

       * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
       * `subnetId`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
       * `assignPublicIp`: Permission to [connect](connect.md) to the host from the internet.

  1. Use the [Cluster.Restore](../api-ref/Cluster/restore.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters:restore' \
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
           "assign_public_ip": <public_host_address:_true_or_false>
         }
       ]
     }
     ```

     Where:

     * `backup_id`: [Backup](../concepts/backup.md) ID. You can request it with the [list of backups](#list-backups).
     * `time`: Time point to restore the {{ PG }} cluster to, in `yyyy-mm-ddThh:mm:ssZ` time format.
     * `folder_id`: ID of the folder you want to restore the cluster to. You can request the ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
     * `name`: Cluster name.
     * `environment`: Environment:

       * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test the compatibility of new versions with your application.
       * `PRODUCTION`: For stable versions of your apps.

     * `network_id`: [Network](../../vpc/concepts/network.md#network) ID.
     * `config_spec`: Cluster settings:

       * `version`: {{ PG }} version.
       * `resources`: Cluster resources:

         * `resource_preset_id`: [Host class](../concepts/instance-types.md).
         * `disk_size`: Disk size in bytes.
         * `disk_type_id`: [Disk type](../concepts/storage.md).

     * `host_specs`: Cluster host settings as an array of elements, one for each host. Each element has the following structure:

       * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
       * `subnet_id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
       * `assign_public_ip`: Permission to [connect](connect.md) to the host from the internet.

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

  1. View the [server response](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To create a cluster backup:
  
  1. View a description of the CLI create {{ PG }} backup command:
  
      ```
      {{ yc-mdb-pg }} cluster backup --help
      ```
  1. Request the creation of a backup specifying the cluster name or ID:
  
      ```
      {{ yc-mdb-pg }} cluster backup my-pg-cluster
      ```
  
      The cluster name and ID can be retrieved with the [list of clusters](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Backup](../api-ref/Cluster/backup.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>:backup'
     ```

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

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

  1. View the [server response](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of cluster backups:
  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. To get a list of cluster backups:

     1. Use the [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
           --request GET \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/backups'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

     1. View the [server response](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsResponse) to make sure the request was successful.

  1. To get a list of backups for all the clusters in a folder:

     1. Use the [Backup.List](../api-ref/Backup/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
           --request GET \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/backups' \
           --url-query folderId=<folder_ID>
        ```

        
        You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


     1. View the [server response](../api-ref/Backup/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

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

     1. View the [server response](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.postgresql.v1.ListClusterBackupsResponse) to make sure the request was successful.

  1. To get a list of backups for all the clusters in a folder:

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

        
        You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


     1. View the [server response](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse) to make sure the request was successful.

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

  To get information about the backup of an existing cluster:
  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.

  To get information about the backup of a previously deleted cluster:
  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select the **{{ ui-key.yacloud.postgresql.switch_backups }}** tab.
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To get information about a {{ PG }} cluster backup, run this command:
  
  ```
  {{ yc-mdb-pg }} backup get <backup_ID>
  ```
  
  You can get the backup ID together with the [list of backups](#list-backups).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Backup.Get](../api-ref/Backup/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/backups/<backup_ID>'
     ```

     You can request the backup ID together with the [list of backups](#list-backups).

  1. View the [server response](../api-ref/Backup/get.md#yandex.cloud.mdb.postgresql.v1.Backup) to make sure the request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "backup_id": "<backup_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.BackupService.Get
     ```

     You can request the backup ID together with the [list of backups](#list-backups).

  1. View the [server response](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.postgresql.v1.Backup) to make sure the request was successful.

{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs group=instructions %}

- Management console {#console}
  
  In the management console, you can set the backup start time when [creating](cluster-create.md) or [updating a cluster](update.md).

- CLI {#cli}

  To set the backup start time, use the `--backup-window-start` parameter. Time is given in `HH:MM:SS` format.

  ```bash
  {{ yc-mdb-pg }} cluster create \
     --cluster-name <cluster_name> \
     --environment <environment> \
     --network-name <network_name> \
     --host zone-id=<availability_zone>,subnet-id=<subnet_ID> \
     --resource-preset <host_class> \
     --user name=<username>,password=<user_password> \
     --database name=<DB_name>,owner=<database_owner_name> \
     --disk-size <storage_size_in_GB>
     --backup-window-start 10:00:00
  ```

  Where `environment` is the environment: `prestable` or `production`.

  To change the backup start time in an existing cluster, use the `update` command:

  ```bash
  {{ yc-mdb-pg }} cluster update \
     --cluster-name <cluster_name> \
     --backup-window-start 11:25:00
  ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

    1. Add a `backup_window_start` block in the `config` section to the {{ mpg-name }} cluster description:

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       In this case, only one parameter is provided.

     * `configSpec.backupWindowStart`: [Backup](../concepts/backup.md) window settings.

       In this parameter, specify the backup start time. Possible values:

       * `hours`: Between `0` and `23` hours.
       * `minutes`: Between `0` and `59` minutes.
       * `seconds`: Between `0` and `59` seconds.
       * `nanos`: Between `0` and `999999999` nanoseconds.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

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

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       Only one parameter is provided in this case.

     * `config_spec.backup_window_start`: [Backup](../concepts/backup.md) window settings.

       In this parameter, specify the backup start time. Possible values:

       * `hours`: Between `0` and `23` hours.
       * `minutes`: Between `0` and `59` minutes.
       * `seconds`: Between `0` and `59` seconds.
       * `nanos`: Between `0` and `999999999` nanoseconds.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Setting a retention period for automatic backups {#set-backup-retain}

{% list tabs group=instructions %}

- Management console {#console}

  In the [management console]({{ link-console-main }}), you can set the retention period for automatic backups when [creating](cluster-create.md) or [modifying a cluster](update.md).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set the retention period for automatic backups, provide the required value in the `--backup-retain-period-days` argument of the `cluster update` command:

    ```bash
    {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
       --backup-retain-period-days=<retention_period_in_days>
    ```

  The possible values range from `7` to `60`. The default value is `7`.

  You can request the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

    1. Add a `backup_retain_period_days` block in the `config` section to the {{ mpg-name }} cluster description:

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
       
       The possible values range from `7` to `60`. The default value is `7`.

  1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

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
         --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>' \
         --data '{
                   "updateMask": "configSpec.backupRetainPeriodDays",
                   "configSpec": {
                     "backupRetainPeriodDays": <retention_period_in_days>
                   }
                 }'
       ```

       Where:

       * `updateMask`: List of parameters to update as a single string, separated by commas.

         Only one parameter is provided in this case.

       * `configSpec.backupRetainPeriodDays`: Automatic backup retention period.
 
         The values range from `7` to `60`. The default value is `7`.

       You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

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

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       Only one parameter is provided in this case.

     * `config_spec.backup_retain_period_days`: Automatic backup retention period.

       The values range from `7` to `60`. The default value is `7`.

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Deleting a backup {#delete}

You can only delete backups that were created manually.

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Select the {{ mpg-name }} cluster whose backup you want to delete.
    1. In the left-hand panel, select **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the backup you want to delete.
    1. Select **{{ ui-key.yacloud.mdb.cluster.backups.button_delete }}**.
    1. Confirm deletion and click **{{ ui-key.yacloud.mdb.cluster.backups.action_delete-backup }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete a backup:

    1. View the description of the CLI command to delete a {{ PG }} cluster backup:

        ```bash
        {{ yc-mdb-pg }} backup delete --help
        ```

    1. Request the deletion of a backup by specifying its ID:

        ```bash
        {{ yc-mdb-pg }} backup delete <backup_ID>
        ```

    You can get the backup ID together with the [list of backups](#list-backups).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Backup.Delete](../api-ref/Backup/delete.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request DELETE \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/backups/<backup_ID>'
     ```

     You can request the backup ID with the [list of backups](#list-backups).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "backup_id": "<backup_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.BackupService.Delete
     ```

     You can request the backup ID together with the [list of backups](#list-backups).

  1. View the [server response](../api-ref/grpc/Backup/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}
