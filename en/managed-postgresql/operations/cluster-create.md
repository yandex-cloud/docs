---
title: How to create a {{ PG }} cluster
description: Follow this guide to create a {{ PG }} cluster with a single or multiple DB hosts.
---

# Creating a {{ PG }} cluster


A {{ PG }} cluster is one or more [database hosts](../concepts/index.md) between which you can configure [replication](../concepts/replication.md). Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests and duplicates changes on replicas. The transaction is confirmed if the data is written to [disk](../concepts/storage.md) both on the master host and on a certain number of replicas, sufficient to establish a quorum.

{% note info %}

* The number of hosts you can create together with a {{ PG }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* Available disk types depend on the selected [host class](../concepts/instance-types.md#available-flavors).
* If the DB storage is 97% full, the cluster switches to read-only mode. Plan and increase the required storage size in advance or [set up an automatic increase in its size](storage-space.md#disk-size-autoscale).

{% endnote %}

By default, {{ mpg-name }} sets the maximum number of connections to each {{ PG }} cluster host. This maximum cannot be greater than the value of [Max connections](../concepts/settings-list.md#setting-max-connections).

{% include [note-pg-user-connections.md](../../_includes/mdb/note-pg-user-connections.md) %}


## Creating a cluster {#create-cluster}


To create a {{ mpg-name }} cluster, you will need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) and [{{ roles.mpg.editor }} roles or higher](../security/index.md#roles-list). For more information on assigning roles, see the [{{ iam-name }} documentation](../../iam/operations/roles/grant.md).


{% include [Connection Manager](../../_includes/mdb/connman-cluster-create.md) %}

{% list tabs group=instructions %}

- Management console {#console}



  To create a {{ mpg-name }} cluster:

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a DB cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Enter a name for the cluster in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. It must be unique within the folder.
  1. Select the environment where you want to create the cluster (you cannot change the environment once the cluster is created):
     * `PRODUCTION`: For stable versions of your apps.
     * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
  1. Select the DBMS version.
  1. Select the host class that defines the technical specifications of the [VMs](../../compute/concepts/vm.md) where the DB hosts will be deployed. All available options are listed under [Host classes](../concepts/instance-types.md). When you change the host class for a cluster, the characteristics of all the already created hosts change too.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

     * Select the disk type.

     
       {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


     * Select the storage size to be used for data and backups. For more information on how backups take up storage space, see [Backups](../concepts/backup.md).

  1. (Optional) Under **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**, specify the settings you need:

      * In the **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** field, set the conditions to:

          * Increase the storage size during the [next maintenance window](../concepts/maintenance.md#maintenance-window) if the storage is more than the specified percent (%) full.
          * Increase the storage size right away if the storage is more than the specified percent (%) full.

          You can set both conditions, but the threshold for immediate increase must be higher than that for increase during the maintenance window.

      * In the **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** field, specify the maximum storage size that can be set when increasing the storage size automatically.

      {% include [storage-resize-steps](../../_includes/mdb/mpg/storage-resize-steps.md) %}

      
      {% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


      {% include [settings-dependence-on-storage](../../_includes/mdb/mpg/settings-dependence-on-storage.md) %}

      If you have set up the storage size to increase within the maintenance window, set up a schedule for the maintenance window.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify the DB attributes:

     * DB name. The name must be unique within the folder.

       {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     * DB owner username. By default, the new user is assigned 50 connections to each host in the cluster. You can change the allowed number of connections using the [Conn limit](../concepts/settings-list.md#setting-conn-limit) setting.
       
       {% include [username-limits](../../_includes/mdb/mpg/note-info-user-name-and-pass-limits.md) %}

     * Password:

       * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Select to enter your password. The password must be from 8 to 128 characters long.

       * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Select to generate a password with the help of {{ connection-manager-name }}.

       To view the password, select the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab after you create the cluster and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.
     
     * Collation (sorting) locale and character set locale. These settings define the rules for sorting strings (`LC_COLLATE`) and classifying characters (`LC_CTYPE`). In {{ mpg-name }}, locale settings apply at the individual DB level.

       {% include [postgresql-locale](../../_includes/mdb/mpg-locale-settings.md) %}

  
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select:
     * [Cloud network](../../vpc/concepts/network.md#network) for the cluster. If you do not have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

       1. In the window that opens, specify the network name and select the folder to host the network.
       1. Optionally, enable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** setting to automatically create subnets in all availability zones.
       1. Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

       {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     * [Security groups](../../vpc/concepts/security-groups.md) for the cluster network traffic. You may need to additionally [set up security groups](connect.md#configuring-security-groups) to be able to connect to the cluster.


  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, select the parameters for the DB hosts created with the cluster. By default, each host is created in a separate [subnet](../../vpc/concepts/network.md#subnet). To select a specific subnet for a host, click ![image](../../_assets/console-icons/pencil.svg).

     When configuring the hosts, note that if you selected `local-ssd` or `network-ssd-nonreplicated` under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, you need to add at least three hosts to the cluster.

     
     To connect to the host from the internet, enable the **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** setting.


  1. Configure additional cluster settings, if required:

     {% include [Additional cluster settings](../../_includes/mdb/mpg/extra-settings-web-console.md) %}

  1. If required, configure [DBMS cluster-level settings](../concepts/settings-list.md#dbms-cluster-settings).
  
     {% note info %}

     Some {{ PG }} settings [depend on the selected host class or storage size](../concepts/settings-list.md#settings-instance-dependent).

     {% endnote %}

  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ mpg-name }} cluster:

  
  1. Check whether the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) has any [subnets](../../vpc/concepts/network.md#subnet) for the cluster hosts:

     ```bash
     yc vpc subnet list
     ```

     If there are no subnets in the folder, [create the required subnets](../../vpc/operations/subnet-create.md) in [{{ vpc-full-name }}](../../vpc/).


  1. View the description of the CLI command to create a cluster:

     ```bash
     {{ yc-mdb-pg }} cluster create --help
     ```

  1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

     
     ```bash
     {{ yc-mdb-pg }} cluster create \
       --name <cluster_name> \
       --environment <environment> \
       --network-name <network_name> \
       --host zone-id=<availability_zone>,`
                `subnet-id=<subnet_ID>,`
                `assign-public-ip=<access_to_host_from_internet> \
       --resource-preset <host_class> \
       --user name=<username>,password=<user_password> \
       --database name=<DB_name>,owner=<database_owner_name> \
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


     * `deletion-protection`: Protection of the cluster, its databases, and users against deletion.

       By default, the parameter inherits its value from the cluster when creating users and databases. You can also set the value manually; for more information, see the [User management](cluster-users.md) and [Database management](databases.md) sections.

       If the parameter is changed on a running cluster, only users and databases with the **Same as cluster** protection will inherit the new value.

       {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     
     You need to specify the `subnet-id` if the selected [availability zone](../../overview/concepts/geo-scope.md) has two or more subnets.

     {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}



     {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     The password must be from 8 to 128 characters long.

     {% note info %}

     You can also generate a password using {{ connection-manager-name }}. To do this, adjust the command, setting the user parameters as follows:
     
     ```bash
       --user name=<username>,generate-password=true
     ```

     To view the password, select the cluster you created in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

     {% endnote %}

     The available [connection pooler modes](../concepts/pooling.md) include `SESSION`, `TRANSACTION`, and `STATEMENT`.

     You can also set the additional `replication-source` option in the `--host` parameter to [manually manage replication threads](../concepts/replication.md#replication-manual).

     
     To allow access to the cluster from [{{ sf-full-name }}](../../functions/), provide the `--serverless-access` parameter. For more information about setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md) documentation.

     To allow access to the cluster from [{{ yq-full-name }}](../../query/index.yaml), provide the `--yandexquery-access=true` parameter. This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage and is available upon request.


     {% note info %}

     When creating a cluster, the `anytime` [maintenance](../concepts/maintenance.md) mode is set by default. You can set a specific maintenance period when [updating the cluster settings](update.md#change-additional-settings).

     {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a {{ mpg-name }} cluster:
  1. In the configuration file, describe the resources you want to create:
     * DB cluster: Description of the cluster and its hosts
     * Database: Cluster DB description
     * User: Cluster user description

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
       deletion_protection = <deletion_protection>

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
         assign_public_ip = <access_to_host_from_internet>
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

       By default, the parameter inherits its value from the cluster when creating users and databases. You can also set the value manually; for more information, see the [User management](cluster-users.md) and [Database management](databases.md) sections.

       If the parameter is changed on a running cluster, only users and databases with the **Same as cluster** protection will inherit the new value.

       {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `version`: {{ PG }} version, {{ pg.versions.tf.str }}.
     * `pool_discard`: Odyssey `pool_discard` parameter, `true` or `false`.
     * `pooling_mode`: Operation mode, `SESSION`, `TRANSACTION`, or `STATEMENT`.

     {% include [database-name-limit](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     The password must be from 8 to 128 characters long.

     {% note info %}

     You can also generate a password using {{ connection-manager-name }}. To do this, specify `generate_password = true` instead of `"password" = "<user_password>"`.

     To view the password, select the cluster you created in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

     {% endnote %}

     {% include [Maintenance window](../../_includes/mdb/mpg/terraform/maintenance-window.md) %}

     {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}

     For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }}]({{ tf-provider-mpg }}) provider documentation.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a cluster.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

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
       "deletionProtection": <deletion_protection:_true_or_false>,
       "configSpec": {
         "version": "<{{ PG }}_version>",
         "resources": {
           "resourcePresetId": "<host_class>",
           "diskSize": "<storage_size_in_bytes>",
           "diskTypeId": "<disk_type>"
         },
         "access": {
           "dataLens": <access_to_{{ datalens-name }}:_true_or_false>,
           "webSql": <access_to_{{ websql-name }}:_true_or_false>,
           "serverless": <access_to_Cloud_Functions:_true_or_false>,
           "dataTransfer": <access_to_Data_Transfer:_true_or_false>,
           "yandexQuery": <access_to_{{ yq-name }}:_true_or_false>
         },
         "performanceDiagnostics": {
           "enabled": <activate_statistics_collection:_true_or_false>,
           "sessionsSamplingInterval": "<session_sampling_interval>",
           "statementsSamplingInterval": "<statement_sampling_interval>"
         }
       },
       "databaseSpecs": [
         {
           "name": "<DB_name>",
           "owner": "<database_owner_name>"
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
           "login": <allow_user_to_connect_to_DB:_true_or_false>
         },
         { <similar_configuration_for_user_2> },
         { ... },
         { <similar_configuration_for_user_N> }
       ],
       "hostSpecs": [
         {
           "zoneId": "<availability_zone>",
           "subnetId": "<subnet_ID>",
           "assignPublicIp": <public_host_address:_true_or_false>
         },
         { <similar_configuration_for_host_2> },
         { ... },
         { <similar_configuration_for_host_N> }
       ]
     }
     ```


     Where:

     * `folderId`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
     * `name`: Cluster name.
     * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
     * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be in.

       {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     
     * `securityGroupIds`: [Security group](../concepts/network.md#security-groups) IDs.


     * `deletionProtection`: Protection of the cluster, its databases, and users against deletion.

       By default, the parameter inherits its value from the cluster when creating users and databases. You can also set the value manually; for more information, see the [User management](cluster-users.md) and [Database management](databases.md) sections.

       If the parameter is changed on a running cluster, only users and databases with the **Same as cluster** protection will inherit the new value.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `configSpec`: Cluster settings:

       * `version`: {{ PG }} version.
       * `resources`: Cluster resources:

         * `resourcePresetId`: [Host class](../concepts/instance-types.md).
         * `diskSize`: Disk size in bytes.
         * `diskTypeId`: [Disk type](../concepts/storage.md).

       
       * `access`: Cluster settings for access to the following {{ yandex-cloud }} services:

         * `dataLens`: [{{ datalens-full-name }}](../../datalens/index.yaml)
         * `webSql`: [{{ websql-full-name }}](../../websql/index.yaml)
         * `serverless`: [{{ sf-full-name }}](../../functions/index.yaml)
         * `dataTransfer`: [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)
         * `yandexQuery`: [{{ yq-full-name }}](../../query/index.yaml)


       * `performanceDiagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:

         * `enabled`: Enables statistics collection.
         * `sessionsSamplingInterval`: Session sampling interval. The values range from `1` to `86400` seconds.
         * `statementsSamplingInterval`: Statement sampling interval. The values range from `60` to `86400` seconds.

     * `databaseSpecs`: Database settings as an array of elements, one for each DB. Each element has the following structure:

       * `name`: DB name.
       * `owner`: DB owner username. It must match one of the usenames specified in the request.

     * `userSpecs`: User settings as an array of elements, one for each user. Each element has the following structure:

       * `name`: Username.
       * `password`: User password. The password must be from 8 to 128 characters long.
       
          You can also generate a password using {{ connection-manager-name }}. To do this, specify `"generatePassword": true` instead of `"password": "<user_password>"`.

          To view the password, select the cluster you created in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

       * `permissions.databaseName`: Name of the database the user gets access to.
       * `login`: User permission to connect to the DB.

     * `hostSpecs`: Cluster host settings as an array of elements, one for each host. Each element has the following structure:

       * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
       * `subnetId`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
       * `assignPublicIp`: Permission to [connect](connect.md) to the host from the internet.

  1. Use the [Cluster.Create](../api-ref/Cluster/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters' \
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
       "deletion_protection": <deletion_protection:_true_or_false>,
       "config_spec": {
         "version": "<{{ PG }}_version>",
         "resources": {
           "resource_preset_id": "<host_class>",
           "disk_size": "<storage_size_in_bytes>",
           "disk_type_id": "<disk_type>"
         },
         "access": {
           "data_lens": <access_to_{{ datalens-name }}:_true_or_false>,
           "web_sql": <access_to_{{ websql-name }}:_true_or_false>,
           "serverless": <access_to_Cloud_Functions:_true_or_false>,
           "data_transfer": <access_to_Data_Transfer:_true_or_false>,
           "yandex_query": <access_to_{{ yq-name }}:_true_or_false>
         },
         "performance_diagnostics": {
           "enabled": <activate_statistics_collection:_true_or_false>,
           "sessions_sampling_interval": "<session_sampling_interval>",
           "statements_sampling_interval": "<statement_sampling_interval>"
         }
       },
       "database_specs": [
         {
           "name": "<DB_name>",
           "owner": "<database_owner_name>"
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
           "login": <allow_user_to_connect_to_DB:_true_or_false>
         },
         { <similar_configuration_for_user_2> },
         { ... },
         { <similar_configuration_for_user_N> }
       ],
       "host_specs": [
         {
           "zone_id": "<availability_zone>",
           "subnet_id": "<subnet_ID>",
           "assign_public_ip": <public_host_address:_true_or_false>
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

       {% include [network-cannot-be-changed](../../_includes/mdb/mpg/network-cannot-be-changed.md) %}

     
     * `security_group_ids`: [Security group](../concepts/network.md#security-groups) IDs.


     * `deletion_protection`: Protection of the cluster, its databases, and users against deletion.

        By default, the parameter inherits its value from the cluster when creating users and databases. You can also set the value manually; for more information, see the [User management](cluster-users.md) and [Database management](databases.md) sections.

        If the parameter is changed on a running cluster, only users and databases with the **Same as cluster** protection will inherit the new value.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `config_spec`: Cluster settings:

       * `version`: {{ PG }} version.
       * `resources`: Cluster resources:

         * `resource_preset_id`: [Host class](../concepts/instance-types.md).
         * `disk_size`: Disk size in bytes.
         * `disk_type_id`: [Disk type](../concepts/storage.md).

       
       * `access`: Cluster settings for access to the following {{ yandex-cloud }} services:

         * `data_lens`: [{{ datalens-full-name }}](../../datalens/index.yaml)
         * `web_sql`: [{{ websql-full-name }}](../../websql/index.yaml)
         * `serverless`: [{{ sf-full-name }}](../../functions/index.yaml)
         * `data_transfer`: [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)
         * `yandex_query`: [{{ yq-full-name }}](../../query/index.yaml)


       * `performance_diagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:

         * `enabled`: Enables statistics collection.
         * `sessions_sampling_interval`: Session sampling interval. The values range from `1` to `86400` seconds.
         * `statements_sampling_interval`: Statement sampling interval. The values range from `60` to `86400` seconds.

     * `database_specs`: Database settings as an array of elements, one for each DB. Each element has the following structure:

       * `name`: DB name.
       * `owner`: DB owner username. It must match one of the usenames specified in the request.

     * `user_specs`: User settings as an array of elements, one for each user. Each element has the following structure:

       * `name`: Username.
       * `password`: User password. The password must be from 8 to 128 characters long.
       
          You can also generate a password using {{ connection-manager-name }}. To do this, specify `"generate_password": true` instead of `"password": "<user_password>"`.

          To view the password, select the cluster you created in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.postgresql.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

       * `permissions.database_name`: Name of the database the user gets access to.
       * `login`: User permission to connect to the DB.

     * `host_specs`: Cluster host settings as an array of elements, one for each host. Each element has the following structure:

       * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
       * `subnet_id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
       * `assign_public_ip`: Permission to [connect](connect.md) to the host from the internet.

  1. Use the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}


{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to [configure security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}


## Creating a cluster copy {#duplicate}

You can create a {{ PG }} cluster using the settings of another one created earlier. To do so, you need to import the configuration of the source {{ PG }} cluster to {{ TF }}. This way you can either create an identical copy or use the imported configuration as the baseline and modify it as needed. Importing a configuration is a good idea when the source {{ PG }} cluster has a lot of settings and you need to create a similar one.

To create an {{ PG }} cluster copy:

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

    1. Write the ID of the initial {{ PG }} cluster to the environment variable:

        ```bash
        export POSTGRESQL_CLUSTER_ID=<cluster_ID>
        ```

        You can request the ID with the [list of clusters in the folder](../../managed-postgresql/operations/cluster-list.md#list-clusters).

    1. Import the settings of the initial {{ PG }} cluster into the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_postgresql_cluster.old ${POSTGRESQL_CLUSTER_ID}
        ```

    1. Get the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from the terminal and paste it into the `.tf` file.
    1. Place the file in the new `imported-cluster` directory.
    1. Modify the copied configuration so that you can create a new cluster from it:

        * Specify the new cluster name in the `resource` string and the `name` parameter.
        * Delete `created_at`, `health`, `id`, and `status`.
        * In the `host` sections, delete `fqdn` and `role`.
        * If the `disk_size_autoscaling` section has `disk_size_limit = 0`, delete this section.
        * If the `maintenance_window` section has `type = "ANYTIME"`, delete the `hour` parameter.
        * Optionally, make further changes if you need to customize the configuration.

    1. [Get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) in the `imported-cluster` directory.

    1. In the same directory, [configure and initialize a provider](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). There is no need to create a provider configuration file manually, you can [download it](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Place the configuration file in the `imported-cluster` directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you did not add the authentication credentials to environment variables, specify them in the configuration file.

    1. Check that the {{ TF }} configuration files are correct:

        ```bash
        terraform validate
        ```

        {{ TF }} will show any errors found in your configuration files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  To create a cluster with a single host, provide a single `--host` parameter.

  Create a {{ mpg-name }} cluster with the following test specifications:

  
  * Name: `mypg`.
  * Environment: `production`.
  * Network: `default`.
  * Security group: `{{ security-group }}`.
  * With one `{{ host-class }}` host in the `b0rcctk2rvtr********` subnet, in the `{{ region-id }}-a` availability zone.
  * Network SSD storage (`{{ disk-type-example }}`): 20 GB.
  * User: `user1`, password: `user1user1`.
  * Database: `db1`, owner: `user1`.
  * Protection of the cluster, its DBs, and users against accidental deletion: Enabled.


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

  Create a {{ mpg-name }} cluster and a network for it with the following test specifications:

  * Name: `mypg`.
  * Version: `{{ pg.versions.tf.latest }}`.
  * Environment: `PRESTABLE`.
  * Cloud ID: `{{ tf-cloud-id }}`.
  * Folder ID: `{{ tf-folder-id }}`.
  * New network: `mynet`.

  
  * New security group: `pgsql-sg`, allowing cluster connections from the internet through port `6432`.


  * Host class: `{{ host-class }}` (one host), new subnet: `mysubnet`, availability zone: `{{ region-id }}-a`. `mysubnet` range: `10.5.0.0/24`.
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
