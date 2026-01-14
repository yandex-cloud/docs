---
title: Managing {{ SD }} backups
description: You can create backups and use existing backups to restore {{ SD }} clusters. Point-in-time recovery, or PITR, enables you to restore your cluster to the state it was in at any point in time after the backup was created.
---

# Managing backups in {{ mmg-name }}

You can create [backups](../concepts/backup.md) and use existing backups to restore clusters.

{{ mmg-name }} also creates an automatic daily backup. You can [set the backup start time and retention period](update.md#change-additional-settings).

## Restoring a cluster from a backup {#restore}

The Point-in-Time Recovery (PITR) technology allows you to restore your cluster to any state in the time interval between the oldest backup and the archiving of the most recent oplog collection. For more information, see [Backups](../concepts/backup.md).

For example, if the backup operation ended on August 10, 2020 at 12:00:00 UTC, the current date is August 15, 2020, 19:00:00 UTC, and the most recent oplog collection was saved on August 15, 2020, 18:50:00 UTC, the cluster can be restored to any state between August 10, 2020, 12:00:01 UTC and August 15, 2020, 18:50:00 UTC, inclusive.

{% note warning %}

PITR is not supported for clusters with [sharding](../tutorials/sharding.md) enabled. Such clusters can only be restored to the time point of the selected backup.

{% endnote %}

When you restore a cluster from a backup, you create a new cluster with the backup data. If your folder lacks resources to create such a cluster, you will not be able to restore your data from the backup. The average backup restore speed is 10 MBps.

For a new cluster, you should set all the parameters required during creation, except for cluster type (a {{ SD }} backup cannot be restored as a {{ PG }} cluster).

When restored to the current point in time, the new cluster will reflect the state of:

* Existing cluster at the time of recovery.
* Deleted cluster at the time of archiving the last oplog.


Before you begin, [assign](../../iam/operations/roles/grant.md) to your {{ yandex-cloud }} account the [managed-mongodb.restorer](../../iam/roles-reference.md#managed-mongodb-restorer) role or higher for the backup folder and the new cluster folder.


{% list tabs group=instructions %}

- Management console {#console}

  To restore an existing cluster from a backup:

  1. Go to the [folder]({{ link-console-main }}) page.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.

  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

      To recover a sharded cluster, use a [sharded backup](../concepts/backup.md#size). Such backups are larger in size.

  1. Configure the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.

  1. To restore the cluster state to a specific point in time after the backup was created, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly. You can either enter the date manually or select it from the drop-down calendar.

      If you leave this setting as is, the cluster will be restored to the state it had when the backup was completed.

  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  To restore a previously deleted cluster from a backup:

  1. Go to the [folder]({{ link-console-main }}) page.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  1. Find the backup you need using the backup creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs in `<cluster_ID>:<backup_ID>` format.

      If you want to recover a sharded cluster, find its [sharded backup](../concepts/backup.md#size). Such backups are larger in size.

  1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the backup you need and then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  1. Configure the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.

  1. To restore the cluster state to a specific point in time after the backup was created, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly. You can either enter the date manually or select it from the drop-down calendar.

      If you leave this setting as is, the cluster will be restored to the state it had when the backup was completed.

  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  {{ mmg-name }} will start creating the cluster from the backup.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore a cluster from a backup:

  1. View the description of the CLI command for restoring a {{ SD }} cluster:

      ```bash
      {{ yc-mdb-mg }} cluster restore --help
      ```

  1. Get the list of available {{ SD }} cluster backups:

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

     The `CREATED AT` column in the list of available backups shows the backup completion time in `yyyy-mm-dd hh:mm:ss` format (`2020-08-10 12:00:00` in the example above). You can restore your cluster to the state it was in at any point in time after the backup was created.

  1. Run the command to create a new cluster from a backup. The examples below do not include all parameters.

      
      For a non-sharded cluster:

      ```bash
      {{ yc-mdb-mg }} cluster restore \
         --backup-id <backup_ID> \
         --recovery-target-timestamp <time_point> \
         --mongodb-version <Yandex_StoreDoc_version> \
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

      For a sharded cluster:

      ```bash
      {{ yc-mdb-mg }} cluster restore \
         --backup-id <backup_ID> \
         --recovery-target-timestamp <time_point> \
         --mongodb-version <Yandex_StoreDoc_version> \
         --name <new_cluster_name> \
         --environment <environment> \
         --network-name <network_name> \
         --host zone-id=<availability_zone>,`
               `subnet-id=<subnet_ID>,`
               `type=mongod,`
               `shard-name=<shard_name> \
         --mongod-resource-preset <host_class> \
         --mongod-disk-size <storage_size_in_GB> \
         --mongod-disk-type <disk_type> \
         --host zone-id=<availability_zone>,`
               `subnet-id=<subnet_ID>,`
               `type=<host_type> \
         ...
         --host zone-id=<availability_zone>,`
               `subnet-id=<subnet_ID>,`
               `type=<host_type> \
         --<host_type>-resource-preset <host_class> \
         --<host_type>-disk-size <storage_size_in_GB> \
         --<host_type>-disk-type <disk_type> \
         --performance-diagnostics=<enable_diagnostics>
      ```


      Where:

      * `--backup-id`: Backup ID. To recover a sharded cluster, specify the [sharded backup](../concepts/backup.md#size) ID. Such backups are larger in size. To find out the ID, [get the list of backups in the folder](#list-backups).

      * `--recovery-target-timestamp`: Time point to restore the {{ SD }} cluster to, in [UNIX time](https://en.wikipedia.org/wiki/Unix_time) format. If you omit this parameter, the cluster state will be restored to the backup completion time.
      * `--environment`: Environment, `PRESTABLE` or `PRODUCTION`.

      
      * `--mongod-disk-type`: Disk type, `network-hdd`, `network-ssd`, or `network-ssd-io-m3`.


      * `--<host_type>-resource-preset`, `--<host_type>-disk-size`, `--<host_type>-disk-type`: Host parameters that manage sharding in the cluster. The possible `<host_type>` values are `mongoinfra`, `mongocfg`, or `mongos`.

      * `--performance-diagnostics`: Enables cluster performance diagnostics, `true` or `false`.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

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
            "version": "<Yandex_StoreDoc_version>",
            "mongodb": {
              "<Yandex_StoreDoc_host_type>": {
                "resources": {
                  "resourcePresetId": "<host_class>",
                  "diskSize": "<storage_size_in_bytes>",
                  "diskTypeId": "<disk_type>"
                }
              },
              ...
              "<Yandex_StoreDoc_host_type>": {
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
              "assignPublicIp": <allow_public_access_to_host>,
              "type": "<host_type>",
              "shardName": "<shard_name>",
              "hidden": <hide_host>,
              "secondaryDelaySecs": "<lag_in_seconds>",
              "priority": "<host_priority_for_assignment_as_master>",
              "tags": "<host_labels>"
            }
          ]
        }
        ```

        Where:

        * `folderId`: Folder ID. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `backupId`: Backup ID. To recover a sharded cluster, specify the [sharded backup](../concepts/backup.md#size) ID. Such backups are larger in size. To find out the ID, [get the list of backups in the folder](#list-backups).
        * `name`: Name of the new cluster.
        * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
        * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) where the cluster will be deployed.
        * `recoveryTargetSpec.timestamp`: Time point to restore the {{ SD }} cluster to, in [UNIX time](https://en.wikipedia.org/wiki/Unix_time) format. If you omit this parameter, the cluster state will be restored to the backup completion time.

        * `configSpec`: Cluster settings:

          * `version`: {{ SD }} version, 5.0, 6.0, or 7.0.
          * {{ SD }} host type depends on the [sharding type](../concepts/sharding.md). Possible values: `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.
            
            * `resources`: Cluster resources:

              * `resourcePresetId`: [Host class](../concepts/instance-types.md).
              * `diskSize`: Disk size, in bytes.
              * `diskTypeId`: [Disk type](../concepts/storage.md).

        * `hostSpecs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

          * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
          * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. For a non-sharded cluster, use `MONGOD`.
          * `shardName`: Shard name in a sharded cluster.
          * `hidden`: The host will either be visible (`false`) or hidden (`true`).
          * `secondaryDelaySecs`: Host's lag behind the master.
          * `priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
          * `tags`: Host labels.

    1. Call the [Cluster.Restore](../api-ref/Cluster/restore.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters:restore' \
            --data "@body.json"
        ```

    1. View the [server response](../api-ref/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and paste the following code into it:

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
            "version": "<Yandex_StoreDoc_version>",
            "mongodb": {
              "<Yandex_StoreDoc_host_type>": {
                "resources": {
                  "resource_preset_id": "<host_class>",
                  "disk_size": "<storage_size_in_bytes>",
                  "disk_type_id": "<disk_type>"
                }
              },
              ...
              "<Yandex_StoreDoc_host_type>": {
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
              "assign_public_ip": <allow_public_access_to_host>,
              "type": "<host_type>",
              "shard_name": "<shard_name>",
              "hidden": <hide_host>,
              "secondary_delay_secs": "<lag_in_seconds>",
              "priority": "<host_priority_for_assignment_as_master>",
              "tags": "<host_labels>"
            }
          ]
        }
        ```

        Where:

        * `folder_id`: Folder ID. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `backup_id`: Backup ID. To recover a sharded cluster, specify the [sharded backup](../concepts/backup.md#size) ID. Such backups are larger in size. To find out the ID, [get the list of backups in the folder](#list-backups).
        * `name`: Name of the new cluster.
        * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
        * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) where the cluster will be deployed.
        * `recovery_target_spec.timestamp`: Time point to restore the {{ SD }} cluster to, in [UNIX time](https://en.wikipedia.org/wiki/Unix_time) format. If you omit this parameter, the cluster state will be restored to the backup completion time.

        * `config_spec`: Cluster settings:

          * `version`: {{ SD }} version, 5.0, 6.0, or 7.0.
          * {{ SD }} host type depends on the [sharding type](../concepts/sharding.md). Possible values: `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.
            
            * `resources`: Cluster resources:
            
              * `resource_preset_id`: [Host class](../concepts/instance-types.md).
              * `disk_size`: Disk size, in bytes.
              * `disk_type_id`: [Disk type](../concepts/storage.md).

        * `host_specs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

          * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
          * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. For a non-sharded cluster, use `MONGOD`.
          * `shard_name`: Shard name in a sharded cluster.
          * `hidden`: The host will either be visible (`false`) or hidden (`true`).
          * `secondary_delay_secs`: Host's lag behind the master.
          * `priority`: Host priority for promotion to master if the [primary master fails](../concepts/replication.md#master-failover).
          * `tags`: Host labels.

    1. Call the [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md#yandex.cloud.mdb.mongodb.v1.HostSpec) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

  1. Check the [server response](../api-ref/grpc/Cluster/restore.md#yandex.cloud.operation.Operation) to make sure your request was successful.
          

{% endlist %}

## Creating a backup {#create-backup}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder]({{ link-console-main }}) page.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.backups.button_create }}**.

  {% include [no-prompt](../../_includes/mdb/backups/no-prompt.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster backup:

  1. View the description of the CLI command for creating a {{ SD }} backup:

      ```bash
      {{ yc-mdb-mg }} cluster backup --help
      ```

  1. Send the following request to create a backup, specifying the cluster ID or name:

      ```bash
      {{ yc-mdb-mg }} cluster backup <cluster_name_or_ID>
      ```

      You can get the cluster ID and name with the [list of clusters](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Backup](../api-ref/Cluster/backup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>:backup'
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

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
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Backup
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [backup-warning](../../_includes/mdb/backups/backup-create-warning.md) %}

## Getting a list of backups {#list-backups}

{% list tabs group=instructions %}

- Management console {#console}

  To get a list of cluster backups:

  1. Go to the [folder]({{ link-console-main }}) page.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.

  To get a list of all backups in a folder:

  1. Go to the [folder]({{ link-console-main }}) page.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  These lists contain the following information:

  * Backup name.
  * Source shard.
  * Backup size.
  * Backup type: `Automated` or `Manual`.
  * Backup start time (UTC).
  * Backup end time (UTC).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ SD }} cluster backups available in the default folder, run this command:

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

  The table in the command output contains the following information:
  * Backup ID.
  * Backup end time (UTC).
  * ID of the backed up cluster.
  * Start time of backup creation in UTC.
  * Backup size.
  * Backup type: `AUTOMATED` or `MANUAL`.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. To get a list of cluster backups:

     1. Call the [Cluster.ListBackups](../api-ref/Cluster/listBackups.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
           --request GET \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/backups'
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

     1. Check the [server response](../api-ref/Cluster/listBackups.md#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsResponse) to make sure your request was successful.

  1. To get a list of backups for all clusters in a folder:

     1. Call the [Backup.List](../api-ref/Backup/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
           --request GET \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/backups'
           --url-query folderId=<folder_ID>
        ```

        
        You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


     1. Check the [server response](../api-ref/Backup/list.md#yandex.cloud.mdb.mongodb.v1.ListBackupsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. To get a list of cluster backups:

      1. Call the [ClusterService.ListBackups](../api-ref/grpc/Cluster/listBackups.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

          You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

      1. Check the [server response](../api-ref/grpc/Cluster/listBackups.md#yandex.cloud.mdb.mongodb.v1.ListClusterBackupsResponse) to make sure your request was successful.

  1. To get a list of backups for all clusters in a folder:

      1. Call the [BackupService.List](../api-ref/grpc/Backup/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

          
          You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


      1. Check the [server response](../api-ref/grpc/Backup/list.md#yandex.cloud.mdb.mongodb.v1.ListBackupsResponse) to make sure your request was successful.


{% endlist %}

## Getting backup information {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

  To get information about a backup of an existing cluster:
  1. Go to the [folder]({{ link-console-main }}) page.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.

  To get information about a backup of a previously deleted cluster:
  1. Go to the [folder]({{ link-console-main }}) page.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ SD }} cluster backup, run this command:

  ```bash
  {{ yc-mdb-mg }} backup get <backup_ID>
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
        --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/backups/<backup_ID>'
     ```

     You can get the backup ID with the [list of backups](#list-backups).

  1. Check the [server response](../api-ref/Backup/get.md#yandex.cloud.mdb.mongodb.v1.Backup) to make sure your request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/backup_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "backup_id": "<backup_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mongodb.v1.BackupService.Get
     ```

     You can get the backup ID with the [list of backups](#list-backups).

  1. View the [server response](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.mongodb.v1.Backup) to make sure your request was successful.

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
    {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
       --backup-retain-period-days=<retention_period_in_days>
    ```

  The valid values range from `7` to `35`. The default value is `7`.

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

        For a complete list of configurable {{ SD }} cluster fields, refer to the [{{ TF }} provider guides]({{ tf-provider-mmg }}).

    1. Add the `backup_retain_period_days` block to the `cluster_config` section of the {{ SD }} cluster description:

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
       
       The valid values range from `7` to `35`. The default value is `7`.

  1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

      * `updateMask`: Comma-separated string of settings you want to update.

          Here, we provide only one setting.

      * `configSpec.backupRetainPeriodDays`: Automatic backup retention period, in days.

          The valid values range from `7` to `35`. The default value is `7`.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  
  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

          Here, we provide only one setting.

      * `config_spec.backup_retain_period_days`: Automatic backup retention period, in days.

          The valid values range from `7` to `35`. The default value is `7`.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.mongodb.v1.Cluster) to make sure your request was successful.

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
