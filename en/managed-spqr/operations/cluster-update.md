---
title: Updating a {{ SPQR }} cluster
description: After creating a {{ SPQR }} cluster, you can edit its basic and advanced settings.
keywords:
  - keyword: updating a {{ SPQR }} cluster
  - keyword: '{{ SPQR }} cluster'
  - keyword: '{{ SPQR }}'
---

# Updating a {{ SPQR }} cluster

After creating a cluster, you can edit its basic and advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to update a {{ SPQR }} cluster.
    1. [Navigate]({{ link-console-main }}/link/managed-spqr) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Edit the cluster name and description.
        * Delete or add new [labels](../../resource-manager/concepts/labels.md).

    
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select [security groups](../../vpc/concepts/security-groups.md) for the cluster.

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}
    

    1. Update the computing resource configuration:

        * For standard sharding, update the infrastructure host configuration under **{{ ui-key.yacloud.spqr.section_infra }}**.
        * For advanced sharding, update the router host configuration under **{{ ui-key.yacloud.spqr.section_router }}** and the configuration of coordinator hosts under **{{ ui-key.yacloud.spqr.section_coordinator }}**.

        To update your computing resource configuration:

        1. Change platform in the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** field.
        1. Change **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** for the VM the hosts are deployed on.
        1. Change the **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
        1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, change the storage size.

    1. Configure advanced cluster settings:

        {% include [extra-settings](../../_includes/mdb/mspqr/console/extra-settings.md) %}

    1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** and change the [cluster-level DBMS settings](../concepts/settings-list.md).

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To update cluster and host settings:

    1. View the description of the CLI command for updating a cluster:

        ```bash
        yc managed-sharded-postgresql cluster update --help
        ```

    1. Specify the new cluster settings in the update command. Note that our example does not contain all available settings:

       * For a cluster with standard sharding:

         
         
         ```bash
         yc managed-sharded-postgresql cluster update <cluster_name_or_ID>  \
          --new-name <cluster_name> \
          --security-group-ids <security_group_IDs> \      
          --infra-resource-preset <host_class> \
          --infra-disk-size <storage_size_in_GB> \
          --deletion-protection \
          --maintenance-window type=<maintenance_type>,`
                               `day=<day_of_week>,`
                               `hour=<sequence_number_of_hour_interval> \
          --websql-access=<true_or_false> \
          --backup-window-start <backup_start_time> \
          --backup-retain-period-days <automatic_backup_retention_period>
         ```



       * For a cluster with advanced sharding:

         
         
         ```bash
         yc managed-sharded-postgresql cluster update <cluster_name_or_ID>  \
           --new-name <cluster_name> \
           --security-group-ids <security_group_IDs> \      
           --router-resource-preset <host_class> \
           --router-disk-size <storage_size_in_GB> \
           --coordinator-resource-preset <host_class> \
           --coordinator-disk-size <storage_size_in_GB> \
           --deletion-protection \
           --maintenance-window type=<maintenance_type>,`
                                  `day=<day_of_week>,`
                                  `hour=<sequence_number_of_hour_interval> \
           --websql-access=<true_or_false> \
           --backup-window-start <backup_start_time> \
           --backup-retain-period-days <automatic_backup_retention_period>
         ```



         Where:

         * `<cluster_name_or_ID>`: Cluster name or ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.
         * `--new-name`: New cluster name.

         
         * `--security-group-ids`: List of security group IDs.

            {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


         * `--infra-resource-preset`, `--router-resource-preset`, and `--coordinator-resource-preset`: `INFRA`, `ROUTER`, and `COORDINATOR` host classes, respectively.
         * `--infra-disk-size`, `--router-disk-size`, and `--coordinator-disk-size`: `INFRA`, `ROUTER`, and `COORDINATOR` host storage sizes, respectively.
         * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

           {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

         * `--maintenance-window`: Maintenance window settings that apply to both running and stopped clusters. The `type` setting defines the maintenance type:

           {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

         * `--backup-retain-period`: Automatic backup retention period, in days.

         {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    To update the cluster service configuration:

    1. View the description of the CLI command to update the configuration:

        ```bash
        yc managed-sharded-postgresql cluster update-config --help
        ```

    1. Specify the new configuration settings in the update command. Note that our example does not contain all available settings:

        ```bash
        yc managed-sharded-postgresql cluster update-config <cluster_name_or_ID>  \
          --set router.show_notice_messages=<show_information_notifications>,`
                router.prefer_same_availability_zone=<routing_priority_to_router_availability_zone>,`
                router.default_route_behavior=<allow_multishard_requests>,`
                router.time_quantiles="<list_of_time_quantiles_for_displaying_statistics>"
        ```

        Where:

        * `<cluster_name_or_ID>`: Cluster name or ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.
        * `--set`: New router configuration:
          * `router.show_notice_messages`: Show information notifications, `true` or `false`.
          * `router.prefer_same_availability_zone`: Enable priority routing of read requests to the router's availability zone, `true` or `false`.
          * `router.default_route_behavior`: Router's multishard request execution policy. Possible values: `BLOCK` or `ALLOW`.
          * `router.time_quantiles`: List of time quantiles for displaying statistics. The default value is `"0.5,0.75,0.9,0.95,0.99,0.999,0.9999"`.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with the infrastructure plan.

        For information on how to create this file, see [Creating a cluster](cluster-create.md).

        For the complete list of configurable {{ mspqr-name }} cluster fields, see [this {{ TF }} provider guide](https://yandex.cloud/en/docs/terraform/resources/mdb_sharded_postgresql_cluster).

    1. Change the resource descriptions:

       * For a cluster with standard sharding:

         
         ```hcl
         resource "yandex_mdb_sharded_postgresql_cluster" "<cluster_name>" {
           ...
           security_group_ids = [ "<list_of_security_group_IDs>" ]
           config = {
             sharded_postgresql_config = {
               infra = {
                 resources = {
                   resource_preset_id = "<host_class>"
                   disk_size          = <storage_size_in_GB>
                 }
                 router = {
                   show_notice_messages = <show_information_notifications>
                   prefer_same_availability_zone = <routing_priority_to_router_availability_zone>
                   default_route_behavior = <allow_multishard_requests>
                   time_quantiles = [ <list_of_time_quantiles_for_displaying_statistics> ]
                 }
               }
             }
             deletion_protection = <protect_cluster_from_deletion>
             maintenance_window = {
               type = "<maintenance_type>"
               day  = "<day_of_week>"
               hour = <sequence_number_of_hour_interval>
             }
             backup_retain_period_days = <number_of_days>
             backup_window_start = {
               hours   = <backup_start_hour>
               minutes = <backup_start_minute>
             }
           }
         }
         ```


       * For a cluster with advanced sharding:

         
         ```hcl
         resource "yandex_mdb_sharded_postgresql_cluster" "<cluster_name>" {
           ...
           security_group_ids = [ "<list_of_security_group_IDs>" ]
           config = {
             sharded_postgresql_config = {
               router = {
                 resources = {
                   resource_preset_id = "<host_class>"
                   disk_size          = <storage_size_in_GB>
                 }
                 config = {
                   show_notice_messages = <show_information_notifications>
                   prefer_same_availability_zone = <routing_priority_to_router_availability_zone>
                   default_route_behavior = <allow_multishard_requests>
                   time_quantiles = [ <list_of_time_quantiles_for_displaying_statistics> ]
                 }
               }
               coordinator = {
                 resources = {
                   resource_preset_id = "<host_class>"
                   disk_size          = <storage_size_in_GB>
                 }
               }
             }
             deletion_protection = <protect_cluster_from_deletion>
             maintenance_window = {
               type = "<maintenance_type>"
               day  = "<day_of_week>"
               hour = <sequence_number_of_hour_interval>
             }
             backup_retain_period_days = <number_of_days>
             backup_window_start = {
               hours   = <backup_start_hour>
               minutes = <backup_start_minute>
             }
           }
         }
         ```


       Where:

       
       * `security_group_ids`: [Security group](../../vpc/concepts/security-groups.md) IDs.

         {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


       * `deletion_protection`: Cluster deletion protection, `true` or `false`.

          {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

       * `config`: Cluster settings:

         * `sharded_postgresql_config`: {{ SPQR }} settings:

           * `router`: Router settings:

             * `config`: Router configuration:

                * `show_notice_messages`: Show information notifications, `true` or `false`.
                * `time_quantiles`: Array of time quantile strings for displaying statistics. The default values are `"0.5"`, `"0.75"`, `"0.9"`, `"0.95"`, `"0.99"`, `"0.999"`, `"0.9999"`.
                * `default_route_behavior`: Router's multishard request execution policy. Possible values: `BLOCK` or `ALLOW`.
                * `prefer_same_availability_zone`: Enable priority routing of read requests to the router's availability zone, `true` or `false`.

             * `resources`: `ROUTER` host resource parameters:
                * `resource_preset_id`: [Host class](../concepts/instance-types.md).
                * `disk_size`: Disk size, in GB.

           * `coordinator`: Coordinator settings:
             * `resources`: Resource parameters:
               * `resource_preset_id`: Host class.
               * `disk_size`: Disk size, in GB.

           * `infra`: `INFRA` host settings:

             * `resources`: Resource parameters:
               * `resource_preset_id`: Host class.
               * `disk_size`: Disk size, in GB.

             * `router`: Router configuration:

               * `show_notice_messages`: Show information notifications, `true` or `false`.
               * `time_quantiles`: Array of time quantile strings for displaying statistics. The default values are `"0.5"`, `"0.75"`, `"0.9"`, `"0.95"`, `"0.99"`, `"0.999"`, `"0.9999"`.
               * `default_route_behavior`: Router's multishard request execution policy. Possible values: `BLOCK` or `ALLOW`.
               * `prefer_same_availability_zone`: Enable priority routing of read requests to the router's availability zone, `true` or `false`.

       * `backup_window_start`: Backup window settings.

         Here, specify the backup start time. Allowed values:

         * `hours`: From `0` to `23` hours.
         * `minutes`: Between `0` and `59` minutes.

       * `backup_retain_period_days`: Cluster backup retention period in days. Possible values: between `7` and `60` days.

       * `maintenance_window`: Maintenance window settings:

         * `type`: Maintenance type. The possible values include:
             * `ANYTIME`: Any time.
             * `WEEKLY`: On a schedule.
         * `day`: Day of week for the `WEEKLY` type, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
         * `hour`: UTC hour interval for the `WEEKLY` type, from `1` to `24`.

           > For example, `1` stands for the interval from `00:00` to `01:00`, and `5`, from `04:00` to `05:00`.

    1. Make sure the settings are correct.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [Terraform timeouts](../../_includes/mdb/mspqr/terraform/timeouts.md) %}

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
       "deletionProtection": <protect_cluster_from_deletion>,
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
               "diskSize": "<storage_size_in_bytes>"
             }
           },
           "coordinator": {
             "resources": {
               "resourcePresetId": "<coordinator_host_class>",
               "diskSize": "<storage_size_in_bytes>"
             }
           },
           "infra": {
             "resources": {
               "resourcePresetId": "INFRA_host_class",
               "diskSize": "<storage_size_in_bytes>"
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

        When you update a cluster, all parameters of the object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

        {% endnote %}

     * `name`: New cluster name.

     
     * `securityGroupIds`: [Security group](../../vpc/concepts/security-groups.md) IDs.
        
        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


     * `deletionProtection`: Cluster deletion protection, `true` or `false`.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `configSpec`: Cluster settings:

       * `spqrSpec`: {{ SPQR }} settings.

         * `router`: For [advanced sharding](../concepts/index.md#router), configure the following router settings:

           * `config`: Router configuration:

             * `showNoticeMessages`: Show information notifications, `true` or `false`.
             * `timeQuantiles`: Array of time quantile strings for displaying statistics. The default values are `"0.5"`, `"0.75"`, `"0.9"`, `"0.95"`, `"0.99"`, `"0.999"`, `"0.9999"`.
             * `defaultRouteBehavior`: Router's multishard request execution policy. Possible values: `BLOCK` or `ALLOW`.
             * `preferSameAvailabilityZone`: Enable priority routing of read requests to the router's availability zone, `true` or `false`.

           * `resources`: `ROUTER` host resource parameters:
             * `resourcePresetId`: [Host class](../concepts/instance-types.md).
             * `diskSize`: Disk size in bytes.

           * `coordinator`: For advanced sharding, configure the following coordinator settings:
             * `resources`: Resource parameters:
               * `resourcePresetId`: Host class.
               * `diskSize`: Disk size in bytes.

           * `infra`: For standard sharding, set the following `INFRA` host settings:

             * `resources`: Resource parameters:
               * `resourcePresetId`: Host class.
               * `diskSize`: Disk size in bytes.

             * `router`: Router configuration:

               * `showNoticeMessages`: Show information notifications, `true` or `false`.
               * `timeQuantiles`: Array of time quantile strings for displaying statistics. The default values are `"0.5"`, `"0.75"`, `"0.9"`, `"0.95"`, `"0.99"`, `"0.999"`, `"0.9999"`.
               * `defaultRouteBehavior`: Router's multishard request execution policy. Possible values: `BLOCK` or `ALLOW`.
               * `preferSameAvailabilityZone`: Enable priority routing of read requests to the router's availability zone, `true` or `false`.

           * `consolePassword`: {{ SPQR }} console password.
           * `logLevel`: Query logging level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`, `PANIC`.


       * `backupWindowStart`: Backup window settings.

         Here, specify the backup start time. Allowed values:

         * `hours`: Between `0` and `23` hours.
         * `minutes`: Between `0` and `59` minutes.
         * `seconds`: Between `0` and `59` seconds.
         * `nanos`: Between `0` and `999999999` nanoseconds.

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

     {% include [cluster-id-standard](../../_includes/managed-spqr/cluster-id-standard.md) %}

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and paste the following code into it:

     
     ```json
     {
       "cluster_id": "<cluster_ID>",
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
       "deletion_protection": <protect_cluster_from_deletion>,
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
               "disk_size": "<storage_size_in_bytes>"
             }
           },
           "coordinator": {
             "resources": {
               "resource_preset_id": "<coordinator_host_class>",
               "disk_size": "<storage_size_in_bytes>"
             }
           },
           "infra": {
             "resources": {
               "resource_preset_id": "INFRA_host_class",
               "disk_size": "<storage_size_in_bytes>"
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

     * {% include [cluster-id-cluster](../../_includes/managed-spqr/cluster-id-cluster.md) %}
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

        {% note warning %}

        When you update a cluster, all parameters of the object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

        {% endnote %}

     * `name`: New cluster name.

     
     * `security_group_ids`: [Security group](../../vpc/concepts/security-groups.md) IDs.

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


     * `deletion_protection`: Cluster deletion protection, `true` or `false`.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `config_spec`: Cluster settings:

       * `spqr_spec`: {{ SPQR }} settings:

         * `router`: For [advanced sharding](../concepts/index.md#router), configure the following router settings:

           * `config`: Router configuration:

             * `show_notice_messages`: Show information notifications, `true` or `false`.
             * `time_quantiles`: Array of time quantiles for displaying statistics. The following values are used by default: `0.5`, `0.75`, `0.9`, `0.95`, `0.99`, `0.999`, `0.9999`.
             * `default_route_behavior`: Router's multishard request execution policy. Possible values: `BLOCK` or `ALLOW`.
             * `prefer_same_availability_zone`: Enable priority routing of read requests to the router's availability zone, `true` or `false`.

           * `resources`: `ROUTER` host resource parameters:
             * `resource_preset_id`: [Host class](../concepts/instance-types.md).
             * `disk_size`: Disk size in bytes.

           * `coordinator`: For advanced sharding, configure the following coordinator settings:
             * `resources`: Resource parameters:
               * `resource_preset_id`: Host class.
               * `disk_size`: Disk size in bytes.

           * `infra`: For standard sharding, set the following `INFRA` host settings:

             * `resources`: Resource parameters:
               * `resource_preset_id`: Host class.
               * `disk_size`: Disk size in bytes.

             * `router`: Router configuration:

               * `show_notice_messages`: Show information notifications, `true` or `false`.
               * `time_quantiles`: Array of time quantiles for displaying statistics. The following values are used by default: `0.5`, `0.75`, `0.9`, `0.95`, `0.99`, `0.999`, `0.9999`.
               * `default_route_behavior`: Router's multishard request execution policy. Possible values: `BLOCK` or `ALLOW`.
               * `prefer_same_availability_zone`: Enable priority routing of read requests to the router's availability zone, `true` or `false`.

           * `console_password`: {{ SPQR }} console password.
           * `log_level`: Query logging level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`, `PANIC`.


       * `backup_window_start`: Backup window settings.

         Here, specify the backup start time. Allowed values:

         * `hours`: Between `0` and `23` hours.
         * `minutes`: Between `0` and `59` minutes.
         * `seconds`: Between `0` and `59` seconds.
         * `nanos`: Between `0` and `999999999` nanoseconds.

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
