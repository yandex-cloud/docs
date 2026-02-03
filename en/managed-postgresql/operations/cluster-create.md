---
title: How to create a {{ PG }} cluster
description: Follow this guide to create a {{ PG }} cluster with one or multiple database hosts.
---

# Creating a {{ PG }} cluster


A {{ PG }} cluster is one or more [database hosts](../concepts/index.md) between which you can configure [replication](../concepts/replication.md). Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests and duplicates changes on replicas. A transaction is committed once the data is written to [disk](../concepts/storage.md) on both the master host and on a sufficient number of replicas to form a quorum.

{% note info %}

* The number of hosts you can create together with a {{ PG }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* The available disk types depend on the selected [host class](../concepts/instance-types.md#available-flavors).
* If the database storage reaches 97% capacity, the cluster will switch to read-only mode. Plan and increase your storage size beforehand, or [set up an automatic storage expansion](storage-space.md#disk-size-autoscale).

{% endnote %}

By default, {{ mpg-name }} sets the maximum possible number of connections for each host in the {{ PG }} cluster. This maximum cannot exceed the value of the [Max connections](../concepts/settings-list.md#setting-max-connections) setting.

{% include [note-pg-user-connections.md](../../_includes/mdb/note-pg-user-connections.md) %}


## Creating a cluster {#create-cluster}


To create a {{ mpg-name }} cluster, you need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role and the [{{ roles.mpg.editor }} role or higher](../security/index.md#roles-list). For more information on assigning roles, see the [{{ iam-name }} guides](../../iam/operations/roles/grant.md).


{% include [Connection Manager](../../_includes/mdb/connman-cluster-create.md) %}



{% list tabs group=instructions %}

- Management console {#console}



  To create a {{ mpg-name }} cluster:

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your database cluster.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Enter a cluster name in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. The cluster name must be unique within the folder.
  1. Select the environment where you want to create your cluster (you cannot change the environment once the cluster is created):
     * `PRODUCTION`: For stable versions of your applications.
     * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and is also covered by an SLA. However, it receives new features, improvements, and bug fixes earlier. In the prestable environment, you can test new versions for compatibility with your application.
  1. Select the DBMS version.
  1. Select the host class, which will determine the technical specifications of the [VMs](../../compute/concepts/vm.md) for deploying your database hosts. All available options are listed under [Host classes](../concepts/instance-types.md). Changing the cluster’s host class updates the specifications for all of its existing hosts.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

     * Select the disk type.

     
       {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


     * Select the storage capacity for your data and backups. For more information on how backups take up storage space, see [Backups](../concepts/backup.md).

     
     * Optionally, select **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}** to encrypt the disk with a [custom KMS key](../../kms/concepts/key.md).

       * To [create](../../kms/operations/key.md#create) a new key, click **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.

       * To use a previously created key, select it in the **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** field.

       To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).


  1. Optionally, under **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**, specify the following settings:

      * In the **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** field, set the conditions for the actions below:

          * Storage expansion during the [next maintenance window](../concepts/maintenance.md#maintenance-window) if and when the specified storage space utilization percentage is exceeded.
          * Storage expansion immediately if and when the specified storage space utilization percentage is exceeded.

          You can set both thresholds, provided that the threshold for immediate scaling is higher than that for scaling during the maintenance window. 
          
          For more information on storage scaling rules, see [this section](../concepts/storage.md#auto-rescale).

      * In the **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** field, specify the maximum storage size that can be set during automatic scaling.

      {% include [storage-resize-steps](../../_includes/mdb/mpg/storage-resize-steps.md) %}

      
      {% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


      {% include [settings-dependence-on-storage](../../_includes/mdb/mpg/settings-dependence-on-storage.md) %}

      If you have configured storage scaling during a maintenance window, set the maintenance schedule.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify the database details:

     * Database name. The name must be unique within the folder.

       {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     * Database owner username. By default, the system allocates 50 connections per cluster host to a new user. You can change the maximum number of connections using the [Conn limit](../concepts/settings-list.md#setting-conn-limit) setting.

       {% include [username-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

     
     * Password:

       * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Select this option to set your own password. It must be from 8 to 128 characters long.

       * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Select this option to generate a password using {{ connection-manager-name }}.

       To view the password after creating a cluster, select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. To view passwords, you need the `lockbox.payloadViewer` role.


     * Collation locale and character set locale. These settings define the rules for sorting strings (`LC_COLLATE`) and classifying characters (`LC_CTYPE`). In {{ mpg-name }}, locale settings apply at the level of an individual database.

       {% include [postgresql-locale](../../_includes/mdb/mpg-locale-settings.md) %}

  
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select:
     * [Cloud network](../../vpc/concepts/network.md#network) for cluster deployment. If there are no networks in the list, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

       1. In the window that opens, specify the network name and select the folder where it will be created.
       1. Optionally, check **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** to automatically create subnets in all availability zones.
       1. Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

       {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     * [Security groups](../../vpc/concepts/security-groups.md) for the cluster network traffic. You may need to additionally [set up security groups](connect.md#configuring-security-groups) to be able connect to the cluster.


  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, configure the settings for the cluster’s database hosts. By default, each host is created in a separate [subnet](../../vpc/concepts/network.md#subnet). To select a specific subnet for a host, click ![image](../../_assets/console-icons/pencil.svg) next to it.

     The minimum number of hosts per cluster depends on the selected [disk type](../concepts/storage.md). The default cluster configuration offered in the management console includes:

      * Two hosts if the selected disk type is `network-ssd`, `network-hdd`, or `network-ssd-io-m3`.
      * Three hosts if the selected disk type is `local-ssd` or `network-ssd-nonreplicated`.

     {% note warning %}

     We do not recommend creating a single-host cluster. While being cheaper, it will not ensure [high availability](../concepts/high-availability.md#host-configuration).

     {% endnote %}

     After creating a {{ mpg-name }} cluster, you can add more hosts to it if your [folder resource](../concepts/limits.md) quotas allow.

     
     To enable internet access to the hosts, check **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.


    
  1. {% include [diagnostics-settings-console](../../_includes/mdb/mpg/diagnostics-settings-console.md) %}


  1. Specify additional cluster settings, if required:

     {% include [Additional cluster settings](../../_includes/mdb/mpg/extra-settings-web-console.md) %}

  1. If needed, configure [cluster-level DBMS settings](../concepts/settings-list.md#dbms-cluster-settings).
  
     {% note info %}

     Some {{ PG }} settings [depend on the selected host class or storage size](../concepts/settings-list.md#settings-instance-dependent).

     {% endnote %}

  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ mpg-name }} cluster:

  
  1. Check whether your [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) has [subnets](../../vpc/concepts/network.md#subnet) for the cluster hosts:

     ```bash
     yc vpc subnet list
     ```

     If your folder has no subnets, [create them](../../vpc/operations/subnet-create.md) in [{{ vpc-full-name }}](../../vpc/).


  1. View the description of the CLI command for creating a cluster:

     ```bash
     {{ yc-mdb-pg }} cluster create --help
     ```

  1. Specify the cluster properties in this command (the example does not show all that are available):

     
     ```bash
     {{ yc-mdb-pg }} cluster create \
       --name <cluster_name> \
       --environment <environment> \
       --network-name <network_name> \
       --host zone-id=<availability_zone>,`
                `subnet-id=<subnet_ID>,`
                `assign-public-ip=<allow_public_access_to_host> \
       --resource-preset <host_class> \
       --user name=<username>,password=<user_password> \
       --database name=<DB_name>,owner=<DB_owner_name> \
       --disk-size <storage_size_in_GB> \
       --disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
       --security-group-ids <list_of_security_group_IDs> \
       --connection-pooling-mode=<connection_pooler_mode> \
       --deletion-protection
     ```

     
     Where:

     * `environment`: Environment, `prestable` or `production`.
     * `disk-type`: Disk type.

     
     * `assign-public-ip`: Allow access to the host from the internet, `true` or `false`.


     * `deletion-protection`: Deletion protection for the cluster, its databases, and users.

       By default, when users and databases are created, this setting’s value is inherited from the cluster. You can also specify this setting manually. See [User management](cluster-users.md) and [Database management](databases.md) for details.

       If the setting is changed on a running cluster, the new value will only be inherited by users and databases with **Same as cluster** protection level.

       {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     
     You need to specify the `subnet-id` if the selected [availability zone](../../overview/concepts/geo-scope.md) has two or more subnets.

     {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}



     {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     The password must be from 8 to 128 characters long.

     
     {% note info %}

     You can also generate a password using {{ connection-manager-name }}. To do this, edit the command, specifying the user properties as follows:

     ```bash
       --user name=<username>,generate-password=true
     ```

     To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. To view passwords, you need the `lockbox.payloadViewer` role.

     {% endnote %}


     The available [connection pooler modes](../concepts/pooling.md) include `SESSION`, `TRANSACTION`, and `STATEMENT`.

     You can also specify the `--host` `replication-source` option to [manually manage replication streams](../concepts/replication.md#replication-manual).

     
     To encrypt the disk with a [custom KMS key](../../kms/concepts/key.md), provide `--disk-encryption-key-id <KMS_key_ID>`. To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).

     To allow access to the cluster from [{{ sf-full-name }}](../../functions/), provide the `--serverless-access` parameter. For details on setting up access, see [this {{ sf-name }} guide](../../functions/operations/database-connection.md).

     To allow access to the cluster from [{{ yq-full-name }}](../../query/index.yaml), provide `--yandexquery-access=true`. This feature is in the [Preview](../../overview/concepts/launch-stages.md) stage and can be enabled upon request.


     {% note info %}

     The default [maintenance](../concepts/maintenance.md) mode for new clusters is `anytime`. You can set a specific maintenance period when [updating the cluster settings](update.md#change-additional-settings).

     {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a {{ mpg-name }} cluster:
  1. In the configuration file, describe the resources you want to create:
     * Database cluster: Description of the cluster and its hosts.
     * Database: Cluster database description.
     * User: Cluster user description.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     Here is an example of the configuration file structure:

     
     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
       name                = "<cluster_name>"
       environment         = "<environment>"
       network_id          = "<network_ID>"
       security_group_ids  = [ "<list_of_security_group_IDs>" ]
       deletion_protection = <protect_cluster_from_deletion>

       config {
         version = "<{{ PG }}_version>"
         resources {
           resource_preset_id = "<host_class>"
           disk_type_id       = "<disk_type>"
           disk_size          = <storage_size_in_GB>
         }
         pooler_config {
           pool_discard = <Odyssey_parameter>
           pooling_mode = "<operation_mode>"
         }
         ...
       }

       host {
         zone             = "<availability_zone>"
         name             = "<host_name>"
         subnet_id        = "<subnet_ID>"
         assign_public_ip = <allow_public_access_to_host>
       }
     }

     resource "yandex_mdb_postgresql_database" "<DB_name>" {
       cluster_id = "<cluster_ID>"
       name       = "<DB_name>"
       owner      = "<database_owner_name>"
       depends_on = [
         yandex_mdb_postgresql_user.<username>
       ]
     }

     resource "yandex_mdb_postgresql_user" "<username>" {
       cluster_id = "<cluster_ID>"
       name       = "<username>"
       password   = "<user_password>"
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

     
     * `assign_public_ip`: Allow access to the host from the internet, `true` or `false`.


     * `deletion_protection`: Protection of the cluster, its databases, and users against deletion, `true` or `false`.

       By default, when users and databases are created, this setting’s value is inherited from the cluster. You can also specify this setting manually. See [User management](cluster-users.md) and [Database management](databases.md) for details.

       If the setting is changed on a running cluster, the new value will only be inherited by users and databases with the **Same as cluster** protection level.

       {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `version`: {{ PG }} version, {{ pg.versions.tf.str }}.
     * `pool_discard`: Odyssey `pool_discard` setting, `true` or `false`.
     * `pooling_mode`: Operation mode, `SESSION`, `TRANSACTION`, or `STATEMENT`.

     {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     The password must be from 8 to 128 characters long.

     
     {% note info %}

     You can also generate a password using {{ connection-manager-name }}. To do this, specify `generate_password = true` instead of `"password" = "<user_password>"`.

     To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. To view passwords, you need the `lockbox.payloadViewer` role.

     {% endnote %}


     To configure automatic storage scaling, add the `disk_size_autoscaling` section within the `config` section:

     {% include [disk-size-autoscaling](../../_includes/mdb/mpg/terraform/disk-size-autoscaling.md) %}

     {% note warning %}
     
     * When using `planned_usage_threshold`, make sure to set up a maintenance window in the `maintenance_window` section.
     
     * If you specify both thresholds, `emergency_usage_threshold` must not be less than `planned_usage_threshold`.
     
     {% endnote %}

     {% include [Maintenance window](../../_includes/mdb/mpg/terraform/maintenance-window.md) %}

     
     To encrypt the disk with a [custom KMS key](../../kms/concepts/key.md), add the `disk_encryption_key_id` parameter:

       ```hcl
       resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
         ...
         disk_encryption_key_id = <KMS_key_ID>
         ...
       }
       ```

       To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).


     {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}

     For a complete list of configurable {{ mpg-name }} cluster fields, refer to the [{{ TF }} provider guides]({{ tf-provider-mpg }}).
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a cluster.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

     
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
       "deletionProtection": <protect_cluster_from_deletion>,
       "configSpec": {
         "version": "<{{ PG }}_version>",
         "resources": {
           "resourcePresetId": "<host_class>",
           "diskSize": "<storage_size_in_bytes>",
           "diskTypeId": "<disk_type>",
           "diskEncryptionKeyId": "<KMS_key_ID>"
         },
         "access": {
           "dataLens": <allow_access_from_{{ datalens-name }}>,
           "webSql": <allow_access_from_{{ websql-name }}>,
           "serverless": <allow_access_from_Cloud_Functions>,
           "dataTransfer": <allow_access_from_Data_Transfer>,
           "yandexQuery": <allow_access_from_{{ yq-name }}>
         },
         "performanceDiagnostics": {
           "enabled": <enable_statistics_collection>,
           "sessionsSamplingInterval": "<session_sampling_interval>",
           "statementsSamplingInterval": "<statement_sampling_interval>"
         },
         "diskSizeAutoscaling": {
           "plannedUsageThreshold": "<scheduled_expansion_threshold_in_percent>",
           "emergencyUsageThreshold": "<immediate_expansion_threshold_in_percent>",
           "diskSizeLimit": "<maximum_storage_size_in_bytes>"
         }
       },
       "databaseSpecs": [
         {
           "name": "<DB_name>",
           "owner": "<DB_owner_name>"
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
             }
           ],
           "login": <allow_user_to_connect_to_DB>
         },
         { <similar_settings_for_user_2> },
         { ... },
         { <similar_settings_for_user_N> }
       ],
       "hostSpecs": [
         {
           "zoneId": "<availability_zone>",
           "subnetId": "<subnet_ID>",
           "assignPublicIp": <allow_public_access_to_host>
         },
         { <similar_settings_for_host_2> },
         { ... },
         { <similar_settings_for_host_N> }
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

     * `folderId`: Folder ID. You can get it from the [list of your cloud folders](../../resource-manager/operations/folder/get-id.md).
     * `name`: Cluster name.
     * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
     * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) where your cluster will be deployed.

       {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     
     * `securityGroupIds`: [Security group](../concepts/network.md#security-groups) IDs.


     * `deletionProtection`: Protection of the cluster, its databases, and users against deletion, `true` or `false` value.

       By default, when users and databases are created, this setting’s value is inherited from the cluster. You can also specify this setting manually. See [User management](cluster-users.md) and [Database management](databases.md) for details.

       If the setting is changed on a running cluster, the new value will only be inherited by users and databases with the **Same as cluster** protection level.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `configSpec`: Cluster settings:

       * `version`: {{ PG }} version.
       * `resources`: Cluster resources:

         * `resourcePresetId`: [Host class](../concepts/instance-types.md).
         * `diskSize`: Disk size, in bytes.
         * `diskTypeId`: [Disk type](../concepts/storage.md).
         * `diskEncryptionKeyId`: KMS key ID for disk encryption.

       
       * `access`: Cluster access settings for the following {{ yandex-cloud }} services:

         * `dataLens`: [{{ datalens-full-name }}](../../datalens/index.yaml)
         * `webSql`: [{{ websql-full-name }}](../../websql/index.yaml)
         * `serverless`: [{{ sf-full-name }}](../../functions/index.yaml)
         * `dataTransfer`: [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)
         * `yandexQuery`: [{{ yq-full-name }}](../../query/index.yaml)

         The possible setting values are `true` or `false`.


       * `performanceDiagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:

         * `enabled`: Enables statistics collection, `true` or `false`.
         * `sessionsSamplingInterval`: Session sampling interval. The values range from `1` to `86400` seconds.
         * `statementsSamplingInterval`: Statement sampling interval. The values range from `60` to `86400` seconds.
       
       {% include [disk-size-autoscaling-rest](../../_includes/mdb/mpg/disk-size-autoscaling-rest.md) %}

     * `databaseSpecs`: Database settings as an array of elements, one per database. Each element has the following structure:

       * `name`: Database name.
       * `owner`: Database owner username. This setting must correspond to one of the usernames specified in the request.

     * `userSpecs`: User settings as an array of elements, one per user. Each element has the following structure:

       * `name`: Username.
       * `password`: User password. The password must be from 8 to 128 characters long.

          
          You can also generate a password using {{ connection-manager-name }}. To do this, specify `"generatePassword": true` instead of `"password": "<user_password>"`.

          To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. To view passwords, you need the `lockbox.payloadViewer` role.


       * `permissions.databaseName`: Name of the database the user can access.
       * `login`: User permission to connect to the DB, `true` or `false`.

     * `hostSpecs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

       * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
       * `subnetId`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
       * `assignPublicIp`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.

     * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings:

       * `day`: Day of the week, in `DDD` format, for scheduled maintenance.
       * `hour`: Hour of day, in `HH` format, for scheduled maintenance. Allowed values range from `1` to `24`.  

  1. Call the [Cluster.Create](../api-ref/Cluster/create.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters' \
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
       "environment": "<environment>",
       "network_id": "<network_ID>",
       "security_group_ids": [
         "<security_group_1_ID>",
         "<security_group_2_ID>",
         ...
         "<security_group_N_ID>"
       ],
       "deletion_protection": <protect_cluster_from_deletion>,
       "config_spec": {
         "version": "<{{ PG }}_version>",
         "resources": {
           "resource_preset_id": "<host_class>",
           "disk_size": "<storage_size_in_bytes>",
           "disk_type_id": "<disk_type>",
           "disk_encryption_key_id": "<KMS_key_ID>"
         },
         "access": {
           "data_lens": <allow_access_from_{{ datalens-name }}>,
           "web_sql": <allow_access_from_{{ websql-name }}>,
           "serverless": <allow_access_from_Cloud_Functions>,
           "data_transfer": <allow_access_from_Data_Transfer>,
           "yandex_query": <allow_access_from_{{ yq-name }}>
         },
         "performance_diagnostics": {
           "enabled": <enable_statistics_collection>,
           "sessions_sampling_interval": "<session_sampling_interval>",
           "statements_sampling_interval": "<statement_sampling_interval>"
         },
         "disk_size_autoscaling": {
           "planned_usage_threshold": "<scheduled_expansion_threshold_in_percent>",
           "emergency_usage_threshold": "<immediate_expansion_threshold_in_percent>",
           "disk_size_limit": "<maximum_storage_size_in_bytes>"
         }
       },
       "database_specs": [
         {
           "name": "<DB_name>",
           "owner": "<DB_owner_name>"
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
             }
           ],
           "login": <allow_user_to_connect_to_DB>
         },
         { <similar_settings_for_user_2> },
         { ... },
         { <similar_settings_for_user_N> }
       ],
       "host_specs": [
         {
           "zone_id": "<availability_zone>",
           "subnet_id": "<subnet_ID>",
           "assign_public_ip": <allow_public_access_to_host>
         },
         { <similar_settings_for_host_2> },
         { ... },
         { <similar_settings_for_host_N> }
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

     * `folder_id`: Folder ID. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
     * `name`: Cluster name.
     * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
     * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) where your cluster will be deployed.

       {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     
     * `security_group_ids`: [Security group](../concepts/network.md#security-groups) IDs.


     * `deletion_protection`: Protection of the cluster, its databases, and users against deletion, `true` or `false` value.

        By default, when users and databases are created, this setting’s value is inherited from the cluster. You can also specify this setting manually. See [User management](cluster-users.md) and [Database management](databases.md) for details.

        If the setting is changed on a running cluster, the new value will only be inherited by users and databases with the **Same as cluster** protection level.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `config_spec`: Cluster settings:

       * `version`: {{ PG }} version.
       * `resources`: Cluster resources:

         * `resource_preset_id`: [Host class](../concepts/instance-types.md).
         * `disk_size`: Disk size, in bytes.
         * `disk_type_id`: [Disk type](../concepts/storage.md).
         * `disk_encryption_key_id`: KMS key ID for disk encryption.

       
       * `access`: Cluster access settings for the following {{ yandex-cloud }} services:

         * `data_lens`: [{{ datalens-full-name }}](../../datalens/index.yaml)
         * `web_sql`: [{{ websql-full-name }}](../../websql/index.yaml)
         * `serverless`: [{{ sf-full-name }}](../../functions/index.yaml)
         * `data_transfer`: [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)
         * `yandex_query`: [{{ yq-full-name }}](../../query/index.yaml)

         The possible values are `true` or `false`.


       * `performance_diagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:

         * `enabled`: Enables statistics collection, `true` or `false`.
         * `sessions_sampling_interval`: Session sampling interval. The values range from `1` to `86400` seconds.
         * `statements_sampling_interval`: Statement sampling interval. The values range from `60` to `86400` seconds.

       {% include [disk-size-autoscaling-grpc](../../_includes/mdb/mpg/disk-size-autoscaling-grpc.md) %}

     * `database_specs`: Database settings as an array of elements, one for each DB. Each element has the following structure:

       * `name`: Database name.
       * `owner`: Database owner username. This setting must correspond to one of the usernames specified in the request.

     * `user_specs`: User settings as an array of elements, one per user. Each element has the following structure:

       * `name`: Username.
       * `password`: User password. The password must be from 8 to 128 characters long.

          
          You can also generate a password using {{ connection-manager-name }}. To do this, specify `"generate_password": true` instead of `"password": "<user_password>"`.

          To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. To view passwords, you need the `lockbox.payloadViewer` role.


       * `permissions.database_name`: Name of the database the user can access.
       * `login`: User permission to connect to the DB, `true` or `false`.

     * `host_specs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

       * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
       * `subnet_id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
       * `assign_public_ip`: Permission for internet [access](connect.md) to the host.
    
     * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings:

       * `day`: Day of the week, in `DDD` format, for scheduled maintenance.
       * `hour`: Hour of day, in `HH` format, for scheduled maintenance. Allowed values range from `1` to `24`.

  1. Call the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Create \
       < body.json
     ```

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure your request was successful.

{% endlist %}


{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [configure security groups](connect.md#configuring-security-groups) to connect to it.

{% endnote %}


## Creating a cluster copy {#duplicate}

You can create a {{ PG }} cluster with the settings of another one created earlier. Do this by importing the original {{ PG }} cluster configuration into {{ TF }}. This way, you can either create an identical copy or use the imported configuration as the baseline and modify it as needed. The import feature is handy when the original {{ PG }} cluster has a lot of settings and you need to create a similar one.

To create a {{ PG }} cluster copy:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. In the same working directory, place a `.tf` file with the following contents:

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "old" { }
        ```

    1. Save the ID of the original {{ PG }} cluster to an environment variable:

        ```bash
        export POSTGRESQL_CLUSTER_ID=<cluster_ID>
        ```

        You can get the cluster ID with the [list of clusters in the folder](../../managed-postgresql/operations/cluster-list.md#list-clusters).

    1. Import the original {{ PG }} cluster settings to the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_postgresql_cluster.old ${POSTGRESQL_CLUSTER_ID}
        ```

    1. Get the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from the terminal and paste it into the `.tf` file.
    1. Move the file to the new `imported-cluster` directory.
    1. Modify the copied configuration to prepare it for creating a new cluster:

        * Specify the new cluster name in the `resource` string and the `name` parameter.
        * Delete `created_at`, `health`, `id`, and `status`.
        * In the `host` sections, delete `fqdn` and `role`.
        * If the `disk_size_autoscaling` section has `disk_size_limit = 0`, delete this section.
        * If the `maintenance_window` section contains `type = "ANYTIME"`, delete the `hour` setting.
        * Optionally, make further changes if you need a customized configuration.

    1. Navigate to the `imported-cluster` directory and [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).

    1. In the same directory, [configure and initialize the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Instead of manually creating the provider configuration file, you can [download it](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Move the configuration file to the `imported-cluster` directory and [specify its settings](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you have not set the authentication credentials as environment variables, specify them in the configuration file.

    1. Validate your {{ TF }} configuration:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  To create a single-host cluster, provide one `--host` argument.

  Create a {{ mpg-name }} cluster with the following test specifications:

  
  * Name: `mypg`.
  * Environment: `production`.
  * Network: `default`.
  * Security group: `{{ security-group }}`.
  * One `{{ host-class }}` host in the `b0rcctk2rvtr********` subnet and `{{ region-id }}-a` availability zone.
  * Network SSD storage (`{{ disk-type-example }}`): 20 GB.
  * User: `user1`, password: `user1user1`.
  * Database: `db1`, owner: `user1`.
  * Deletion protection for the cluster, its databases, and users: Enabled.


  Run this command:

  
  ```bash
  {{ yc-mdb-pg }} cluster create \
     --name mypg \
     --environment production \
     --network-name default \
     --resource-preset {{ host-class }} \
     --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr******** \
     --disk-type {{ disk-type-example }} \
     --disk-size 20 \
     --user name=user1,password=user1user1 \
     --database name=db1,owner=user1 \
     --security-group-ids {{ security-group }} \
     --deletion-protection
  ```


- {{ TF }} {#tf}

  Create a {{ mpg-name }} cluster and its network with the following test specifications:

  * Name: `mypg`.
  * Version: `{{ pg.versions.tf.latest }}`.
  * Environment: `PRESTABLE`.
  * Cloud ID: `{{ tf-cloud-id }}`.
  * Folder ID: `{{ tf-folder-id }}`.
  * Network: `mynet`.

  
  * Security group allowing internet access to the cluster on port `6432`: `pgsql-sg`.


  * Host class: `{{ host-class }}` (one host), subnet: `mysubnet`, availability zone: `{{ region-id }}-a`. `mysubnet` CIDR range: `10.5.0.0/24`.
  * Network SSD storage (`{{ disk-type-example }}`): 20 GB.
  * User: `user1`, password: `user1user1`.
  * Database: `db1`, owner: `user1`.
  * Protection of the cluster, its DBs, and users against accidental deletion: Enabled.

  The configuration file for this cluster is as follows:

  
  ```hcl
  resource "yandex_mdb_postgresql_cluster" "mypg" {
    name                = "mypg"
    environment         = "PRESTABLE"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.pgsql-sg.id ]
    deletion_protection = true

    config {
      version = {{ pg.versions.tf.latest }}
      resources {
        resource_preset_id = "{{ host-class }}"
        disk_type_id       = "{{ disk-type-example }}"
        disk_size          = "20"
      }
    }

    host {
      zone      = "{{ region-id }}-a"
      name      = "mypg-host-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }

  resource "yandex_mdb_postgresql_database" "db1" {
    cluster_id = yandex_mdb_postgresql_cluster.mypg.id
    name       = "db1"
    owner      = "user1"
  }

  resource "yandex_mdb_postgresql_user" "user1" {
    cluster_id = yandex_mdb_postgresql_cluster.mypg.id
    name       = "user1"
    password   = "user1user1"
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }

  resource "yandex_vpc_security_group" "pgsql-sg" {
    name       = "pgsql-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "PostgreSQL"
      port           = 6432
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }
  ```


{% endlist %}
