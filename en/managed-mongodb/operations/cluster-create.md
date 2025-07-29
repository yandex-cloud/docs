---
title: Creating a {{ MG }} cluster
description: Follow this guide to create a {{ MG }} cluster.
---

# Creating a {{ MG }} cluster

A {{ MG }} cluster is one or more database hosts between which you can configure [replication](../concepts/replication.md). Replication is enabled by default in any cluster consisting of more than one host, where the primary host accepts write requests and asynchronously replicates the changes in the secondary hosts.


{% note info %}

* The number of hosts you can create together with a {{ MG }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

{% endnote %}




## Creating a cluster {#create-cluster}


To create a {{ mmg-name }} cluster, you will need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) and [{{ roles.mmg.editor }} roles or higher](../security/index.md#roles-list). For information on assigning roles, see the [{{ iam-name }}](../../iam/operations/roles/grant.md) documentation.


{% list tabs group=instructions %}

- Management console {#console}

  To create a {{ mmg-name }} cluster:

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.

  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

      * Enter a name in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. The cluster name must be unique within the cloud.
      * (Optional) Enter a cluster **{{ ui-key.yacloud.mdb.forms.base_field_description }}**.
      * Select the environment where you want to create the cluster (you cannot change the environment once the cluster is created):

          * `PRODUCTION`: For stable versions of your apps.
          * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test the compatibility of new versions with your application.

      * Specify the DBMS version.

  1. {% include [mmg-settings-host-class](../../_includes/mdb/mmg/settings-host-class.md) %}

  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      * Select the [disk type](../concepts/storage.md).

        {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}

      * Select the storage size to be used for data and backups. For more information on how backups take up storage space, see [Backups](../concepts/backup.md).

      
      * Optionally, select the **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}** option to encrypt the disk with a [custom KMS key](../../kms/concepts/key.md).

        {% include [preview-note](../../_includes/note-preview-by-request.md) %}

        * To [create](../../kms/operations/key.md#create) a new key, click **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.

        * To use the key you created earlier, select it in the **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** field.

        To learn more about disk encryption, see [Storage](../../network-load-balancer/k8s-ref/networkpolicy.md).


  1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify the DB attributes:

      * DB name.

        {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

      * Username.
      * User password. The password must be at least 8 characters long.

  
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select:

      * [Cloud network](../../vpc/concepts/network.md#network) for the cluster.
      * Security groups for the cluster network traffic. You may need to additionally [set up security groups](connect/index.md#configuring-security-groups) to be able to connect to the cluster.


  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, add the DB hosts created with the cluster:

     
     * Click **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.
     * Select the [availability zone](../../overview/concepts/geo-scope.md).
     * Select a [subnet](../../vpc/concepts/network.md#subnet) in the specified availability zone. If there is no subnet, create one.
     * If the host must be available outside {{ yandex-cloud }}, enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

     
     To ensure fault tolerance, you need at least 3 hosts for `local-ssd` and `network-ssd-nonreplicated` disk types. For more information, see [Storage](../concepts/storage.md).

     By default, hosts are created in different availability zones. Read more about [host management](hosts.md).
  
  1. Configure additional cluster settings, if required:

      {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}

  1. Configure the [DBMS settings](../concepts/settings-list.md#dbms-cluster-settings), if required.

      {% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ mmg-name }} cluster:

  
  1. Check whether the folder has any subnets for the cluster hosts:

     ```bash
     yc vpc subnet list
     ```

     If there are no subnets in the folder, [create the required subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.


  1. View the description of the CLI command to create a cluster:

      ```bash
      {{ yc-mdb-mg }} cluster create --help
      ```

  1. Specify the cluster parameters in the create command (not all parameters are given in the example):

      
      ```bash
      {{ yc-mdb-mg }} cluster create \
        --name <cluster_name> \
        --environment=<environment> \
        --network-name <network_name> \
        --host zone-id=<availability_zone>,`
              `subnet-id=<subnet_ID>,`
              `assign-public-ip=<public_access_to_host>,`
              `hidden=<hide_host>,`
              `secondary-delay-secs=<replica_lag_in_seconds>,`
              `priority=<host_priority> \
        --mongod-resource-preset <host_class> \
        --user name=<user_name>,password=<user_password> \
        --database name=<DB_name> \
        --mongod-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --mongod-disk-size <storage_size_in_GB> \
        --performance-diagnostics=<enable_diagnostics> \
        --deletion-protection
      ```

      You need to specify the `subnet-id` if the selected availability zone has two or more subnets.


      Where:

      * `--environment`: Environment, `prestable` or `production`.

      
      * `--host`: Host parameters:
         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
         * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
         * `assign-public-ip`: Internet access to the host via a public IP address, `true` or `false`.
         * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
         * `secondary-delay-secs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
         * `priority`: [Priority for assigning the host as a master](../concepts/replication.md#master-failover).

      * `--mongod-disk-type`: Disk type.


      * `--performance-diagnostics`: Enables cluster performance diagnostics, `true` or `false`.
      
      * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

      {% note info %}

      When creating a cluster, the `anytime` [maintenance](../concepts/maintenance.md) mode is set by default. You can set a specific maintenance period when [updating the cluster settings](update.md#change-additional-settings).

      {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a {{ mmg-name }} cluster:

  1. In the configuration file, describe the parameters of resources you want to create:

     * Database cluster: Description of the cluster and its hosts.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Here is an example of the configuration file structure:

     
     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
       name                = "<cluster_name>"
       environment         = "<environment>"
       network_id          = "<network_ID>"
       security_group_ids  = [ "<list_of_security_group_IDs>" ]
       deletion_protection = <cluster_deletion_protection>

       cluster_config {
         version = "<{{ MG }}_version>"
       }

       resources_mongod {
         resource_preset_id = "<host_class>"
         disk_type_id       = "<disk_type>"
         disk_size          = <storage_size_in_GB>
       }

       host {
         zone_id          = "<availability_zone>"
         subnet_id        = "<subnet_ID>"
         assign_public_ip = <public_access>
         host_parameters {
           hidden               = <hide_host>
           secondary_delay_secs = <replica_lag_in_seconds>
           priority             = <host_priority>
         }
       }
     }

     resource "yandex_mdb_mongodb_database" "<DB_name>" {
       cluster_id = "<cluster_ID>"
       name       = "<DB_name>"
     }

     resource "yandex_mdb_mongodb_user" "<user_name>" {
       cluster_id = <cluster_ID>
       name       = "<user_name>"
       password   = "<password>"
       permission {
         database_name = "<DB_name>"
         roles         = [ "<list_of_user_roles>" ]
       }
       depends_on = [
         yandex_mdb_mongodb_database.<DB_name>
       ]
     }

     resource "yandex_vpc_network" "<network_name>" { name = "<network_name>" }

     resource "yandex_vpc_subnet" "<subnet_name>" {
       name           = "<subnet_name>"
       zone           = "<availability_zone>"
       network_id     = "<network_ID>"
       v4_cidr_blocks = ["<range>"]
     }
     ```


     Where:

     * `environment`: Environment, `PRESTABLE` or `PRODUCTION`.
     * `host`: Host parameters:
       * `zone_id`: Availability zone.
       * `subnet_id`: ID of a subnet in the selected availability zone.
       * `assign_public_ip`: Public access to the host, `true` or `false`.
       * `host_parameters`: Additional host parameters:
         * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
         * `secondary_delay_secs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
         * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).
     * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

     * `version`: {{ MG }} version, {{ versions.tf.str }}.

     {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

     {% include [Maintenance window](../../_includes/mdb/mmg/terraform/maintenance-window.md) %}

     For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-mmg }}).

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      After this, all required resources will be created in the specified folder, and the [host FQDNs](../concepts/network.md#hostname) will be displayed in the terminal. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

      {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and add the following contents to it:

        
        ```json
        {
          "folderId": "<folder_ID>",
          "name": "<cluster_name>",
          "environment": "<environment>",
          "networkId": "<network_ID>",
          "securityGroupIds": [
            "<security_group_1_ID>",
            "<security_group_2_ID>",
            ...
            "<security_group_N_ID>"
          ],
          "deletionProtection": <cluster_deletion_protection:_true_or_false>,
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "configSpec": {
            "version": "<{{ MG }}_version>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resourcePresetId": "<host_class>",
                  "diskSize": "<storage_size_in_bytes>",
                  "diskTypeId": "<disk_type>"
                }
              }
            },
            "backupWindowStart":  {
              "hours": "<hours>",
              "minutes": "<minutes>",
              "seconds": "<seconds>",
              "nanos": "<nanoseconds>"
            },  
            "backupRetainPeriodDays": "<backup_retention_in_days>",
            "performanceDiagnostics": {
              "profilingEnabled": <enable_profiler:_true_or_false>
            }
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
                  "databaseName": "<DB_name>",
                  "roles": [
                    "<role_1>", "<role_2>", ..., "<role_N>"
                  ]
                }
              ]
            },
            { <similar_configuration_for_user_2> },
            { ... },
            { <similar_configuration_for_user_N> }
          ],
          "hostSpecs": [
            {
              "zoneId": "<availability_zone>",
              "subnetId": "<subnet_ID>",
              "assignPublicIp": <public_access_to_host:_true_or_false>,
              "type": "<host_type>",
              "shardName": "<shard_name>",
              "hidden": <hide_host:_true_or_false>,
              "secondaryDelaySecs": "<replica_lag_in_seconds>",
              "priority": "<host_priority>",
              "tags": "<host_labels>"
            },
            { <similar_configuration_for_host_2> },
            { ... },
            { <similar_configuration_for_host_N> }
          ],
        }
        ```


        Where:

        * `folderId`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
        * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be in.

        
        * `securityGroupIds`: [Security group](../concepts/network.md#security-groups) IDs.


        * `deletionProtection`: Cluster protection from accidental deletion, `true` or `false`.

          {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). In `maintenanceWindow`, provide one of the two parameters:

          * `anytime`: Maintenance can take place at any time.
          * `weeklyMaintenanceWindow`: Maintenance takes place once a week at the specified time:

            * `day`: Day of week, in `DDD` format.
            * `hour`: Hour, in `HH` format. The values range from `1` to `24` hours.

        * `configSpec`: Cluster settings:

            * `version`: {{ MG }} version: 5.0, 6.0, or 7.0.
            * `mongod`: Host type.

              * `resources`: Cluster resources:

                * `resourcePresetId`: [Host class](../concepts/instance-types.md).
                * `diskSize`: Disk size in bytes.
                * `diskTypeId`: [Disk type](../concepts/storage.md).

            * `backupWindowStart`: [Backup](../concepts/backup.md) window settings.

              In this parameter, specify the backup start time:

              * `hours`: Between `0` and `23` hours.
              * `minutes`: Between `0` and `59` minutes.
              * `seconds`: Between `0` and `59` seconds.
              * `nanos`: Between `0` and `999999999` nanoseconds.

            * `backupRetainPeriodDays`: Backup retention in days.

            * `performanceDiagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:
              * `profilingEnabled`: Enable [profiler](tools.md#explore-profiler). 

        * `databaseSpecs`: Database settings as an array of elements, one for each DB. Each element contains the `name` parameter with the DB name.

            {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

        * `userSpecs`: User settings as an array of elements, one for each user. Each element has the following structure:

          * `name`: Username.
          * `password`: User password.
          * `permissions`: User permissions settings:

            * `databaseName`: Name of the database the user gets access to.
            * `roles`: Array of user roles. Each role is provided as a separate string in the array. For a list of possible values, see [Users and roles](../concepts/users-and-roles.md).

            For each database, add a separate element with permission settings to the `permissions` array.

        * `hostSpecs`: Cluster host settings as an array of elements, one for each host. Each element has the following structure:

          * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp`: Internet access to the host via a public IP address.
          * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`.
          * `shardName`: Shard name in a sharded cluster.
          * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
          * `secondaryDelaySecs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
          * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).
          * `tags`: Host labels.

  1. Use the [Cluster.Create](../api-ref/Cluster/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters' \
          --data "@body.json"
      ```

  1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and add the following contents to it:

        
        ```json
        {
          "folder_id": "<folder_ID>",
          "name": "<cluster_name>",
          "environment": "<environment>",
          "network_id": "<network_ID>",
          "security_group_ids": [
            "<security_group_1_ID>",
            "<security_group_2_ID>",
            ...
            "<security_group_N_ID>"
          ],
          "deletion_protection": <cluster_deletion_protection:_true_or_false>,
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "config_spec": {
            "version": "<{{ MG }}_version>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resource_preset_id": "<host_class>",
                  "disk_size": "<storage_size_in_bytes>",
                  "disk_type_id": "<disk_type>"
                }
              }
            },
            "backup_window_start": {
              "hours": "<hours>",
              "minutes": "<minutes>",
              "seconds": "<seconds>",
              "nanos": "<nanoseconds>"
            },
            "backup_retain_period_days": "<backup_retention_in_days>",
            "performance_diagnostics": {
              "profiling_enabled": <enable_profiler:_true_or_false>
            }
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
                  "database_name": "<DB_name>",
                  "roles": [
                    "<role_1>", "<role_2>", ..., "<role_N>"
                  ]
                }
              ]
            },
            { <similar_configuration_for_user_2> },
            { ... },
            { <similar_configuration_for_user_N> }
          ],
          "host_specs": [
            {
              "zone_id": "<availability_zone>",
              "subnet_id": "<subnet_ID>",
              "assign_public_ip": <public_access_to_host:_true_or_false>,
              "type": "<host_type>",
              "shard_name": "<shard_name>",
              "hidden": <hide_host:_true_or_false>,
              "secondary_delay_secs": "<replica_lag_in_seconds>",
              "priority": "<host_priority>",
              "tags": "<host_labels>"
            },
            { <similar_configuration_for_host_2> },
            { ... },
            { <similar_configuration_for_host_N> }
          ]
        }
        ```


        Where:

        * `folder_id`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
        * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be in.

        
        * `security_group_ids`: [Security group](../concepts/network.md#security-groups) IDs.


        * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

          {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). In `maintenance_window`, provide one of the two parameters:

          * `anytime`: Maintenance can take place at any time.
          * `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:

            * `day`: Day of week, in `DDD` format.
            * `hour`: Hour, in `HH` format. The values range from `1` to `24` hours.

        * `config_spec`: Cluster settings:

          * `version`: {{ MG }} version: 5.0, 6.0, or 7.0.
            * `mongod`: Host type.

              * `resources`: Cluster resources:

                * `resource_preset_id`: [Host class](../concepts/instance-types.md).
                * `disk_size`: Disk size in bytes.
                * `disk_type_id`: [Disk type](../concepts/storage.md).

            * `backup_window_start`: [Backup](../concepts/backup.md) window settings.

              In this parameter, specify the backup start time:

              * `hours`: Between `0` and `23` hours.
              * `minutes`: Between `0` and `59` minutes.
              * `seconds`: Between `0` and `59` seconds.
              * `nanos`: Between `0` and `999999999` nanoseconds.

            * `backup_retain_period_days`: Backup retention in days.

            * `performance_diagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:
              * `profiling_enabled`: Enable [profiler](tools.md#explore-profiler).

        * `database_specs`: Database settings as an array of elements, one for each DB. Each element contains the `name` parameter with the DB name.

            {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

        * `user_specs`: User settings as an array of elements, one for each user. Each element has the following structure:

          * `name`: Username.
          * `password`: User password.
          * `permissions`: User permission settings:

            * `database_name`: Name of the database the user gets access to.
            * `roles`: Array of user roles. Each role is provided as a separate string in the array. For a list of possible values, see [Users and roles](../concepts/users-and-roles.md).

            For each database, add a separate element with permission settings to the `permissions` array.

        * `host_specs`: Cluster host settings as an array of elements, one for each host. Each element has the following structure:

          * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assign_public_ip`: Internet access to the host via a public IP address.
          * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`.
          * `shard_name`: Shard name in a sharded cluster.
          * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
          * `secondaryDelaySecs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
          * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).
          * `tags`: Host labels.

  1. Use the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Create \
          < body.json
      ```

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}


{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to additionally [configure security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}


## Creating a cluster copy {#duplicate}

You can create a {{ MG }} cluster using the settings of another one created earlier. To do so, import the source {{ MG }} cluster’s configuration to {{ TF }}. This way, you can either create an identical copy or use the configuration you imported as the baseline and modify it as needed. Importing a configuration is a good idea when the source {{ MG }} cluster has a lot of settings and you need to create a similar one.

To create a {{ MG }} cluster copy:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. In the same working directory, place a `.tf` file with the following contents:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "old" { }
        ```

    1. Write the initial {{ MG }} cluster’s ID to the environment variable:

        ```bash
        export MONGODB_CLUSTER_ID=<cluster_ID>
        ```

        You can get the ID with the [list of clusters in the folder](../../managed-mongodb/operations/cluster-list.md#list-clusters).

    1. Import the initial {{ MG }} cluster’s settings into the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_mongodb_cluster.old ${MONGODB_CLUSTER_ID}
        ```

    1. Get the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from the terminal and paste it into the `.tf` file.
    1. Place the file in the new `imported-cluster` directory.
    1. Modify the copied configuration so that you can create a new cluster from it:

        * Specify the new cluster name in the `resource` string and the `name` parameter.
        * Delete `created_at`, `health`, `id`, `sharded`, and `status`.
        * In the `host` sections, delete `health` and `name`.
        * If the `maintenance_window` section has `type = "ANYTIME"`, delete the `hour` parameter.
        * Delete all `user` sections (if any). You can add database users using the separate `yandex_mdb_mongodb_user` resource.
        * Optionally, make further changes if you need to customize the configuration.

    1. [Get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) in the `imported-cluster` directory.

    1. In the same directory, [configure and initialize a provider](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). To avoid creating a configuration file with provider settings manually, [download it](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Place the configuration file in the `imported-cluster` directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you did not add the authentication credentials to environment variables, specify them in the configuration file.

    1. Check that the {{ TF }} configuration files are correct:

        ```bash
        terraform validate
        ```

        {{ TF }} will show any errors found in your configuration files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  To create a cluster with a single host, provide a single `--host` parameter.

  Create a {{ mmg-name }} cluster with the following test specifications:

  
  * Name: `mymg`.
  * Environment: `production`.
  * Network: `{{ network-name }}`.
  * Security group ID: `{{ security-group }}`.
  * One `{{ host-class }}` host in the `b0rcctk2rvtr********` subnet, in the `{{ region-id }}-a` availability zone.
  * Network SSD storage (`{{ disk-type-example }}`): 20 GB.
  * One user: `user1`, password: `user1user1`.
  * One database: `db1`.
  * Deletion protection: Enabled.


  Run this command:

  
  ```bash
  {{ yc-mdb-mg }} cluster create \
    --name mymg \
    --environment production \
    --network-name {{ network-name }} \
    --security-group-ids {{ security-group }} \
    --mongod-resource-preset {{ host-class }} \
    --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr******** \
    --mongod-disk-size 20 \
    --mongod-disk-type {{ disk-type-example }} \
    --user name=user1,password=user1user1 \
    --database name=db1 \
    --deletion-protection
  ```


- {{ TF }} {#tf}

  Create a {{ mmg-name }} cluster and a network for it with the following test specifications:

  * Name: `mymg`.
  * Version: `{{ versions.tf.latest }}`.
  * Environment: `PRODUCTION`.
  * Cloud ID: `{{ tf-cloud-id }}`.
  * Folder ID: `{{ tf-folder-id }}`.
  * Network: `mynet`.
  * Host class: `{{ host-class }}`.
  * Number of `host` blocks: 1.
  * Subnet: `mysubnet`. Network settings:

    * Availability zone: `{{ region-id }}-a`.
    * Range: `10.5.0.0/24`.

  
  * Security group: `mymg-sg`. The group rules allow TCP connections to the cluster from the internet via port `{{ port-mmg }}`.


  * Network SSD storage: `{{ disk-type-example }}`.
  * Storage size: 20 GB.
  * `user1` user.
  * Password: `user1user1`.
  * Database: `db1`.
  * Deletion protection: Enabled.

  Configuration file for a single-host cluster:

  
  ```hcl
  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.mymg-sg.id ]
    deletion_protection = true

    cluster_config {
      version = "{{ versions.tf.latest }}"
    }

    resources_mongod {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 20
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }

  resource "yandex_mdb_mongodb_database" "db1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "db1"
  }

  resource "yandex_mdb_mongodb_user" "user1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = "db1"
    }
    depends_on = [
      yandex_mdb_mongodb_database.db1
    ]
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mymg-sg" {
    name       = "mymg-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "MongoDB"
      port           = {{ port-mmg }}
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```


{% endlist %}

### Creating sharded clusters {#creating-a-sharded-cluster}

You can create {{ mmg-name }} clusters with [standard](#std-sharding) or [advanced](#adv-sharding) sharding. For more information about sharding types, see [Sharding management](../concepts/sharding.md#shard-management).

#### Standard sharding {#std-sharding}

Create a {{ mmg-name }} cluster and a network for it with multiple hosts:

* One `MONGOD` host
* Three `MONGOINFRA` hosts

Cluster test specifications:

* Name: `mymg`.
* Environment: `PRODUCTION`.
* Deletion protection: Enabled.
* Version: `{{ versions.tf.latest }}`.
* Database: `db1`.
* `user1` user.
* Password: `user1user1`.
* `MONGOD` host class: `{{ host-class }}`.
* `MONGOINFRA` host class: `c3-c2-m4`.
* Network SSD storage: `{{ disk-type-example }}`.
* Storage size: 10 GB.

Network specifications:

* Network: `mynet`.
* Security group: `mymg-sg` with `{{ security-group }}` ID. In {{ TF }}, a group is created with the rule allowing TCP connections to the cluster from the internet on port `{{ port-mmg }}`.

* Subnet: `mysubnet`.
* Availability zone: `{{ region-id }}-a`.
* Range: `10.5.0.0/24` (only for {{ TF }}).

{% list tabs group=instructions %}

- CLI {#cli}

  To create a {{ mmg-name }} cluster with standard sharding, run this command:

  ```bash
  {{ yc-mdb-mg }} cluster create \
     --name mymg \
     --environment production \
     --deletion-protection \
     --mongodb-version {{ versions.cli.latest }} \
     --database name=db1 \
     --user name=user1,password=user1user1 \
     --mongod-resource-preset {{ host-class }} \
     --mongod-disk-type {{ disk-type-example }} \
     --mongod-disk-size 10 \
     --host type=mongod,`
       `zone-id={{ region-id }}-a,`
       `subnet-name=mysubnet \
     --mongoinfra-resource-preset c3-c2-m4 \
     --mongoinfra-disk-type {{ disk-type-example }} \
     --mongoinfra-disk-size 10 \
     --host type=mongoinfra,`
       `zone-id={{ region-id }}-a,`
       `subnet-name=mysubnet \
     --host type=mongoinfra,`
       `zone-id={{ region-id }}-a,`
       `subnet-name=mysubnet \
     --host type=mongoinfra,`
       `zone-id={{ region-id }}-a,`
       `subnet-name=mysubnet \
     --network-name mynet \
     --security-group-ids {{ security-group }}
  ```

- {{ TF }} {#tf}

  The configuration file for a cluster with standard sharding is as follows:

  ```hcl
  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.mymg-sg.id ]
    deletion_protection = true

    cluster_config {
      version = "{{ versions.tf.latest }}"
    }

    resources_mongod {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    resources_mongoinfra {
      resource_preset_id = "c3-c2-m4"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongod"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongoinfra"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongoinfra"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongoinfra"
    }

  resource "yandex_mdb_mongodb_database" "db1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "db1"
  }

  resource "yandex_mdb_mongodb_user" "user1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = "db1"
    }
    depends_on = [
      yandex_mdb_mongodb_database.db1
    ]
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mymg-sg" {
    name       = "mymg-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "MongoDB"
      port           = {{ port-mmg }}
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

{% endlist %}

#### Advanced sharding {#adv-sharding}

Create a {{ mmg-name }} cluster and a network for it with multiple hosts:

* One `MONGOD` host
* Two `MONGOS` hosts
* Three `MONGOCFG` hosts

Cluster test specifications:

* Name: `mymg`.
* Environment: `PRODUCTION`.
* Deletion protection: Enabled.
* Version: `{{ versions.tf.latest }}`.
* Database: `db1`.
* `user1` user.
* Password: `user1user1`.
* Host class: `{{ host-class }}`.
* Network SSD storage: `{{ disk-type-example }}`.
* Storage size: 10 GB.

Network specifications:

* Network: `mynet`.
* Security group: `mymg-sg` with `{{ security-group }}` ID. In {{ TF }}, a group is created with the rule allowing TCP connections to the cluster from the internet on port `{{ port-mmg }}`.
* Subnet: `mysubnet`.
* Availability zone: `{{ region-id }}-a`.
* Range: `10.5.0.0/24` (only for {{ TF }}).

{% list tabs group=instructions %}

- CLI {#cli}

  To create a {{ mmg-name }} cluster with advanced sharding, run this command:

  ```bash
  {{ yc-mdb-mg }} cluster create \
    --name mymg \
    --environment production \
    --deletion-protection \
    --mongodb-version {{ versions.cli.latest }} \
    --database name=db1 \
    --user name=user1,password=user1user1 \
    --mongod-resource-preset {{ host-class }} \
    --mongod-disk-type {{ disk-type-example }} \
    --mongod-disk-size 10 \
    --host type=mongod,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --mongos-resource-preset {{ host-class }} \
    --mongos-disk-type {{ disk-type-example }} \
    --mongos-disk-size 10 \
    --host type=mongos,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --host type=mongos,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --mongocfg-resource-preset {{ host-class }} \
    --mongocfg-disk-type {{ disk-type-example }} \
    --mongocfg-disk-size 10 \
    --host type=mongocfg,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --host type=mongocfg,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --host type=mongocfg,`
      `zone-id={{ region-id }}-a,`
      `subnet-name=mysubnet \
    --network-name mynet \
    --security-group-ids {{ security-group }}
  ```

- {{ TF }} {#tf}

  The configuration file for a cluster with advanced sharding is as follows:

  ```hcl
  resource "yandex_mdb_mongodb_cluster" "mymg" {
    name                = "mymg"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.mymg-sg.id ]
    deletion_protection = true

    cluster_config {
      version = "{{ versions.tf.latest }}"
    }

    resources_mongod {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    resources_mongos {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    resources_mongocfg {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongod"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongos"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongos"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongocfg"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongocfg"
    }

    host {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
      type      = "mongocfg"
    }
  }

  resource "yandex_mdb_mongodb_database" "db1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "db1"
  }

  resource "yandex_mdb_mongodb_user" "user1" {
    cluster_id = yandex_mdb_mongodb_cluster.mymg.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = "db1"
    }
    depends_on = [
      yandex_mdb_mongodb_database.db1
    ]
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mymg-sg" {
    name       = "mymg-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "MongoDB"
      port           = {{ port-mmg }}
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  ```

{% endlist %}
