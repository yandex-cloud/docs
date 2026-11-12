---
title: Creating a {{ SPQR }} cluster
description: Follow this guide to create a {{ SPQR }} cluster with standard or advanced sharding.
keywords:
  - keyword: create {{ SPQR }} cluster
  - keyword: '{{ SPQR }} cluster'
  - keyword: '{{ SPQR }}'
---

# Creating a {{ SPQR }} cluster



## Roles for creating a cluster {#roles}

To create and use a {{ mspqr-name }} cluster, your {{ yandex-cloud }} account needs the following roles:

* {% include [roles-mspqr-editor](../../_includes/mdb/mspqr/roles-mspqr-editor.md) %}
* {% include [roles-vpc-user](../../_includes/mdb/roles-vpc-user.md) %}
* {% include [roles-mdb-viewer](../../_includes/mdb/roles-mdb-viewer-create-cluster.md) %}

For more information about assigning roles, see [this {{ iam-full-name }} guide](../../iam/operations/roles/grant.md).


## Creating a cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ SPQR }} cluster.
    1. [Navigate]({{ link-console-main }}/link/managed-spqr) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
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
            * `{{ ui-key.yacloud.spqr.section_sharding-type-advanced }}`: Cluster will consist only of router hosts and coordinator hosts.

    1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select a [network](../../vpc/operations/network-create.md) and [security groups](../../vpc/concepts/security-groups.md) for the cluster.

        
        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


    1. Specify the computing resource configuration:

        * For standard sharding, specify the infrastructure host configuration under **{{ ui-key.yacloud.spqr.section_infra }}**.
        * For advanced sharding, specify the router host configuration under **{{ ui-key.yacloud.spqr.section_router }}**.

            Under **{{ ui-key.yacloud.spqr.section_coordinator }}**, configure the coordinator hosts.

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

    1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify parameters of the database in which you can run queries to tables in shards. [Learn more about connecting to databases](connect.md).

        * Database name. Acceptable length is from 1 to 63 characters. May contain lowercase and uppercase Latin letters, numbers, underscores, and hyphens.

        * Username. Acceptable length is from 1 to 63 characters. May contain lowercase and uppercase Latin letters, numbers, underscores, and hyphens, but cannot start with a hyphen.

        * Password. It may be from 8 to 128 characters long.

    1. Configure advanced cluster settings:

        {% include [extra-settings](../../_includes/mdb/mspqr/console/extra-settings.md) %}

    1. To configure [cluster-level DBMS settings](../concepts/settings-list.md), under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.

    1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ mspqr-name }} cluster:

  1. View the description of the CLI command for creating a cluster:

      ```bash
      yc managed-sharded-postgresql cluster create --help
      ```

  1. Specify the cluster settings in the `cluster create` command. Note that our example does not contain all available settings:

      {% cut "For a cluster with standard sharding" %}

            
      ```bash
      yc managed-sharded-postgresql cluster create \
         --name <cluster_name> \
         --environment <environment> \
         --network-name <network_name> \
         --security-group-ids <security_group_IDs> \
         --host type=infra,`
               `zone-id=<availability_zone>,`
               `subnet-id=<subnet_ID>,`
               `assign-public-ip=<allow_public_access_to_host> \
         --infra-resource-preset <INFRA_host_class> \
         --infra-disk-size <storage_size_in_GB> \
         --infra-disk-type <disk_type> \
         --database name=<DB_name> \
         --user name=<username>,`
               `password=<password>,`
               `permission=<DB_name>,`
               `connection-limit=<maximum_number_of_user_connections>,`
               `connection-retries=<maximum_connection_retry_attempts> \
         --deletion-protection=<protect_cluster_from_deletion>
      ```


      {% endcut %}

      {% cut "For a cluster with advanced sharding" %}

      
      ```bash
      yc managed-sharded-postgresql cluster create \
         --name <cluster_name> \
         --environment <environment> \
         --network-name <network_name> \
         --security-group-ids <security_group_IDs> \
         --host type=router,`
               `zone-id=<availability_zone>,`
               `subnet-id=<subnet_ID>,`
               `assign-public-ip=<allow_public_access_to_host> \
         --router-resource-preset <router_host_class> \
         --router-disk-size <storage_size_in_GB> \
         --router-disk-type <disk_type> \
         --host type=coordinator,`
               `zone-id=<availability_zone>,`
               `subnet-id=<subnet_ID>,`
               `assign-public-ip=<allow_public_access_to_host> \
         --coordinator-resource-preset <coordinator_host_class> \
         --coordinator-disk-size <storage_size_in_GB> \
         --coordinator-disk-type <disk_type> \
         --database name=<DB_name> \
         --user name=<username>,`
               `password=<password>,`
               `permission=<DB_name>,`
               `connection-limit=<maximum_number_of_user_connections>,`
               `connection-retries=<maximum_connection_retry_attempts> \
         --deletion-protection=<protect_cluster_from_deletion>
      ```


      {% endcut %}

      Where:

      * `--name`: Cluster name.
      * `--environment`: Cluster environment, `production` or `prestable`.
      * `--network-name`: Name of the [network](../../vpc/concepts/network.md#network) the cluster will be deployed in.

        {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

      
      * `--security-group-ids`: [Security group](../../vpc/concepts/security-groups.md) IDs, comma-separated.

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


      * `--host`: Cluster host settings. This parameter is specified separately for each host and has the following structure:

        * `type`: Host type. Its possible values are:
          
          * `router`: [Router](../concepts/index.md#router) in a cluster with advanced sharding.
          * `coordinator`: [Coordinator](../concepts/index.md#coordinator) in a cluster with advanced sharding.
          * `infra`: `INFRA` host in a cluster with standard sharding.
        
        * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
        
        
        * `subnet-id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
        * `assign-public-ip`: Internet access to the host via a public IP address, `true` or `false`.

      
      * `--router-resource-preset`: [Class](../concepts/instance-types.md) of router hosts.
      * `--router-disk-size`: Router disk size, in GB.
      * `--router-disk-type`: Router [disk type](../concepts/storage.md).
      * `--coordinator-resource-preset`: Class of coordinator hosts.
      * `--coordinator-disk-size`: Coordinator disk size, in GB.
      * `--coordinator-disk-type`: Coordinator disk type.
      * `--infra-resource-preset`: `INFRA` host class.
      * `--infra-disk-size`: `INFRA` disk size, in GB.
      * `--infra-disk-type`: `INFRA` disk type.
      * `--database`: Database settings:
        
        * `name`: Database name.

        Specify a separate `--database` property for each database.

      * `--user`: User settings. This parameter is specified separately for each user and has the following structure:
        
        * `name`: Username.
          
          {% include [user-name-limits](../../_includes/mdb/mspqr/console/user-name-limits.md) %}

        * `password`: User password. The password must be from 8 to 128 characters long.
        * `permission`: Name of the database the user can access.

          Provide a separate `permission` property for each database you want the user to access.

        * `connection-limit`: Maximum number of concurrent user connections.
        * `connection-retries`: Maximum number of connection retry attempts.

      * `--deletion-protection`: Cluster deletion protection, `true` or `false`.

        {% include [deletion-protection-cluster](../../_includes/mdb/mspqr/deletion-protection-cluster.md) %}

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}
      
      1. To set up the [backup window](../concepts/backup.md), provide the following parameters:

          ```bash
          yc managed-sharded-postgresql cluster create \
             ...
             --backup-window-start <backup_start_time> \
             --backup-retain-period-days <automatic_backup_retention_period_in_days> \
             ...
          ```

          Where:

          * `--backup-window-start`: Cluster backup start time (UTC) in `HH:MM:SS` format.
          * `--backup-retain-period-days`: Automatic backup retention period. Possible values: between `7` and `60` days. The default is `7` days.
      


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a {{ mspqr-name }} cluster:

  1. In the configuration file, describe the properties of the following resources:

      * {{ mspqr-name }} cluster
      * Cluster database
      * Cluster user
      * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}
      * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

      Configuration file structure example:

      {% cut "For a cluster with standard sharding" %}

      ```hcl
      resource "yandex_mdb_sharded_postgresql_cluster" "<local_cluster_name>" {
        name                = "<cluster_name>"
        environment         = "<environment>"
        network_id          = yandex_vpc_network.<local_network_name>.id
        security_group_ids  = ["<security_group_IDs>"]
        deletion_protection = <protect_cluster_from_deletion>
  
        config = {
          sharded_postgresql_config = {
            infra = {
              resources = {
                resource_preset_id = "<INFRA_host_class>"
                disk_size          = <storage_size_in_GB>
                disk_type_id       = "<disk_type>"
              }
            }
          }
        }

        hosts = {
          <host_name> = {
            type             = "INFRA"
            zone             = "<availability_zone>"
            subnet_id        = yandex_vpc_subnet.<local_subnet_name>.id
            assign_public_ip = <allow_public_access_to_host>
          }
        } 
      }

      resource "yandex_mdb_sharded_postgresql_database" "<local_DB_name>" {
        cluster_id = yandex_mdb_sharded_postgresql_cluster.<local_cluster_name>.id
        name       = "<DB_name>"
      }
      
      resource "yandex_mdb_sharded_postgresql_user" "<local_username>" {
        cluster_id = yandex_mdb_sharded_postgresql_cluster.<local_cluster_name>.id
        name       = "<username>"
        password   = "<password>"

        permissions {
          database = yandex_mdb_sharded_postgresql_database.<local_DB_name>.name
        }

        settings = {
          connection_limit   = <maximum_number_of_user_connections>
          connection_retries = <maximum_number_of_connection_retry_attempts>
        }
      }

      resource "yandex_vpc_network" "<local_network_name>" {
        name = "<network_name>"
      }

      resource "yandex_vpc_subnet" "<local_subnet_name>" {
        name           = "<subnet_name>"
        zone           = "<availability_zone>"
        network_id     = yandex_vpc_network.<local_network_name>.id
        v4_cidr_blocks = ["<IP_address_range>"]
      }
      ```
      
      {% endcut %}

      {% cut "For a cluster with advanced sharding" %}

      ```hcl
      resource "yandex_mdb_sharded_postgresql_cluster" "<local_cluster_name>" {
        name                = "<cluster_name>"
        environment         = "<environment>"
        network_id          = yandex_vpc_network.<local_network_name>.id
        security_group_ids  = ["<security_group_IDs>"]
        deletion_protection = <protect_cluster_from_deletion>
  
        config = {
          sharded_postgresql_config = {
            router = {
              resources = {
                resource_preset_id = "<router_host_class>"
                disk_size          = <storage_size_in_GB>
                disk_type_id       = "<disk_type>"
              }
            }
            
            coordinator = {
              resources = {
                resource_preset_id = "<coordinator_host_class>"
                disk_size          = <storage_size_in_GB>
                disk_type_id       = "<disk_type>"
              }
            }
          }
        }

        hosts = {
          <host_1_name> = {
            type             = "ROUTER"
            zone             = "<availability_zone>"
            subnet_id        = yandex_vpc_subnet.<local_subnet_name>.id
            assign_public_ip = <allow_public_access_to_host>
          }

          <host_2_name> = {
            type             = "COORDINATOR"
            zone             = "<availability_zone>"
            subnet_id        = yandex_vpc_subnet.<local_subnet_name>.id
            assign_public_ip = <allow_public_access_to_host>
          }
        } 
      }

      resource "yandex_mdb_sharded_postgresql_database" "<local_DB_name>" {
        cluster_id = yandex_mdb_sharded_postgresql_cluster.<local_cluster_name>.id
        name       = "<DB_name>"
      }
      
      resource "yandex_mdb_sharded_postgresql_user" "<local_username>" {
        cluster_id = yandex_mdb_sharded_postgresql_cluster.<local_cluster_name>.id
        name       = "<username>"
        password   = "<password>"

        permissions {
          database = yandex_mdb_sharded_postgresql_database.<local_DB_name>.name
        }

        settings = {
          connection_limit   = <number_of_user_connections>
          connection_retries = <number_of_retries_when_connecting>
        }
      }

      resource "yandex_vpc_network" "<local_network_name>" {
        name = "<network_name>"
      }

      resource "yandex_vpc_subnet" "<local_subnet_name>" {
        name           = "<subnet_name>"
        zone           = "<availability_zone>"
        network_id     = yandex_vpc_network.<local_network_name>.id
        v4_cidr_blocks = ["<IP_address_range>"]
      }
      ```

      {% endcut %}

      Where:

      * `name`: Cluster name.
      * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
      * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be deployed in.

        {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

      * `security_group_ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}
      
      * `deletion_protection`: Cluster deletion protection, `true` or `false`.

        {% include [deletion-protection-cluster](../../_includes/mdb/mspqr/deletion-protection-cluster.md) %}

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

      * `hosts`: Cluster hosts as an associative array of elements. The key specifies the host name, and the value, the host parameters. Each element in the array has the following structure:

        * `type`: Host type. Its possible values are:
          
          * `ROUTER`: [Router](../concepts/index.md#router) in a cluster with advanced sharding.
          * `COORDINATOR`: [Coordinator](../concepts/index.md#coordinator) in a cluster with advanced sharding.
          * `INFRA`: `INFRA` host in a cluster with standard sharding.
        
        * `zone`: [Availability zone](../../overview/concepts/geo-scope.md).
        * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
        * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
      
      * `config.sharded_postgresql_config.router.resources`: Router resource parameters in a cluster with advanced sharding:
        
        * `resource_preset_id`: [Host class](../concepts/instance-types.md).
        * `disk_size`: Disk size, in GB.
        * `disk_type_id`: [Disk type](../concepts/storage.md).
      
      * `config.sharded_postgresql_config.coordinator.resources`: Coordinator resource parameters in a cluster with advanced sharding:
        
        * `resource_preset_id`: Host class.
        * `disk_size`: Disk size, in GB.
        * `disk_type_id`: Disk type.
      
      * `config.sharded_postgresql_config.infra.resources`: `INFRA` host resource parameters in a cluster with standard sharding:
        
        * `resource_preset_id`: Host class.
        * `disk_size`: Disk size, in GB.
        * `disk_type_id`: Disk type.
      
      1. To set up the [backup window](../concepts/backup.md), provide the `config` section to the following parameters:

          ```hcl
          resource "yandex_mdb_sharded_postgresql_cluster" "<local_cluster_name>" {
            ...
            config = {
              backup_window_start = {
                hours   = <hours>
                minutes = <minutes>
              }

              backup_retain_period_days = <automatic_backup_retention_period_in_days>
              ...
            }
            ...
          }
          ```

          Where:

          * `backup_window_start`: Cluster backup start time (UTC):
        
            * `hours`: From `0` to `23` hours.
            * `minutes`: From `0` to `59` minutes.
        
          * `backup_retain_period_days`: Automatic backup retention period. Possible values: between `7` and `60` days. The default is `7` days.
    
      1. {% include [Maintenance window](../../_includes/mdb/mspqr/terraform/maintenance-window.md) %}
  
      For more information about the `yandex_mdb_sharded_postgresql_cluster` resource, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster).

  1. Validate your {{ TF }} configuration:

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a cluster:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}
      
      {% include [Terraform timeouts](../../_includes/mdb/mspqr/terraform/timeouts.md) %}


- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

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
         { <similar_settings_for_DB_2> },
         { ... },
         { <similar_settings_for_DB_N> }
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
           "hour": "<sequence_number_of_hour_interval>"
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

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


     * `deletionProtection`: Cluster deletion protection, `true` or `false`.

        {% include [deletion-protection-cluster](../../_includes/mdb/mspqr/deletion-protection-cluster.md) %}

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


       * `type`: Host type. Its possible values are:
         
         * `ROUTER`: Router in a cluster with advanced sharding.
         * `COORDINATOR`: Coordinator in a cluster with advanced sharding.
         * `INFRA`: `INFRA` host in a cluster with standard sharding.

     * `shardSpecs`: Shard settings as an array of elements, one per shard. Each element has the following structure:

       * `shardName`: Shard name.
       * `mdbPostgresql.clusterId`: {{ mpg-name }} cluster ID within the shard.

     * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings, including for disabled clusters. Provide one of these two properties:

         * `anytime`: Maintenance takes place at any time.
         * `weeklyMaintenanceWindow`: Maintenance takes place once a week at the specified time:

             * `day`: Day of week, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
             * `hour`: UTC hour interval, from `1` to `24`.

               > For example, `1` stands for the interval from `00:00` to `01:00`, and `5`, from `04:00` to `05:00`.

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

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
         { <similar_settings_for_DB_2> },
         { ... },
         { <similar_settings_for_DB_N> }
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
           "hour": "<sequence_number_of_hour_interval>"
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

        {% include [note-sg](../../_includes/managed-spqr/note-sg.md) %}


     * `deletion_protection`: Cluster deletion protection, `true` or `false`.

        {% include [deletion-protection-cluster](../../_includes/mdb/mspqr/deletion-protection-cluster.md) %}

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


       * `type`: Host type. Its possible values are:
         
         * `ROUTER`: Router in a cluster with advanced sharding.
         * `COORDINATOR`: Coordinator in a cluster with advanced sharding.
         * `INFRA`: `INFRA` host in a cluster with standard sharding.

     * `shard_specs`: Shard settings as an array of elements, one per shard. Each element has the following structure:

       * `shard_name`: Shard name.
       * `mdb_postgresql.cluster_id`: {{ mpg-name }} cluster ID within the shard.

     * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings, including for disabled clusters. Provide one of these two properties:

         * `anytime`: Maintenance takes place at any time.
         * `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:

             * `day`: Day of week, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
             * `hour`: UTC hour interval, from `1` to `24`.

               > For example, `1` stands for the interval from `00:00` to `01:00`, and `5`, from `04:00` to `05:00`.

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


## Examples {#examples}


### Creating a cluster with standard sharding {#creating-standard-sharded-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a {{ mspqr-name }} cluster with the following test specifications:

  * Name: `spqr-std`.
  * Environment: `production`.
  * Network: `{{ network-name }}`.

    
  * Security group: `enpjfvd3f34c********`.
  * Single `infra` host in the `{{ region-id }}-a` availability zone in the `e9bhbia2scnk********` subnet.

  
  * Host class: `{{ host-class }}`.
  
  
  * Network SSD storage (`{{ disk-type-example }}`): `10` GB.
  

  * Database: `db1`.
  * User: `user1`; password: `Password123`; `db1` access granted.
  * Cluster protection from accidental deletion: Enabled.

  Run this command:

  
  ```bash
  yc managed-sharded-postgresql cluster create \
     --name spqr-std \
     --environment production \
     --network-name {{ network-name }} \
     --security-group-ids enpjfvd3f34c******** \
     --host type=infra,zone-id={{ region-id }}-a,subnet-id=e9bhbia2scnk******** \
     --infra-resource-preset {{ host-class }} \
     --infra-disk-size 10 \
     --infra-disk-type {{ disk-type-example }} \
     --database name=db1 \
     --user name=user1,password=Password123,permission=db1 \
     --deletion-protection=true
  ```



- {{ TF }} {#tf}
  
  Create a {{ mspqr-name }} cluster, along with a network, subnet, and security group for it using the following test specifications:
  
  * Name: `spqr-std`.
  * Environment: `PRODUCTION`.
  * Network: `spqr-network`.
  * Security group: `spqr-sg` with rules allowing inbound and outbound TCP connections on port `{{ port-mpg }}`.
    
    These rules allow the router to connect to the shard hosts and enable internet access to the cluster. To connect to your cluster over the internet, enable public access to the host as well. [Learn more about connecting to clusters](connect.md).

  * Single `INFRA` host in the `{{ region-id }}-a` availability zone in the `spqr-network-{{ region-id }}-a` subnet with the `10.128.0.0/24` IP address range.
  * Host class: `{{ host-class }}`.
  * Network SSD storage (`{{ disk-type-example }}`): `10` GB.
  * Database: `db1`.
  * User: `user1`; password: `Password123`; `db1` access granted.
  * Cluster protection from accidental deletion: Enabled.
  
  The configuration file for creating these resources looks like this:

  ```hcl
  resource "yandex_vpc_network" "spqr_network" {
    description = "Network for the Managed Service for Sharded PostgreSQL"
    name        = "spqr-network"
  }

  resource "yandex_vpc_subnet" "subnet_a" {
    description    = "Subnet in the {{ region-id }}-a availability zone"
    name           = "spqr-network-{{ region-id }}-a"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.spqr_network.id
    v4_cidr_blocks = ["10.128.0.0/24"]
  }

  resource "yandex_vpc_security_group" "spqr_sg" {
    description = "Security group for the Managed Service for Sharded PostgreSQL"
    name        = "spqr-sg"
    network_id  = yandex_vpc_network.spqr_network.id

    ingress {
      description    = "Allow connections from the Internet and between cluster components"
      port           = 6432
      protocol       = "TCP"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      description    = "Allow connections between cluster components"
      port           = 6432
      protocol       = "TCP"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  }

  resource "yandex_mdb_sharded_postgresql_cluster" "spqr_cluster" {
    description         = "Managed Service for Sharded PostgreSQL cluster with standard sharding"
    name                = "spqr-std"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.spqr_network.id
    security_group_ids  = [yandex_vpc_security_group.spqr_sg.id]
    deletion_protection = true
  
    config = {
      sharded_postgresql_config = {
        infra = {
          resources = {
            disk_size          = 10
            disk_type_id       = "{{ disk-type-example }}"
            resource_preset_id = "{{ host-class }}"
          }
        }
      }
    }

    hosts = {
      infra1 = {
        type      = "INFRA"
        zone      = "{{ region-id }}-a"
        subnet_id = yandex_vpc_subnet.subnet_a.id
      }
    } 
  }

  resource "yandex_mdb_sharded_postgresql_database" "spqr_cluster_db" {
    cluster_id = yandex_mdb_sharded_postgresql_cluster.spqr_cluster.id
    name       = "db1"
  }

  resource "yandex_mdb_sharded_postgresql_user" "spqr_cluster_user" {
    cluster_id = yandex_mdb_sharded_postgresql_cluster.spqr_cluster.id
    name       = "user1"
    password   = "Password123"
    
    permissions {
      database = yandex_mdb_sharded_postgresql_database.spqr_cluster_db.name
    }
  }
  ```


{% endlist %}


### Creating a cluster with advanced sharding {#creating-advanced-sharded-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a {{ mspqr-name }} cluster with the following test specifications:

  * Name: `spqr-adv`.
  * Environment: `production`.
  * Network: `{{ network-name }}`.
  
  
  * Security group: `enpjfvd3f34c********`.
  * Three `router` hosts of `{{ host-class }}` class, one in each availability zone:
    
    * In the `{{ region-id }}-a` availability zone in the `e9bhbia2scnk********` subnet.
    * In the `{{ region-id }}-b` availability zone in the `e2lfqbm5nt9r********` subnet.
    * In the `{{ region-id }}-d` availability zone in the `fl8beqmjckv8********` subnet.
  
  * Three `coordinator` hosts of `{{ host-class }}` class, one in each availability zone:
    
    * In the `{{ region-id }}-a` availability zone in the `e9bhbia2scnk********` subnet.
    * In the `{{ region-id }}-b` availability zone in the `e2lfqbm5nt9r********` subnet.
    * In the `{{ region-id }}-d` availability zone in the `fl8beqmjckv8********` subnet.

  * Network SSD storage (`{{ disk-type-example }}`) for each of the `router` hosts: `10` GB.
  * Network SSD storage (`{{ disk-type-example }}`) for each of the `coordinator` hosts: `10` GB.
  

  * Database: `db1`.
  * User: `user1`; password: `Password123`; `db1` access granted.
  * Cluster protection from accidental deletion: Enabled.

  Run this command:

  
  ```bash
  yc managed-sharded-postgresql cluster create \
     --name spqr-adv \
     --environment production \
     --network-name {{ network-name }} \
     --security-group-ids enpjfvd3f34c******** \
     --host type=router,zone-id={{ region-id }}-a,subnet-id=e9bhbia2scnk******** \
     --host type=router,zone-id={{ region-id }}-b,subnet-id=e2lfqbm5nt9r******** \
     --host type=router,zone-id={{ region-id }}-d,subnet-id=fl8beqmjckv8******** \
     --host type=coordinator,zone-id={{ region-id }}-a,subnet-id=e9bhbia2scnk******** \
     --host type=coordinator,zone-id={{ region-id }}-b,subnet-id=e2lfqbm5nt9r******** \
     --host type=coordinator,zone-id={{ region-id }}-d,subnet-id=fl8beqmjckv8******** \
     --router-resource-preset {{ host-class }} \
     --router-disk-size 10 \
     --router-disk-type {{ disk-type-example }} \
     --coordinator-resource-preset {{ host-class }} \
     --coordinator-disk-size 10 \
     --coordinator-disk-type {{ disk-type-example }} \
     --database name=db1 \
     --user name=user1,password=Password123,permission=db1 \
     --deletion-protection=true
  ```



- {{ TF }} {#tf}
  
  Create a {{ mspqr-name }} cluster, along with a network, subnet, and security group for it using the following test specifications:
  
  * Name: `spqr-adv`.
  * Environment: `PRODUCTION`.
  * Network: `spqr-network`.
  * Security group: `spqr-sg` with rules allowing inbound and outbound TCP connections on port `{{ port-mpg }}`.
    
    These rules allow the router to connect to the shard hosts and enable internet access to the cluster. To connect to your cluster over the internet, enable public access to the hosts as well. [Learn more about connecting to clusters](connect.md).
  
  * Three `ROUTER` hosts of `{{ host-class }}` class, one in each availability zone:
    
    * In the `{{ region-id }}-a` availability zone in the `spqr-network-{{ region-id }}-a` subnet with the `10.128.0.0/24` IP address range.
    * In the `{{ region-id }}-b` availability zone in the `spqr-network-{{ region-id }}-b` subnet with the `10.128.1.0/24` IP address range.
    * In the `{{ region-id }}-d` availability zone in the `spqr-network-{{ region-id }}-d` subnet with the `10.128.2.0/24` IP address range.
  
  * Three `COORDINATOR` hosts of `{{ host-class }}` class, one in each availability zone:
    
    * In the `{{ region-id }}-a` availability zone in the `spqr-network-{{ region-id }}-a` subnet with the `10.128.0.0/24` IP address range.
    * In the `{{ region-id }}-b` availability zone in the `spqr-network-{{ region-id }}-b` subnet with the `10.128.1.0/24` IP address range.
    * In the `{{ region-id }}-d` availability zone in the `spqr-network-{{ region-id }}-d` subnet with the `10.128.2.0/24` IP address range.
  
  * Network SSD storage (`{{ disk-type-example }}`) for each of the `ROUTER` hosts: `10` GB.
  * Network SSD storage (`{{ disk-type-example }}`) for each of the `COORDINATOR` hosts: `10` GB.
  * Database: `db1`.
  * User: `user1`; password: `Password123`; `db1` access granted.
  * Cluster protection from accidental deletion: Enabled.
  
  The configuration file for creating these resources looks like this:

  ```hcl
  resource "yandex_vpc_network" "spqr_network" {
    description = "Network for the Managed Service for Sharded PostgreSQL"
    name        = "spqr-network"
  }

  resource "yandex_vpc_subnet" "subnet_a" {
    description    = "Subnet in the {{ region-id }}-a availability zone"
    name           = "spqr-network-{{ region-id }}-a"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.spqr_network.id
    v4_cidr_blocks = ["10.128.0.0/24"]
  }

  resource "yandex_vpc_subnet" "subnet_b" {
    description    = "Subnet in the {{ region-id }}-b availability zone"
    name           = "spqr-network-{{ region-id }}-b"
    zone           = "{{ region-id }}-b"
    network_id     = yandex_vpc_network.spqr_network.id
    v4_cidr_blocks = ["10.128.1.0/24"]
  }

  resource "yandex_vpc_subnet" "subnet_d" {
    description    = "Subnet in the {{ region-id }}-d availability zone"
    name           = "spqr-network-{{ region-id }}-d"
    zone           = "{{ region-id }}-d"
    network_id     = yandex_vpc_network.spqr_network.id
    v4_cidr_blocks = ["10.128.2.0/24"]
  }

  resource "yandex_vpc_security_group" "spqr_sg" {
    description = "Security group for the Managed Service for Sharded PostgreSQL"
    name        = "spqr-sg"
    network_id  = yandex_vpc_network.spqr_network.id

    ingress {
      description    = "Allow connections from the Internet and between cluster components"
      port           = 6432
      protocol       = "TCP"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      description    = "Allow connections between cluster components"
      port           = 6432
      protocol       = "TCP"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  }

  resource "yandex_mdb_sharded_postgresql_cluster" "spqr_cluster" {
    description         = "Managed Service for Sharded PostgreSQL cluster with advanced sharding"
    name                = "spqr-adv"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.spqr_network.id
    security_group_ids  = [yandex_vpc_security_group.spqr_sg.id]
    deletion_protection = true
  
    config = {
      sharded_postgresql_config = {
        router = {
          resources = {
            disk_size          = 10
            disk_type_id       = "{{ disk-type-example }}"
            resource_preset_id = "{{ host-class }}"
          }
        }
        coordinator = {
          resources = {
            disk_size          = 10
            disk_type_id       = "{{ disk-type-example }}"
            resource_preset_id = "{{ host-class }}"
          }
        }
      }
    }

    hosts = {
      router1 = {
        type      = "ROUTER"
        zone      = "{{ region-id }}-a"
        subnet_id = yandex_vpc_subnet.subnet_a.id
      }

      router2 = {
        type      = "ROUTER"
        zone      = "{{ region-id }}-b"
        subnet_id = yandex_vpc_subnet.subnet_b.id
      }
    
      router3 = {
        type      = "ROUTER"
        zone      = "{{ region-id }}-d"
        subnet_id = yandex_vpc_subnet.subnet_d.id
      }

      coordinator1 = {
        type      = "COORDINATOR"
        zone      = "{{ region-id }}-a"
        subnet_id = yandex_vpc_subnet.subnet_a.id
      }

      coordinator2 = {
        type      = "COORDINATOR"
        zone      = "{{ region-id }}-b"
        subnet_id = yandex_vpc_subnet.subnet_b.id
      }
    
      coordinator3 = {
        type      = "COORDINATOR"
        zone      = "{{ region-id }}-d"
        subnet_id = yandex_vpc_subnet.subnet_d.id
      }
    } 
  }

  resource "yandex_mdb_sharded_postgresql_database" "spqr_cluster_db" {
    cluster_id = yandex_mdb_sharded_postgresql_cluster.spqr_cluster.id
    name       = "db1"
  }

  resource "yandex_mdb_sharded_postgresql_user" "spqr_cluster_user" {
    cluster_id = yandex_mdb_sharded_postgresql_cluster.spqr_cluster.id
    name       = "user1"
    password   = "Password123"
  
    permissions {
      database = yandex_mdb_sharded_postgresql_database.spqr_cluster_db.name
    }
  }
  ```


{% endlist %}