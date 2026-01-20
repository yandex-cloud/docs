---
title: Creating an {{ SD }} cluster
description: Follow this guide to create a {{ SD }} cluster.
---

# Creating an {{ SD }} cluster

A {{ SD }} cluster is one or more database hosts between which you can configure [replication](../concepts/replication.md). Replication is on by default in any cluster consisting of more than one host: the primary host accepts write requests and asynchronously replicates the changes in the secondary hosts.


{% note info %}

* The number of hosts you can create together with a {{ SD }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* The available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

{% endnote %}


{% include [Connection Manager](../../_includes/mdb/connman-cluster-create.md) %}





## Creating a cluster {#create-cluster}


To create a {{ mmg-name }} cluster, you need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role and the [{{ roles.mmg.editor }} role or higher](../security/index.md#roles-list). For information on assigning roles, see [this {{ iam-name }} guide](../../iam/operations/roles/grant.md).


{% list tabs group=instructions %}

- Management console {#console}

  To create a {{ mmg-name }} cluster:

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your database cluster.

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

      * Enter a name in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. The cluster name must be unique within the cloud.
      * Optionally, enter a cluster **{{ ui-key.yacloud.mdb.forms.base_field_description }}**.
      * Select the environment where you want to create your cluster (you cannot change the environment once the cluster is created):

          * `PRODUCTION`: For stable versions of your applications.
          * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by an SLA, but it is the first to get new features, improvements, and bug fixes. In the prestable environment, you can test new versions for compatibility with your application.

      * Specify the DBMS version.
      * Select the sharding type:
          * **{{ ui-key.yacloud.mongodb.ClusterForm.sections.option_sharding-type-disabled_3ErMk }}**: Cluster will consist only of `MONGOD` hosts.
          * **{{ ui-key.yacloud.mongodb.ClusterForm.sections.option_sharding-type-standard_afrPq }}**: Cluster will consist of `MONGOD` and `MONGOINFRA` hosts.
          * **{{ ui-key.yacloud.mongodb.ClusterForm.sections.option_sharding-type-extended_9NHmb }}**: Cluster will consist of `MONGOD`, `MONGOS`, and `MONGOCFG` hosts.

  
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select:

      * [Cloud network](../../vpc/concepts/network.md#network) for cluster deployment.
      * Security groups for the cluster network traffic. You may need to [configure security groups](connect/index.md#configuring-security-groups) to connect to the cluster.


  1. Specify the computing resource configuration:

      * For a non-sharded cluster, under **Resources**.
      * For a cluster with standard sharding, under **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_mongod-resources_ncXUZ }}** and **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_mongoinfra-resources_13TPT }}**.
      * For a cluster with advanced sharding, under **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_mongod-resources_ncXUZ }}**, **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_mongos-resources_wBGnr }}**, and **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_mongocfg-resources_1cuU2 }}**.

     To specify your computing resource configuration:

     1. Select the platform, VM type, and host class. The latter determines the technical specifications of the VMs the database hosts will be deployed on. All available options are listed under [Host classes](../concepts/instance-types.md). When you change the host class for a cluster, the specifications of all existing instances also change.

        {% note info %}

        The **memory-optimized** configuration type is unavailable for `MONGOS` hosts.

        {% endnote %}

     
     1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**:

         * Select the [disk type](../concepts/storage.md).

             {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}

         * Select the storage capacity for your data and backups. For more information, see [Backups](../concepts/backup.md).

         * Optionally, select **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}** to encrypt the disk with a [custom KMS key](../../kms/concepts/key.md).

             * To [create](../../kms/operations/key.md#create) a new key, click **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.

             * To use the key you created earlier, select it in the **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** field.

             To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).


     1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, add the DB hosts created with the cluster:

         
         * Click **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.
         * Select the [availability zone](../../overview/concepts/geo-scope.md).
         * Select a [subnet](../../vpc/concepts/network.md#subnet) in the specified availability zone. If there is no subnet, create one.
         * If the host must be available outside {{ yandex-cloud }}, enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

         
         To ensure fault tolerance, you need at least 3 hosts for `local-ssd` and `network-ssd-nonreplicated` disk types. For more information, see [Storage](../concepts/storage.md).

         
         By default, hosts are created in different availability zones. Read more about [host management](hosts.md).


  1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify the database details:

      * Database name.

        {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

      * Username.
      * User password. The password must be at least 8 characters long. 

  1. Specify additional cluster settings, if required:

      {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}

  1. [Configure the DBMS](../concepts/settings-list.md#dbms-cluster-settings), if required.

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

     If your folder has no subnets, [create them](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.


  1. View the description of the CLI command for creating a cluster:

      ```bash
      {{ yc-mdb-mg }} cluster create --help
      ```

  1. Specify the cluster parameters in the create command (not all parameters are given in the example):

      {% cut "For a non-sharded cluster" %}

      
      ```bash
      {{ yc-mdb-mg }} cluster create \
        --name <cluster_name> \
        --environment=<environment> \
        --network-name <network_name> \\
        --security-group-ids <security_group_IDs> \ 
        --host zone-id=<availability_zone>,`
              `subnet-id=<subnet_ID>,`
              `assign-public-ip=<allow_public_access_to_host>,`
              `hidden=<hide_host>,`
              `secondary-delay-secs=<replica_lag_in_seconds>,`
              `priority=<host_priority> \
        --mongod-resource-preset <host_class> \
        --user name=<username>,password=<user_password> \
        --database name=<DB_name> \
        --mongod-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --mongod-disk-size <storage_size_in_GB> \
        --disk-encryption-key-id <KMS_key_ID> \
        --performance-diagnostics=<enable_diagnostics> \
        --deletion-protection
      ```


      {% endcut %}

      {% cut "For a cluster with standard sharding" %}

      
      ```bash
      {{ yc-mdb-mg }} cluster create \
        --name <cluster_name> \
        --environment=<environment> \
        --mongodb-version <Yandex_StoreDoc_version> \          
        --network-name <network_name> \
        --security-group-ids <security_group_IDs> \      
        --user name=<username>,password=<user_password> \
        --database name=<DB_name> \
        --mongod-resource-preset <host_class> \
        --mongod-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --mongod-disk-size <storage_size_in_GB> \
        --host type=mongod,`
              `zone-id=<availability_zone>,`
              `subnet-id=<subnet_ID>,`
              `hidden=<hide_host>,`
              `secondary-delay-secs=<replica_lag_in_seconds>,`
              `priority=<host_priority> \
        --mongoinfra-resource-preset <host_class> \
        --mongoinfra-disk-type <network-hdd|network-ssd> \
        --mongoinfra-disk-size <storage_size_in_GB> \
        --host type=mongoinfra,`
              `zone-id=<availability_zone>,`
              `subnet-id=<subnet_ID>,`
              `assign-public-ip=<allow_public_access_to_host> \
        --disk-encryption-key-id <KMS_key_ID> \
        --performance-diagnostics=<enable_diagnostics> \
        --deletion-protection
      ```


      {% endcut %}

      {% cut "For a cluster with advanced sharding" %}

      
      ```bash
      {{ yc-mdb-mg }} cluster create \
        --name <cluster_name> \
        --environment=<environment> \
        --mongodb-version <Yandex_StoreDoc_version> \          
        --network-name <network_name> \
        --security-group-ids <security_group_IDs> \      
        --user name=<username>,password=<user_password> \
        --database name=<DB_name> \
        --mongod-resource-preset <host_class> \
        --mongod-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --mongod-disk-size <storage_size_in_GB> \
        --host type=mongod,`
              `zone-id=<availability_zone>,`
              `subnet-id=<subnet_ID>,`
              `hidden=<hide_host>,`
              `secondary-delay-secs=<replica_lag_in_seconds>,`
              `priority=<host_priority> \
        --mongos-resource-preset <host_class> \
        --mongos-disk-type <network-hdd|network-ssd> \
        --mongos-disk-size <storage_size_in_GB> \
        --host type=mongos,`
              `zone-id=<availability_zone>,`
              `subnet-id=<subnet_ID>,`
              `assign-public-ip=<allow_public_access_to_host> \
        --mongocfg-resource-preset <host_class> \
        --mongocfg-disk-type <network-hdd|network-ssd> \
        --mongocfg-disk-size <storage_size_in_GB> \
        --host type=mongocfg,`
              `zone-id=<availability_zone>,`
              `subnet-id=<subnet_ID> \
        --disk-encryption-key-id <KMS_key_ID> \
        --performance-diagnostics=<enable_diagnostics> \
        --deletion-protection
      ```


      {% endcut %}

      Where:

      * `--environment`: Environment, `prestable` or `production`.

      
      * `--security-group-ids`: List of security group IDs.
      * `--database name`: Database name.
        
        {% note info %}

        {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

        {% endnote %}

      * `--host`: Host settings:
        * `type`: Host type, i.e., `mongod`, `mongoinfra`, `mongos`, or `mongocfg`. The default host type is `mongod`.
        * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
        * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). To be specified if the selected availability zone has more than one subnet.
        * `assign-public-ip`: Internet access to the host via a public IP address, `true` or `false`. In a sharded cluster, it is used only for `MONGOS` and `MONGOINFRA` hosts.
        * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
        * `secondary-delay-secs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
        * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).
          
          {% note info %}

          The `hidden`, `secondary-delay-secs`, and `priority` parameters are used for `MONGOD` hosts only.

          {% endnote %}

      * `--mongod-resource-preset`: `MONGOD` host class.
      * `--mongoinfra-resource-preset`, `--mongos-resource-preset`, `--mongocfg-resource-preset`: `MONGOINFRA`, `MONGOS`, and `MONGOCFG` host classes, respectively (for sharded clusters only).
      * `--mongod-disk-type`: Disk type of `MONGOD` hosts.
      * `--mongoinfra-disk-type`, `--mongos-disk-type`, `--mongocfg-disk-type`: Disk types of `MONGOINFRA`, `MONGOS`, and `MONGOCFG` hosts, respectively (for sharded clusters only).
      * `--disk-encryption-key-id`: Disk encryption with a [custom KMS key](../../kms/concepts/key.md).

         To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).


      * `--performance-diagnostics`: Enables cluster performance diagnostics, `true` or `false`.
      
      * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      {% note info %}

      The default [maintenance](../concepts/maintenance.md) mode for new clusters is `anytime`. You can set a specific maintenance period when [updating the cluster settings](update.md#change-additional-settings).

      {% endnote %}


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a {{ mmg-name }} cluster:

  1. In the configuration file, describe the resources you want to create:

     * Database cluster: Description of the cluster and its hosts.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Here is an example of the configuration file structure:

     {% cut "For a non-sharded cluster" %}

     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
       name                = "<cluster_name>"
       environment         = "<environment>"
       network_id          = yandex_vpc_network.<network_name>.id
       security_group_ids  = [ "<list_of_security_group_IDs>" ]
       deletion_protection = <protect_cluster_against_deletion>

       cluster_config {
         version = "<Yandex_StoreDoc_version>"
       }

       resources_mongod {
         resource_preset_id = "<host_class>"
         disk_type_id       = "<disk_type>"
         disk_size          = <storage_size_in_GB>
       }

       host {
         type             = "mongod"
         zone_id          = "<availability_zone>"
         subnet_id        = yandex_vpc_subnet.<subnet_name>.id
         assign_public_ip = <allow_public_access_to_host>
         host_parameters {
           hidden               = <hide_host>
           secondary_delay_secs = <replica_lag_in_seconds>
           priority             = <host_priority>
         }
       }

       resources_mongoinfra {
         resource_preset_id = "<host_class>"
         disk_type_id       = "<disk_type>"
         disk_size          = <storage_size_in_GB>
       }

       host {
         type             = "mongoinfra"
         zone_id          = "<availability_zone>"
         subnet_id        = yandex_vpc_subnet.<subnet_name>.id
         assign_public_ip = <allow_public_access_to_host>
       }
     }

     resource "yandex_mdb_mongodb_database" "<DB_name>" {
       cluster_id = yandex_mdb_mongodb_cluster.<cluster_name>.id
       name       = "<DB_name>"
     }

     resource "yandex_mdb_mongodb_user" "<username>" {
       cluster_id = yandex_mdb_mongodb_cluster.<cluster_name>.id
       name       = "<username>"
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
       network_id     = yandex_vpc_network.<network_name>.id
       v4_cidr_blocks = ["<range>"]
     }
     ```

     {% endcut %}

     {% cut "For a cluster with standard sharding" %}

     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
       name                = "<cluster_name>"
       environment         = "<environment>"
       network_id          = yandex_vpc_network.<network_name>.id
       security_group_ids  = [ "<list_of_security_group_IDs>" ]
       deletion_protection = <protect_cluster_against_deletion>

       cluster_config {
         version = "<Yandex_StoreDoc_version>"
       }

       resources_mongod {
         resource_preset_id = "<host_class>"
         disk_type_id       = "<disk_type>"
         disk_size          = <storage_size_in_GB>
       }

       host {
         type             = "mongod"
         zone_id          = "<availability_zone>"
         subnet_id        = yandex_vpc_subnet.<subnet_name>.id
         host_parameters {
           hidden               = <hide_host>
           secondary_delay_secs = <replica_lag_in_seconds>
           priority             = <host_priority>
         }
       }

       resources_mongoinfra {
         resource_preset_id = "<host_class>"
         disk_type_id       = "<disk_type>"
         disk_size          = <storage_size_in_GB>
       }

       host {
         type             = "mongoinfra"
         zone_id          = "<availability_zone>"
         subnet_id        = yandex_vpc_subnet.<subnet_name>.id
         assign_public_ip = <allow_public_access_to_host>
       }
     }

     resource "yandex_mdb_mongodb_database" "<DB_name>" {
       cluster_id = yandex_mdb_mongodb_cluster.<cluster_name>.id
       name       = "<DB_name>"
     }

     resource "yandex_mdb_mongodb_user" "<username>" {
       cluster_id = yandex_mdb_mongodb_cluster.<cluster_name>.id
       name       = "<username>"
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
       network_id     = yandex_vpc_network.<network_name>.id
       v4_cidr_blocks = ["<range>"]
     }
     ```

     {% endcut %}

     {% cut "For a cluster with advanced sharding" %}

     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
       name                = "<cluster_name>"
       environment         = "<environment>"
       network_id          = yandex_vpc_network.<network_name>.id
       security_group_ids  = [ "<list_of_security_group_IDs>" ]
       deletion_protection = <protect_cluster_against_deletion>

       cluster_config {
         version = "<Yandex_StoreDoc_version>"
       }

       resources_mongod {
         resource_preset_id = "<host_class>"
         disk_type_id       = "<disk_type>"
         disk_size          = <storage_size_in_GB>
       }

       host {
         type             = "mongod"
         zone_id          = "<availability_zone>"
         subnet_id        = yandex_vpc_subnet.<subnet_name>.id
         host_parameters {
           hidden               = <hide_host>
           secondary_delay_secs = <replica_lag_in_seconds>
           priority             = <host_priority>
         }
       }

       resources_mongos {
         resource_preset_id = "<host_class>"
         disk_type_id       = "<disk_type>"
         disk_size          = <storage_size_in_GB>
       }

       host {
         type             = "mongos"
         zone_id          = "<availability_zone>"
         subnet_id        = yandex_vpc_subnet.<subnet_name>.id
         assign_public_ip = <allow_public_access_to_host>
       }

       resources_mongocfg {
         resource_preset_id = "<host_class>"
         disk_type_id       = "<disk_type>"
         disk_size          = <storage_size_in_GB>
       }

       host {
         type             = "mongocfg"
         zone_id          = "<availability_zone>"
         subnet_id        = yandex_vpc_subnet.<subnet_name>.id
       }
     }

     resource "yandex_mdb_mongodb_database" "<DB_name>" {
       cluster_id = yandex_mdb_mongodb_cluster.<cluster_name>.id
       name       = "<DB_name>"
     }

     resource "yandex_mdb_mongodb_user" "<username>" {
       cluster_id = yandex_mdb_mongodb_cluster.<cluster_name>.id
       name       = "<username>"
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
       network_id     = yandex_vpc_network.<network_name>.id
       v4_cidr_blocks = ["<range>"]
     }
     ```

     {% endcut %}

     Where:

     * `environment`: Environment, `PRESTABLE` or `PRODUCTION`.
     * `host`: Host settings:
       * `zone_id`: Availability zone.
       * `subnet_id`: ID of the subnet in the selected availability zone.
       * `assign_public_ip`: Public access to the host, `true` or `false`. In a sharded cluster, it is used only for `MONGOS` and `MONGOINFRA` hosts.
       * `host_parameters`: Additional host parameters:
         * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
         * `secondary_delay_secs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
         * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).

        {% note info %}

        The `hidden`, `secondary_delay_secs`, and `priority` parameters are used for `MONGOD` hosts only.

        {% endnote %}
     
     * `deletion_protection`: Cluster protection against accidental deletion, `true` or `false`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

     * `version`: {{ SD }} version, {{ versions.tf.str }}.

     {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

     {% include [Maintenance window](../../_includes/mdb/mmg/terraform/maintenance-window.md) %}

     To encrypt the disk with a [custom KMS key](../../kms/concepts/key.md), add the `disk_encryption_key_id` parameter:

       ```hcl
       resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
         ...
         disk_encryption_key_id = <KMS_key_ID>
         ...
       }
       ```

       To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).

     For more information about the resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-mmg }}).

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      After this, all required resources will be created in the specified folder, and the [host FQDNs](../concepts/network.md#hostname) will be displayed in the terminal. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

      {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}


- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        {% cut "For a non-sharded cluster" %}

        
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
          "deletionProtection": <protect_cluster_against_deletion>,
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "configSpec": {
            "version": "<Yandex_StoreDoc_version>",
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
              "profilingEnabled": <enable_profiler>
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
            { <similar_settings_for_user_2> },
            { ... },
            { <similar_settings_for_user_N> }
          ],
          "hostSpecs": [
            {
              "zoneId": "<availability_zone>",
              "subnetId": "<subnet_ID>",
              "assignPublicIp": <allow_public_access_to_host>,
              "type": "MONGOD",
              "hidden": <hide_host>,
              "secondaryDelaySecs": "<replica_lag_in_seconds>",
              "priority": "<host_priority>",
              "tags": "<host_labels>"
            },
            { <similar_settings_for_host_2> },
            { ... },
            { <similar_configuration_for_host_N> }
          ]
        }
        ```


        {% endcut %}

        {% cut "For a cluster with standard sharding" %}

        
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
          "deletionProtection": <protect_cluster_against_deletion>,
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "configSpec": {
            "version": "<Yandex_StoreDoc_version>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resourcePresetId": "<host_class>",
                  "diskSize": "<storage_size_in_bytes>",
                  "diskTypeId": "<disk_type>"
                }
              },
              "mongoinfra": {
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
              "profilingEnabled": <enable_profiler>
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
            { <similar_settings_for_user_2> },
            { ... },
            { <similar_settings_for_user_N> }
          ],
          "hostSpecs": [
            {
              "zoneId": "<availability_zone>",
              "subnetId": "<subnet_ID>",
              "type": "MONGOD",
              "shardName": "<shard_name>",
              "hidden": <hide_host>,
              "secondaryDelaySecs": "<replica_lag_in_seconds>",
              "priority": "<host_priority>",
              "tags": "<host_labels>"
            },
            {
              "zoneId": "<availability_zone>",
              "subnetId": "<subnet_ID>",
              "type": "MONGOINFRA",
              "assignPublicIp": <allow_public_access_to_host>,
              "tags": "<host_labels>"
            },
            { <similar_settings_for_host_3> },
            { ... },
            { <similar_configuration_for_host_N> }
          ]
        }
        ```


        {% endcut %}

        {% cut "For a cluster with advanced sharding" %}

        
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
          "deletionProtection": <protect_cluster_against_deletion>,
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "configSpec": {
            "version": "<Yandex_StoreDoc_version>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resourcePresetId": "<host_class>",
                  "diskSize": "<storage_size_in_bytes>",
                  "diskTypeId": "<disk_type>"
                }
              },
              "mongos": {
                "resources": {
                  "resourcePresetId": "<host_class>",
                  "diskSize": "<storage_size_in_bytes>",
                  "diskTypeId": "<disk_type>"
                }
              },
              "mongocfg": {
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
              "profilingEnabled": <enable_profiler>
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
            { <similar_settings_for_user_2> },
            { ... },
            { <similar_settings_for_user_N> }
          ],
          "hostSpecs": [
            {
              "zoneId": "<availability_zone>",
              "subnetId": "<subnet_ID>",
              "type": "MONGOD",
              "shardName": "<shard_name>",
              "hidden": <hide_host>,
              "secondaryDelaySecs": "<replica_lag_in_seconds>",
              "priority": "<host_priority>",
              "tags": "<host_labels>"
            },
            {
              "zoneId": "<availability_zone>",
              "subnetId": "<subnet_ID>",
              "type": "MONGOS",
              "assignPublicIp": <allow_public_access_to_host>,
              "tags": "<host_labels>"
            },
            {
              "zoneId": "<availability_zone>",
              "subnetId": "<subnet_ID>",
              "type": "MONGOCFG",
              "tags": "<host_labels>"
            },
            { <similar_settings_for_host_4> },
            { ... },
            { <similar_configuration_for_host_N> }
          ]
        }
        ```


        {% endcut %}

        Where:

        * `folderId`: Folder ID. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
        * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) the cluster will be deployed in.

        
        * `securityGroupIds`: [Security group](../concepts/network.md#security-groups) IDs.


        * `deletionProtection`: Cluster protection against accidental deletion, `true` or `false`.

          {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings, including for stopped clusters. In `maintenanceWindow`, provide one of the following values:

          * `anytime`: Maintenance can occur at any time.
          * `weeklyMaintenanceWindow`: Maintenance takes place once a week at the specified time:

            * `day`: Day of week, in `DDD` format.
            * `hour`: Hour of the day, in `HH` format. The values range from `1` to `24` hours.

        * `configSpec`: Cluster settings:

            * `version`: {{ SD }} version, 5.0, 6.0, or 7.0.
            * `mongod`, `mongoinfra`, `mongos`, `mongocfg`: Host types.

              * `resources`: Cluster resources:

                * `resourcePresetId`: [Host class](../concepts/instance-types.md).
                * `diskSize`: Disk size, in bytes.
                * `diskTypeId`: [Disk type](../concepts/storage.md).

            * `backupWindowStart`: [Backup](../concepts/backup.md) window settings.

              Here, specify the backup start time:

              * `hours`: Between `0` and `23` hours.
              * `minutes`: Between `0` and `59` minutes.
              * `seconds`: Between `0` and `59` seconds.
              * `nanos`: Between `0` and `999999999` nanoseconds.

            * `backupRetainPeriodDays`: Backup retention in days.

            * `performanceDiagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:
              * `profilingEnabled`: Enable [profiler](tools.md#explore-profiler), `true` or `false`.

        * `databaseSpecs`: Database settings as an array of elements, one per database. Each element contains the `name` parameter with the database name.

            {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

        * `userSpecs`: User settings as an array of elements, one per user. Each element has the following structure:

          * `name`: Username.
          * `password`: User password.
          * `permissions`: User permissions settings:

            * `databaseName`: Name of the database to which the user will have access.
            * `roles`: Array of user roles. Each role is provided as a separate string in the array. For a list of possible values, see [Users and roles](../concepts/users-and-roles.md).

            For each database, add a separate element with permission settings to the `permissions` array.

        * `hostSpecs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

                    * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`. In a sharded cluster, it is used only for `MONGOS` and `MONGOINFRA` hosts.
          * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`.
          * `tags`: Host labels.
          * `shard_name`: Shard name in a sharded cluster (for `MONGOD` hosts only).
          * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
          * `secondaryDelaySecs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
          * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).

          {% note info %}

          The `shardName`, `hidden`, `secondaryDelaySecs`, and `priority` parameters are used for `MONGOD` hosts only.

          {% endnote %}


  1. Call the [Cluster.Create](../api-ref/Cluster/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters' \
          --data "@body.json"
      ```

  1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and paste the following code into it:

        {% cut "For a non-sharded cluster" %}

        
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
          "deletion_protection": <protect_cluster_against_deletion>,
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "config_spec": {
            "version": "<Yandex_StoreDoc_version>",
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
              "profiling_enabled": <enable_profiler>
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
            { <similar_settings_for_user_2> },
            { ... },
            { <similar_settings_for_user_N> }
          ],
          "host_specs": [
            {
              "zone_id": "<availability_zone>",
              "subnet_id": "<subnet_ID>",
              "assign_public_ip": <allow_public_access_to_host>,
              "type": "MONGOD",
              "hidden": <hide_host>,
              "secondary_delay_secs": "<replica_lag_in_seconds>",
              "priority": "<host_priority>",
              "tags": "<host_labels>"
            },
            { <similar_settings_for_host_2> },
            { ... },
            { <similar_configuration_for_host_N> }
          ]
        }
        ```


        {% endcut %}

        {% cut "For a cluster with standard sharding" %}

        
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
          "deletion_protection": <protect_cluster_against_deletion>,
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "config_spec": {
            "version": "<Yandex_StoreDoc_version>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resource_preset_id": "<host_class>",
                  "disk_size": "<storage_size_in_bytes>",
                  "disk_type_id": "<disk_type>"
                }
              },
              "mongoinfra": {
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
              "profiling_enabled": <enable_profiler>
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
            { <similar_settings_for_user_2> },
            { ... },
            { <similar_settings_for_user_N> }
          ],
          "host_specs": [
            {
              "zone_id": "<availability_zone>",
              "subnet_id": "<subnet_ID>",
              "type": "MONGOD",
              "shard_name": "<shard_name>",
              "hidden": <hide_host>,
              "secondary_delay_secs": "<replica_lag_in_seconds>",
              "priority": "<host_priority>",
              "tags": "<host_labels>"
            },
            {
              "zone_id": "<availability_zone>",
              "subnet_id": "<subnet_ID>",
              "type": "MONGOINFRA",
              "assign_public_ip": <allow_public_access_to_host>,
              "tags": "<host_labels>"
            },
            { <similar_settings_for_host_3> },
            { ... },
            { <similar_configuration_for_host_N> }
          ]
        }
        ```


        {% endcut %}

        {% cut "For a cluster with advanced sharding" %}

        
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
          "deletion_protection": <protect_cluster_against_deletion>,
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "config_spec": {
            "version": "<Yandex_StoreDoc_version>",
            "mongodb": {
              "mongod": {
                "resources": {
                  "resource_preset_id": "<host_class>",
                  "disk_size": "<storage_size_in_bytes>",
                  "disk_type_id": "<disk_type>"
                }
              },
              "mongos": {
                "resources": {
                  "resource_preset_id": "<host_class>",
                  "disk_size": "<storage_size_in_bytes>",
                  "disk_type_id": "<disk_type>"
                }
              },
              "mongocfg": {
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
              "profiling_enabled": <enable_profiler>
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
            { <similar_settings_for_user_2> },
            { ... },
            { <similar_settings_for_user_N> }
          ],
          "host_specs": [
            {
              "zone_id": "<availability_zone>",
              "subnet_id": "<subnet_ID>",
              "type": "MONGOD",
              "shard_name": "<shard_name>",
              "hidden": <hide_host>,
              "secondary_delay_secs": "<replica_lag_in_seconds>",
              "priority": "<host_priority>",
              "tags": "<host_labels>"
            },
            {
              "zone_id": "<availability_zone>",
              "subnet_id": "<subnet_ID>",
              "type": "MONGOS",
              "assign_public_ip": <allow_public_access_to_host>,
              "tags": "<host_labels>"
            },
            {
              "zone_id": "<availability_zone>",
              "subnet_id": "<subnet_ID>",
              "type": "MONGOCFG",
              "tags": "<host_labels>"
            },
            { <similar_settings_for_host_4> },
            { ... },
            { <similar_configuration_for_host_N> }
          ]
        }
        ```


        {% endcut %}

        Where:

        * `folder_id`: Folder ID. You can get it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
        * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) where the cluster will be deployed.

        
        * `security_group_ids`: [Security group](../concepts/network.md#security-groups) IDs.


        * `deletion_protection`: Cluster protection against accidental deletion, `true` or `false`.

          {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings, including for stopped clusters. In `maintenance_window`, provide one of the following values:

          * `anytime`: Maintenance can take place at any time.
          * `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:

            * `day`: Day of week, in `DDD` format.
            * `hour`: Hour of the day, in `HH` format. The values range from `1` to `24` hours.

        * `config_spec`: Cluster settings:

          * `version`: {{ SD }} version, 5.0, 6.0, or 7.0.
            * `mongod`, `mongoinfra`, `mongos`, `mongocfg`: Host types.

              * `resources`: Cluster resources:

                * `resource_preset_id`: [Host class](../concepts/instance-types.md).
                * `disk_size`: Disk size, in bytes.
                * `disk_type_id`: [Disk type](../concepts/storage.md).

            * `backup_window_start`: [Backup](../concepts/backup.md) window settings.

              Here, specify the backup start time:

              * `hours`: Between `0` and `23` hours.
              * `minutes`: Between `0` and `59` minutes.
              * `seconds`: Between `0` and `59` seconds.
              * `nanos`: Between `0` and `999999999` nanoseconds.

            * `backup_retain_period_days`: Backup retention in days.

            * `performance_diagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:
              * `profiling_enabled`: Enable [profiler](tools.md#explore-profiler), `true` or `false`.

        * `database_specs`: Database settings as an array of elements, one per database. Each element contains the `name` parameter with the database name.

            {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

        * `user_specs`: User settings as an array of elements, one per user. Each element has the following structure:

          * `name`: Username.
          * `password`: User password.
          * `permissions`: User permission settings:

            * `database_name`: Name of the database to which the user will have access.
            * `roles`: Array of user roles. Each role is provided as a separate string in the array. For a list of possible values, see [Users and roles](../concepts/users-and-roles.md).

            For each database, add a separate element with permission settings to the `permissions` array.

        * `host_specs`: Cluster host settings as an array of elements, one per host. Each element has the following structure:

                    * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
          * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`. In a sharded cluster, it is used only for `MONGOS` and `MONGOINFRA` hosts.
          * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`.
          * `tags`: Host labels.
          * `shard_name`: Shard name in a sharded cluster.
          * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
          * `secondaryDelaySecs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
          * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).

          {% note info %}

          The `shard_name`, `hidden`, `secondaryDelaySecs`, and `priority` parameters are used for `MONGOD` hosts only.

          {% endnote %}


  1. Call the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


{% note warning %}

If you specified security group IDs when creating a cluster, you may need to additionally [configure security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}



## Creating a cluster copy {#duplicate}

You can create an {{ SD }} cluster with the settings of another one created earlier. To do this, import the original {{ SD }} cluster configuration to {{ TF }}. This way, you can either create an identical copy or use the imported configuration as the baseline and modify it as needed. The import feature is useful when you need to replicate a {{ SD }} cluster packed with settings.

To create an {{ SD }} cluster copy:

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

    1. Save the ID of the original {{ SD }} cluster to an environment variable:

        ```bash
        export STOREDOC_CLUSTER_ID=<cluster_ID>
        ```

        You can get the ID with the [list of clusters in the folder](../operations/cluster-list.md#list-clusters).

    1. Import the original {{ SD }} cluster settings to the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_mongodb_cluster.old ${STOREDOC_CLUSTER_ID}
        ```

    1. Get the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from the terminal and paste it into the `.tf` file.
    1. Place the file in the new `imported-cluster` directory.
    1. Edit the copied configuration so that you can create a new cluster from it:

        * Specify the new cluster name in the `resource` string and the `name` parameter.
        * Delete `created_at`, `health`, `id`, `sharded`, and `status`.
        * In the `host` sections, delete `health` and `name`.
        * If you have `type = "ANYTIME"` in the `maintenance_window` section, delete the `hour` argument.
        * Delete all `user` sections (if any). You can add database users with a separate `yandex_mdb_mongodb_user` resource.
        * Optionally, make further changes if you need a customized configuration.

    1. [Get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) in the `imported-cluster` directory.

    1. In the same directory, [configure and initialize the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). There is no need to create a provider configuration file manually, as you can [download it](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Place the configuration file in the `imported-cluster` directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you did not add the authentication credentials to environment variables, specify them in the configuration file.

    1. Make sure the {{ TF }} configuration files are correct:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

{% endlist %}


## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

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

  Create a {{ mmg-name }} cluster and its network with the following test specifications:

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
      description    = "{{ SD }}"
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

##### **Standard sharding** {#std-sharding}

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

* Availability zone: `{{ region-id }}-a`.
* Network: `mynet`.


* Security group: `mymg-sg` with `{{ security-group }}` ID. In {{ TF }}, a group is created with the rule allowing TCP connections to the cluster from the internet on port `{{ port-mmg }}`.
* Subnet: `mysubnet`. 
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
      description    = "{{ SD }}"
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

##### **Advanced sharding** {#adv-sharding}

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

* Availability zone: `{{ region-id }}-a`.
* Network: `mynet`.


* Security group: `mymg-sg` with `{{ security-group }}` ID. In {{ TF }}, a group is created with the rule allowing TCP connections to the cluster from the internet on port `{{ port-mmg }}`.
* Subnet: `mysubnet`. 
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
      description    = "{{ SD }}"
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
