---
title: How to create a {{ VLK }} cluster
description: In this tutorial, you will learn how to create a {{ VLK }} cluster with one or more database hosts.
---

# Creating a {{ VLK }} cluster


A {{ VLK }} cluster is one or more database hosts between which you can configure replication. Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests and asynchronously duplicates changes on replicas.

For more information on the {{ mrd-name }} cluster structure, see [Resource relationships](../concepts/index.md).

{% note info %}

* The number of hosts you can create together with a {{ VLK }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors) as well as on whether [sharding](../concepts/sharding.md) is enabled.
* Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

{% endnote %}


## Creating a cluster {#create-cluster}


To create a {{ mrd-name }} cluster, you will need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role, as well as the [{{ roles.mrd.editor }} role or higher](../security/index.md#roles-list). For more information on assigning roles, see the [{{ iam-name }} guides](../../iam/operations/roles/grant.md).


{% note info %}

The following restrictions apply when creating sharded clusters:

* You can create a single-shard cluster using the CLI, {{ TF }}, or API.
* You cannot create a cluster with two shards, but you can [add a shard](./shards.md#add) to an existing single-shard cluster.
* You can create a cluster with three or more shards using the management console, CLI, {{ TF }}, or API.

There are no restrictions for non-sharded clusters.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}


  To create a {{ mrd-name }} cluster:

  1. In the [management console]({{ link-console-main }}), go to the folder to create a DB cluster in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

     * Specify the cluster name in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. The cluster name must be unique within the folder.
     * Optionally, add a cluster description.
     * Select the environment where you want to create your cluster (the environment cannot be changed after cluster creation):
       * `PRODUCTION`: For stable versions of your applications.
       * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first of the two to get new features, improvements, and bug fixes. In the prestable environment, you can test the new versions for compatibility with your application.
     * Select the DBMS version.
     * Optionally, you add labels.
     * If necessary, enable [cluster sharding](../concepts/sharding.md).

          {% note warning %}

          You cannot disable sharding in a cluster where it is already enabled. You can create a non-sharded cluster and [enable sharding](./update.md#enable-sharding) later, if required.

          {% endnote %}

     * If required, enable support for encrypted TLS connections to the cluster.

          {% note warning %}

          You can only enable connection encryption when creating a new cluster. You cannot disable encryption for a cluster that it is enabled for.

          {% endnote %}

     * If required, enable the [use of FQDNs instead of IP addresses](../concepts/network.md#fqdn-ip-setting).

        {% include [fqdn-option-compatibility-note](../../_includes/mdb/mrd/connect/fqdn-option-compatibility-note.md) %}

     * Select the [data persistence](../concepts/replication.md#persistence) mode.

  1. Under **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**:

     * Select a platform in the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** field.
     * Specify the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** of the VM to deploy hosts on.
     * Select **{{ ui-key.yacloud.mdb.forms.section_resource }}**.

     
     * Select the [disk type](../concepts/storage.md):
       * Either the more flexible network SSD (`network-ssd`) or non-replicated SSD (`network-ssd-nonreplicated`) storage
       * Or the faster local SSD (`local-ssd`) storage

       {% include [storages-step-settings-no-hdd](../../_includes/mdb/settings-storages-no-hdd.md) %}


     * Select the storage size. The available storage size is limited by [quotas and limits](../concepts/limits.md#mrd-limits).

     {% include [console-autoscaling](../../_includes/mdb/mrd/console-autoscaling.md) %}

     
     * Optionally, select **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}** to encrypt the disk with a [custom KMS key](../../kms/concepts/key.md).

       * To [create](../../kms/operations/key.md#create) a new key, click **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.

       * To use the key you created earlier, select it in the **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** field.

       To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).


  
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select:
       * [Cloud network](../../vpc/concepts/network.md#network) for the cluster.
       * Security groups for the cluster network traffic. You may need to additionally [set up security groups](connect/index.md#configuring-security-groups) to be able to connect to the cluster.


   1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, configure the hosts:

      * To change the settings of an individual host, click the ![pencil](../../_assets/console-icons/pencil.svg) icon in the line with its name.

          * **{{ ui-key.yacloud.mdb.forms.host_column_zone }}**: Select an [availability zone](../../overview/concepts/geo-scope.md).
          * **{{ ui-key.yacloud.mdb.forms.host_column_subnetwork }}**: Specify a [subnet](../../vpc/concepts/network.md#subnet) in the selected availability zone.

          
          * **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}**: Enables access to the host from the internet if the cluster is created with **{{ ui-key.yacloud.redis.field_tls-support }}** enabled.


          * **{{ ui-key.yacloud.mdb.forms.host_column_replica-priority }}**: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
          * **{{ ui-key.yacloud.mdb.forms.host_column_shard-name }}**: Enables you to change the shard name for the host. The field is available only if the cluster is created with **{{ ui-key.yacloud.mdb.forms.field_cluster-mode }}** enabled.

      * To add hosts to your cluster, click **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.

      If you enabled sharding in the cluster and chose the **local-ssd** disk type, add at least two hosts per shard.

   1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**:

      * In the **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** field, enter the user password.

         {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

      * Configure the [DBMS settings](../concepts/settings-list.md), if required.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**, configure the additional cluster settings:

      {% include [mrd-extra-settings](../../_includes/mdb/mrd-extra-settings-web-console.md) %}

  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ mrd-name }} cluster:

  
  1. Check whether the folder has any subnets for the cluster hosts:

     ```bash
     yc vpc subnet list
     ```

     If your folder has no subnets, [create them](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.


  1. View the description of the CLI command to create a cluster:

      ```bash
      {{ yc-mdb-rd }} cluster create --help
      ```

  1. When you create a cluster from the CLI, you cannot explicitly specify the host type and amount of RAM. Choose the applicable [host class](../concepts/instance-types.md) instead. To see what host classes are available, run the command:

     ```bash
     {{ yc-mdb-rd }} resource-preset list
     ```

  1. Specify the cluster parameters in the create command (not all flags are shown in the example):

      
      ```bash
      {{ yc-mdb-rd }} cluster create \
        --name <cluster_name> \
        --environment <environment> \
        --redis-version <{{ VLK }}_version> \
        --network-name <network_name> \
        --host zone-id=<availability_zone>,`
              `subnet-id=<subnet_ID>,`
              `assign-public-ip=<public_access>,`
              `replica-priority=<host_priority> \
        --security-group-ids <list_of_security_group_IDs> \
        --enable-tls \
        --persistence-mode <persistence_mode> \
        --resource-preset <host_class> \
        --disk-size <storage_size_in_GB> \
        --disk-size-autoscaling disk-size-limit=<maximum_storage_size_in_GB>,`
                                `planned-usage-threshold=<scheduled_increase_percentage>,`
                                `emergency-usage-threshold=<immediate_increase_percentage> \
        --disk-type-id <network-ssd|network-ssd-nonreplicated|local-ssd> \
        --password=<user_password> \
        --backup-window-start <time> \
        --disk-encryption-key-id <KMS_key_ID> \
        --deletion-protection \
        --announce-hostnames <using_FQDNs_instead_of_IP_addresses>
      ```


      Where:
      * `--environment`: Environment, `prestable` or `production`.
      * `--redis-version`: {{ VLK }} version, {{ versions.cli.str }}.

      
      * `--host`: Host settings:
         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
         * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify it if two or more subnets are created in the selected availability zone.
         * `assign-public-ip`: Internet access to the host via a public IP address, `true` or `false`.
         * `replica-priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
      * `--disk-type-id`: Disk type.

      * `--websql-access`: Enables [SQL queries](web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}. The default value is `false`.


      * `--disk-size-autoscaling`: Automatic storage size increase settings:

        {% include [autoscale-description](../../_includes/mdb/mrd/cli-autoscaling.md) %}

      * `--persistence-mode`: [Data persistence mode](../concepts/replication.md#persistence).

        {% include [persistence-modes](../../_includes/mdb/mrd/persistence-modes.md) %}

      * `--backup-window-start`: Backup start time in `HH:MM:SS` format.
      * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

      
      * `--disk-encryption-key-id`: Disk encryption with a [custom KMS key](../../kms/concepts/key.md).

        To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).


      * `--announce-hostnames`: Enables or disables [using FQDNs instead of IP addresses](../concepts/network.md#fqdn-ip-setting): `true` or `false`.

        {% include [fqdn-option-compatibility-note](../../_includes/mdb/mrd/connect/fqdn-option-compatibility-note.md) %}

      You need to specify `subnet-id` if the selected availability zone has two or more subnets.

      {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

      If you are creating a sharded cluster with the **local-ssd** disk type, specify at least two hosts per shard in the command.

      {% note info %}

      The default [maintenance](../concepts/maintenance.md) mode for new clusters is `anytime`. You can set a specific maintenance period when [updating the cluster settings](update.md#change-additional-settings).

      {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a {{ mrd-name }} cluster:

    1. In the configuration file, describe the properties of resources you want to create:

       * Database cluster: Description of the cluster and its hosts. You can also configure [DBMS settings](../concepts/settings-list.md) here if necessary.

       
       * Network: Description of the [cloud network](../../vpc/concepts/network.md#network) to host the cluster. If you already have a suitable network, you do not need to describe it again.
       * Subnets: Description of the [subnets](../../vpc/concepts/network.md#network) to connect the cluster hosts to. If you already have suitable subnets, you do not need to describe them again.


       Sample configuration file structure for creating a non-sharded cluster with SSL support:

       
       ```hcl
       resource "yandex_mdb_redis_cluster" "<cluster_name>" {
         name                = "<cluster_name>"
         environment         = "<environment>"
         network_id          = "<network_ID>"
         security_group_ids  = [ "<list_of_security_group_IDs>" ]
         tls_enabled         = true
         deletion_protection = <cluster_deletion_protection>
         announce_hostnames  = <using_FQDNs_instead_of_IP_addresses>
         persistence_mode    = "<persistence_mode>"

         disk_size_autoscaling {
           planned_usage_threshold   = "<scheduled_increase_percentage>"
           emergency_usage_threshold = "<immediate_increase_percentage>"
           disk_size_limit           = "<maximum_storage_size_in_GiB>"
         }

         config {
           password = "<password>"
           version  = "<{{ VLK }}_version>"
         }

         resources {
           resource_preset_id = "<host_class>"
           disk_type_id       = "<disk_type>"
           disk_size          = <storage_size_in_GB>
         }

         host {
           zone             = "<availability_zone>"
           subnet_id        = "<subnet_ID>"
           assign_public_ip = <public_access>
           replica_priority = <host_priority>
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
       * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

            {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

       * `disk_size_autoscaling`: Automatic storage size increase settings:

            {% include [autoscale-description](../../_includes/mdb/mrd/terraform/terraform-autoscaling.md) %}

       * `announce_hostnames`: Enables or disables [using FQDNs instead of IP addresses](../concepts/network.md#fqdn-ip-setting): `true` or `false`.

            {% include [fqdn-option-compatibility-note](../../_includes/mdb/mrd/connect/fqdn-option-compatibility-note.md) %}

       * `persistence_mode`: [Data persistence mode](../concepts/replication.md#persistence).

            {% include [persistence-modes](../../_includes/mdb/mrd/persistence-modes.md) %}

       * `version`: {{ VLK }} version, {{ versions.tf.str }}.
       * `host`: Host settings:
         * `zone_id`: Availability zone.
         * `subnet_id`: ID of a subnet in the selected availability zone.
         * `assign_public_ip`: Public access to the host, `true` or `false`.
         * `replica_priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).

       {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

       If you are creating a sharded cluster with the **local-ssd** disk type, specify at least two hosts per shard in the configuration file.

       {% include [Maintenance window](../../_includes/mdb/mrd/terraform/maintenance-window.md) %}

       
       To encrypt the disk with a [custom KMS key](../../kms/concepts/key.md), add the `disk_encryption_key_id` parameter:

         ```hcl
         resource "yandex_mdb_redis_cluster" "<cluster_name>" {
           ...
           disk_encryption_key_id = <KMS_key_ID>
           ...
         }
         ```

         To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).


       For more information about the resources you can create with {{ TF }}, see this [provider guide]({{ tf-provider-mrd }}).

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a cluster.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       After this, all required resources will be created in the specified folder, and the [FQDNs of the cluster hosts](../concepts/network.md#hostname) will be displayed in the terminal. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

       {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        
        ```json
        {
          "folderId": "<folder_ID>",
          "name": "<cluster_name>",
          "environment": "<environment>",
          "configSpec": {
            "version": "<{{ VLK }}_version>",
            "resources": {
              "resourcePresetId": "<host_class>",
              "diskSize": "<storage_size_in_bytes>",
              "diskTypeId": "<disk_type>"
            },
            "diskSizeAutoscaling": {
              "plannedUsageThreshold": "<scheduled_increase_percentage>",
              "emergencyUsageThreshold": "<immediate_increase_percentage>",
              "diskSizeLimit": "<maximum_storage_size_in_bytes>"
            },
            "access": {
              "webSql": <access_from_{{ websql-name }}>
            },
            "redis": {
              "password": "<user_password>"
            }
          },
          "hostSpecs": [
            {
              "zoneId": "<availability_zone>",
              "subnetId": "<subnet_ID>",
              "shardName": "<shard_name>",
              "replicaPriority": "<host_priority>",
              "assignPublicIp": <public_access_to_cluster_host>
            },
            { <similar_settings_for_host_2> },
            { ... },
            { <similar_settings_for_host_N> }
          ],
          "networkId": "<network_ID>",
          "sharded": <cluster_sharding>,
          "securityGroupIds": [
            "<security_group_1_ID>",
            "<security_group_2_ID>",
            ...
            "<security_group_N_ID>"
          ],
          "tlsEnabled": <encrypted_TLS_connection_support>,
          "deletionProtection": <cluster_deletion_protection>,
          "announceHostnames": <using_FQDNs_instead_of_IP_addresses>,
          "persistenceMode": "<persistence_mode>"
        }
        ```




        Where:

        * `folderId`: Folder ID. You can get it from the [cloud’s folder list](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `environment`: Environment, `PRESTABLE` or `PRODUCTION`.
        * `configSpec`: Cluster settings:

            * `version`: {{ VLK }} version, {{ versions.cli.str }}.
            * `resources`: Cluster resources:

                * `resourcePresetId`: [Host class](../concepts/instance-types.md).
                * `diskSize`: Disk size in bytes.
                * `diskTypeId`: [Disk type](../concepts/storage.md).

            {% include [autoscale-description](../../_includes/mdb/mrd/api/autoscaling-rest.md) %}    

            
            * `access.webSql`: Access to cluster databases from the {{ yandex-cloud }} management console through [{{ websql-full-name }}](../../websql/index.yaml), `true` or `false`.


            * `redis.password`: Password.

        * `hostSpecs`: Host settings:

            * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify it if the selected availability zone has two or more subnets.
            * `shardName`: Shard name for the host. Only used if the `sharded` parameter is set to `true`.
            * `replicaPriority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
            * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`. You can enable public access only if the `tlsEnabled` parameter is set to `true`.

        * `networkId`: ID of the [network](../../vpc/concepts/network.md#network) where the cluster will be deployed.

        * `sharded`: [Cluster sharding](../concepts/sharding.md), `true` or `false`.

            {% note warning %}

            You cannot disable sharding in a cluster where it is already enabled. You can create a non-sharded cluster and [enable sharding](../operations/update.md#enable-sharding) later, if required.

            {% endnote %}

            If you are creating a sharded cluster with the `local-ssd` disk type, specify at least two hosts per shard, adding the appropriate number of `hostSpecs` blocks.

        
        * `securityGroupIds`: [Security group](../concepts/network.md#security-groups) IDs.


        * `tlsEnabled`: Support for encrypted TLS connections to the cluster, `true` or `false`.

            {% note warning %}

            You can only enable connection encryption when creating a new cluster. You cannot disable encryption for a cluster that it is enabled for.

            {% endnote %}

        * `deletionProtection`: Cluster protection from accidental deletion, `true` or `false`.

            {% include [deletion-protection-limits-dataa](../../_includes/mdb/deletion-protection-limits-data.md) %}

        * `announceHostnames`: [Using FQDNs instead of IP addresses](../concepts/network.md#fqdn-ip-setting), `true` or `false`.

            {% include [fqdn-option-compatibility-note](../../_includes/mdb/mrd/connect/fqdn-option-compatibility-note.md) %}

        * `persistenceMode`: [Data persistence mode](../concepts/replication.md#persistence).

            {% include [persistence-modes](../../_includes/mdb/mrd/persistence-modes.md) %}

    1. Use the [Cluster.Create](../api-ref/Cluster/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters' \
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
          "config_spec": {
            "version": "<{{ VLK }}_version>",
            "resources": {
              "resource_preset_id": "<host_class>",
              "disk_size": "<storage_size_in_bytes>",
              "disk_type_id": "<disk_type>"
            },
            "disk_size_autoscaling": {
              "planned_usage_threshold": "<scheduled_increase_percentage>",
              "emergency_usage_threshold": "<immediate_increase_percentage>",
              "disk_size_limit": "<maximum_storage_size_in_bytes>"
            },
            "access": {
              "web_sql": <access_from_{{ websql-name }}>
            },
            "redis": {
              "password": "<user_password>"
            }
          },
          "host_specs": [
            {
              "zone_id": "<availability_zone>",
              "subnet_id": "<subnet_ID>",
              "shard_name": "<shard_name>",
              "replica_priority": "<host_priority>",
              "assign_public_ip": <public_access_to_cluster_host>
            },
            { <similar_settings_for_host_2> },
            { ... },
            { <similar_settings_for_host_N> }
          ],
          "network_id": "<network_ID>",
          "sharded": <cluster_sharding>,
          "security_group_ids": [
            "<security_group_1_ID>",
            "<security_group_2_ID>",
            ...
            "<security_group_N_ID>"
          ],
          "tls_enabled": <encrypted_TLS_connection_support>,
          "deletion_protection": <cluster_deletion_protection>,
          "announce_hostnames": <using_FQDNs_instead_of_IP_addresses>,
          "persistence_mode": "<persistence_mode>"
        }
        ```




        Where:

        * `folder_id`: Folder ID. You can request it with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).
        * `name`: Cluster name.
        * `environment`: Environment, `PRESTABLE` or `PRODUCTION`.
        * `config_spec`: Cluster settings:

            * `version`: {{ VLK }} version, {{ versions.cli.str }}.
            * `resources`: Cluster resources:

                * `resource_preset_id`: [Host class](../concepts/instance-types.md).
                * `disk_size`: Disk size in bytes.
                * `disk_type_id`: [Disk type](../concepts/storage.md).

            {% include [autoscale-description](../../_includes/mdb/mrd/api/autoscaling-grpc.md) %}    

            
            * `access.web_sql`: Access to cluster databases from the {{ yandex-cloud }} management console through [{{ websql-full-name }}](../../websql/index.yaml), `true` or `false`.


            * `redis.password`: Password.

        * `host_specs`: Host settings:

            * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify it if the selected availability zone has two or more subnets.
            * `shard_name`: Shard name for the host. Only used if the `sharded` parameter is set to `true`.
            * `replica_priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
            * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`. You can enable public access only if the `tls_enabled` parameter is set to `true`.

        * `network_id`: ID of the [network](../../vpc/concepts/network.md#network) where the cluster will be deployed.

        * `sharded`: [Cluster sharding](../concepts/sharding.md), `true` or `false`.

            {% note warning %}

            You cannot disable sharding in a cluster where it is already enabled. You can create a non-sharded cluster and [enable sharding](update.md#enable-sharding) later, if required.

            {% endnote %}

            If you are creating a sharded cluster with the `local-ssd` disk type, specify at least two hosts per shard, adding the appropriate number of `host_specs` blocks.

        
        * `security_group_ids`: [Security group](../concepts/network.md#security-groups) IDs.


        * `tls_enabled`: Support for encrypted TLS connections to the cluster, `true` or `false`.

            {% note warning %}

            You can only enable connection encryption when creating a new cluster. You cannot disable encryption for a cluster that it is enabled for.

            {% endnote %}

        * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

            {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

        * `announce_hostnames`: [Using FQDNs instead of IP addresses](../concepts/network.md#fqdn-ip-setting), `true` or `false`.

            {% include [fqdn-option-compatibility-note](../../_includes/mdb/mrd/connect/fqdn-option-compatibility-note.md) %}

        * `persistence_mode`: [Data persistence mode](../concepts/replication.md#persistence).
        
            {% include [persistence-modes](../../_includes/mdb/mrd/persistence-modes.md) %}

    1. Use the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Create \
            < body.json
        ```

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


{% note warning %}

If you specified security group IDs when creating a cluster, you may also need to additionally [configure security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}


## Creating a cluster copy {#duplicate}

You can create a {{ VLK }} cluster using the settings of another one created earlier. To do this, import the {{ VLK }} source cluster configuration to {{ TF }}. This way, you can either create an identical copy or use the imported configuration as a starting point for modification. Import is convenient when the source {{ VLK }} cluster has many settings and you need to create a similar cluster.

To create a {{ VLK }} cluster copy:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. In your current working directory, create a `.tf` file with the following content:

        ```hcl
        resource "yandex_mdb_redis_cluster" "old" { }
        ```

    1. Save the ID of the original {{ VLK }} cluster to an environment variable:

        ```bash
        export REDIS_CLUSTER_ID=<cluster_ID>
        ```

        You can get the ID from the [folder’s cluster list](../../managed-redis/operations/cluster-list.md#list-clusters).

    1. Import the original {{ VLK }} cluster settings to the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_redis_cluster.old ${REDIS_CLUSTER_ID}
        ```

    1. Display the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from the terminal and paste it into the `.tf` file.
    1. Create a new directory named `imported-cluster` and move your file there.
    1. Modify the configuration so it can be used to create a new cluster:

        * Specify the new cluster name in the `resource` string and the `name` parameter.
        * Delete `created_at`, `health`, `id`, and `status`.
        * Add the `password` parameter to the `config` section.
        * If the `config` section has `notify_keyspace_events = "\"\""`, delete this parameter.
        * If `sharded = false` is specified, delete the `shard_name` parameters in the `host` sections.
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

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  To create a single-host cluster, provide one `--host` parameter.

  Create a {{ mrd-name }} cluster with the following test specifications:

  * Name: `myredis`.
  * Version: `{{ versions.cli.latest }}`.
  * Environment: `production`.
  * Network: `default`.
  * A single `{{ mrd-host-class }}` class host in the `b0rcctk2rvtr********` subnet, `{{ region-id }}-a` availability zone and security group with the `{{ security-group }}` ID, with public access and a [host priority](../concepts/replication.md#master-failover) of `50`.
  * SSL support: Enabled.
  * Network SSD storage (`{{ disk-type-example }}`): 16 GB.
  * Password: `user1user1`.
  * Deletion protection: Enabled.

  Run this command:

  
  ```bash
  {{ yc-mdb-rd }} cluster create \
    --name myredis \
    --redis-version {{ versions.cli.latest }} \
    --environment production \
    --network-name default \
    --resource-preset {{ mrd-host-class }} \
    --host zone-id={{ region-id }}-a,subnet-id=b0rcctk2rvtr********,assign-public-ip=true,replica-priority=50 \
    --security-group-ids {{ security-group }} \
    --enable-tls \
    --disk-type-id {{ disk-type-example }} \
    --disk-size 16 \
    --password=user1user1 \
    --deletion-protection
  ```


- {{ TF }} {#tf}

  Create a {{ mrd-name }} cluster and its network with the following test specifications:

    * Name: `myredis`.
    * Version: `{{ versions.tf.latest }}`.
    * Environment: `PRODUCTION`.
    * Cloud ID: `{{ tf-cloud-id }}`.
    * Folder ID: `{{ tf-folder-id }}`.
    * New `mynet` network.
    * A single `{{ mrd-host-class }}` class host in the new subnet called `mysubnet`, `{{ region-id }}-a` availability zone, with public access and a [host priority](../concepts/replication.md#master-failover) of `50`. `mysubnet` CIDR range: `10.5.0.0/24`.
    * New `redis-sg` security group allowing connections through the `{{ port-mrd-tls }}` port from any addresses in `mysubnet`.
    * SSL support: Enabled.
    * Network SSD storage (`{{ disk-type-example }}`): 16 GB.
    * Password: `user1user1`.
    * Deletion protection: Enabled.

  The configuration file for this cluster looks like this:

  
  ```hcl
  resource "yandex_mdb_redis_cluster" "myredis" {
    name                = "myredis"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [ yandex_vpc_security_group.redis-sg.id ]
    tls_enabled         = true
    deletion_protection = true

    config {
      password = "user1user1"
      version  = "{{ versions.tf.latest }}"
    }

    resources {
      resource_preset_id = "{{ mrd-host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 16
    }

    host {
      zone             = "{{ region-id }}-a"
      subnet_id        = yandex_vpc_subnet.mysubnet.id
      assign_public_ip = true
      replica_priority = 50
    }
  }

  resource "yandex_vpc_network" "mynet" { name = "mynet" }

  resource "yandex_vpc_security_group" "redis-sg" {
    name       = "redis-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "{{ VLK }}"
      port           = {{ port-mrd-tls }}
      protocol       = "TCP"
      v4_cidr_blocks = ["10.5.0.0/24"]
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

### Creating a sharded cluster with a single shard {#creating-a-single-shard-sharded-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a [sharded](../concepts/sharding.md) {{ mrd-name }} cluster with the following test specifications:

  * Name: `myredis`.
  * Version: `{{ versions.cli.latest }}`.
  * Environment: `production`.
  * Sharding: Enabled.
  * SSL support: Enabled.
  * Deletion protection: Enabled.
  * Network: `default`.
  * Security group ID: `{{ security-group }}`.
  * Host class: `{{ mrd-host-class }}`.
  * A single host in the shard called `shard1`, in the `b0rcctk2rvtr********` subnet, `{{ region-id }}-a` availability zone, with public access and a [host priority](../concepts/replication.md#master-failover) of `50`.
  * Network SSD storage (`{{ disk-type-example }}`): 16 GB.
  * Password: `user1user1`.

  Run this command:

  
  ```bash
  {{ yc-mdb-rd }} cluster create \
    --name myredis \
    --redis-version {{ versions.cli.latest }} \
    --environment production \
    --sharded \
    --enable-tls \
    --deletion-protection \
    --network-name default \
    --security-group-ids {{ security-group }} \
    --resource-preset {{ mrd-host-class }} \
    --host shard-name=shard1,subnet-id=b0rcctk2rvtr********,zone-id=ru-central1-a,assign-public-ip=true,replica-priority=50 \
    --disk-type-id {{ disk-type-example }} \
    --disk-size 16 \
    --password user1user1
  ```


- {{ TF }} {#tf}

  Create a [sharded](../concepts/sharding.md) {{ mrd-name }} cluster and a network for it with the following test characteristics:

  * Name: `myredis`.
  * Version: `{{ versions.cli.latest }}`.
  * Environment: `PRODUCTION`.
  * Sharding: Enabled.
  * SSL support: Enabled.
  * Deletion protection: Enabled.
  * New network named `mynet` with a single subnet. Range for `mysubnet`: `10.5.0.0/24`.
  * New `redis-sg` security group allowing connections through the `{{ port-mrd-tls }}` port from any addresses in `mysubnet`.
  * Host class: `{{ mrd-host-class }}`.
  * A single host in the shard called `shard1`, in the `mysubnet` subnet, `{{ region-id }}-a` availability zone, with public access and a [host priority](../concepts/replication.md#master-failover) of `50`.
  * Network SSD storage (`{{ disk-type-example }}`): 16 GB.
  * Password: `user1user1`.

  The configuration file for this cluster looks like this:

  
  ```hcl
  resource "yandex_mdb_redis_cluster" "myredis" {
    name                = "myredis"
    environment         = "PRODUCTION"
    sharded             = true
    tls_enabled         = true
    deletion_protection = true
    network_id          = yandex_vpc_network.mynet.id
    security_group_ids  = [yandex_vpc_security_group.redis-sg.id]
  
    config {
      version  = "{{ versions.tf.latest }}"
      password = "user1user1"
    }
  
    resources {
      resource_preset_id = "{{ mrd-host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 16
    }
  
    host {
      shard_name = "shard1"
      subnet_id  = yandex_vpc_subnet.mysubnet.id
      zone       = "ru-central1-a"
      assign_public_ip = true
      replica_priority = 50
    }
  }
  
  resource "yandex_vpc_network" "mynet" { name = "mynet" }
  
  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  
  resource "yandex_vpc_security_group" "redis-sg" {
    name       = "redis-sg"
    network_id = yandex_vpc_network.mynet.id
  
    ingress {
      description    = "{{ VLK }}"
      port           = {{ port-mrd-tls }}
      protocol       = "TCP"
      v4_cidr_blocks = ["10.5.0.0/24"]
    }
  }
  ```


{% endlist %}

### Creating a sharded cluster with three shards {#creating-a-sharded-cluster}


{% list tabs group=instructions %}

- {{ TF }} {#tf}

    Create a [sharded](../concepts/sharding.md) {{ mrd-name }} cluster with the following test specifications:

    * Name: `myredis`.
    * Version: `{{ versions.tf.latest }}`.
    * Environment: `PRODUCTION`.
    * Cloud ID: `{{ tf-cloud-id }}`.
    * Folder ID: `{{ tf-folder-id }}`.
    * New `mynet` network.
    * Three subnets in the `mynet` network, one in each availability zone:
      * `subnet-a` with the `10.1.0.0/24` range
      * `subnet-b` with the `10.2.0.0/24` range
      * `subnet-d` with the `10.3.0.0/24` range
    * Three `{{ mrd-host-class }}` class hosts, one in each subnet.
    * New `redis-sg` security group allowing connections via ports `{{ port-mrd }}` and `{{ port-mrd-sentinel }}` ([{{ VLK }} Sentinel](./connect/index.md)) from any subnet addresses.
    * Network SSD storage (`{{ disk-type-example }}`): 16 GB.
    * Password: `user1user1`.
    * Deletion protection: Enabled.

    The configuration file for this cluster looks like this:

    
    ```hcl
    resource "yandex_mdb_redis_cluster" "myredis" {
      name                = "myredis"
      environment         = "PRODUCTION"
      network_id          = yandex_vpc_network.mynet.id
      security_group_ids  = [yandex_vpc_security_group.redis-sg.id]
      sharded             = true
      deletion_protection = true

      config {
        password = "user1user1"
        version  = "{{ versions.tf.latest }}"
      }

      resources {
        resource_preset_id = "{{ mrd-host-class }}"
        disk_type_id       = "{{ disk-type-example }}"
        disk_size          = 16
      }

      host {
        zone       = "{{ region-id }}-a"
        subnet_id  = yandex_vpc_subnet.subnet-a.id
        shard_name = "shard1"
      }

      host {
        zone       = "{{ region-id }}-b"
        subnet_id  = yandex_vpc_subnet.subnet-b.id
        shard_name = "shard2"
      }

      host {
        zone       = "{{ region-id }}-d"
        subnet_id  = yandex_vpc_subnet.subnet-d.id
        shard_name = "shard3"
      }
    }

    resource "yandex_vpc_network" "mynet" { name = "mynet" }

    resource "yandex_vpc_subnet" "subnet-a" {
      name           = "subnet-a"
      zone           = "{{ region-id }}-a"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.1.0.0/24"]
    }

    resource "yandex_vpc_subnet" "subnet-b" {
      name           = "subnet-b"
      zone           = "{{ region-id }}-b"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.2.0.0/24"]
    }

    resource "yandex_vpc_subnet" "subnet-d" {
      name           = "subnet-d"
      zone           = "{{ region-id }}-d"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.3.0.0/24"]
    }

    resource "yandex_vpc_security_group" "redis-sg" {
      name       = "redis-sg"
      network_id = yandex_vpc_network.mynet.id

      ingress {
        description    = "{{ VLK }}"
        port           = {{ port-mrd }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }

      ingress {
        description    = "{{ VLK }} Sentinel"
        port           = {{ port-mrd-sentinel }}
        protocol       = "TCP"
        v4_cidr_blocks = [
          "10.1.0.0/24",
          "10.2.0.0/24",
          "10.3.0.0/24"
        ]
      }
    }
    ```


{% endlist %}
