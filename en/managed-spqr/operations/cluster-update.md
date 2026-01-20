---
title: Updating a {{ SPQR }} cluster
description: After creating an {{ SPQR }} cluster, you can edit its basic and advanced settings.
keywords:
  - Updating an {{ SPQR }} cluster
  - '{{ SPQR }} cluster'
  - '{{ SPQR }}'
---

# Updating a {{ SPQR }} cluster

{% include notitle [preview](../../_includes/note-preview.md) %}

After creating a cluster, you can edit its basic and advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Edit the cluster name and description.
        * Delete or add new [labels](../../resource-manager/concepts/labels.md).

    1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select security groups for the cluster.

    1. Update the computing resource configuration:

        * For standard sharding, update the infrastructure host configuration under **{{ ui-key.yacloud.spqr.section_infra }}**.
        * For advanced sharding, update the router host configuration under **{{ ui-key.yacloud.spqr.section_router }}**. If employing a coordinator, update the coordinator host configuration under **{{ ui-key.yacloud.spqr.section_coordinator }}**.

        To update your computing resource configuration:

        1. Change platform in the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** field.
        1. Change **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** for the VM the hosts are deployed on.
        1. Change the **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
        1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, change disk type and storage size.

    1. Change additional cluster settings:

        {% include [extra-settings](../../_includes/mdb/mspqr/console/extra-settings.md) %}

    1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** and change the [cluster-level DBMS settings](../concepts/settings-list.md).

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

     
     ```json
     {
       "updateMask": "<list_of_parameters_to_update>",
       "name": "<cluster_name>",
       "description": "<description>",
       "environment": "<environment>",
       "securityGroupIds": [
         "<security_group_1_ID>",
         "<security_group_2_ID>",
         ...
         "<security_group_N_ID>"
       ],
       "deletionProtection": <protect_cluster_against_deletion>,
       "configSpec": {
         "spqrSpec": {
           "router": {
             "config": {
               "showNoticeMessages": <show_information_notifications>,
               "timeQuantiles": [
                 <list_of_time_quantiles_for_displaying_statistics>
               ],
               "defaultRouteBehavior": "<allow_multishard_requests>",
               "preferSameAvailabilityZone": <routing_priority_to_router_availability_zone>
             },
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
               "resourcePresetId": "INFRA_host_class",
               "diskSize": "<storage_size_in_bytes>",
               "diskTypeId": "<disk_type>"
             },
             "router": {
               "showNoticeMessages": <show_information_notifications>,
               "timeQuantiles": [
                 <list_of_time_quantiles_for_displaying_statistics>
               ],
               "defaultRouteBehavior": "<allow_multishard_requests>",
               "preferSameAvailabilityZone": <routing_priority_to_router_availability_zone>
             }
           },
           "consolePassword": "<Sharded_PostgreSQL_console_password>",
           "logLevel": "<logging_level>"
         },
         "backupWindowStart": {
           "hours": "<hours>",
           "minutes": "<minutes>",
           "seconds": "<seconds>",
           "nanos": "<nanoseconds>"
         },
         "backupRetainPeriodDays": "<number_of_days>",
         "maintenanceWindow": {
           "weeklyMaintenanceWindow": {
             "day": "<day_of_week>",
             "hour": "<hour>"
           }
         }
       }
     }
     ```


     Where:

     * `updateMask`: Comma-separated list of parameters to update.

        {% note warning %}

        When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

        {% endnote %}

     * `name`: Cluster name.

     
     * `securityGroupIds`: [Security group](../../vpc/concepts/security-groups.md) IDs.


     * `deletionProtection`: Cluster deletion protection, `true` or `false`.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `configSpec`: Cluster settings:

       * `spqrSpec`: {{ SPQR }} settings.

         * `router`: For [advanced sharding](../concepts/index.md#router), configure the following router settings:

           * `config`: Router configuration:

             * `showNoticeMessages`: Show information notifications, `true` or `false`.
             * `timeQuantiles`: Array of time quantile strings for displaying statistics. The following values ​​are used by default: `"0.5"`, `"0.75"`, `"0.9"`, `"0.95"`, `"0.99"`, `"0.999"`, `"0.9999"`.
             * `defaultRouteBehavior`: Router's multishard request execution policy. Possible values: `BLOCK` or `ALLOW`.
             * `preferSameAvailabilityZone`: Enable priority routing of read requests to the router's availability zone, `true` or `false`.

           * `resources`: `ROUTER` host resource parameters:
             * `resourcePresetId`: [Host class](../concepts/instance-types.md).
             * `diskSize`: Disk size, in bytes.
             * `diskTypeId`: [Disk type](../concepts/storage.md).

           * `coordinator`: For advanced sharding, configure the following coordinator settings:
             * `resources`: Resource parameters:
               * `resourcePresetId`: Host class.
               * `diskSize`: Disk size, in bytes.
               * `diskTypeId`: Disk type.

           * `infra`: For standard sharding, set the following `INFRA` host settings:

             * `resources`: Resource parameters:
               * `resourcePresetId`: Host class.
               * `diskSize`: Disk size, in bytes.
               * `diskTypeId`: Disk type.

             * `router`: Router configuration:

               * `showNoticeMessages`: Show information notifications, `true` or `false`.
               * `timeQuantiles`: Array of time quantile strings for displaying statistics. The following values ​​are used by default: `"0.5"`, `"0.75"`, `"0.9"`, `"0.95"`, `"0.99"`, `"0.999"`, `"0.9999"`.
               * `defaultRouteBehavior`: Router's multishard request execution policy. Possible values: `BLOCK` or `ALLOW`.
               * `preferSameAvailabilityZone`: Enable priority routing of read requests to the router's availability zone, `true` or `false`.

           * `consolePassword`: {{ SPQR }} console password.
           * `logLevel`: Query logging level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`, `PANIC`.


       * `backupWindowStart`: Backup window settings.

         Here, specify the backup start time. Allowed values:

         * `hours`: From `0` to `23` hours.
         * `minutes`: From `0` to `59` minutes.
         * `seconds`: From `0` to `59` seconds.
         * `nanos`: From `0` to `999999999` nanoseconds.

       * `backupRetainPeriodDays`: Number of days to retain the cluster backup. Possible values: between `7` and `60` days.

     * `maintenanceWindow`: Maintenance window settings:

        * `day`: Day of the week, in `DDD` format, for scheduled maintenance.
        * `hour`: Hour of day, in `HH` format, for scheduled maintenance. The valid values range from `1` to `24`.

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>' \
       --data "@body.json"
     ```

  1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and paste the following code into it:

     
     ```json
     {
       "update_mask": {
         "paths": [
           <list_of_settings_to_update>
         ]
       },
       "name": "<cluster_name>",
       "description": "<description>",
       "security_group_ids": [
         "<security_group_1_ID>",
         "<security_group_2_ID>",
         ...
         "<security_group_N_ID>"
       ],
       "deletion_protection": <protect_cluster_against_deletion>,
       "config_spec": {
         "spqr_spec": {
           "router": {
             "config": {
               "show_notice_messages": {
                 "value": <show_information_notifications>
               },
               "time_quantiles": [
                 <list_of_time_quantiles_for_displaying_statistics>
               ],
               "default_route_behavior": "<allow_multishard_requests>",
               "prefer_same_availability_zone": {
                 "value": <routing_priority_to_router_availability_zone>
               }
             },
             "resources": {
               "resource_preset_id": "<router_host_class>",
               "disk_size": "<storage_size_in_bytes>",
               "disk_type_id": "<disk_type>"
             }
           },
           "coordinator": {
             "resources": {
               "resource_preset_id": "<coordinator_host_class>",
               "disk_size": "<storage_size_in_bytes>",
               "disk_type_id": "<disk_type>"
             }
           },
           "infra": {
             "resources": {
               "resource_preset_id": "INFRA_host_class",
               "disk_size": "<storage_size_in_bytes>",
               "disk_type_id": "<disk_type>"
             },
             "router": {
               "show_notice_messages": {
                 "value": <show_information_notifications>
               },
               "time_quantiles": [
                 <list_of_time_quantiles_for_displaying_statistics>
               ],
               "default_route_behavior": "<allow_multishard_requests>",
               "prefer_same_availability_zone": {
                 "value": <routing_priority_to_router_availability_zone>
               }
             }
           },
           "console_password": "<Sharded_PostgreSQL_console_password>",
           "log_level": "<logging_level>"
         },
         "backup_window_start": {
           "hours": "<hours>",
           "minutes": "<minutes>",
           "seconds": "<seconds>",
           "nanos": "<nanoseconds>"
         },
         "backup_retain_period_days": "<number_of_days>"
       },
       "maintenance_window": {
         "weekly_maintenance_window": {
           "day": "<day_of_week>",
           "hour": "<hour>"
         }
       }
     }
     ```


     Where:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

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

        {% note warning %}

        When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

        {% endnote %}

     * `name`: Cluster name.

     
     * `security_group_ids`: [Security group](../../vpc/concepts/security-groups.md) IDs.


     * `deletion_protection`: Cluster deletion protection, `true` or `false`.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `config_spec`: Cluster settings:

       * `spqr_spec`: {{ SPQR }} settings:

         * `router`: For [advanced sharding](../concepts/index.md#router), configure the following router settings:

           * `config`: Router configuration:

             * `show_notice_messages`: Show information notifications, `true` or `false`.
             * `time_quantiles`: Array of time quantiles for displaying statistics. The following values ​​are used by default: `0.5`, `0.75`, `0.9`, `0.95`, `0.99`, `0.999`, `0.9999`.
             * `default_route_behavior`: Router's multishard request execution policy. Possible values: `BLOCK` or `ALLOW`.
             * `prefer_same_availability_zone`: Enable priority routing of read requests to the router's availability zone, `true` or `false`.

           * `resources`: `ROUTER` host resource parameters:
             * `resource_preset_id`: [Host class](../concepts/instance-types.md).
             * `disk_size`: Disk size, in bytes.
             * `disk_type_id`: [Disk type](../concepts/storage.md).

           * `coordinator`: For advanced sharding, configure the following coordinator settings:
             * `resources`: Resource parameters:
               * `resource_preset_id`: Host class.
               * `disk_size`: Disk size, in bytes.
               * `disk_type_id`: Disk type.

           * `infra`: For standard sharding, set the following `INFRA` host settings:

             * `resources`: Resource parameters:
               * `resource_preset_id`: Host class.
               * `disk_size`: Disk size, in bytes.
               * `disk_type_id`: Disk type.

             * `router`: Router configuration:

               * `show_notice_messages`: Show information notifications, `true` or `false`.
               * `time_quantiles`: Array of time quantiles for displaying statistics. The following values ​​are used by default: `0.5`, `0.75`, `0.9`, `0.95`, `0.99`, `0.999`, `0.9999`.
               * `default_route_behavior`: Router's multishard request execution policy. Possible values: `BLOCK` or `ALLOW`.
               * `prefer_same_availability_zone`: Enable priority routing of read requests to the router's availability zone, `true` or `false`.

           * `console_password`: {{ SPQR }} console password.
           * `log_level`: Query logging level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`, `PANIC`.


       * `backup_window_start`: Backup window settings.

         Here, specify the backup start time. Allowed values:

         * `hours`: From `0` to `23` hours.
         * `minutes`: From `0` to `59` minutes.
         * `seconds`: From `0` to `59` seconds.
         * `nanos`: From `0` to `999999999` nanoseconds.

       * `backup_retain_period_days`: Number of days to retain the cluster backup. Possible values: between `7` and `60` days.

     * `maintenance_window`: Maintenance window settings:

       * `day`: Day of the week, in `DDD` format, for scheduled maintenance.
       * `hour`: Hour of day, in `HH` format, for scheduled maintenance. The valid values range from `1` to `24`.

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
