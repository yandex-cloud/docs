---
title: Managing MongoDB backups
description: You can create backups and restore clusters from existing MongoDB backups. The Point-in-Time Recovery (PITR) technology enables you to restore cluster state to any point in time starting with the moment a backup was created.
---

# Managing backups in {{ mmg-name }}

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

{{ mmg-name }} also creates automatic daily backups. You can [set the backup start time and retention period](update.md#change-additional-settings).

## Restoring a cluster from a backup {#restore}

The Point-in-Time Recovery (PITR) technology allows you to restore your cluster to any state in the time interval between the oldest backup and the archiving of the most recent [oplog](https://www.mongodb.com/docs/manual/core/replica-set-oplog/) collection. For more information, see [Backups](../concepts/backup.md).

For example, if the backup operation ended on August 10, 2020 at 12:00:00 UTC, the current date is August 15, 2020, 19:00:00 UTC, and the most recent oplog collection was saved on August 15, 2020, 18:50:00 UTC, the cluster can be restored to any state between August 10, 2020, 12:00:01 UTC and August 15, 2020, 18:50:00 UTC, inclusive.

{% note warning %}

PITR is not supported for clusters with [sharding](../tutorials/sharding.md) enabled. Such clusters can only be restored to the time point of the selected backup.

{% endnote %}

When you restore a cluster from a backup, you create a new cluster with the backup data. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average backup recovery speed is 10 MBps.

For a new cluster, you should set all the parameters required during creation, except for cluster type (a {{ MG }} backup cannot be restored as a {{ PG }} cluster).

When restored to the current state, the new cluster will match the state of:

* Existing cluster at the time of recovery.
* Deleted cluster at the time of archiving the last oplog.


Before you begin, [assign](../../iam/operations/roles/grant.md) the [{{ roles.mmg.editor }}](../../iam/roles-reference.md#managed-mongodb-editor) role or higher to your {{ yandex-cloud }} account for the backup folder and the new cluster folder.


{% list tabs group=instructions %}

- Management console {#console}

  To restore an existing cluster from a backup:

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.

  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.

  1. To restore the cluster to a particular point in time after creating this backup, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly. You can enter the date manually or select it from the drop-down calendar.

      If you do not change the setting, the cluster will be restored to the state it was in when the backup was completed.

  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  To restore a previously deleted cluster from a backup:

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs formatted as `<cluster_ID>:<backup_ID>`.

  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  1. Set up the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.

  1. To restore the cluster to a particular point in time after creating this backup, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly. You can enter the date manually or select it from the drop-down calendar.

      If you do not change the setting, the cluster will be restored to the state it was in when the backup was completed.

  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mmg-name }} will launch the operation to create a cluster from the backup.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore a cluster from a backup:

  1. View a description of the CLI restore {{ MG }} cluster command:

      ```bash
      {{ yc-mdb-mg }} cluster restore --help
      ```

  1. Getting a list of available {{ MG }} cluster backups:

     ```bash
     {{ yc-mdb-mg }} backup list
     ```

     Result:

     ```text
     +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
     |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |  SIZE  |   TYPE    |
     +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
     | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 | 3.3 KB | AUTOMATED |
     | ...                                                                                         |                    |
     +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
     ```

     The backup completion time is shown in the `CREATED AT` column of the list of available backups, in `yyyy-mm-dd hh:mm:ss` format (`2020-08-10 12:00:00` in the example above). You can restore a cluster to any point in time starting with the point when the backup is created.

  1. Run the command to create a new cluster from a backup (the example shows only some parameters):

     
     ```bash
      {{ yc-mdb-mg }} cluster restore \
         --backup-id <backup_ID> \
         --recovery-target-timestamp <time_point> \
         --mongodb-version <{{ MG }}_version> \
         --name <new_cluster_name> \
         --environment <environment> \
         --network-name <network_name> \
         --host zone-id=<availability_zone>,`
               `subnet-id=<subnet_ID> \
         --mongod-resource-preset <host_class> \
         --mongod-disk-size <storage_size_in_GB> \
         --mongod-disk-type <disk_type> \
         --performance-diagnostics=<enable_diagnostics>
      ```


      Where:

      * `--recovery-target-timestamp`: Time point to restore the {{ MG }} cluster to, in [UNIX time](https://en.wikipedia.org/wiki/Unix_time) format. If you omit this parameter, the cluster state will be restored to the backup completion time.
      * `--environment`: Environment, `PRESTABLE` or `PRODUCTION`.

      
      * `--mongod-disk-type`: Disk type, `network-hdd`, `network-ssd`, or `network-ssd-io-m3`.


      * `--performance-diagnostics`: Enables cluster performance diagnostics, `true` or `false`.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and add the following contents to it:

        ```json
        {
          "folderId": "<folder_ID>",
          "backupId": "<backup_ID>",
          "name": "<new_cluster_name>",
          "environment": "<environment>",
          "networkId": "<network_ID>",
          "recoveryTargetSpec": {
            "timestamp": "<time>"
          },
          "configSpec": {
            "version": "<{{ MG }}_version>",
            "mongodb": {
              "<{{ MG }}_host_type>": {
                "resources": {
                  "resourcePresetId": "<host_class>",
                  "diskSize": "<storage_size_in_bytes>",
                  "diskTypeId": "<disk_type>"
                }
              }
            }
          },
          "hostSpecs": [
            {
              "zoneId": "<availability_zone>",
              "subnetId": "<subnet_ID>",
              "assignPublicIp": <public_host_address:_true_or_false>,
              "type": "<host_type>",
              "shardName": "<shard_name>",
              "hidden": <host_visibility:_true_or_false>,
              "secondaryDelaySecs": "<lag_in_seconds>",
              "priority": "<host_priority_for_assignment_as_master>",
              "tags": "<host_labels>"
            }
          ]
        }
        ```

        Where:

        * `folderId`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `backupId`: Backup ID. To find out the ID, [get a list of folder backups](#list-backups).
        * `name`: Name of the new cluster.
        * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
        * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be in.
        * `recoveryTargetSpec.timestamp`: Time point to restore the {{ MG }} cluster to, in [UNIX time](https://en.wikipedia.org/wiki/Unix_time) format. If you omit this parameter, the cluster state will be restored to the backup completion time.

        * `configSpec`: Cluster settings:

          * `version`: {{ MG }} version: 5.0, 6.0, or 7.0.
          * {{ MG }} host type depends on the [sharding type](../concepts/sharding.md). Possible values: `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.
            
            * `resources`: Cluster resources:

              * `resourcePresetId`: [Host class](../concepts/instance-types.md).
              * `diskSize`: Disk size in bytes.
              * `diskTypeId`: [Disk type](../concepts/storage.md).

        * `hostSpecs`: Cluster host settings as an array of elements, one for each host. Each element has the following structure:

          * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp`: Internet access to the host via a public IP address.
          * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. For a non-sharded cluster, use `MONGOD`.
          * `shardName`: Shard name in a sharded cluster.
          * `hidden`: Host will be visible or hidden.
          * `secondaryDelaySecs`: Host's lag behind the master.
          * `priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
          * `tags`: Host labels.

    1. Use the [Cluster.Restore](../api-ref/Cluster/restore.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters:restore' \
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
          "folder_id": "<folder_ID>",
          "backup_id": "<backup_ID>",
          "name": "<new_cluster_name>",
          "environment": "<environment>",
          "network_id": "<network_ID>",
          "recovery_target_spec": {
            "timestamp": "<time>"
          },
          "config_spec": {
            "version": "<{{ MG }}_version>",
            "mongodb": {
              "<{{ MG }}_host_type>": {
                "resources": {
                  "resource_preset_id": "<host_class>",
                  "disk_size": "<storage_size_in_bytes>",
                  "disk_type_id": "<disk_type>"
                }
              }
            }
          },
          "host_specs": [
            {
              "zone_id": "<availability_zone>",
              "subnet_id": "<subnet_ID>",
              "assign_public_ip": <public_host_address:_true_or_false>,
              "type": "<host_type>",
              "shard_name": "<shard_name>",
              "hidden": <host_visibility:_true_or_false>,
              "secondary_delay_secs": "<lag_in_seconds>",
              "priority": "<host_priority_for_assignment_as_master>",
              "tags": "<host_labels>"
            }
          ]
        }
        ```

        Where:

        * `folder_id`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `backup_id`: Backup ID. To find out the ID, [get a list of folder backups](#list-backups).
        * `name`: Name of the new cluster.
        * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
        * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be in.
        * `recovery_target_spec.timestamp`: Time point to restore the {{ MG }} cluster to, in [UNIX time](https://en.wikipedia.org/wiki/Unix_time) format. If you omit this parameter, the cluster state will be restored to the backup completion time.

        * `config_spec`: Cluster settings:

          * `version`: {{ MG }} version: 5.0, 6.0, or 7.0.
          * {{ MG }} host type depends on the [sharding type](../concepts/sharding.md). Possible values: `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.
            
            * `resources`: Cluster resources:
            
              * `resource_preset_id`: [Host class](../concepts/instance-types.md).
              * `disk_size`: Disk size in bytes.
              * `disk_type_id`: [Disk type](../concepts/storage.md).

        * `host_specs`: Cluster host settings as an array of elements, one for each host. Each element has the following structure:

          * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assign_public_ip`: Internet access to the host via a public IP address.
          * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. For a non-sharded cluster, use `MONGOD`.
          * `shard_name`: Shard name in a sharded cluster.
          * `hidden`: The host will either be visible or hidden.
          * `secondary_delay_secs`: Host's lag behind the master.
          * `priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
          * `tags`: Host labels.

    1. Use the [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md#yandex.cloud.mdb.mongodb.v1.HostSpec) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.Restore \
            < body.json
        ```

  1. View the [server response](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure the request was successful.
          

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster backup:

  1. View a description of the CLI create {{ MG }} backup command:

      ```bash
      {{ yc-mdb-mg }} cluster backup --help
      ```

  1. Request a backup to be created by specifying the cluster name or ID:

      ```bash
      {{ yc-mdb-mg }} cluster backup <cluster_name_or_ID>
      ```

      You can get the cluster ID and name with the [list of clusters](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Backup](../api-ref/Cluster/backup.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>:backup'
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

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
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Backup
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of cluster backups:

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.

  To get a list of all backups in a folder:

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  These lists contain the following information:

  * Backup name.
  * Source shard.
  * Backup size.
  * Backup type: Automatic (`Automated`) or manual (`Manual`).
  * Start time of backup creation in UTC (Coordinated Universal Time).
  * End time of backup creation in UTC.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ MG }} cluster backups available in the default folder, run this command:

  ```bash
  {{ yc-mdb-mg }} backup list
  ```

  Result:

  ```text
  +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
  |            ID            |     CREATED AT      |  SOURCE CLUSTER ID   |     STARTED AT      |  SIZE  |   TYPE    |
  +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
  | c9qlk4v13uq7********:... | 2020-08-10 12:00:00 | c9qlk4v13uq7******** | 2020-08-10 11:55:17 | 3.3 KB | AUTOMATED |
  | c9qpm90p3pcg********:... | 2020-08-09 22:01:04 | c9qpm90p3pcg******** | 2020-08-09 21:30:00 | 30 KB  | MANUAL    |
  +--------------------------+---------------------+----------------------+---------------------+--------+-----------+
  ```

  The resulting table contains the following information:
  * ID of the backup.
  * End time of backup creation in UTC (Coordinated Universal Time).
  * ID of the cluster that the backup was created for.
  * Start time of backup creation in UTC.
  * Backup size.
  * Backup type: Automatic (`AUTOMATED`) or manual (`MANUAL`).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. To get a list of cluster backups:

     1. Use the [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
           --request GET \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/backups'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

     1. View the [server response](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsResponse) to make sure the request was successful.

  1. To get a list of backups for all the clusters in a folder:

     1. Use the [Backup.List](../api-ref/Backup/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
           --request GET \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/backups'
           --url-query folderId=<folder_ID>
        ```

        
        You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


     1. View the [server response](../api-ref/Backup/list.md#yandex.cloud.mdb.mongodb.v1.ListBackupsResponse) to make sure the request was successful.

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
              -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d '{
                    "cluster_id": "<cluster_ID>"
                  }' \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.mongodb.v1.ClusterService.ListBackups
          ```

          You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

      1. View the [server response](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsResponse) to make sure the request was successful.

  1. To get a list of backups for all the clusters in a folder:

      1. Use the [BackupService.List](../api-ref/grpc/Backup/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

          ```bash
          grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/backup_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d '{
                    "folder_id": "<folder_ID>"
                  }' \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.mongodb.v1.BackupService.List
          ```

          
          You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


      1. View the [server response](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.mongodb.v1.ListBackupsResponse) to make sure the request was successful.


{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

  To get information about the backup of an existing cluster:
  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.

  To get information about the backup of a previously deleted cluster:
  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ MG }} cluster backup, run this command:

  ```bash
  {{ yc-mdb-mg }} backup get <backup_ID>
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
        --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/backups/<backup_ID>'
     ```

     You can request the backup ID together with the [list of backups](#list-backups).

  1. View the [server response](../api-ref/Backup/get.md#yandex.cloud.mdb.mongodb.v1.Backup) to make sure the request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/backup_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "backup_id": "<backup_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.BackupService.Get
     ```

     You can request the backup ID together with the [list of backups](#list-backups).

  1. View the [server response](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.mongodb.v1.Backup) to make sure the request was successful.

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
    {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
       --backup-retain-period-days=<retention_period_in_days>
    ```

  The possible values range from `7` to `35`. The default value is `7`.

  You can request the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ MG }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

    1. Add a `backup_retain_period_days` block in the `cluster_config` section to the {{ MG }} cluster description:

        ```hcl
          resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
            ...
            cluster_config {
              ...
              backup_retain_period_days = <retention_period_in_days>
              }
              ...
            }
            ...
        ```

       Where `backup_retain_period_days` is the automatic backup retention period. 
       
       The possible values range from `7` to `35`. The default value is `7`.

  1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

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
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "configSpec.backupRetainPeriodDays",
                    "configSpec": {
                      "backupRetainPeriodDays": <backup_retention_in_days>
                    }
                  }'
      ```

      Where:

      * `updateMask`: List of parameters to update as a single string, separated by commas.

          Only one parameter is provided in this case.

      * `configSpec.backupRetainPeriodDays`: Automatic backup retention period, in days.

          The values range from `7` to `35`. The default value is `7`.

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
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "update_mask": {
                  "paths": [
                    "config_spec.backup_retain_period_days"
                  ]
                },
                "config_spec": {
                  "backup_retain_period_days": <backup_retention_in_days>
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.

          Only one parameter is provided in this case.

      * `config_spec.backup_retain_period_days`: Automatic backup retention period, in days.

          The values range from `7` to `35`. The default value is `7`.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.mongodb.v1.Cluster) to make sure the request was successful.

{% endlist %}         

## Examples {#examples}

Create a new {{ mmg-name }} cluster from a backup with the following test characteristics:


* Recovery backup: `c9qlk4v13uq7********:...`.
* Time point to recover to: `1597060810` (`2020-08-10 12:00:10`).
* Version: `6.0`.
* Name of the new cluster: `mynewmg`.
* Environment: `PRODUCTION`.
* Network: `{{ network-name }}`.
* One `{{ host-class }}` host in the `{{ region-id }}-a` availability zone and `b0rcctk2rvtr********` subnet.
* Network SSD storage (`{{ disk-type-example }}`): 20 GB.
* With databases and users that existed in the cluster at the time of recovery.


{% list tabs group=instructions %}

- CLI {#cli}

  Run this command:

  
  ```bash
  {{ yc-mdb-mg }} cluster restore \
     --backup-id c9qlk4v13uq7********:... \
     --recovery-target-timestamp 1597060810 \
     --mongodb-version 6.0 \
     --name mynewmg \
     --environment PRODUCTION \
     --network-name {{ network-name }} \
     --host {{ host-net-example }} \
     --mongod-resource-preset {{ host-class }} \
     --mongod-disk-size 20 \
     --mongod-disk-type {{ disk-type-example }}
  ```


{% endlist %}
