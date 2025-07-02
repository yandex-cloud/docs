---
title: How to create a {{ CH }} cluster
description: Follow this guide to create a {{ CH }} cluster with a single or multiple DB hosts.
---

# Creating a {{ CH }} cluster


A {{ CH }} cluster consists of one or more database hosts between which you can configure replication.


## Roles for creating a cluster {#roles}

To create a {{ mch-name }} cluster, you will need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) and [{{ roles.mch.editor }}](../security.md#managed-clickhouse-editor) roles or higher.

To link your service account to a cluster, e.g., to [use {{ objstorage-full-name }}](s3-access.md), make sure your {{ yandex-cloud }} account has the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher.

For more information about assigning roles, see the [{{ iam-full-name }}](../../iam/operations/roles/grant.md) documentation.


## Creating a cluster {#create-cluster}

* Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

* The number of hosts you can create together with a {{ CH }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).

* When using [{{ CK }}](../concepts/replication.md#ck), a cluster must consist of three or more hosts. You do not need separate hosts to run {{ CK }}. You can only create this kind of cluster using the [{{ yandex-cloud }} CLI](../../cli) or API.

* When using [{{ ZK }}](../concepts/replication.md#zk), a cluster can consist of two or more hosts. Another three {{ ZK }} hosts will be added to the cluster automatically.

  The minimum number of cores per {{ ZK }} host depends on the total number of cores on {{ CH }} hosts. To learn more, see [Replication](../concepts/replication.md#zk).

  {% note warning %}

  {{ ZK }} hosts count against the cloud resource usage [quota]({{ link-console-quotas }}) and contribute to the cluster [cost](../pricing.md#prices-zookeeper).

  {% endnote %}

{% include [Connection Manager](../../_includes/mdb/connman-cluster-create.md) %}

{% list tabs group=instructions %}

- Management console {#console}



  To create a {{ mch-name }} cluster:

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Enter a name for the cluster in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. It must be unique within the folder.
  1. Select the environment where you want to create the cluster (you cannot change the environment once the cluster is created):
      * `PRODUCTION`: For stable versions of your apps.
      * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
  1. From the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** drop-down list, select the {{ CH }} version which the {{ mch-name }} cluster will use. For most clusters, we recommend selecting the latest LTS version.

  
  1. If you are expecting to use data from a {{ objstorage-name }} bucket with [restricted access](../../storage/concepts/bucket#bucket-access), select a service account from the drop-down list or create a new one. For more information about setting up a service account, see [Configuring access to {{ objstorage-name }}](s3-access.md).


  1. Under **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**:

      * Select the platform, VM type, and host class that defines the technical specifications of the VMs where the DB hosts will be deployed. All available options are listed under [Host classes](../concepts/instance-types.md). When you change the host class for a cluster, the specifications of all existing instances also change.

      
      * Select the [disk type](../concepts/storage.md).

        {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

        {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


      * Select the size of your data and backup disk. For more information on how backups take up storage space, see [Backups](../concepts/backup.md).


  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**:

      * To create additional DB hosts, click **{{ ui-key.yacloud.mdb.forms.button_add-host }}**. After you add a second host, the **Configure ZooKeeper** button will appear. Change the {{ ZK }} settings in **{{ ui-key.yacloud.mdb.forms.section_zookeeper-resource }}**, **{{ ui-key.yacloud.mdb.forms.section_zookeeper-disk }}**, and **{{ ui-key.yacloud.mdb.forms.section_zookeeper-hosts }}**, if required.
      * Specify the parameters of the DB hosts that will be created together with the cluster. To change the added host, hover over the host line and click ![image](../../_assets/console-icons/pencil.svg).
      * To connect to the host from the internet, enable the **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** setting.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**:

      * If you want to manage cluster users via SQL, select **{{ ui-key.yacloud.common.enabled }}** from the drop-down list in the **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** field and enter the `admin` user password. This disables user management through other interfaces.

        Otherwise, select **{{ ui-key.yacloud.common.disabled }}**.


      * If you want to manage databases via SQL, select **{{ ui-key.yacloud.common.enabled }}** from the drop-down list in the **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}** field. This disables database management through other interfaces. The field is inactive if user management via SQL is disabled.

        Otherwise, select **{{ ui-key.yacloud.common.disabled }}**.

        {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

      * Enter the username.

        {% include [user-name-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

      * Enter the user password:

        * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Select to enter your password. The password must be from 8 to 128 characters long.

        * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Select to generate a password with the help of {{ connection-manager-name }}.

        To view the password, select the **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** tab after you create the cluster and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

      * Specify the DB name. The DB name may contain Latin letters, numbers, and underscores. It may be up to 63 characters long. You cannot create a database named `default`.

      * Enable [hybrid storage](../concepts/storage.md#hybrid-storage-features) for the cluster, if required.

        {% note warning %}

        You cannot disable this option.

        {% endnote %}

      * Configure the [DBMS settings](../concepts/settings-list.md#server-level-settings), if required. You can specify them later.

        Using the {{ yandex-cloud }} interfaces, you can manage a limited number of settings. Using SQL queries, you can [apply {{ CH }} settings at the query level](change-query-level-settings.md).

  
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select a cloud network to host the cluster and security groups for cluster network traffic. You may need to additionally [set up security groups](connect/index.md#configuring-security-groups) to be able to connect to the cluster.


  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, select the parameters of database hosts created together with the cluster. To change the settings of a host, click the ![pencil](../../_assets/console-icons/pencil.svg) icon in the line with its number:

      * **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_zone }}**: Select an [availability zone](../../overview/concepts/geo-scope.md).
      * **{{ ui-key.yacloud.mdb.hosts.dialog.field_subnetworks }}**: Specify a [subnet](../../vpc/concepts/network.md#subnet) in the selected availability zone.
      * **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**: Allow [access](connect/index.md) to the host from the internet.

      To add hosts to the cluster, click **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.

  1. Configure cluster service settings, if required:

      {% include [mch-extra-settings](../../_includes/mdb/mch/extra-settings-web-console.md) %}

  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ mch-name }} cluster:

  
  1. Check whether the folder has any subnets for the cluster hosts:

      ```bash
      yc vpc subnet list
      ```

     If there are no subnets in the folder, [create the required subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.


  1. View the description of the CLI command to create a cluster:

      ```bash
      {{ yc-mdb-ch }} cluster create --help
      ```

  1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      
      ```bash
      {{ yc-mdb-ch }} cluster create \
        --name <cluster_name> \
        --environment <environment> \
        --network-name <network_name> \
        --host type=<host_type>,`
             `zone-id=<availability_zone>,`
             `subnet-id=<subnet_ID>,`
             `assign-public-ip=<public_access_to_host> \
        --clickhouse-resource-preset <host_class> \
        --clickhouse-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --clickhouse-disk-size <storage_size_in_GB> \
        --user name=<username>,password=<user_password> \
        --database name=<DB_name> \
        --security-group-ids <list_of_security_group_IDs> \
        --websql-access=<true_or_false> \
        --deletion-protection
      ```

      You need to specify the `subnet-id` if the selected availability zone has two or more subnets.


      Where:

      * `--environment`: Cluster environment, `prestable` or `production`.
      * `--host`: Host parameters:
        * `type`: Host type: `clickhouse` or `zookeeper`.
        * `zone-id`: Availability zone.
        * `assign-public-ip`: Internet access to the host via a public IP address, `true` or `false`.

      
      * `--clickhouse-disk-type`: Disk type.

        {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}


      * `--user`: Contains the {{ CH }} user `name` and `password`.

        {% include [user-name-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

        The password must be from 8 to 128 characters long.

        {% note info %}

        You can also generate a password using {{ connection-manager-name }}. To do this, adjust the command, setting the user parameters as follows:

        ```bash
          --user name=<username>,generate-password=true
        ```

        To view the password, select the cluster you created in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

        {% endnote %}

      * `--websql-access`: Enables [SQL queries](web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}. The default value is `false`.

      * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

      You can manager cluster users and databases via SQL.

      {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

      1. To enable [SQL user management](./cluster-users.md#sql-user-management):

         * set `--enable-sql-user-management` to `true`.
         * Set a password for the `admin` user in the `--admin-password` parameter.

         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --enable-sql-user-management true \
           --admin-password "<admin_user_password>"
         ```


      1. To enable [SQL database management](./databases.md#sql-database-management):

         * Set `--enable-sql-user-management` and `--enable-sql-database-management` to `true`;
         * Set a password for the `admin` user in the `--admin-password` parameter.

         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --enable-sql-user-management true \
           --enable-sql-database-management true \
           --admin-password "<admin_user_password>"
         ```

      
      1. To allow access to the cluster from [{{ sf-full-name }}](../../functions/concepts/index.md), provide the `--serverless-access` parameter. For more information about setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md) documentation.


      1. To allow access to the cluster from [{{ yq-full-name }}](../../query/concepts/index.md), provide the `--yandexquery-access=true` parameter. This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage.


      1. To enable [{{ CK }}](../concepts/replication.md#ck) in a cluster, set the `--embedded-keeper` parameter to `true`.

         ```bash
         {{ yc-mdb-ch }} cluster create \
           ...
           --embedded-keeper true
         ```

         {% include [ClickHouse Keeper can't turn off](../../_includes/mdb/mch/note-ck-no-turn-off.md) %}

      1. To configure [hybrid storage settings](../concepts/storage.md#hybrid-storage-settings):

         * Set the `--cloud-storage` parameter to `true` to enable hybrid storage.

            {% include [Hybrid Storage cannot be switched off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}

         * Provide the hybrid storage settings in the relevant parameters:

            {% include [Hybrid Storage settings CLI](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

         ```bash
         {{ yc-mdb-ch }} cluster create \
            ...
            --cloud-storage=true \
            --cloud-storage-data-cache=<file_storage> \
            --cloud-storage-data-cache-max-size=<memory_size_in_bytes> \
            --cloud-storage-move-factor=<share_of_free_space> \
            --cloud-storage-prefer-not-to-merge=<merging_data_parts>
           ...
         ```

         Where:
         * `--cloud-storage-data-cache`: Store files in cluster storage, `true` or `false`.
         * `--cloud-storage-prefer-not-to-merge`: Disables merging of data parts in cluster and object storage, `true` or `false`.

  {% note info %}

  When creating a cluster, the `anytime` [maintenance](../concepts/maintenance.md) mode is set by default. You can set a specific maintenance period when [updating the cluster settings](update.md#change-additional-settings).

  {% endnote %}

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  To create a {{ mch-name }} cluster:

    1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan. Create the directory if it does not exist.

    
    1. {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Create a configuration file describing the [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet).
        * Network: Description of the [cloud network](../../vpc/concepts/network.md#network) where the cluster will be hosted. If you already have a suitable network, you do not need to describe it again.
        * Subnets: [Subnets](../../vpc/concepts/network.md#network) to connect the cluster hosts to. If you already have suitable subnets, you do not need to describe them again.

       Example structure of a configuration file describing a single-subnet cloud network:

       ```hcl
       resource "yandex_vpc_network" "<network_name_in_{{ TF }}>" { name = "<network_name>" }

       resource "yandex_vpc_subnet" "<subnet_name_in_{{ TF }}>" {
         name           = "<subnet_name>"
         zone           = "<availability_zone>"
         network_id     = yandex_vpc_network.<network_name_in_{{ TF }}>.id
         v4_cidr_blocks = ["<subnet>"]
       }
       ```


    1. Create a configuration file with a description of the cluster resources to create:

       * Database cluster: description of the cluster and its hosts. Also here, as needed:
          * Specify the [DBMS server-level settings](../concepts/settings-list.md#server-level-settings). You can also provide them later.
          * Enable cluster protection against accidental deletion.

             {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

       * Database: cluster DB description.
       * User: cluster user description. Also here, as needed, specify the [DBMS user-level settings](../concepts/settings-list.md#dbms-user-settings). You can also provide them later.

          Using the {{ yandex-cloud }} interfaces, you can manage a limited number of settings. Using SQL queries, you can [apply {{ CH }} settings at the query level](change-query-level-settings.md).

       Example structure of a configuration file that describes a cluster with a single host:

       
       ```hcl
       resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
         name                = "<cluster_name>"
         environment         = "<environment>"
         network_id          = yandex_vpc_network.<network_name_in_{{ TF }}>.id
         security_group_ids  = ["<list_of_security_group_IDs>"]
         deletion_protection = <cluster_deletion_protection>

         clickhouse {
           resources {
             resource_preset_id = "<host_class>"
             disk_type_id       = "<disk_type>"
             disk_size          = <storage_size_in_GB>
           }
         }

         host {
           type             = "CLICKHOUSE"
           zone             = "<availability_zone>"
           subnet_id        = yandex_vpc_subnet.<subnet_name_in_{{ TF }}>.id
           assign_public_ip = <public_access_to_host>
         }

         lifecycle {
           ignore_changes = [database, user]
         }
       }

       resource "yandex_mdb_clickhouse_database" "<DB_name>" {
         cluster_id = yandex_mdb_clickhouse_cluster.<cluster_name>.id
         name       = "<DB_name>"
       }

       resource "yandex_mdb_clickhouse_user" "<username>" {
         cluster_id = yandex_mdb_clickhouse_cluster.<cluster_name>.id
         name       = "<username>"
         password   = "<user_password>"
         permission {
           database_name = yandex_mdb_clickhouse_database.<DB_name>.name
         }
         settings {
           <parameter_1_name> = <value_1>
           <parameter_2_name> = <value_2>
           ...
         }
       }
       ```


       Where:

       * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.
       * `assign_public_ip`: Public access to the host, `true` or `false`.
       * `lifecycle.ignore_changes`: Eliminates resource conflicts in operations with users and databases created through individual resources.

       For a user, specify as follows:

       * `name` and `password`: {{ CH }} user's username and password, respectively.

          {% include [user-name](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

          The password must be from 8 to 128 characters long.

          {% note info %}

          You can also generate a password using {{ connection-manager-name }}. To do this, specify `generate_password = true` instead of `"password" = "<user_password>"`.

          To view the password, select the cluster you created in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

          {% endnote %}

       * `permission`: List of DBs the user must have access to.

       1. {% include [Maintenance window](../../_includes/mdb/mch/terraform/maintenance-window.md) %}

       1. To enable access from other services and allow [running SQL queries from the management console](web-sql-query.md) using {{ websql-full-name }}, add a section named `access` with the settings you need:

          
          ```hcl
          resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
            ...
            access {
              data_lens    = <access_from_{{ datalens-name }}>
              metrika      = <access_from_Metrica_and_AppMetrica>
              serverless   = <access_from_Cloud_Functions>
              yandex_query = <access_from_Yandex_Query>
              web_sql      = <run_SQL_queries_from_management_console>
            }
            ...
          }
          ```


          Where:

          * `data_lens`: Access from {{ datalens-name }}, `true` or `false`.

          
          * `metrika`: Access from Yandex Metrica and AppMetrica, `true` or `false`.
          * `serverless`: Access from {{ sf-name }}, `true` or `false`.


          * `yandex_query`: Access from {{ yq-full-name }}, `true` or `false`.
          * `web_sql`: Execution of SQL queries from the management console, `true` or `false`.

       1. You can manager cluster users and databases via SQL.

          {% include notitle [SQL Management can't be switched off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

          * {% include notitle [Enable SQL user management with Terraform](../../_includes/mdb/mch/terraform/sql-management-users.md) %}


          * {% include notitle [Enable SQL database management with Terraform](../../_includes/mdb/mch/terraform/sql-management-databases.md) %}

       For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-mch }}).

    1. Check that the {{ TF }} configuration files are correct:

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a cluster:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Create](../api-ref/Cluster/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        1. Create a file named `body.json` and add the following contents to it:

            {% note info %}

            This example does not use all available parameters.

            {% endnote %}

            
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
              "configSpec": {
                "version": "<{{ CH }}>_version",
                "embeddedKeeper": <using_ClickHouse®_Keeper>,
                "clickhouse": {
                  "resources": {
                    "resourcePresetId": "<{{ CH }}>_host_class",
                    "diskSize": "<storage_size_in_bytes>",
                    "diskTypeId": "<disk_type>"
                  }
                },
                "zookeeper": {
                  "resources": {
                    "resourcePresetId": "<{{ ZK }}>_host_class",
                    "diskSize": "<storage_size_in_bytes>",
                    "diskTypeId": "<disk_type>"
                  }
                },
                "access": {
                  "dataLens": <access_from_{{ datalens-name }}>,
                  "webSql": <run_SQL_queries_from_management_console>,
                  "metrika": <access_from_Metrica_and_AppMetrica>,
                  "serverless": <access_from_Cloud_Functions>,
                  "dataTransfer": <access_from_Data_Transfer>,
                  "yandexQuery": <access_from_Yandex_Query>
                },
                "cloudStorage": {
                  "enabled": <hybrid_storage_use>,
                  "moveFactor": "<share_of_free_space>",
                  "dataCacheEnabled": <temporary_file_storage>,
                  "dataCacheMaxSize": "<maximum_cache_size_for_file_storage>",
                  "preferNotToMerge": <disabling_merge_of_data_parts>
                },
                "adminPassword": "<admin_user_password>",
                "sqlUserManagement": <user_management_via_SQL>,
                "sqlDatabaseManagement": <database_management_via_SQL>
              },
              "databaseSpecs": [
                {
                  "name": "<DB_name>"
                },
                { <similar_settings_for_database_2> },
                { ... },
                { <similar_settings_for_database_N> }
              ],
              "userSpecs": [
                {
                  "name": "<username>",
                  "password": "<user_password>",
                  "permissions": [
                    {
                      "databaseName": "<DB_name>"
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
                  "type": "<host_type>",
                  "subnetId": "<subnet_ID>",
                  "assignPublicIp": <public_access_to_host>,
                  "shardName": "<shard_name>"
                },
                { <similar_configuration_for_host_2> },
                { ... },
                { <similar_configuration_for_host_N> }
              ],
              "deletionProtection": <cluster_deletion_protection>
            }
            ```


            Where:

            * `name`: Cluster name.
            * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
            * `networkId`: ID of the [network](../../vpc/concepts/network.md) the cluster will be in.

            
            * `securityGroupIds`: [Security group](../../vpc/concepts/security-groups.md) IDs as an array of strings. Each string is a security group ID.


            * `configSpec`: Cluster configuration:

                * `version`: {{ CH }} version, {{ versions.api.str }}.
                * `embeddedKeeper`: Using [{{ CK }}](../concepts/replication.md#ck) instead of {{ ZK }}, `true` or `false`.

                    {% include [replication-management-details](../../_includes/mdb/mch/api/replication-management-details.md) %}

                * `clickhouse`: {{ CH }} configuration:

                    * `resources.resourcePresetId`: [Host class](../concepts/instance-types.md) ID. You can request the list of available host classes with their IDs using the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method.
                    * `resources.diskSize`: Disk size in bytes.
                    * `resources.diskTypeId`: [Disk type](../concepts/storage.md).

                * `zookeeper`: [{{ ZK }}](../concepts/replication.md#zk) configuration.

                    * `resources.resourcePresetId`: Host class ID. You can request the list of available host classes with their IDs using the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method.
                    * `resources.diskSize`: Disk size in bytes.
                    * `resources.diskTypeId`: Disk type.

                    If you enabled {{ CK }} with the help of the `embeddedKeeper: true` setting, you do not have to specify a {{ ZK }} configuration in `configSpec` as it will not be applied.

                * `access`: Settings enabling access to the cluster from other services and [SQL queries from the management console](web-sql-query.md) using {{ websql-full-name }}:

                    {% include [rest-access-settings](../../_includes/mdb/mch/api/rest-access-settings.md) %}

                * `cloudStorage`: [Hybrid storage](../concepts/storage.md#hybrid-storage-features) settings:

                    {% include [rest-cloud-storage-settings](../../_includes/mdb/mch/api/rest-cloud-storage-settings.md) %}

                * `sql...` and `adminPassword`: Group of settings for user and database management via SQL:

                    * `adminPassword`: `admin` user password.
                    * `sqlUserManagement`: [User management via SQL](./cluster-users.md#sql-user-management), `true` or `false`.
                    * `sqlDatabaseManagement`: [Database management via SQL](./databases.md#sql-database-management), `true` or `false`. For that, you also need to enable user management through SQL.


                    {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

            * `databaseSpecs`: Database settings as an array of `name` element parameters. Each parameter contains a name of a separate database.

            * `userSpecs`: User settings as an array of elements, one for each user. Each element has the following structure:

                {% include [rest-user-specs](../../_includes/mdb/mch/api/rest-user-specs.md) %}

            * `hostSpecs`: Cluster host settings as an array of elements, one for each host. Each element has the following structure:

                * `type`: Host type: `CLICKHOUSE` or `ZOOKEEPER`.

                    If you enabled {{ CK }} with the help of the `embeddedKeeper: true` setting, specify only {{ CH }} host settings in `hostSpecs`.

                * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
                * `subnetId`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
                * `shardName`: [Shard](../concepts/sharding.md) name. The setting is only relevant for `CLICKHOUSE`-type hosts.
                * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.

                
                {% include [zk-hosts-details](../../_includes/mdb/mch/api/zk-hosts-details.md) %}


            * `deletionProtection`: Cluster protection from accidental deletion, `true` or `false`. The default value is `false`.

                {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

            
            You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. Run this request:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters' \
              --data '@body.json'
            ```

    1. View the [server response](../api-ref/Cluster/create.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        1. Create a file named `body.json` and add the following contents to it:

            {% note info %}

            This example does not use all available parameters.

            {% endnote %}

            
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
              "config_spec": {
                "version": "<{{ CH }}_version>",
                "embedded_keeper": <{{ CK }}_usage>,
                "clickhouse": {
                  "resources": {
                    "resource_preset_id": "<{{ CH }}>_host_class",
                    "disk_size": "<storage_size_in_bytes>",
                    "disk_type_id": "<disk_type>"
                  }
                },
                "zookeeper": {
                  "resources": {
                    "resource_preset_id": "<{{ ZK }}_host_class>",
                    "disk_size": "<storage_size_in_bytes>",
                    "disk_type_id": "<disk_type>"
                  }
                },
                "access": {
                  "data_lens": <access_from_{{ datalens-name }}>,
                  "web_sql": <run_SQL_queries_from_management_console>,
                  "metrika": <access_from_Metrica_and_AppMetrica>,
                  "serverless": <access_from_Cloud_Functions>,
                  "data_transfer": <access_from_Data_Transfer>,
                  "yandex_query": <access_from_Yandex_Query>
                },
                "cloud_storage": {
                  "enabled": <hybrid_storage_use>,
                  "move_factor": "<share_of_free_space>",
                  "data_cache_enabled": <temporary_file_storage>,
                  "data_cache_max_size": "<maximum_cache_size_for_file_storage>",
                  "prefer_not_to_merge": <disabling_merge_of_data_parts>
                },
                "admin_password": "<admin_user_password>",
                "sql_user_management": <user_management_via_SQL>,
                "sql_database_management": <database_management_via_SQL>
              },
              "database_specs": [
                {
                  "name": "<DB_name>"
                },
                { <similar_settings_for_database_2> },
                { ... },
                { <similar_settings_for_database_N> }
              ],
              "user_specs": [
                {
                  "name": "<username>",
                  "password": "<user_password>",
                  "permissions": [
                    {
                      "database_name": "<DB_name>"
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
                  "type": "<host_type>",
                  "subnet_id": "<subnet_ID>",
                  "assign_public_ip": <public_access_to_host>,
                  "shard_name": "<shard_name>"
                },
                { <similar_configuration_for_host_2> },
                { ... },
                { <similar_configuration_for_host_N> }
              ],
              "deletion_protection": <cluster_deletion_protection>
            }
            ```


            Where:

            * `name`: Cluster name.
            * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.

            * `network_id`: ID of the [network](../../vpc/concepts/network.md) the cluster will be in.

            
            * `security_group_ids`: [Security group](../../vpc/concepts/security-groups.md) IDs as an array of strings. Each string is a security group ID.


            * `config_spec`: Cluster configuration:

                * `version`: {{ CH }} version, {{ versions.api.str }}.

                * `embedded_keeper`: Using [{{ CK }}](../concepts/replication.md#ck) instead of {{ ZK }}, `true` or `false`.

                    {% include [replication-management-details](../../_includes/mdb/mch/api/replication-management-details.md) %}

                * `clickhouse`: {{ CH }} configuration:

                    * `resources.resource_preset_id`: [Host class](../concepts/instance-types.md) ID. You can request the list of available host classes with their IDs using the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method.
                    * `resources.disk_size`: Disk size in bytes.
                    * `resources.disk_type_id`: [Disk type](../concepts/storage.md).

                * `zookeeper`: [{{ ZK }}](../concepts/replication.md#zk) configuration.

                    * `resources.resource_preset_id`: Host class ID. You can request the list of available host classes with their IDs using the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method.
                    * `resources.disk_size`: Disk size in bytes.
                    * `resources.disk_type_id`: Disk type.

                    If you enabled {{ CK }} with the help of the `embedded_keeper: true` setting, you do not have to specify a {{ ZK }} configuration in `config_spec` as it will not be applied.

                * `access`: Settings enabling access to the cluster from other services and [SQL queries from the management console](web-sql-query.md) using {{ websql-full-name }}:

                    {% include [grpc-access-settings](../../_includes/mdb/mch/api/grpc-access-settings.md) %}

                * `cloud_storage`: [Hybrid storage](../concepts/storage.md#hybrid-storage-features) settings:

                    {% include [grpc-cloud-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

                * `sql...` and `admin_password`: Group of settings for user and database management via SQL:

                    * `admin_password`: `admin` user password.
                    * `sql_user_management`: [User management via SQL](./cluster-users.md#sql-user-management), `true` or `false`.
                    * `sql_database_management`: [Database management via SQL](./databases.md#sql-database-management), `true` or `false`. For that, you also need to enable user management through SQL.


                    {% include [SQL-management-can't-be-switched-off](../../_includes/mdb/mch/note-sql-db-and-users-create-cluster.md) %}

            * `database_specs`: Database settings as an array of `name` element parameters. Each parameter contains the name of a separate database.

            * `user_specs`: User settings as an array of elements, one for each user. Each element has the following structure:

                {% include [grpc-user-specs](../../_includes/mdb/mch/api/grpc-user-specs.md) %}

            * `host_specs`: Cluster host settings as an array of elements, one for each host. Each element has the following structure:

                * `type`: Host type: `CLICKHOUSE` or `ZOOKEEPER`.

                    If you enabled {{ CK }} with the help of the `embedded_keeper: true` setting, specify only {{ CH }} host settings in `host_specs`.

                * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
                * `subnet_id`: Subnet [ID](../../vpc/concepts/network.md#subnet).
                * `shard_name`: [Shard](../concepts/sharding.md) name. The setting is only relevant for `CLICKHOUSE`-type hosts.
                * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.

                
                {% include [zk-hosts-details](../../_includes/mdb/mch/api/zk-hosts-details.md) %}


            * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`. The default value is `false`.

                {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

            
            You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. Run this request:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.Create \
              < body.json
            ```

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}


{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to additionally [configure security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}


## Creating a cluster copy {#duplicate}

You can create a {{ CH }} cluster using the settings of another one created earlier. To do so, you need to import the configuration of the source {{ CH }} cluster to {{ TF }}. This way you can either create an identical copy or use the imported configuration as the baseline and modify it as needed. Importing a configuration is a good idea when the source {{ CH }} cluster has a lot of settings and you need to create a similar one.

To create a {{ CH }} cluster copy:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. In the same working directory, place a `.tf` file with the following contents:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "old" { }
        ```

    1. Write the ID of the initial {{ CH }} cluster to the environment variable:

        ```bash
        export CLICKHOUSE_CLUSTER_ID=<cluster_ID>
        ```

        You can request the ID with the [list of clusters in the folder](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. Import the settings of the initial {{ CH }} cluster into the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_clickhouse_cluster.old ${CLICKHOUSE_CLUSTER_ID}
        ```

    1. Get the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from the terminal and paste it into the `.tf` file.
    1. Place the file in the new `imported-cluster` directory.
    1. Modify the copied configuration so that you can create a new cluster from it:

        * Specify the new cluster name in the `resource` string and the `name` parameter.
        * Delete the `created_at`, `health`, `id`, and `status` parameters.
        * In the `host` sections, delete the `fqdn` parameters.
        * Under `clickhouse.config.merge_tree`, if `max_bytes_to_merge_at_max_space_in_pool`, `max_parts_in_total`, and `number_of_free_entries_in_pool_to_execute_mutation` is set to `0`, delete these parameters.
        * Under `clickhouse.config.kafka`, set `sasl_password` or delete this parameter.
        * Under `clickhouse.config.rabbitmq`, set `password` or delete this parameter.
        * If the `maintenance_window` section has `type = "ANYTIME"`, delete the `hour` parameter.
        * Delete all `user` sections (if any). You can add database users using the separate `yandex_mdb_clickhouse_user` resource.
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

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  To create a cluster with a single host, provide a single `--host` parameter.

  Create a {{ mch-name }} cluster with the following test specifications:

  
  * Name: `mych`.
  * Environment: `production`.
  * Network: `default`.
  * Security group: `{{ security-group }}`.
  * Number of {{ CH }} hosts of the `{{ host-class }}` class in the `b0rcctk2rvtr********` subnet in the `{{ region-id }}-a` availability zone: 1.
  * {{ CK }}.
  * Network SSD storage (`{{ disk-type-example }}`): 20 GB.
  * User: `user1` with password `user1user1`.
  * Database: `db1`.
  * Cluster protection from accidental deletion.


  Run this command:

  
  ```bash
  {{ yc-mdb-ch }} cluster create \
    --name mych \
    --environment=production \
    --network-name default \
    --clickhouse-resource-preset {{ host-class }} \
    --host type=clickhouse,zone-id={{ region-id }}-a,subnet-id=b0cl69g98qum******** \
    --embedded-keeper true \
    --clickhouse-disk-size 20 \
    --clickhouse-disk-type {{ disk-type-example }} \
    --user name=user1,password=user1user1 \
    --database name=db1 \
    --security-group-ids {{ security-group }} \
    --deletion-protection
  ```


- {{ TF }} {#tf}

  Create a {{ mch-name }} cluster and a network for it with the following test specifications:

  * Name: `mych`.
  * Environment: `PRESTABLE`.
  * Cloud ID: `{{ tf-cloud-id }}`.
  * Folder ID: `{{ tf-folder-id }}`.
  * New cloud network: `cluster-net`.

  
  * New [default security group](connect/index.md#configuring-security-groups): `cluster-sg` (in the `cluster-net` network). It must allow connections to any cluster host from any network (including the internet) on ports `8443` and `9440`.


  * One `{{ host-class }}` class hosts in a new subnet named `cluster-subnet-{{ region-id }}-a`.

    Subnet parameters:
    * Address range: `172.16.1.0/24`.
    * Network: `cluster-net`.
    * Availability zone: `{{ region-id }}-a`.

  * Network SSD storage (`{{ disk-type-example }}`): 32 GB.
  * Database name: `db1`.
  * User: `user1` with password `user1user1`.

  The configuration files for this cluster are as follows:

  1. Configuration file with a description of provider settings:

      {% include [terraform-provider](../../_includes/mdb/terraform-provider.md) %}

  1. Configuration file with a description of the cloud network and subnet:

      {% include [terraform-mdb-single-network](../../_includes/mdb/terraform-single-network.md) %}

  
  1. Configuration file with a description of the security group:

      {% include [terraform-mch-sg](../../_includes/mdb/mch/terraform/security-groups.md) %}


  1. Configuration file with a description of the cluster and cluster host:

      {% include [terraform-mch-single-host-single-shard](../../_includes/mdb/mch/terraform/single-host-single-shard.md) %}

{% endlist %}

### Creating a multi-host cluster {#creating-a-multi-host-cluster}


{% list tabs group=instructions %}

- {{ TF }} {#tf}

  Create a {{ mch-name }} cluster with the following test specifications:

  * Name: `mych`.
  * Environment: `PRESTABLE`.
  * Cloud ID: `{{ tf-cloud-id }}`.
  * Folder ID: `{{ tf-folder-id }}`.
  * New cloud network: `cluster-net`.

  * Three {{ CH }} hosts of the `{{ host-class }}` class and three {{ ZK }} hosts of the `{{ zk-host-class }}` class (to ensure [replication](../concepts/replication.md)).

    One host of each class will be added to the new subnets:
    * `cluster-subnet-{{ region-id }}-a`: `172.16.1.0/24`, availability zone: `{{ region-id }}-a`.
    * `cluster-subnet-{{ region-id }}-b`: `172.16.2.0/24`, availability zone: `{{ region-id }}-b`.
    * `cluster-subnet-{{ region-id }}-d`: `172.16.3.0/24`, availability zone: `{{ region-id }}-d`.

    These subnets will belong to the `cluster-net` network.

  
  * New [default security group](connect/index.md#configuring-security-groups): `cluster-sg` (in the `cluster-net` network). It must allow connections to any cluster host from any network (including the internet) on ports `8443` and `9440`.


  * Local SSD storage (`{{ disk-type-example }}`) for each of the cluster's {{ CH }} hosts: 32 GB.
  * Local SSD storage (`{{ disk-type-example }}`) for each of the cluster's {{ ZK }} hosts: 10 GB.
  * Database name: `db1`.
  * User: `user1` with password `user1user1`.

  The configuration files for this cluster are as follows:

  1. Configuration file with a description of provider settings:

      {% include [terraform-provider](../../_includes/mdb/terraform-provider.md) %}

  1. Configuration file with a description of the cloud network and subnets:

      {% include [terraform-mdb-multiple-networks](../../_includes/mdb/terraform-multiple-networks.md) %}

  
  1. Configuration file with a description of the security group:

      {% include [terraform-mch-sg](../../_includes/mdb/mch/terraform/security-groups.md) %}


  1. Configuration file with a description of the cluster and cluster hosts:

      {% include [terraform-mch-multiple-hosts-single-shard](../../_includes/mdb/mch/terraform/multiple-hosts-single-shard.md) %}

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
