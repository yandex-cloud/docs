---
title: Creating a {{ SPQR }} cluster
description: Follow this guide to create a {{ SPQR }} cluster with standard or advanced sharding.
keywords:
  - keyword: create {{ SPQR }} cluster
  - keyword: '{{ SPQR }} cluster'
  - keyword: '{{ SPQR }}'
---

# Creating a {{ SPQR }} cluster

{% include notitle [preview](../../_includes/note-preview.md) %}

## Creating a cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ SPQR }} cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Give the cluster a name. The name must be unique within the folder.
        1. Optionally, enter a description for the cluster.
        1. Optionally, create [labels](../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.

        1. Select your cluster environment. Note that you cannot change the environment once the cluster is created:

            * `PRODUCTION`: For stable versions of your applications.
            * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by an SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test new versions for compatibility with your application.

        1. Select the sharding type:

            * `{{ ui-key.yacloud.spqr.section_sharding-type-standard }}`: Cluster will consist only of infrastructure hosts.
            * `{{ ui-key.yacloud.spqr.section_sharding-type-advanced }}`: Cluster will consist only of router hosts and, optionally, coordinator hosts.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select a [network](../../vpc/operations/network-create.md) and [security groups](../../vpc/concepts/security-groups.md) for the cluster.

    1. Specify the computing resource configuration:

        * For standard sharding, specify the infrastructure host configuration under **{{ ui-key.yacloud.spqr.section_infra }}**.
        * For advanced sharding, specify the router host configuration under **{{ ui-key.yacloud.spqr.section_router }}**.

            Optionally, under **{{ ui-key.yacloud.spqr.section_coordinator }}**, enable **{{ ui-key.yacloud.spqr.field_coordinator }}** and specify the coordinator host configuration.

        To specify your computing resource configuration:

        1. Select a platform in the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** field.
        1. Specify the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** of virtual machine where you want to deploy the hosts:
        1. Select **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
        1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, select the disk type and specify the [storage](../concepts/storage.md) size.
        1. Under **{{ ui-key.yacloud.spqr.section_hosts }}**:

            1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.label_title }}** to add the required number of hosts to create together with the {{ SPQR }} cluster.
            
            
            1. Click ![image](../../_assets/console-icons/pencil.svg) and specify the following for each host:
                * [Availability zone](../../overview/concepts/geo-scope.md).
                * [Subnet](../../vpc/concepts/network.md#subnet): By default, each host is created in a separate subnet.
                * **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** to make the host accessible from outside {{ yandex-cloud }}, if required.


            After creating a {{ SPQR }} cluster, you can add more hosts to it if your [folder resource](../concepts/limits.md) quotas allow.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify the database parameters:

        * Database name. Acceptable length is from 1 to 63 characters. Can contain lowercase and uppercase Latin letters, numbers, underscores, and hyphens.

        * Username. Acceptable length is from 1 to 63 characters. Can contain lowercase and uppercase Latin letters, numbers, underscores, and hyphens, but can't start with a hyphen.

        * Password: It may be from 8 to 128 characters long.

    1. If needed, configure advanced cluster settings:

        {% include [extra-settings](../../_includes/mdb/mspqr/console/extra-settings.md) %}

    1. To configure [cluster-level DBMS settings](../concepts/settings-list.md), under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.

    1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

     
     ```json
     {
       "folderId": "<folder_ID>",
       "name": "<cluster_name>",
       "description": "<description>",
       "environment": "<environment>",
       "securityGroupIds": [
         "<security_group_1_ID>",
         "<security_group_2_ID>",
         ...
         "<security_group_N_ID>"
       ],
       "networkId": "<network_ID>",
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
             "router": {
               "showNoticeMessages": <show_information_notifications>,
               "time_quantiles": [
                 <list_of_time_quantiles_for_displaying_statistics>
               ],
               "defaultRouteBehavior": "<allow_multishard_requests>",
               "preferSameAvailabilityZone": <routing_priority_to_router_availability_zone>
             },
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
           "hours": "<hours>",
           "minutes": "<minutes>",
           "seconds": "<seconds>",
           "nanos": "<nanoseconds>"
         },
         "backupRetainPeriodDays": "<number_of_days>",
       },
       "databaseSpecs": [
         {
           "name": "<DB_name>"
         },
         { <similar_configuration_for_DB_2> },
         { ... },
         { <similar_configuration_for_DB_N> }
       ],
       "userSpecs": [
         {
           "name": "<username>",
           "password": "<user_password>",
           "permissions": [
             {
               "databaseName": "<DB_name>"
             },
             { <database_2_name> },
             { ... },
             { <DB_N_name> }
           ],
           "settings": {
             "connectionLimit": "<number_of_user_connections>",
             "connectionRetries": "<number_of_retries_when_connecting>"
           },
           "grants": [
             "privilege_1",
             ...,
             "privilege_N"
           ]
         },
         { <similar_settings_for_user_2> },
         { ... },
         { <similar_settings_for_user_N> }
       ],
       "hostSpecs": [
         {
           "zoneId": "<availability_zone>",
           "subnetId": "<subnet_ID>",
           "assignPublicIp": <allow_public_access_to_host>,
           "type": "<host_type>"
         },
         { <similar_settings_for_host_2> },
         { ... },
         { <similar_settings_for_host_N> }
       ],
       "shardSpecs": [
         {
           "shardName": "<shard_name>",
           "mdbPostgresql": {
             "clusterId": "<cluster_ID>"
           }
         },
         { <similar_set_of_settings_for_shard_2> },
         { ... },
         { <similar_set_of_settings_for_shard_N> }
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

     * `folderId`: Folder ID.  You can get it from the [list of your cloud folders](../../resource-manager/operations/folder/get-id.md).
     * `name`: Cluster name.
     * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
     * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be deployed in.

       {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     
     * `securityGroupIds`: [Security group](../../vpc/concepts/security-groups.md) IDs.


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
             * `diskSize`: Disk size, in bytes.
             * `diskTypeId`: [Disk type](../concepts/storage.md).

         * `coordinator`: For advanced sharding, set the following coordinator resource parameters:
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
             * `timeQuantiles`: Array of time quantiles for displaying statistics. The default values are `0.5`, `0.75`, `0.9`, `0.95`, `0.99`, `0.999`, `0.9999`.
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

     * `databaseSpecs`: Database settings as an array of elements, one per database. Each element has the following structure:

       * `name`: Database name.

     * `userSpecs`: User settings as an array of elements, one per user. Each element has the following structure:

       * `name`: Username.
       * `password`: User password. The password must be from 8 to 128 characters long.
       * `permissions.databaseName`: Name of the database the user can access.
       * `settings`: Database user connection parameters:

         * `connectionLimit`: Connection limit.
         * `connectionRetries`: Number of reconnect attempts.

       * `grants`: User privileges as an array of strings. The possible values are `reader`, `writer`, `admin`, or `transfer`.

     * `hostSpecs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

       * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).

       
       * `subnetId`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
       * `assignPublicIp`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.


       * `type`: Host type. The possible values are:
         * `ROUTER`: Router in a cluster with advanced sharding.
         * `COORDINATOR`: Coordinator in a cluster with advanced sharding.
         * `INFRA`: `INFRA` host in a cluster with standard sharding.

     * `shardSpecs`: Shard settings as an array of elements, one per shard. Each element has the following structure:

       * `shardName`: Shard name.
       * `mdbPostgresql.clusterId`: {{ mpg-name }} cluster ID within the shard.

     * `maintenanceWindow`: Maintenance window settings:

       * `day`: Day of the week, in `DDD` format, for scheduled maintenance.
       * `hour`: Hour of day, in `HH` format, for scheduled maintenance. Allowed values range from `1` to `24`.

  1. Call the [Cluster.Create](../api-ref/Cluster/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters' \
       --data "@body.json"
     ```

  1. Check the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and paste the following code into it:

     
     ```json
     {
       "folder_id": "<folder_ID>",
       "name": "<cluster_name>",
       "description": "<description>",
       "environment": "<environment>",
       "security_group_ids": [
         "<security_group_1_ID>",
         "<security_group_2_ID>",
         ...
         "<security_group_N_ID>"
       ],
       "network_id": "<network_ID>",
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
               "disk_size": "<storage_size_in_bytes>",
               "disk_type_id": "<disk_type>" }
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
             },
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
       "database_specs": [
         {
           "name": "<DB_name>"
         },
         { <similar_configuration_for_DB_2> },
         { ... },
         { <similar_configuration_for_DB_N> }
       ],
       "user_specs": [
         {
           "name": "<username>",
           "password": "<user_password>",
           "permissions": [
             {
               "database_name": "<DB_name>"
             },
             { <database_2_name> },
             { ... },
             { <DB_N_name> }
           ],
           "settings": {
             "connection_limit": {
               "value": <number_of_user_connections>
             },
             "connection_retries": {
               "value": <number_of_retries_when_connecting>
             }
           },
           "grants": [
             "privilege_1",
             ...,
             "privilege_N"
           ]
         },
         { <similar_settings_for_user_2> },
         { ... },
         { <similar_settings_for_user_N> }
       ],
       "host_specs": [
         {
           "zone_id": "<availability_zone>",
           "subnet_id": "<subnet_ID>",
           "assign_public_ip": <allow_public_access_to_host>,
           "type": "<host_type>"
         },
         { <similar_settings_for_host_2> },
         { ... },
         { <similar_settings_for_host_N> }
       ],
       "shard_specs": [
         {
           "shard_name": "<shard_name>",
           "mdb_postgresql": {
             "cluster_id": "<cluster_ID>"
           }
         },
         { <similar_set_of_settings_for_shard_2> },
         { ... },
         { <similar_set_of_settings_for_shard_N> }
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

     * `folder_id`: Folder ID.  You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
     * `name`: Cluster name.
     * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
     * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be deployed in.

       {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     
     * `security_group_ids`: [Security group](../../vpc/concepts/security-groups.md) IDs.


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
             * `disk_size`: Disk size, in bytes.
             * `disk_type_id`: [Disk type](../concepts/storage.md).

         * `coordinator`: For advanced sharding, set the following coordinator resource parameters:
             * `resource_preset_id`: Host class.
             * `disk_size`: Disk size, in bytes.
             * `disk_type_id`: Disk type.

         * `infra`: For standard sharding, set the following `INFRA` host settings:

           * `resources`: Resource parameters:
              * `resource_preset_id`: Host class.
              * `disk_size`: Disk size, in bytes.
              * `disk_type_id`: Disk type.

           * `router`: Router configuration:
               * `default_route_behavior`: Default router behavior. Possible values: `BLOCK` or `ALLOW` the request.
               * `prefer_same_availability_zone`: Enable priority routing to the router's availability zone, `true` or `false`.

           * `console_password`: {{ SPQR }} console password.
           * `log_level`: Query logging level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `FATAL`, `PANIC`.


       * `backup_window_start`: Backup window settings.

         Here, specify the backup start time. Allowed values:

         * `hours`: Between `0` and `23` hours.
         * `minutes`: Between `0` and `59` minutes.
         * `seconds`: Between `0` and `59` seconds.
         * `nanos`: Between `0` and `999999999` nanoseconds.

       * `backup_retain_period_days`: Number of days to retain the cluster backup. Possible values: between `7` and `60` days.

     * `database_specs`: Database settings as an array of elements, one for each DB. Each element has the following structure:

       * `name`: Database name.

     * `user_specs`: User settings as an array of elements, one per user. Each element has the following structure:

       * `name`: Username.
       * `password`: User password. The password must be from 8 to 128 characters long.
       * `permissions.database_name`: Name of the database the user can access.
       * `settings`: Database user connection parameters:

         * `connection_limit`: Connection limit.
         * `connection_retries`: Number of reconnect attempts.

       * `grants`: User privileges as an array of strings. The possible values are `reader`, `writer`, `admin`, or `transfer`.

     * `host_specs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

       * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md)

       
       * `subnet_id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
       * `assign_public_ip`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.


       * `type`: Host type. The possible values are:
         * `ROUTER`: Router in a cluster with advanced sharding.
         * `COORDINATOR`: Coordinator in a cluster with advanced sharding.
         * `INFRA`: `INFRA` host in a cluster with standard sharding.

     * `shard_specs`: Shard settings as an array of elements, one per shard. Each element has the following structure:

       * `shard_name`: Shard name.
       * `mdb_postgresql.cluster_id`: {{ mpg-name }} cluster ID within the shard.

     * `maintenance_window`: Maintenance window settings:

       * `day`: Day of the week, in `DDD` format, for scheduled maintenance.
       * `hour`: Hour of day, in `HH` format, for scheduled maintenance. Allowed values range from `1` to `24`.

  1. Call the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.Create \
       < body.json
     ```

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
