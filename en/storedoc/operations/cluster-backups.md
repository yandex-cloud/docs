---
title: Managing {{ SD }} backups
description: You can back up {{ SD }} clusters and restore them from existing backups. Point-in-time recovery, or PITR, enables you to restore a cluster’s state to any point in time since the backup was created.
---

# Managing backups in {{ mmg-name }}

You can [back up](../concepts/backup.md) your clusters and restore them using existing backups.

{{ mmg-name }} automatically takes a daily backup as well. For this backup, you can [configure the start time and retention period](update.md#change-additional-settings).

## Restoring a cluster from a backup {#restore}

{% note warning %}

{% include [deprecated-note](../../_includes/mdb/backups/deprecated-note.md) %}

{% endnote %}

Point-in-Time Recovery (PITR) allows you to restore your cluster’s state to any point in time within the interval from the creation of the oldest backup to the archiving of the most recent oplog. For more information, see [Backups](../concepts/backup.md).

For example, if a backup operation completed on August 10, 2020 at 12:00:00 UTC, it is now August 15, 2020, 19:00:00 UTC, and the latest oplog was saved on August 15, 2020, at 18:50:00 UTC, the cluster can be restored to any of its states within the time interval from August 10, 2020, 12:00:01 UTC to August 15, 2020, 18:50:00 UTC, inclusive.

{% note warning %}

PITR is not supported for clusters with [sharding](../tutorials/sharding.md) enabled. These clusters can only be restored to the point in time when the chosen backup was created.

{% endnote %}

Restoring a cluster from a backup creates a new cluster with that backup’s data. If your folder lacks [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. The average restore speed is 10 MBps.

For a new cluster, you must specify all settings required during creation, except for the cluster type, i.e., you cannot restore a {{ SD }} backup as a {{ PG }} cluster.

When restored to the current point in time, the new cluster will reflect the state of:

* Existing cluster at the time of recovery.
* Deleted cluster at the time of archiving the last oplog.


Before you begin, [assign](../../iam/operations/roles/grant.md) the [managed-mongodb.restorer](../../iam/roles-reference.md#managed-mongodb-restorer) or higher role to your {{ yandex-cloud }} account for both the backup folder and the new cluster folder.


{% list tabs group=instructions %}

- Management console {#console}

  To restore an existing cluster from a backup:

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.

  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.

  1. For the backup you need, click ![image](../../_assets/console-icons/ellipsis.svg), then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

      To restore a sharded cluster, use a [sharded backup](../concepts/backup.md#size). Such backups are larger in size.

  1. Configure the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.

  1. To restore the cluster’s state to a specific point in time after the backup was created, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly. You can either specify the date manually or select it using the date picker.

      If you leave this setting unchanged, the cluster will be restored to the state when the backup was completed.

  1. Click **{{ ui-key.yacloud.mdb.forms.button_restore }}**.

  To restore a previously deleted cluster from a backup:

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.

  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

  1. Find the backup you need using its creation time and cluster ID. The **{{ ui-key.yacloud.common.id }}** column contains IDs in `<cluster_ID>:<backup_ID>` format.

      If you want to restore a sharded cluster, find its [sharded backup](../concepts/backup.md#size). Such backups are larger in size.

  1. For the backup you need, click ![image](../../_assets/console-icons/ellipsis.svg), then click **{{ ui-key.yacloud.mdb.cluster.backups.button_restore }}**.

  1. Configure the new cluster. You can select a folder for the new cluster from the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** list.

  1. To restore the cluster’s state to a specific point in time after the backup was created, configure **{{ ui-key.yacloud.mdb.forms.field_date }}** accordingly. You can either specify the date manually or select it using the date picker.

      If you leave this setting unchanged, the cluster will be restored to the state when the backup was completed.

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

     You can see the backup completion time in the `CREATED AT` column of the available backups list. It is formatted as `yyyy-mm-dd hh:mm:ss`, e.g., `2020-08-10 12:00:00` in the example above. You can restore your cluster to any point in time since the backup was created.

  1. Run the command below to create a new cluster from a backup. Note that these examples do not show all available command options.

      
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
         --disk-size-autoscaling mongod-disk-size-limit=<max_storage_size_in_GB>,`
                                `mongod-planned-usage-threshold=<scheduled_expansion_percentage>,`
                                `mongod-emergency-usage-threshold=<immediate_expansion_percentage> \
         --maintenance-window type=<maintenance_type>,`
                             `day=<day_of_week>,`
                             `hour=<hour> \
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
         --disk-size-autoscaling mongod-disk-size-limit=<max_storage_size_in_GB>,`
                                `mongod-planned-usage-threshold=<scheduled_expansion_percentage>,`
                                `mongod-emergency-usage-threshold=<immediate_expansion_percentage>,`
                                 ...
                                `<host_type>-disk-size-limit=<max_storage_size_in_GB>,`
                                `<host_type>-planned-usage-threshold=<scheduled_expansion_percentage>,`
                                `<host_type>-emergency-usage-threshold=<immediate_expansion_percentage> \
         --maintenance-window type=<maintenance_type>,`
                             `day=<day_of_week>,`
                             `hour=<hour> \
         --performance-diagnostics=<enable_diagnostics>
      ```


      Where:

      {% include [backup-parameters](../../_includes/mdb/mmg/backup-parameters-cli.md)%}

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
            "timestamp": "<time_point>"
          },
          "configSpec": {
            "version": "<Yandex_StoreDoc_version>",
            "mongodb": {
              "<Yandex_StoreDoc_host_type>": {
                "resources": {
                  "resourcePresetId": "<host_class>",
                  "diskSize": "<storage_size_in_bytes>",
                  "diskTypeId": "<disk_type>"
                },
                "diskSizeAutoscaling": {
                  "plannedUsageThreshold": "<scheduled_expansion_percentage>",
                  "emergencyUsageThreshold": "<immediate_expansion_percentage>",
                  "diskSizeLimit": "<maximum_storage_size_in_bytes>"
                }
              },
              ...
              "<Yandex_StoreDoc_host_type>": {
                "resources": {
                  "resourcePresetId": "<host_class>",
                  "diskSize": "<storage_size_in_bytes>",
                  "diskTypeId": "<disk_type>"
                },
                "diskSizeAutoscaling": {
                  "plannedUsageThreshold": "<scheduled_expansion_percentage>",
                  "emergencyUsageThreshold": "<immediate_expansion_percentage>",
                  "diskSizeLimit": "<maximum_storage_size_in_bytes>"
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
          ],
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          }
        }
        ```

        Where:

        {% include [backup-parameters](../../_includes/mdb/mmg/backup-parameters-rest.md)%}

    1. Call the [Cluster.Restore](../api-ref/Cluster/restore.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters:restore' \
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
          "folder_id": "<folder_ID>",
          "backup_id": "<backup_ID>",
          "name": "<new_cluster_name>",
          "environment": "<environment>",
          "network_id": "<network_ID>",
          "recovery_target_spec": {
            "timestamp": "<time_point>"
          },
          "config_spec": {
            "version": "<Yandex_StoreDoc_version>",
            "mongodb": {
              "<Yandex_StoreDoc_host_type>": {
                "resources": {
                  "resource_preset_id": "<host_class>",
                  "disk_size": "<storage_size_in_bytes>",
                  "disk_type_id": "<disk_type>"
                },
                "disk_size_autoscaling": {
                  "planned_usage_threshold": "<scheduled_expansion_percentage>",
                  "emergency_usage_threshold": "<immediate_expansion_percentage>",
                  "disk_size_limit": "<maximum_storage_size_in_bytes>"
                }
              },
              ...
              "<Yandex_StoreDoc_host_type>": {
                "resources": {
                  "resource_preset_id": "<host_class>",
                  "disk_size": "<storage_size_in_bytes>",
                  "disk_type_id": "<disk_type>"
                },
                "disk_size_autoscaling": {
                  "planned_usage_threshold": "<scheduled_expansion_percentage>",
                  "emergency_usage_threshold": "<immediate_expansion_percentage>",
                  "disk_size_limit": "<maximum_storage_size_in_bytes>"
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
          ],
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          }
        }
        ```

        Where:

        {% include [backup-parameters](../../_includes/mdb/mmg/backup-parameters-grpc.md)%}

    1. Call the [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

## Restoring individual databases and collections from a backup {#restore-database}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restore individual databases and collections from a backup:

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

     You can see the backup completion time in the `CREATED AT` column of the available backups list. It is formatted as `yyyy-mm-dd hh:mm:ss`, e.g., `2020-08-10 12:00:00` in the example above. You can restore your cluster to any point in time since the backup was created.

  1. Run the command to create a new cluster from a backup. Use `--whitelist` to specify which databases and collections to restore, or `--blacklist` to define exclusions.

      
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
         --disk-size-autoscaling mongod-disk-size-limit=<max_storage_size_in_GB>,`
                                `mongod-planned-usage-threshold=<scheduled_expansion_percentage>,`
                                `mongod-emergency-usage-threshold=<immediate_expansion_percentage> \
         --maintenance-window type=<maintenance_type>,`
                             `day=<day_of_week>,`
                             `hour=<hour> \
         --performance-diagnostics=<enable_diagnostics> \
         --whitelist <list_of_databases_and_collections_to_restore> \
         --blacklist <list_of_databases_and_collections_to_exclude_from_restoring>
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
         --disk-size-autoscaling mongod-disk-size-limit=<max_storage_size_in_GB>,`
                                `mongod-planned-usage-threshold=<scheduled_expansion_percentage>,`
                                `mongod-emergency-usage-threshold=<immediate_expansion_percentage>,`
                                 ...
                                `<host_type>-disk-size-limit=<max_storage_size_in_GB>,`
                                `<host_type>-planned-usage-threshold=<scheduled_expansion_percentage>,`
                                `<host_type>-emergency-usage-threshold=<immediate_expansion_percentage> \
         --maintenance-window type=<maintenance_type>,`
                             `day=<day_of_week>,`
                             `hour=<hour> \
         --performance-diagnostics=<enable_diagnostics>
         --whitelist <list_of_databases_and_collections_to_restore> \
         --blacklist <list_of_databases_and_collections_to_exclude_from_restoring>
      ```


      Where:

      {% include [backup-parameters](../../_includes/mdb/mmg/backup-parameters-cli.md)%}

      * Settings for restoring individual databases and collections:

          * `--whitelist`: List of databases and collections to restore. Here is an example: `"db1","db2.collection1"`.
          * `--blacklist`: List of databases and collections to exclude from restoring. Here is an example: `"db1.collection1"`.

          If you specify databases under `--whitelist`, you can use `--blacklist` to exclude specific collections within those databases.
          If the `--whitelist` parameter is not specified, all databases and collections will be restored except those specified under `--blacklist`.

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
                },
                "diskSizeAutoscaling": {
                  "plannedUsageThreshold": "<scheduled_expansion_percentage>",
                  "emergencyUsageThreshold": "<immediate_expansion_percentage>",
                  "diskSizeLimit": "<maximum_storage_size_in_bytes>"
                }
              },
              ...
              "<Yandex_StoreDoc_host_type>": {
                "resources": {
                  "resourcePresetId": "<host_class>",
                  "diskSize": "<storage_size_in_bytes>",
                  "diskTypeId": "<disk_type>"
                },
                "diskSizeAutoscaling": {
                  "plannedUsageThreshold": "<scheduled_expansion_percentage>",
                  "emergencyUsageThreshold": "<immediate_expansion_percentage>",
                  "diskSizeLimit": "<maximum_storage_size_in_bytes>"
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
          ],
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "partialRestoreSpec": {
            "whitelist": [<list_of_databases_and_collections_to_restore>],
            "blacklist": [<list_of_databases_and_collections_to_exclude_from_restoring>]
          }
        }
        ```

        Where:

        {% include [backup-parameters](../../_includes/mdb/mmg/backup-parameters-rest.md)%}

        * `partialRestoreSpec`: Settings for restoring individual databases and collections:

            * `whitelist`: List of databases and collections to restore. For example: `["db1", "db2.collection1"]`.
            * `blacklist`: List of databases and collections to exclude from restoring. Here is an example: `["db1.collection1"]`.

            If you specify databases under `whitelist`, you can use `blacklist` to exclude specific collections within those databases.
            If the `whitelist` parameter is not specified, all databases and collections will be restored except those specified under `blacklist`.

    1. Call the [Cluster.Restore](../api-ref/Cluster/restore.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters:restore' \
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
                },
                "disk_size_autoscaling": {
                  "planned_usage_threshold": "<scheduled_expansion_percentage>",
                  "emergency_usage_threshold": "<immediate_expansion_percentage>",
                  "disk_size_limit": "<maximum_storage_size_in_bytes>"
                }
              },
              ...
              "<Yandex_StoreDoc_host_type>": {
                "resources": {
                  "resource_preset_id": "<host_class>",
                  "disk_size": "<storage_size_in_bytes>",
                  "disk_type_id": "<disk_type>"
                },
                "disk_size_autoscaling": {
                  "planned_usage_threshold": "<scheduled_expansion_percentage>",
                  "emergency_usage_threshold": "<immediate_expansion_percentage>",
                  "disk_size_limit": "<maximum_storage_size_in_bytes>"
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
          ],
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "partial_restore_spec": {
            "whitelist": [<list_of_databases_and_collections_to_restore>],
            "blacklist": [<list_of_databases_and_collections_to_exclude_from_restoring>]
          }
        }
        ```

        Where:

        {% include [backup-parameters](../../_includes/mdb/mmg/backup-parameters-grpc.md)%}

        * `partial_restore_spec`: Settings for restoring individual databases and collections:

            * `whitelist`: List of databases and collections to restore. For example: `["db1", "db2.collection1"]`. 
            * `blacklist`: List of databases and collections to exclude from restoring. Here is an example: `["db1.collection1"]`.

            If you specify databases under `whitelist`, you can use `blacklist` to exclude specific collections within those databases.
            If the `whitelist` parameter is not specified, all databases and collections will be restored except those specified under `blacklist`.

    1. Call the [ClusterService.Restore](../api-ref/grpc/Cluster/restore.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
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

  1. To create a backup, send the following request, providing the cluster ID or name:

      ```bash
      {{ yc-mdb-mg }} cluster backup <cluster_name_or_ID>
      ```

      You can get the cluster name and ID from the [list of clusters](cluster-list.md#list-clusters).

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

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/backup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.

  To get a list of all backups in your folder:

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
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

  To get a list of {{ SD }} cluster backups in the default folder, run this command:

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

  The output table contains the following information:
  * Backup ID.
  * Backup end time (UTC).
  * ID of the backed up cluster.
  * Backup start time (UTC).
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

  1. To list backups for all clusters in your folder:

     1. Call the [Backup.List](../api-ref/Backup/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
           --request GET \
           --header "Authorization: Bearer $IAM_TOKEN" \
           --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/backups'
           --url-query folderId=<folder_ID>
        ```

        
        You can get the folder ID from the [list of your cloud folders](../../resource-manager/operations/folder/get-id.md).


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

  1. To list backups for all clusters in your folder:

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

## Getting backup details {#get-backup}

{% list tabs group=instructions %}

- Management console {#console}

  To get backup details for an existing cluster:
  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Click the name of your cluster and select the ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}** tab.

  To get backup details for a previously deleted cluster:
  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_backups }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get backup details for a {{ SD }} cluster, run this command:

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

  1. Check the [server response](../api-ref/grpc/Backup/get.md#yandex.cloud.mdb.mongodb.v1.Backup) to make sure your request was successful.

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
    {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
       --backup-retain-period-days=<retention_period_in_days>
    ```

  Allowed values range from `7` to `35`. The default value is `7`.

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more on how to create this file, see [Creating a cluster](cluster-create.md).

        For a complete list of configurable {{ SD }} cluster fields, see [this {{ TF }} provider guide]({{ tf-provider-mmg }}).

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

       Where `backup_retain_period_days` is the retention period for automatic backups. 
       
       Allowed values range from `7` to `35`. The default value is `7`.

  1. Validate your settings.

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

      * `updateMask`: Comma-separated string of settings to update.

          Here, we provide only one setting.

      * `configSpec.backupRetainPeriodDays`: Retention period for automatic backups, in days.

          Allowed values range from `7` to `35`. The default value is `7`.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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

      * `config_spec.backup_retain_period_days`: Retention period for automatic backups, in days.

          Allowed values range from `7` to `35`. The default value is `7`.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.mongodb.v1.Cluster) to make sure your request was successful.

{% endlist %}         

## Examples {#examples}

Create a new {{ mmg-name }} cluster from a backup with the following test specifications:


* Source backup for recovery: `c9qlk4v13uq7********:...`.
* Recovery timestamp: `1597060810` (`2020-08-10 12:00:10`).
* Version: `6.0`.
* New cluster’s name: `mynewmg`.
* Environment: `PRODUCTION`.
* Network: `{{ network-name }}`.
* One `{{ host-class }}` host in the `{{ region-id }}-a` availability zone and `b0rcctk2rvtr********` subnet.
* Network SSD storage (`{{ disk-type-example }}`): 20 GB.     
* Databases and users that existed in the cluster at the time of recovery.


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
