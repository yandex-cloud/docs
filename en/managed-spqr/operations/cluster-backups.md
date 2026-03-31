---
title: Managing backups in {{ mspqr-name }}
description: Learn how to create backups and use existing backups to restore your clusters in {{ mspqr-full-name }}.
---

# Managing backups in {{ mspqr-full-name }}

{% include [preview](../../_includes/note-service-preview.md) %}

You can [create](#create-backup) backups and use existing backups to [restore](#restore) your clusters.

{{ mspqr-name }} automatically takes a daily backup as well. You can [specify the start time](#set-backup-window) and configure the [retention period](#set-backup-retain) for automatic backups.

## Restoring a cluster from a backup {#restore}

{% note warning %}

{% include [deprecated-note](../../_includes/mdb/backups/deprecated-note.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To restore an existing cluster from a backup:

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the backup you need and select **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Configure the new cluster.
      
      You can select a folder for the new cluster in the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** field.
  
  1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  To restore a deleted cluster from a backup:

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the backup you need and select **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.
  1. Configure the new cluster.
      
      You can select a folder for the new cluster in the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** field.
  
  1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To restore a cluster from a backup:

  1. View the description of the CLI command for restoring a cluster:
  
      ```bash
      yc managed-sharded-postgresql cluster restore --help
      ```
  
  1. Create a cluster from a backup (the example does not include all the available flags):

      
      ```bash
      yc managed-sharded-postgresql cluster restore \
        --backup-id <backup_ID> \
        --time <time_point_to_restore_to> \
        --name <cluster_name> \
        --description <cluster_description> \
        --environment <environment> \
        --network-id <network_ID> \
        --host zone-id=<availability_zone>,`
              `subnet-id=<subnet_ID>,`
              `assign-public-ip=<public_access_to_host>,`
              `type=<host_type> \
        --router-resource-preset <router_host_class> \
        --router-disk-size <storage_size_in_GB> \
        --router-disk-type <disk_type> \
        --coordinator-resource-preset <coordinator_host_class> \
        --coordinator-disk-size <storage_size_in_GB> \
        --coordinator-disk-type <disk_type> \
        --infra-resource-preset <INFRA_host_class> \
        --infra-disk-size <storage_size_in_GB> \
        --infra-disk-type <disk_type> \
        --backup-window-start <backup_start_time> \
        --backup-retain-period-days <backup_retention_period> \
        --security-group-ids <security_group_IDs> \
        --deletion-protection
      ```


      Where:

      * `--backup-id`: Backup ID.
        
        You can get the backup ID with the [list of backups](#list-backups).

      * `--time`: Point in time to restore the cluster to, in `yyyy-mm-ddThh:mm:ssZ` format.
      * `--name`: Cluster name.
      * `--description`: Cluster description.
      * `--environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
      * `--network-id`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be deployed in.
      * `--host`: Host settings:
        
        * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
        
                
        * `subnet-id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
        * `assign-public-ip`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.
        
        
        * `type`: [Host type](../concepts/index.md). The possible values are:
          
          * `ROUTER`: Router in a cluster with advanced sharding.
          * `COORDINATOR`: Coordinator in a cluster with advanced sharding.
          * `INFRA`: `INFRA` host in a cluster with standard sharding.

      * `--router-resource-preset`: [Class](../concepts/instance-types.md) of router hosts.
      * `--router-disk-size`: Storage size for router hosts, GB.
      * `--router-disk-type`: [Disk type](../concepts/storage.md) for router hosts.
      * `--coordinator-resource-preset`: Class of coordinator hosts.
      * `--coordinator-disk-size`: Storage size for coordinator hosts, GB.
      * `--coordinator-disk-type`: Disk type for coordinator hosts.
      * `--infra-resource-preset`: `INFRA` host class.
      * `--infra-disk-size`: `INFRA` storage size, GB.
      * `--infra-disk-type`: Disk type for `INFRA` hosts.
      * `--backup-window-start`: Daily backup start time (UTC) in `HH:MM:SS` format.
      * `--backup-retain-period-days`: Retention period of automatic cluster backups. Possible values: between `7` and `60` days. The default value is `7`.
      
      
      * `--security-group-ids`: [Security group](../../vpc/concepts/security-groups.md) IDs.

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


      * `--deletion-protection`: Enables cluster deletion protection.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      
      ```json
      {
        "backupId": "<backup_ID>",
        "name": "<cluster_name>",
        "description": "<cluster_description>",
        "environment": "<environment>",
        "configSpec": {
          "spqrSpec": {
            "router": {
              "resources": {
                "resourcePresetId": "<router_host_class>",
                "diskSize": "<storage_size_in_bytes>",
                "diskTypeId": "<disk_type>"
              }
            },
            "coordinator": {
              "resources": {
                "resourcePresetId": "<coordinator_host_class>",
                "diskSize": "<storage_size_in_bytes>",
                "diskTypeId": "<disk_type>"
              }
            },
            "infra": {
              "resources": {
                "resourcePresetId": "<INFRA_host_class>",
                "diskSize": "<storage_size_in_bytes>",
                "diskTypeId": "<disk_type>"
              }
            },
            "consolePassword": "<Sharded_PostgreSQL_console_password>",
            "logLevel": "<logging_level>"
          },
          "backupWindowStart": {
            "hours": <hours>,
            "minutes": <minutes>,
            "seconds": <seconds>,
            "nanos": <nanoseconds>
          },
          "backupRetainPeriodDays": "<number_of_days>"
        },
        "hostSpecs": [
          {
            "zoneId": "<availability_zone>",
            "subnetId": "<subnet_ID>",
            "assignPublicIp": <allow_public_access_to_host>,
            "type": "<host_type>",
            "shardName": "<shard_name>",
            "mdbPostgresql": {
              "clusterId": "<{{ PG }}_cluster_ID>"
            }
          },
          { <similar_settings_for_host_2> },
          { ... },
          { <similar_settings_for_host_N> }
        ],
        "networkId": "<network_ID>",
        "folderId": "<folder_ID>",
        "securityGroupIds": [
          "<security_group_1_ID>",
          "<security_group_2_ID>",
          ...
          "<security_group_N_ID>"
        ],
        "deletionProtection": <protect_cluster_from_deletion>,
        "time": "<time_point_to_restore_to>",
        "timeInclusive": <restore_after_specified_time>
      }
      ```


      Where:

      * `backupId`: Backup ID.
        
        You can get the backup ID with the [list of backups](#list-backups).

      * `name`: Cluster name.
      * `description`: Cluster description.
      * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
      * `configSpec.spqrSpec.router.resources`: Parameters of router host resources:
        
        * `resourcePresetId`: [Host class](../concepts/instance-types.md).
        * `diskSize`: Disk size, in bytes.
        * `diskTypeId`: [Disk type](../concepts/storage.md).
      
      * `configSpec.spqrSpec.coordinator.resources`: Parameters of coordinator host resources:
        
        * `resourcePresetId`: Host class.
        * `diskSize`: Disk size, in bytes.
        * `diskTypeId`: Disk type.
      
      * `configSpec.spqrSpec.infra.resources`: `INFRA` host resource parameters:
        
        * `resourcePresetId`: Host class.
        * `diskSize`: Disk size, in bytes.
        * `diskTypeId`: Disk type.
      
      * `configSpec.spqrSpec.consolePassword`: {{ SPQR }} console password.
      * `configSpec.spqrSpec.logLevel`: Query logging level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, or `FATAL`.
      * `configSpec.backupWindowStart`: Backup window settings.

        Here, specify the backup start time. Allowed values:

        * `hours`: Between `0` and `23` hours.
        * `minutes`: Between `0` and `59` minutes.
        * `seconds`: Between `0` and `59` seconds.
        * `nanos`: Between `0` and `999999999` nanoseconds.

      * `configSpec.backupRetainPeriodDays`: Retention period of automatic cluster backups. Possible values: between `7` and `60` days. The default value is `7`.
      * `hostSpecs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

        * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).

        
        * `subnetId`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
        * `assignPublicIp`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.


        * `type`: Host type. The possible values are:

          * `ROUTER`: Router in a cluster with advanced sharding.
          * `COORDINATOR`: Coordinator in a cluster with advanced sharding.
          * `INFRA`: `INFRA` host in a cluster with standard sharding.
        
        * `shardName`: Shard name.
        * `mdbPostgresql.clusterId`: {{ mpg-name }} cluster ID.

          You can get the {{ mpg-name }} cluster ID with the [list of clusters](../../managed-postgresql/operations/cluster-list.md#list-clusters) in the folder.

     * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be deployed in.
     * `folderId`: Folder ID.
       
              
       You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
       
     
     
     * `securityGroupIds`: [Security group](../../vpc/concepts/security-groups.md) IDs.

       {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}

     
     * `deletionProtection`: Cluster deletion protection, `true` or `false`.
     * `time`: Point in time to restore the cluster to, in `yyyy-mm-ddThh:mm:ssZ` format.
     * `timeInclusive`: Restore the cluster after the specified time, `true` or `false`.

  1. Call the [Cluster.Restore](../api-ref/Cluster/restore.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters:restore' \
        --data "@body.json"
      ```

  1. Check the [server response](../api-ref/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and paste the following code into it:

      
      ```json
      {
        "backup_id": "<backup_ID>",
        "name": "<cluster_name>",
        "description": "<cluster_description>",
        "environment": "<environment>",
        "config_spec": {
          "spqr_spec": {
            "router": {
              "resources": {
                "resource_preset_id": "<router_host_class>",
                "disk_size": <storage_size_in_bytes>,
                "disk_type_id": "<disk_type>"
              }
            },
            "coordinator": {
              "resources": {
                "resource_preset_id": "<coordinator_host_class>",
                "disk_size": <storage_size_in_bytes>,
                "disk_type_id": "<disk_type>"
              }
            },
            "infra": {
              "resources": {
                "resource_preset_id": "<INFRA_host_class>",
                "disk_size": <storage_size_in_bytes>,
                "disk_type_id": "<disk_type>"
              }
            },
            "console_password": "<Sharded_PostgreSQL_console_password>",
            "log_level": "<logging_level>"
          },
          "backup_window_start": {
            "hours": <hours>,
            "minutes": <minutes>,
            "seconds": <seconds>,
            "nanos": <nanoseconds>
          },
          "backup_retain_period_days": <number_of_days>
        },
        "host_specs": [
          {
            "zone_id": "<availability_zone>",
            "subnet_id": "<subnet_ID>",
            "assign_public_ip": <allow_public_access_to_host>,
            "type": "<host_type>",
            "shard_name": "<shard_name>",
            "mdb_postgresql": {
              "cluster_id": "<{{ PG }}_cluster_ID>"
            }
          },
          { <similar_settings_for_host_2> },
          { ... },
          { <similar_settings_for_host_N> }
        ],
        "network_id": "<network_ID>",
        "folder_id": "<folder_ID>",
        "security_group_ids": [
          "<security_group_1_ID>",
          "<security_group_2_ID>",
          ...
          "<security_group_N_ID>"
        ],
        "deletion_protection": <protect_cluster_from_deletion>,
        "time": "<time_point_to_restore_to>",
        "time_inclusive": <restore_after_specified_time>
      }
      ```


      Where:

      * `backup_id`: Backup ID.
        
        You can get the backup ID with the [list of backups](#list-backups).

      * `name`: Cluster name.
      * `description`: Cluster description.
      * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
      * `config_spec.spqr_spec.router.resources`: Parameters of router host resources:
        
        * `resource_preset_id`: [Host class](../concepts/instance-types.md).
        * `disk_size`: Disk size, in bytes.
        * `disk_type_id`: [Disk type](../concepts/storage.md).
      
      * `config_spec.spqr_spec.coordinator.resources`: Parameters of coordinator host resources:
        
        * `resource_preset_id`: Host class.
        * `disk_size`: Disk size, in bytes.
        * `disk_type_id`: Disk type.
      
      * `config_spec.spqr_spec.infra.resources`: `INFRA` host resource parameters:
        
        * `resource_preset_id`: Host class.
        * `disk_size`: Disk size, in bytes.
        * `disk_type_id`: Disk type.
      
      * `config_spec.spqr_spec.console_password`: {{ SPQR }} console password.
      * `config_spec.spqr_spec.log_level`: Query logging level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, or `FATAL`.
      * `config_spec.backup_window_start`: Backup window settings.

        Here, specify the backup start time. Allowed values:

        * `hours`: Between `0` and `23` hours.
        * `minutes`: Between `0` and `59` minutes.
        * `seconds`: Between `0` and `59` seconds.
        * `nanos`: Between `0` and `999999999` nanoseconds.

      * `config_spec.backup_retain_period_days`: Retention period of automatic cluster backups. Possible values: between `7` and `60` days.
      * `host_specs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

        * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).

        
        * `subnet_id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
        * `assign_public_ip`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.


        * `type`: Host type. The possible values are:

          * `ROUTER`: Router in a cluster with advanced sharding.
          * `COORDINATOR`: Coordinator in a cluster with advanced sharding.
          * `INFRA`: `INFRA` host in a cluster with standard sharding.
        
        * `shard_name`: Shard name.
        * `mdb_postgresql.cluster_id`: {{ mpg-name }} cluster ID.
          
          You can get the {{ mpg-name }} cluster ID with the [list of clusters](../../managed-postgresql/operations/cluster-list.md#list-clusters) in the folder.

     * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be deployed in.
     * `folder_id`: Folder ID.

              
       You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
       
     
     
     * `security_group_ids`: [Security group](../../vpc/concepts/security-groups.md) IDs.

         {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}

     
     * `deletion_protection`: Cluster deletion protection, `true` or `false`.
     * `time`: Point in time to restore the cluster to, in `yyyy-mm-ddThh:mm:ssZ` format.
     * `time_inclusive`: Restore the cluster after the specified time, `true` or `false`.
  
  1. Call the [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.Restore \
       < body.json
     ```

  1. Check the [server response](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}** in the top-right corner of the page.
  1. Confirm the creation of a backup.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To create a cluster backup:

  1. See the description of the CLI command for creating a cluster backup:
  
      ```bash
      yc managed-sharded-postgresql cluster backup --help
      ```
  
  1. Create a cluster backup:

      ```bash
      yc managed-sharded-postgresql cluster backup <cluster_name_or_ID>
      ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Backup](../api-ref/Cluster/backup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>:backup'
      ```

  1. View the [server response](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService.Backup](../api-ref/grpc/Cluster/backup.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<cluster_ID>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.Backup
      ```

  1. Check the [server response](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of backups for a specific cluster:

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.

  To get a list of backups for all {{ mspqr-name }} clusters in a folder:

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To get a list of backups for a specific cluster:

  1. See the description of the CLI command for getting a list of cluster backups:
  
      ```bash
      yc managed-sharded-postgresql cluster list-backups --help
      ```
  
  1. Get a list of cluster backups:

      ```bash
      yc managed-sharded-postgresql cluster list-backups <cluster_name_or_ID>
      ```    

  To get a list of backups for all {{ mspqr-name }} clusters in a folder:

  1. See the description of the CLI command for getting a list of backups:
  
      ```bash
      yc managed-sharded-postgresql backup list --help
      ```
  
  1. Get a list of backups:

      ```bash
      yc managed-sharded-postgresql backup list
      ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. To get a list of backups for a specific cluster:

      1. Call the [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

          ```bash
          curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/backups'
          ```

      1. Check the [server response](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.spqr.v1.ListClusterBackupsResponse) to make sure your request was successful.

  1. To get a list of backups for all {{ mspqr-name }} clusters in a folder:

      1. Call the [Backup.List](../api-ref/Backup/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

          ```bash
          curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-spqr/v1/backups' \
            --url-query folderId=<folder_ID>
          ```

                 
          You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
       

      1. Check the [server response](../api-ref/Backup/list.md#yandex.cloud.mdb.spqr.v1.ListBackupsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. To get a list of backups for a specific cluster:
      
      1. Call the [ClusterService.ListBackups](../api-ref/grpc/Cluster/listBackups.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

          ```bash
          grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.spqr.v1.ClusterService.ListBackups
          ```

      1. Check the [server response](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.spqr.v1.ListClusterBackupsResponse) to make sure your request was successful.

  1. To get a list of backups for all {{ mspqr-name }} clusters in a folder:

      1. Call the [BackupService.List](../api-ref/grpc/Backup/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

          ```bash
          grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/backup_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "folder_id": "<folder_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.spqr.v1.BackupService.List
          ```

                 
          You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
       

      1. Check the [server response](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.spqr.v1.ListBackupsResponse) to make sure your request was successful.

{% endlist %}

## Getting backup details {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

  To get backup details for an existing cluster:

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.

  To get backup details for a deleted cluster:
  
  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To get details for a specific backup:

  1. See the description of the CLI command for getting backup details:
  
      ```bash
      yc managed-sharded-postgresql backup get --help
      ```
  
  1. Get backup details:

      ```bash
      yc managed-sharded-postgresql backup get <backup_ID>
      ```
      
      You can get the backup ID with the [list of backups](#list-backups).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Backup.Get](../api-ref/Backup/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/backups/<backup_ID>'
      ```

      You can get the backup ID with the [list of backups](#list-backups).
  
  1. Check the [server response](../api-ref/Backup/get.md#yandex.cloud.mdb.spqr.v1.Backup) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [BackupService.Get](../api-ref/grpc/Backup/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/backup_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "backup_id": "<backup_ID>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.BackupService.Get
      ```

      You can get the backup ID with the [list of backups](#list-backups).

  1. Check the [server response](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.spqr.v1.Backup) to make sure your request was successful.
  
{% endlist %}

## Setting the backup start time {#set-backup-window}

{% list tabs group=instructions %}

- Management console {#console}

  In the management console, you can set the backup start time when [creating](cluster-create.md) or [updating a cluster](cluster-update.md).

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To set the backup start time:

  1. View the description of the CLI command for updating a cluster:
  
      ```bash
      yc managed-sharded-postgresql cluster update --help
      ```
  
  1. Set the backup start time:

      ```bash
      yc managed-sharded-postgresql cluster update <cluster_name_or_ID> \
        --backup-window-start <backup_start_time>
      ```

      Where `--backup-window-start` is the daily backup start time (UTC) in `HH:MM:SS` format.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "updateMask": "configSpec.backupWindowStart",
        "configSpec": {
          "backupWindowStart": {
            "hours": <hours>,
            "minutes": <minutes>,
            "seconds": <seconds>,
            "nanos": <nanoseconds>
          }
        }
      }
      ```

      Where:

      * `updateMask`: Comma-separated string of settings to update.

        In this example, only the `configSpec.backupWindowStart` setting is provided.

        {% note warning %}

        When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

        {% endnote %}

      * `configSpec.backupWindowStart`: Backup window settings.

        Here, specify the backup start time. Allowed values:

        * `hours`: Between `0` and `23` hours.
        * `minutes`: Between `0` and `59` minutes.
        * `seconds`: Between `0` and `59` seconds.
        * `nanos`: Between `0` and `999999999` nanoseconds.

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>' \
        --data "@body.json"
      ```

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "update_mask": {
          "paths": [
            "config_spec.backup_window_start"
          ]
        },
        "config_spec": {
          "backup_window_start": {
            "hours": <hours>,
            "minutes": <minutes>,
            "seconds": <seconds>,
            "nanos": <nanoseconds>
          }
        }
      }
      ```

      Where:

      * `update_mask`: List of settings to update as an array of strings (`paths[]`).

        {% cut "Format for listing settings" %}

        ```yaml
        "update_mask": {
          "paths": [
            "<setting_1>",
            "<setting_2>",
            ...
            "<setting_N>"
          ]
        }
        ```

        {% endcut %}

        In this example, only the `config_spec.backup_window_start` setting is provided.

        {% note warning %}

        When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

        {% endnote %}
    
      * `config_spec.backup_window_start`: Backup window settings.

        Here, specify the backup start time. Allowed values:

        * `hours`: Between `0` and `23` hours.
        * `minutes`: Between `0` and `59` minutes.
        * `seconds`: Between `0` and `59` seconds.
        * `nanos`: Between `0` and `999999999` nanoseconds.

  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.Update \
        < body.json
      ```

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Setting a retention period for automatic backups {#set-backup-retain}

{% list tabs group=instructions %}

- Management console {#console}

  You can set the retention period for automatic backups when you [create](cluster-create.md) or [update](cluster-update.md) the cluster via the management console.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To set a retention period for automatic backups:

  1. View the description of the CLI command for updating a cluster:
  
      ```bash
      yc managed-sharded-postgresql cluster update --help
      ```
  
  1. Set a retention period for automatic backups:

      ```bash
      yc managed-sharded-postgresql cluster update <cluster_name_or_ID> \
        --backup-retain-period-days <number_of_days>
      ```

      Where `--backup-retain-period-days` is the retention period of automatic cluster backups. Possible values: between `7` and `60` days. The default value is `7`.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "updateMask": "configSpec.backupRetainPeriodDays",
        "configSpec": {
          "backupRetainPeriodDays": "<number_of_days>"
        }
      }
      ```

      Where:

      * `updateMask`: Comma-separated string of settings to update.

        In this example, only the `configSpec.backupRetainPeriodDays` setting is provided.

        {% note warning %}

        When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

        {% endnote %}

      * `backupRetainPeriodDays`: Retention period of automatic cluster backups. Possible values: between `7` and `60` days. The default value is `7`.

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>' \
        --data "@body.json"
      ```

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "update_mask": {
          "paths": [
            "config_spec.backup_retain_period_days"
          ]
        },
        "config_spec": {
          "backup_retain_period_days": <number_of_days>
        }
      }
      ```

      Where:

      * `update_mask`: List of settings to update as an array of strings (`paths[]`).

        {% cut "Format for listing settings" %}

        ```yaml
        "update_mask": {
          "paths": [
            "<setting_1>",
            "<setting_2>",
            ...
            "<setting_N>"
          ]
        }
        ```

        {% endcut %}

        In this example, only the `config_spec.backup_retain_period_days` setting is provided.

        {% note warning %}

        When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

        {% endnote %}

      * `config_spec.backup_retain_period_days`: Retention period of automatic cluster backups. Possible values: between `7` and `60` days. The default value is `7`.

  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.ClusterService.Update \
        < body.json
      ```

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Deleting a backup {#delete}

You can only delete manual backups.

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the backup you want to delete and select **{{ ui-key.yacloud.mdb.cluster.backups.button_delete }}**.
  1. Confirm deleting the backup.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To delete a backup:

  1. View a description of the CLI delete backup command:
  
      ```bash
      yc managed-sharded-postgresql backup delete --help
      ```
  
  1. Delete the backup:

      ```bash
      yc managed-sharded-postgresql backup delete <backup_ID>
      ```
      
      You can get the backup ID with the [list of backups](#list-backups).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Backup.Delete](../api-ref/Backup/delete.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request DELETE \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-spqr/v1/backups/<backup_ID>'
      ```

      You can get the backup ID with the [list of backups](#list-backups).

  1. Check the [server response](../api-ref/Backup/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [BackupService.Delete](../api-ref/grpc/Backup/delete.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/backup_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "backup_id": "<backup_ID>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.spqr.v1.BackupService.Delete
      ```

      You can get the backup ID with the [list of backups](#list-backups).

  1. Check the [server response](../api-ref/grpc/Backup/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}