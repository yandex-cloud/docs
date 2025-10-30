---
title: How to create a {{ MY }} cluster
description: In this tutorial, you will learn how to create a {{ MY }} cluster with one or more database hosts.
---

# Creating a {{ MY }} cluster


A {{ MY }} cluster consists of one or more database hosts. In multi-host clusters, [semi-synchronous replication](../concepts/replication.md) is configured automatically.

For more information on the {{ mmy-name }} cluster structure, see [Resource relationships](../concepts/index.md).

{% note info %}

* The number of hosts you can create in a {{ MY }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and the [host class](../concepts/instance-types.md#available-flavors).
* Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md#available-flavors).

{% endnote %}


## Creating a cluster {#create-cluster}


To create a {{ mmy-name }} cluster, you will need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role, as well as the [{{ roles.mmy.editor }} role or higher](../security/index.md#roles-list). For more information on assigning roles, see the [{{ iam-name }} guides](../../iam/operations/roles/grant.md).



{% include [Connection Manager](../../_includes/mdb/connman-cluster-create.md) %}


{% list tabs group=instructions %}

- Management console {#console}



  To create a {{ mmy-name }} cluster:

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your database cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Enter a name for the {{ mmy-name }} cluster in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. The cluster name must be unique within the folder.
  1. Select the environment where you want to create a {{ mmy-name }} cluster (you cannot change the environment once the cluster is created):
     * `PRODUCTION`: For stable versions of your apps.
     * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first of the two to get new features, improvements, and bug fixes. In the prestable environment, you can test the new versions for compatibility with your application.
  1. Select the DBMS version.
  1. Select the host class, which will determine the technical specifications of the [VMs](../../compute/concepts/vm-platforms.md) for deploying your database hosts. All available options are listed under [Host classes](../concepts/instance-types.md). When you change the host class for the {{ mmy-name }} cluster, the specifications of all existing hosts change, too.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

     * Select the [disk type](../concepts/storage.md).

       {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}

     * Select the storage size to be used for data and backups. For more details on how backups utilize storage space, see [Backups](../concepts/backup.md).

       {% note info %}

       If the DB storage is 95% full, the {{ mmy-name }} cluster will switch to read-only mode. Increase the storage size in advance.

       {% endnote %}

     
     * Optionally, select **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}** to encrypt the disk with a [custom KMS key](../../kms/concepts/key.md).

       * To [create](../../kms/operations/key.md#create) a new key, click **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.

       * To use the key you created earlier, select it in the **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** field.

       To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).


  1. Optionally, under **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**:
      
     {% include [disk-size-autoscaling-console](../../_includes/mdb/mmy/disk-size-autoscaling-console.md) %}

  1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify the database details:
     * Database name. The name must be unique within the folder.

       {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

     * Database owner username.

       {% include [user-name-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

     
     * User password:

         * **{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}**: Select this option to set your own password. The password must be from 8 to 128 characters long.

         * **{{ ui-key.yacloud.component.password-input.label_button-generate }}**: Select this option to generate a password using {{ connection-manager-name }}.

         To view the password after cluster creation, select the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. Viewing passwords requires the `lockbox.payloadViewer` role.


  
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select:

     * [Cloud network](../../vpc/concepts/network.md#network) for the cluster.
     * [Security groups](../../vpc/concepts/security-groups.md) for the cluster network traffic. You may also need to [set up security groups](connect.md#configuring-security-groups) to connect to the {{ mmy-name }} cluster.


  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, click ![image](../../_assets/console-icons/pencil.svg) and select the parameters for the DB hosts created together with the {{ mmy-name }} cluster:
     * Availability zone.
     * Host [subnet](../../vpc/concepts/network.md#subnet): By default, each host is created in a separate subnet.

     
     * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.


     * [Host priority for assignment as a master](../concepts/replication.md#master-failover).
     * [Host priority as a {{ MY }} replica](../concepts/backup.md#size) for creating backups.

     The minimum number of hosts in a cluster depends on the selected [disk type](../concepts/storage.md). The default cluster configuration offered in the management console includes:

      * Two hosts if selected disk type is `network-ssd`, `network-hdd`, or `network-ssd-io-m3`.
      * Three hosts if selected disk type is `local-ssd` or `network-ssd-nonreplicated`.

     {% note warning %}

     We do not recommend creating a single-host cluster. While being cheaper, it will not ensure [high availability](../concepts/high-availability.md#host-configuration).

     {% endnote %}

     After creating a {{ mmy-name }} cluster, you can add extra hosts to it if there are enough [folder resources](../concepts/limits.md) available.

  1. Specify additional {{ mmy-name }} cluster settings, if required:

     {% include [mmy-extra-settings](../../_includes/mdb/mmy-extra-settings-web-console.md) %}

  1. If needed, configure [cluster-level DBMS settings](../concepts/settings-list.md#dbms-cluster-settings).

     {% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ mmy-name }} cluster:

  
  1. Check whether the folder has any [subnets](../../vpc/concepts/network.md#subnet) for the {{ mmy-name }} cluster hosts:

     ```bash
     yc vpc subnet list
     ```

     If your folder has no subnets, [create them](../../vpc/operations/subnet-create.md) in [{{ vpc-full-name }}](../../vpc/).


  1. See the description of the CLI command for creating a {{ mmy-name }} cluster:

     ```bash
     {{ yc-mdb-my }} cluster create --help
     ```

  1. Specify the {{ mmy-name }} cluster parameters in the create command:

     
     ```bash
     {{ yc-mdb-my }} cluster create \
       --name=<cluster_name> \
       --environment <environment> \
       --network-name <network_name> \
       --host zone-id=<availability_zone>,`
         `subnet-id=<subnet_ID>,`
         `assign-public-ip=<allow_public_access_to_host>,`
         `priority=<priority_when_selecting_master_host>,`
         `backup-priority=<backup_priority> \
       --mysql-version <{{ MY }}_version> \
       --resource-preset <host_class> \
       --user name=<username>,password=<user_password> \
       --database name=<DB_name> \
       --disk-size <storage_size_in_GB> \
       --disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
       --security-group-ids <list_of_security_group_IDs>
     ```

     You need to specify the `subnet-id` if the selected [availability zone](../../overview/concepts/geo-scope.md) has two or more subnets.


     Where:

     * `--environment`: Environment, `prestable` or `production`.

     
     * `--assign-public-ip`: Public access to the host, `true` or `false`.


     * `--disk-type`: [Disk type](../concepts/storage.md).
     * `--priority`: Host priority when selecting a new master host, between `0` and `100`.
     * `--backup-priority`: Backup priority, between `0` and `100`.
     * `--mysql-version`: {{ MY }} version, `{{ versions.cli.str }}`.
     * `--user`: Contains the {{ MY }} user `name` and `password`.

       {% include [user-name-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

       The password must be from 8 to 128 characters long.

       
       {% note info %}

       You can also generate a password using {{ connection-manager-name }}. To do this, modify the command, specifying user details as follows:

       ```bash
         --user name=<username>,generate-password=true
       ```

       To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. Viewing passwords requires the `lockbox.payloadViewer` role.

       {% endnote %}
    
     * `--database name`: Database name.
     
       {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}


     Specify additional {{ mmy-name }} cluster settings, if required:

     
     ```bash
     {{ yc-mdb-my }} cluster create \
       ...
       --backup-window-start <backup_start_time> \
       --backup-retain-period-days=<backup_retention_period> \
       --disk-encryption-key-id <KMS_key_ID> \
       --datalens-access=<allow_access_from_{{ datalens-name }}> \
       --websql-access=<allow_access_from_{{ websql-name }}> \
       --yandexquery-access=<allow_access_from_Yandex_Query> \
       --deletion-protection \
       --performance-diagnostics enabled=true,`
                                `sessions-sampling-interval=<session_sampling_interval>,`
                                `statements-sampling-interval=<statement_sampling_interval>
       --disk-size-autoscaling disk-size-limit=<max_storage_size_in_GB>,`
                              `planned-usage-threshold=<threshold_for_scheduled_increase_in_percent>,`
                              `emergency-usage-threshold=<threshold_for_immediate_increase_in_percent> \
       --maintenance-window type=<maintenance_type>,`
                           `day=<day_of_week>,`
                           `hour=<hour>
     ```


     Where:

     * `--backup-window-start`: Backup start time.
     * `--backup-retain-period-days`: Automatic backup retention period, in days.

     
     * `--disk-encryption-key-id`: Disk encryption using a [custom KMS key](../../kms/concepts/key.md).

       To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).


     * `--datalens-access`: Enables access to the cluster from {{ datalens-full-name }}. The default value is `false`. For more information about setting up a connection, see [{#T}](datalens-connect.md).
     * `--websql-access`: Enables [SQL queries](web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}. The default value is `false`.
     * `--yandexquery-access`: Enables YQL queries against cluster databases from [{{ yq-full-name }}](../../query/concepts/index.md). This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage. The default value is `false`.


     * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

     * `--performance-diagnostics`: Enabling statistics collection for [cluster performance diagnostics](performance-diagnostics.md). For `sessions-sampling-interval` and `statements-sampling-interval`, the valid values range from `1` to `86400` seconds.

     {% include [disk-size-autoscaling-cli](../../_includes/mdb/mmy/disk-size-autoscaling-cli.md) %}

     * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters), where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

     [Configure the DBMS](../concepts/settings-list.md#dbms-cluster-settings), if required.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a {{ mmy-name }} cluster:
  1. In the configuration file, describe the properties of resources you want to create:
     * DB cluster: Description of the cluster and its hosts.
     * Database: Cluster database description.

       {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

     * User: Cluster user description.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Here is an example of the configuration file structure:

     
     ```hcl
     resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
       name                = "<cluster_name>"
       environment         = "<environment>"
       network_id          = "<network_ID>"
       version             = "<{{ MY }}_version>"
       security_group_ids  = [ "<list_of_security_group_IDs>" ]
       deletion_protection = <protect_cluster_from_deletion>

       resources {
         resource_preset_id = "<host_class>"
         disk_type_id       = "<disk_type>"
         disk_size          = "<storage_size_in_GB>"
       }

       host {
         zone             = "<availability_zone>"
         subnet_id        = "<subnet_ID>"
         assign_public_ip = <allow_public_access_to_host>
         priority         = <priority_when_selecting_master_host>
         backup_priority  = <backup_priority>
       }
     }

     resource "yandex_mdb_mysql_database" "<DB_name>" {
       cluster_id = "<cluster_ID>"
       name       = "<DB_name>"
     }

     resource "yandex_mdb_mysql_user" "<username>" {
       cluster_id = "<cluster_ID>"
       name       = "<username>"
       password   = "<user_password>"
       permission {
         database_name = "<DB_name>"
         roles         = ["ALL"]
       }
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
     * `version`: {{ MY }} version, `{{ versions.tf.str }}`.
     * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

     * `assign_public_ip`: Public access to the host, `true` or `false`.
     * `priority`: Host priority when selecting a new master host, between `0` and `100`.
     * `backup_priority`: Backup priority, between `0` and `100`.
     * `name` and `password`: {{ MY }} username and password, respectively.

       {% include [user-name-limits](../../_includes/mdb/mmy/note-info-user-name-and-pass-limits.md) %}

       The password must be from 8 to 128 characters long.

       
       {% note info %}

       You can also generate a password using {{ connection-manager-name }}. To do this, replace `"password" = "<user_password>"` with `generate_password = true`.

       To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. Viewing passwords requires the `lockbox.payloadViewer` role.

       {% endnote %}


     * {% include [disk-size-autoscaling](../../_includes/mdb/mmy/terraform/disk-size-autoscaling.md) %}
  
     * {% include [Maintenance window](../../_includes/mdb/mmy/terraform/maintenance-window.md) %}

     
     * To encrypt the disk with a [custom KMS key](../../kms/concepts/key.md), add the `disk_encryption_key_id` parameter:

       ```hcl
       resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
         ...
         disk_encryption_key_id = <KMS_key_ID>
         ...
       }
       ```

       To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).


     * {% include [Access settings](../../_includes/mdb/mmy/terraform/access-settings.md) %}

     * To set the [backup](../concepts/backup.md) start time, add a `backup_window_start` block to the {{ mmy-name }} cluster description:

       ```hcl
       resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
         ...
         backup_window_start {
           hours   = <hour>
           minutes = <minute>
         }
         ...
       }
       ```

       Where:

       * `hours`: Backup start hour.
       * `minutes`: Backup start minute.

     * To set the retention period for backup files, define the `backup_retain_period_days` parameter in the {{ mmy-name }} cluster description:

       ```hcl
       resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
         ...
           backup_retain_period_days = <backup_retention_period>
           ...
       }
       ```

       Where `backup_retain_period_days` is automatic backup retention period, in days.

       The valid values range from `7` to `60`. The default value is `7`.

     * To enable statistics collection for [cluster performance diagnostics](performance-diagnostics.md), add a `performance_diagnostics` block to your {{ mmy-name }} cluster description:

       ```hcl
       resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
         ...
         performance_diagnostics {
           enabled = true
           sessions_sampling_interval = <session_sampling_interval>
           statements_sampling_interval = <statement_sampling_interval>
         }
         ...
       }
       ```

       For `sessions_sampling_interval` and `statements_sampling_interval`, the valid values range from `1` to `86400` seconds.

     For more information about the resources you can create with {{ TF }}, see this [provider guide]({{ tf-provider-mmy }}).
  1. Make sure the configuration files are correct.

     {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Create a {{ mmy-name }} cluster.

     {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

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
              "version": "<{{ MY }}_version>",
              "resources": {
                  "resourcePresetId": "<host_class>",
                  "diskSize": "<storage_size_in_bytes>",
                  "diskTypeId": "<disk_type>"
              },
              "access": {
                  "dataLens": <allow_access_from_{{ datalens-name }}>,
                  "webSql": <allow_access_from_{{ websql-name }}>,
                  "yandexQuery": <allow_access_from_Yandex_Query>
              },
              "performanceDiagnostics": {
                  "enabled": <enable_statistics_collection>,
                  "sessionsSamplingInterval": "<session_sampling_interval>",
                  "statementsSamplingInterval": "<statement_sampling_interval>"
              },
              "diskSizeAutoscaling": {
                  "plannedUsageThreshold": "<threshold_for_scheduled_increase_in_percent>",
                  "emergencyUsageThreshold": "<threshold_for_immediate_increase_in_percent>",
                  "diskSizeLimit": "<maximum_storage_size_in_bytes>"
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
                              "<privilege_1>", "<privilege_2>", ..., "<privilege_N>"
                          ]
                      }
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

      * `folderId`: Folder ID. You can get it from the [cloud’s folder list](../../resource-manager/operations/folder/get-id.md).
      * `name`: Cluster name.
      * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
      * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be in.

      
      * `securityGroupIds`: [Security group](../concepts/network.md#security-groups) IDs.


      * `deletionProtection`: Cluster protection from accidental deletion, `true` or `false`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      * `configSpec`: Cluster settings:

          * `version`: {{ MY }} version.
          * `resources`: Cluster resources:

              * `resourcePresetId`: [Host class](../concepts/instance-types.md).
              * `diskSize`: Disk size in bytes.
              * `diskTypeId`: [Disk type](../concepts/storage.md).

          * `access`: Settings for cluster access from {{ yandex-cloud }} services:

            * `dataLens`: Access from {{ datalens-full-name }}. For more information about setting up a connection, see [{#T}](datalens-connect.md).
            * `webSql`: [SQL queries](web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}.
            * `yandexQuery`: YQL queries against cluster databases from [{{ yq-full-name }}](../../query/concepts/index.md). This feature is currently in [Preview](../../overview/concepts/launch-stages.md).


            The possible setting values are `true` or `false`.

      * `performanceDiagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:

          * `enabled`: Enables statistics collection, `true` or `false`.
          * `sessionsSamplingInterval`: Session sampling interval, from `1` to `86400` seconds.
          * `statementsSamplingInterval`: Statement sampling interval, from `1` to `86400` seconds.

      {% include [disk-size-autoscaling-rest](../../_includes/mdb/mmy/disk-size-autoscaling-rest.md) %}

      * `databaseSpecs`: Database settings as an array of elements, one for each DB. Each element contains the `name` parameter with the DB name.

          {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      * `userSpecs`: User settings as an array of elements, one per user. Each element has the following structure:

          * `name`: Username.

          * `password`: Password. The password must be from 8 to 128 characters long.

              
              You can also generate a password using {{ connection-manager-name }}. To do this, specify `"generatePassword": true` instead of `"password": "<user_password>"`.

              To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. Viewing passwords requires the `lockbox.payloadViewer` role.


          * `permissions`: User permission settings:

              * `databaseName`: Name of the database to which the user will have access.
              * `roles`: Array of user privileges, each provided as a separate string in the array. For the list of possible values, see [User privileges in a cluster](../concepts/user-rights.md#db-privileges).

              For each database, add a separate element with permission settings to the `permissions` array.

      * `hostSpecs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

          * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnetId`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
          * `assignPublicIp`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.
      
      {% include [maintenance-window-rest](../../_includes/mdb/mmy/maintenance-window-rest.md) %}

  1. Use the [Cluster.create](../api-ref/Cluster/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters' \
          --data "@body.json"
      ```

  1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

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
              "version": "<{{ MY }}_version>",
              "resources": {
                  "resource_preset_id": "<host_class>",
                  "disk_size": "<storage_size_in_bytes>",
                  "disk_type_id": "<disk_type>"
              },
              "access": {
                  "data_lens": <allow_access_from_{{ datalens-name }}>,
                  "web_sql": <allow_access_from_{{ websql-name }}>,
                  "yandex_query": <allow_access_from_Yandex_Query>
              },
              "performance_diagnostics": {
                  "enabled": <enable_statistics_collection>,
                  "sessions_sampling_interval": "<session_sampling_interval>",
                  "statements_sampling_interval": "<statement_sampling_interval>"
              },
              "disk_size_autoscaling": {
                  "planned_usage_threshold": "<threshold_for_scheduled_increase_in_percent>",
                  "emergency_usage_threshold": "<threshold_for_immediate_increase_in_percent>",
                  "disk_size_limit": "<maximum_storage_size_in_bytes>"
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
                              "<privilege_1>", "<privilege_2>", ..., "<privilege_N>"
                          ]
                      }
                  ]
              }
          ],
          "host_specs": [
              {
                  "zone_id": "<availability_zone>",
                  "subnet_id": "<subnet_ID>",
                  "assign_public_ip": <allow_public_access_to_host>
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

      * `folder_id`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
      * `name`: Cluster name.
      * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
      * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be in.

      
      * `security_group_ids`: [Security group](../concepts/network.md#security-groups) IDs.


      * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      * `config_spec`: Cluster settings:

          * `version`: {{ MY }} version.
          * `resources`: Cluster resources:

              * `resource_preset_id`: [Host class](../concepts/instance-types.md).
              * `disk_size`: Disk size in bytes.
              * `disk_type_id`: [Disk type](../concepts/storage.md).

          * `access`: Settings for cluster access from {{ yandex-cloud }} services:

            * `data_lens`: Access from {{ datalens-full-name }}. For more information about setting up a connection, see [{#T}](datalens-connect.md).
            * `web_sql`: [SQL queries](web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}.
            * `yandex_query`: YQL queries against cluster databases from [{{ yq-full-name }}](../../query/concepts/index.md). This feature is currently in [Preview](../../overview/concepts/launch-stages.md).


            The possible setting values are `true` or `false`.

      * `performance_diagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:

          * `enabled`: Enables statistics collection, `true` or `false`.
          * `sessions_sampling_interval`: Session sampling interval, from `1` to `86400` seconds.
          * `statements_sampling_interval`: Statement sampling interval, from `60` to `86400` seconds.

      {% include [disk-size-autoscaling-grpc](../../_includes/mdb/mmy/disk-size-autoscaling-grpc.md) %}

      * `database_specs`: Database settings as an array of elements, one for each DB. Each element contains the `name` parameter with the DB name.
      * `user_specs`: User settings as an array of elements, one per user. Each element has the following structure:

          * `name`: Username.

          * `password`: Password. The password must be from 8 to 128 characters long.

              
              You can also generate a password using {{ connection-manager-name }}. To do this, specify `"generate_password": true` instead of `"password": "<user_password>"`.

              To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. Viewing passwords requires the `lockbox.payloadViewer` role.


          * `permissions`: User permission settings:

              * `database_name`: Name of the database to which the user will have access.
              * `roles`: Array of user privileges, each provided as a separate string in the array. For the list of possible values, see [User privileges in a cluster](../concepts/user-rights.md#db-privileges).

              For each database, add a separate element with permission settings to the `permissions` array.

      * `host_specs`: Cluster host settings as an array of elements, one for each host. Each element has the following structure:

          * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnet_id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.
          * `assign_public_ip`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.

      {% include [maintenance-window-grpc](../../_includes/mdb/mmy/maintenance-window-grpc.md) %}    

  1. Use the [ClusterService/Create](../api-ref/grpc/Cluster/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Create \
          < body.json
      ```

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


{% note warning %}

If you specified security group IDs when creating a {{ mmy-name }} cluster, you may also need to [configure security groups](connect.md#configure-security-groups) to connect to the cluster.

{% endnote %}


## Creating a cluster copy {#duplicate}

You can create a {{ MY }} cluster using the settings of another one created earlier. To do this, import the {{ MY }} source cluster configuration to {{ TF }}. This way, you can either create an identical copy or use the imported configuration as a starting point for modification. Import is convenient when the source {{ MY }} cluster has many settings and you need to create a similar cluster.

To create a {{ MY }} cluster copy:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. In your current working directory, create a `.tf` file with the following content:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "old" { }
        ```

    1. Save the ID of the original {{ MY }} cluster to an environment variable:

        ```bash
        export MYSQL_CLUSTER_ID=<cluster_ID>
        ```

        You can get the ID from the [folder’s cluster list](../../managed-mysql/operations/cluster-list.md#list-clusters).

    1. Import the original {{ MY }} cluster settings to the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_mysql_cluster.old ${MYSQL_CLUSTER_ID}
        ```

    1. Display the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from the terminal and paste it into the `.tf` file.
    1. Create a new directory named `imported-cluster` and move your file there.
    1. Modify the configuration so it can be used to create a new cluster:

        * Specify the new cluster name in the `resource` string and the `name` parameter.
        * Delete the `created_at`, `health`, `id`, and `status` parameters.
        * In the `host` sections, delete `fqdn`.
        * If the `maintenance_window` section has `type = "ANYTIME"`, delete the `hour` parameter.
        * Optionally, you can customize the configuration further if needed.

    1. [Get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) in the `imported-cluster` directory.

    1. In the same directory, [configure and initialize a provider](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). To avoid creating the provider configuration file manually, you can download it [here](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Move the configuration file to the `imported-cluster` directory and edit it to [include your required values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you have not added your authentication credentials to the environment variables, specify them in the configuration file.

    1. Validate your {{ TF }} configuration files:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  To create a {{ mmy-name }} cluster with a single host, provide a single `--host` parameter.

  Create a {{ mmy-name }} cluster with the following test specifications:

  
  * Name: `my-mysql`.
  * Version: `{{ versions.cli.latest }}`.
  * Environment: `production`.
  * Network: `default`.
  * Security group ID: `{{ security-group }}`.
  * One `{{ host-class }}` host in the `{{ subnet-id }}` subnet, in the `{{ region-id }}-a` availability zone.
  * Network SSD storage (`{{ disk-type-example }}`): 20 GB.
  * User: `user1`, password: `user1user1`.
  * With one `db1` database, in which the `user1` user has full rights (same as `GRANT ALL PRIVILEGES on db1.*`).
  * Deletion protection: Enabled.


  1. Run this command to create a {{ mmy-name }} cluster:

     
     ```bash
     {{ yc-mdb-my }} cluster create \
       --name="my-mysql" \
       --mysql-version {{ versions.cli.latest }} \
       --environment=production \
       --network-name=default \
       --security-group-ids {{ security-group }} \
       --host {{ host-net-example }} \
       --resource-preset {{ host-class }} \
       --disk-type {{ disk-type-example }} \
       --disk-size 20 \
       --user name=user1,password="user1user1" \
       --database name=db1 \
       --deletion-protection
     ```


  1. Run the change permissions command for the `user1` user.

     ```bash
     {{ yc-mdb-my }} user grant-permission user1 \
       --cluster-name="my-mysql" \
       --database=db1 \
       --permissions ALL
     ```

- {{ TF }} {#tf}

  Create a {{ mmy-name }} cluster and its network with the following test specifications:

    * Name: `my-mysql`.
    * Version: `{{ versions.tf.latest }}`.
    * Environment: `PRESTABLE`.
    * Cloud ID: `{{ tf-cloud-id }}`.
    * Folder ID: `{{ tf-folder-id }}`.
    * New network: `mynet`.
    * Host class: `{{ host-class }}` (one host), subnet: `mysubnet`, availability zone: `{{ region-id }}-a`. `mysubnet` CIDR range: `10.5.0.0/24`.

    
    * New security group: `mysql-sg`, allowing connections to {{ mmy-name }} clusters from the Internet through port `{{ port-mmy }}`.


    * Network SSD storage (`{{ disk-type-example }}`): 20 GB.
    * User: `user1`, password: `user1user1`.
    * With one `db1` database, in which the `user1` user has full rights (same as `GRANT ALL PRIVILEGES on db1.*`).
    * Deletion protection: Enabled.

  The configuration file for this {{ mmy-name }} cluster is as follows:

  
  ```hcl
  resource "yandex_mdb_mysql_cluster" "my-mysql" {
    name                = "my-mysql"
    environment         = "PRESTABLE"
    network_id          = yandex_vpc_network.mynet.id
    version             = "{{ versions.tf.latest }}"
    security_group_ids  = [ yandex_vpc_security_group.mysql-sg.id ]
    deletion_protection = true

    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 20
    }

    host {
      zone      = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
  }

  resource "yandex_mdb_mysql_database" "db1" {
    cluster_id = yandex_mdb_mysql_cluster.my-mysql.id
    name       = "db1"
  }

  resource "yandex_mdb_mysql_user" "user1" {
    cluster_id = yandex_mdb_mysql_cluster.my-mysql.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = yandex_mdb_mysql_database.db1.name
      roles         = ["ALL"]
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mysql-sg" {
    name       = "mysql-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "{{ MY }}"
      port           = {{ port-mmy }}
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

### Creating a multi-host cluster {#creating-multiple-hosts-cluster}


{% list tabs group=instructions %}

- CLI {#cli}

  To create a multi-host {{ mmy-name }} cluster, provide as many `--host` parameters as there should be hosts in your cluster.

  Create a {{ mmy-name }} cluster with the following test specifications:

  
  * Name: `my-mysql-3`.
  * Version: `{{ versions.cli.latest }}`.
  * Environment: `prestable`.
  * Network: `default`.
  * Security group ID: `{{ security-group }}`.
  * `{{ host-class }}` public hosts: 3.

    One host will be added to each subnet of the `default` network:
    * `subnet-a`: `10.5.0.0/24`, availability zone: `{{ region-id }}-a`.
    * `subnet-b`: `10.6.0.0/24`, availability zone: `{{ region-id }}-b`.
    * `subnet-d`: `10.7.0.0/24`, availability zone: `{{ region-id }}-d`.

    The host residing in `subnet-b` will have the backup priority. Backups will be created from this host's data unless you choose it to be the master host.

  * Network SSD storage (`{{ disk-type-example }}`): 32 GB.
  * User: `user1`, password: `user1user1`.
  * With one `db1` database, in which the `user1` user has full rights (same as `GRANT ALL PRIVILEGES on db1.*`).


  1. Run this command to create a {{ mmy-name }} cluster:

     
     ```bash
     {{ yc-mdb-my }} cluster create \
       --name="my-mysql-3" \
       --mysql-version {{ versions.cli.latest }} \
       --environment=prestable \
       --network-name=default \
       --security-group-ids {{ security-group }} \
       --host zone-id={{ region-id }}-a,`
              `subnet-name=subnet-a,`
              `assign-public-ip=true \
       --host zone-id={{ region-id }}-b,`
              `subnet-name=subnet-b,`
              `backup-priority=10,`
              `assign-public-ip=true \
       --host zone-id={{ region-id }}-d,`
              `subnet-name=subnet-d,`
              `assign-public-ip=true \
       --resource-preset {{ host-class }} \
       --disk-type {{ disk-type-example }} \
       --disk-size 32 \
       --user name=user1,password="user1user1" \
       --database name=db1
     ```


  1. Run the change permissions command for the `user1` user.

     ```bash
     {{ yc-mdb-my }} user grant-permission user1 \
       --cluster-name="my-mysql-3" \
       --database=db1 \
       --permissions ALL
     ```

- {{ TF }} {#tf}

  Create a {{ mmy-name }} cluster and its network with the following test specifications:

    * Name: `my-mysql-3`.
    * Version: `{{ versions.tf.latest }}`.
    * Environment: `PRESTABLE`.
    * Cloud ID: `{{ tf-cloud-id }}`.
    * Folder ID: `{{ tf-folder-id }}`.
    * New network: `mynet`.
    * `{{ host-class }}` public hosts: 3.

      One host will be added to each one of the new subnets:
       * `mysubnet-a`: `10.5.0.0/24`, availability zone: `{{ region-id }}-a`.
       * `mysubnet-b`: `10.6.0.0/24`, availability zone: `{{ region-id }}-b`.
       * `mysubnet-d`: `10.7.0.0/24`, availability zone: `{{ region-id }}-d`.

      These subnets will belong to the `mynet` network.

      The host residing in `mysubnet-b` will have the backup priority. Backups will be created from this host's data unless you choose it to be the master host.

    
    * New security group: `mysql-sg`, allowing connections to {{ mmy-name }} clusters from the Internet through port `{{ port-mmy }}`.


    * Network SSD storage (`{{ disk-type-example }}`): 32 GB.
    * User: `user1`, password: `user1user1`.
    * With one `db1` database, in which the `user1` user has full rights (same as `GRANT ALL PRIVILEGES on db1.*`).

  The configuration file for this {{ mmy-name }} cluster is as follows:

  
  ```hcl
  resource "yandex_mdb_mysql_cluster" "my-mysql-3" {
    name                = "my-mysql-3"
    environment         = "PRESTABLE"
    network_id          = yandex_vpc_network.mynet.id
    version             = "{{ versions.tf.latest }}"
    security_group_ids  = [ yandex_vpc_security_group.mysql-sg.id ]

    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 32
    }

    host {
      zone             = "{{ region-id }}-a"
      subnet_id        = yandex_vpc_subnet.mysubnet-a.id
      assign_public_ip = true
    }

    host {
      zone             = "{{ region-id }}-b"
      subnet_id        = yandex_vpc_subnet.mysubnet-b.id
      assign_public_ip = true
      backup_priority  = 10
    }

    host {
      zone             = "{{ region-id }}-d"
      subnet_id        = yandex_vpc_subnet.mysubnet-d.id
      assign_public_ip = true
    }
  }

  resource "yandex_mdb_mysql_database" "db1" {
    cluster_id = yandex_mdb_mysql_cluster.my-mysql-3.id
    name       = "db1"
  }

  resource "yandex_mdb_mysql_user" "user1" {
    cluster_id = yandex_mdb_mysql_cluster.my-mysql-3.id
    name       = "user1"
    password   = "user1user1"
    permission {
      database_name = yandex_mdb_mysql_database.db1.name
      roles         = ["ALL"]
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_security_group" "mysql-sg" {
    name       = "mysql-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "{{ MY }}"
      port           = {{ port-mmy }}
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }

  resource "yandex_vpc_subnet" "mysubnet-a" {
    name             = "mysubnet-a"
    zone             = "{{ region-id }}-a"
    network_id       = yandex_vpc_network.mynet.id
    v4_cidr_blocks   = ["10.5.0.0/24"]
  }

  resource "yandex_vpc_subnet" "mysubnet-b" {
    name             = "mysubnet-b"
    zone             = "{{ region-id }}-b"
    network_id       = yandex_vpc_network.mynet.id
    v4_cidr_blocks   = ["10.6.0.0/24"]
  }

  resource "yandex_vpc_subnet" "mysubnet-d" {
    name             = "mysubnet-d"
    zone             = "{{ region-id }}-d"
    network_id       = yandex_vpc_network.mynet.id
    v4_cidr_blocks   = ["10.7.0.0/24"]
  }
  ```


{% endlist %}
