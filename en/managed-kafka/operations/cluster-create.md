# Creating an {{ KF }} cluster


A [{{ mkf-name }} cluster](../concepts/index.md) consists of one or more [broker hosts](../concepts/brokers.md) that hold [topics and their partitions](../concepts/topics.md). [Producers and consumers](../concepts/producers-consumers.md) can work with these topics by connecting to {{ mkf-name }} cluster hosts.

{% note info %}

The available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

{% endnote %}

## Differences in configurations of clusters with {{ ZK }} and clusters that use the {{ kraft-name }} protocol {#zk-vs-kraft}

{% include [zk-vs-kraft](../../_includes/mdb/mkf/zk-vs-kraft.md) %}


## Getting started {#before-you-begin}

1. Calculate the [minimum storage size](../concepts/storage.md#minimal-storage-size) for topics.
1. [Assign](../../iam/operations/roles/grant.md) the following roles to your {{ yandex-cloud }} account:
   * [{{ roles.mkf.editor }} or higher](../security/index.md#roles-list): To create a cluster.
   * [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user): To use the cluster [network](../../vpc/concepts/network.md#network).
   * [kms.keys.user](../../kms/security/index.md#kms-keys-user): To manage [disk encryption](../concepts/storage.md#disk-encryption).

If you specify security group IDs when creating a {{ mkf-name }} cluster, you may also need to [configure security groups](connect/index.md#configuring-security-groups) to connect to the cluster.


## Creating a cluster with {{ ZK }} {#create-cluster}

{% note warning %}

When creating a cluster with {{ ZK }}, do not specify the {{ kraft-short-name }} settings.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To create a {{ mkf-name }} cluster:

  1. In the [management console]({{ link-console-main }}), go to the appropriate [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:
     1. Enter a name and description for the {{ mkf-name }} cluster. The {{ mkf-name }} cluster name must be unique within the folder.
     1. {% include notitle [env](../../_includes/mdb/mkf/create-cluster.md#environment) %}
     1. Select the {{ KF }} version.
  1. {% include notitle [broker-class](../../_includes/mdb/mkf/create-cluster.md#broker-class) %}
     
  1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**:
     * Select the disk type.

       {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

       {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

       You cannot change the disk type for a {{ mkf-name }} cluster once the cluster is created.
     * Select the storage size to use for data.

  
  1. Under **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**, set the storage [utilization thresholds](../concepts/storage.md#auto-rescale) that will trigger storage expansion when reached:

     {% include [autoscale-settings](../../_includes/mdb/mkf/autoscale-settings.md) %}

  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**:
     1. Select one or more availability zones to place your {{ KF }} broker hosts in.

        {% include notitle [note-warning](../../_includes/mdb/mkf/create-cluster.md#note-warning) %}

     1. Select the [network](../../vpc/concepts/network.md#network).
     1. Select [subnets](../../vpc/concepts/network.md#subnet) in each availability zone for this network. To [create a new subnet](../../vpc/operations/subnet-create.md), click **{{ ui-key.yacloud.common.create }}** next to the availability zone in question.

        {% note info %}

        For an {{ KF }} cluster with multiple broker hosts, specify subnets in each availability zone even if you plan to place broker hosts only in some of them. You need these subnets to deploy three [{{ ZK }}](../concepts/index.md) hosts, one per availability zone. For more information, see [Resource relationships](../concepts/index.md).

        {% endnote %}

     1. Select [security groups](../../vpc/concepts/security-groups.md) for the {{ mkf-name }} cluster's network traffic.
     1. To enable internet access to broker hosts, select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**. In this case, you can only connect to them using SSL. For more information, see [Connecting to topics in a cluster](connect/clients.md).


  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**:
     1. Specify the number of {{ KF }} broker hosts to place in each of the selected availability zones.

        When selecting the number of hosts, consider the following:
        * If you add more than one host to the cluster, the system automatically adds three {{ ZK }} hosts.
        * You need at least two hosts to enable replication in a {{ mkf-name }} cluster.
        * High availability of a {{ mkf-name }} cluster depends on meeting [specific conditions](../concepts/ha-cluster.md).
    
     1. Select **{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-zookeeper_pN7ub }}** as the coordination service.

  1. If you specified more than one broker host, under **{{ ui-key.yacloud.kafka.section_zookeeper-resources }}**, specify the properties of the [{{ ZK }} hosts](../concepts/index.md) to place in each of the selected availability zones.
  1. Specify additional {{ mkf-name }} cluster settings, if required:

     {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

  1. Configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings), if required.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. {% include notitle [env](../../_includes/mdb/mkf/create-cluster.md#status) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ mkf-name }} cluster:

  1. View the description of the CLI command to create a {{ mkf-name }} cluster:

     ```bash
     {{ yc-mdb-kf }} cluster create --help
     ```

  1. Specify the {{ mkf-name }} cluster parameters in the create command (not all parameters are given in the example):

     
     ```bash
     {{ yc-mdb-kf }} cluster create \
        --name <cluster_name> \
        --environment <environment> \
        --version <version> \
        --schema-registry \
        --network-name <network_name> \
        --subnet-ids <subnet_IDs> \
        --zone-ids <availability_zones> \
        --brokers-count <number_of_broker_hosts_in_zone> \
        --resource-preset <host_class> \
        --disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --disk-size <storage_size_in_GB> \
        --assign-public-ip <enable_public_access_to_cluster> \
        --security-group-ids <list_of_security_group_IDs> \
        --deletion-protection \
        --kafka-ui-enabled <true_or_false> \
        --disk-encryption-key-id <KMS_key_ID>
     ```


     Where:

     * `--environment`: Cluster environment, `prestable` or `production`.
     * `--version`: {{ KF }} version, {{ versions.cli.str }}. Additionally, provide the [{{ ZK }} host configuration](../concepts/index.md#zookeeper).
     * `--schema-registry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md).

         {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

     * `--zone-ids` and `--brokers-count`: Availability zones and number of broker hosts per zone.
     * `--resource-preset`: [Host class](../concepts/instance-types.md).
     * `--disk-type`: [Disk type](../concepts/storage.md).

        {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

     * {% include [deletion-protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}

     
     * {% include [kafka-ui-enabled](../../_includes/mdb/cli/kafka-ui-enabled.md) %}
     * {% include [disk-encryption-key-id-kafka](../../_includes/mdb/cli/disk-encryption-key-id-kafka.md) %}


     {% note tip %}

     You can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here, if required.

     {% endnote %}

  1. To use {{ ZK }} in your cluster, provide the [{{ ZK }} host configuration](../concepts/index.md#zookeeper):
       
     ```bash
     {{ yc-mdb-kf }} cluster create \
         ...
         --zookeeper-resource-preset <host_class> \
         --zookeeper-disk-size <storage_size_in_GB> \
         --zookeeper-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
         ...

     ```

     Where:
     * `--zookeeper-resource-preset`: {{ ZK }} [host class](../concepts/instance-types.md).
     * `--zookeeper-disk-size`: Storage size.
     * `--zookeeper-disk-type`: {{ ZK }} [disk type](../concepts/storage.md).
  
  1. {% include notitle [maintenance](../../_includes/mdb/mkf/create-cluster.md#maintenance) %}

  1. {% include notitle [auto-rescale](../../_includes/mdb/mkf/create-cluster.md#auto-rescale) %}


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a {{ mkf-name }} cluster:
  1. In the configuration file, describe the resources you are creating:
     * {{ mkf-name }} cluster: Description of the cluster and its hosts. You can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here, if required.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Here is a configuration file example:

     
     ```hcl
     resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
       environment            = "<environment>"
       name                   = "<cluster_name>"
       network_id             = "<network_ID>"
       subnet_ids             = ["<list_of_subnet_IDs>"]
       security_group_ids     = ["<list_of_cluster_security_group_IDs>"]
       deletion_protection    = <protect_cluster_against_deletion>

       config {
         version          = "<version>"
         zones            = ["<availability_zones>"]
         brokers_count    = <number_of_broker_hosts>
         assign_public_ip = "<enable_public_access_to_cluster>"
         schema_registry  = "<enable_data_schema_management>"
         kafka_ui {
           enabled = <use_Kafka_UI>
         }
         kafka {
           resources {
             disk_size          = <storage_size_in_GB>
             disk_type_id       = "<disk_type>"
             resource_preset_id = "<host_class>"
           }
           kafka_config {}
         }
       }
     }

     resource "yandex_vpc_network" "<network_name>" {
       name = "<network_name>"
     }

     resource "yandex_vpc_subnet" "<subnet_name>" {
       name           = "<subnet_name>"
       zone           = "<availability_zone>"
       network_id     = "<network_ID>"
       v4_cidr_blocks = ["<range>"]
     }
     ```


     Where:

     * `environment`: Cluster environment, `PRESTABLE` or `PRODUCTION`.
     * `version`: {{ KF }} version, {{ versions.tf.str }}. Additionally, provide the [{{ ZK }} host configuration](../concepts/index.md#zookeeper).
     * `zones` and `brokers_count`: Availability zones and number of broker hosts per zone.
     * `deletion_protection`: Cluster protection against accidental deletion, `true` or `false`.

       {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}

     
     * `disk_encryption_key_id`: Disk encryption with a [custom KMS key](../../kms/concepts/key.md). Provide the KMS key ID to encrypt the disk. To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).
     * `assign_public_ip`: Public access to the cluster, `true` or `false`.


     * `schema_registry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), `true` or `false`. The default value is `false`.

       {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

       

     * `kafka_ui`: This setting defines whether to use [{{ kafka-ui }} for {{ KF }}](../concepts/kafka-ui.md) and can be `true` or `false`. The default value is `false`.


     To use {{ ZK }} in the cluster, add the `zookeeper` section to the cluster description:

     ```hcl
     resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
       ...
       zookeeper {
         resources {
           resource_preset_id = "<host_class>"
           disk_type_id       = "<disk_type>"
           disk_size          = <storage_size_in_GB>
         }
       }
     }
     ```

     {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

     
     {% include [disk-encryption-key](../../_includes/mdb/mkf/terraform/disk-encryption-key.md) %}


  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a {{ mkf-name }} cluster.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     This will create all the resources you need in the specified folder, and the terminal will display the [FQDNs of the {{ mkf-name }} cluster hosts](../concepts/network.md#hostname). You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.create](../api-ref/Cluster/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        1. Create a file named `body.json` and paste the following code into it:

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
                "version": "<{{ KF }}_version>",
                "kafka": {
                  "resources": {
                    "resourcePresetId": "<{{ KF }}_host_class>",
                    "diskSize": "<storage_size_in_bytes>",
                    "diskTypeId": "<disk_type>"
                  }
                },
                "zookeeper": {
                  "resources": {
                    "resourcePresetId": "<{{ ZK }}_host_class>",
                    "diskSize": "<storage_size_in_bytes>",
                    "diskTypeId": "<disk_type>"                   
                  }
                },
                "zoneId": [
                  <list_of_availability_zones>
                ],
                "brokersCount": "<number_of_brokers_in_zone>",
                "assignPublicIp": <enable_public_access_to_cluster>,
                "schemaRegistry": <enable_data_schema_management>,
                "restApiConfig": {
                  "enabled": <enable_sending_requests_to_{{ KF }}_API>
                },
                "diskSizeAutoscaling": {
                  <automatic_storage_expansion_parameters>
                },
                "kafkaUiConfig": {
                  "enabled": <use_Kafka_UI>
                }
              },
              "topicSpecs": [
                {
                  "name": "<topic_name>",
                  "partitions": "<number_of_partitions>",
                  "replicationFactor": "<replication_factor>"
                },
                { <similar_settings_for_topic_2> },
                { ... },
                { <similar_settings_for_topic_N> }
              ],
              "userSpecs": [
                {
                  "name": "<username>",
                  "password": "<user_password>",
                  "permissions": [
                    {
                      "topicName": "<topic_name>",
                      "role": "<user's_role>"
                    }
                  ]
                },
                { <similar_settings_for_user_2> },
                { ... },
                { <similar_settings_for_user_N> }
              ],
              "maintenanceWindow": {
                "anytime": {},
                "weeklyMaintenanceWindow": {
                  "day": "<day_of_week>",
                  "hour": "<hour_UTC>"
                }
              },
              "deletionProtection": <protect_cluster_against_deletion>,
              "diskEncryptionKeyId": "<KMS_key_ID>"
            }
            ```


            Where:

            * `name`: Cluster name.
            * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
            * `networkId`: ID of the [network](../../vpc/concepts/network.md) where the cluster will be deployed.

            
            * `securityGroupIds`: [Security group](../../vpc/concepts/security-groups.md) IDs as an array of strings. Each string is a security group ID.


            * `configSpec`: Cluster configuration:

                * `version`: {{ KF }} version, {{ versions.cli.str }}. Additionally, provide the [{{ ZK }} host configuration](../concepts/index.md#zookeeper).
                * `kafka`: {{ KF }} configuration:

                    * `resources.resourcePresetId`: [Host class](../concepts/instance-types.md) ID. You can get the list of available host classes with their IDs by calling the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method.
                    * `resources.diskSize`: Disk size, in bytes.
                    * `resources.diskTypeId`: [Disk type](../concepts/storage.md).

                * `zookeeper`: {{ ZK }} configuration:

                    * `resources.resourcePresetId`: Host class ID. You can get the list of available host classes with their IDs using the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method.
                    * `resources.diskSize`: Disk size, in bytes.
                    * `resources.diskTypeId`: Disk type.


                * `zoneId` and `brokersCount`: Availability zones and number of broker hosts per zone.

                
                * `assignPublicIp`: Access to broker hosts from the internet, `true` or `false`.


                * `schemaRegistry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), `true` or `false`. The default value is `false`. You will not be able to edit this setting once you create the {{ mkf-name }} cluster.
                * `restApiConfig`: {{ KF }} REST API configuration. To enable sending {{ KF }} REST API requests, specify `enabled: true`.
                * `diskSizeAutoscaling`: Storage [utilization thresholds](../concepts/storage.md#auto-rescale) (as a percentage of the total storage size) that will trigger storage expansion when reached:

                  {% include [autoscale-settings](../../_includes/mdb/mkf/api/rest-autoscale-settings.md) %}

                
                * `kafkaUiConfig`: Use [{{ kafka-ui }}](../concepts/kafka-ui.md). For access to {{ kafka-ui }}, specify `enabled: true`.


            * `topicSpecs`: Topic settings as an array of elements, one per topic. Each element has the following structure:

                {% include [rest-topic-specs](../../_includes/mdb/mkf/api/rest-topic-specs.md) %}

            * `userSpecs`: User settings as an array of elements, one per user. Each element has the following structure:

                {% include [rest-user-specs](../../_includes/mdb/mkf/api/rest-user-specs.md) %}

            * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings, including for stopped clusters. Select one of these options:

                * `anytime`: Any time (default).
                * `weeklyMaintenanceWindow`: On schedule:
                    * `day`: Day of week in `DDD` format, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                    * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

            * `deletionProtection`: Cluster protection against accidental deletion, `true` or `false`. The default value is `false`.

                {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}

            
            * `diskEncryptionKeyId`: ID of the [custom KMS key](../../kms/concepts/key.md). Provide the KMS key ID to encrypt the disks. To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).

              {% note warning %}
                  
              You can enable disk encryption only when creating a cluster.
                  
              {% endnote %}


            
            You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. Run this request:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters' \
              --data '@body.json'
            ```

    1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService/Create](../api-ref/grpc/Cluster/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        1. Create a file named `body.json` and paste the following code into it:

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
                "version": "<{{ KF }}_version>",
                "kafka": {
                  "resources": {
                    "resource_preset_id": "<{{ KF }}_host_class>",
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
                "zone_id": [
                  <list_of_availability_zones>
                ],
                "brokers_count": {
                  "value": "<number_of_brokers_in_zone>"
                },
                "assign_public_ip": <enable_public_access_to_cluster>,
                "schema_registry": <enable_data_schema_management>,
                "rest_api_config": {
                  "enabled": <enable_sending_requests_to_{{ KF }}_API>
                },
                "disk_size_autoscaling": {
                  <automatic_storage_size_increase_parameters>
                },
                "kafka_ui_config": {
                  "enabled": <use_Kafka_UI>
                }
              },
              "topic_specs": [
                {
                  "name": "<topic_name>",
                  "partitions": {
                    "value": "<number_of_partitions>"
                  },
                  "replication_factor": {
                    "value": "<replication_factor>"
                  }
                },
                { <similar_settings_for_topic_2> },
                { ... },
                { <similar_settings_for_topic_N> }
              ],
              "user_specs": [
                {
                  "name": "<username>",
                  "password": "<user_password>",
                  "permissions": [
                    {
                      "topic_name": "<topic_name>",
                      "role": "<user's_role>"
                    }
                  ]
                },
                { <similar_settings_for_user_2> },
                { ... },
                { <similar_settings_for_user_N> }
              ],
              "maintenance_window": {
                "anytime": {},
                "weekly_maintenance_window": {
                  "day": "<day_of_week>",
                  "hour": "<hour_UTC>"
                }
              },
              "deletion_protection": <protect_cluster_against_deletion>,
              "disk_encryption_key_id": "<KMS_key_ID>"
            }
            ```


            Where:

            * `name`: Cluster name.
            * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
            * `network_id`: ID of the [network](../../vpc/concepts/network.md) where the cluster will be deployed.

            
            * `security_group_ids`: [Security group](../../vpc/concepts/security-groups.md) IDs as an array of strings. Each string is a security group ID.


            * `config_spec`: Cluster configuration:

                * `version`: {{ KF }} version, {{ versions.cli.str }}. Additionally, provide the [{{ ZK }} host configuration](../concepts/index.md#zookeeper).
                * `kafka`: {{ KF }} configuration:

                    * `resources.resource_preset_id`: [Host class](../concepts/instance-types.md) ID. You can get the list of available host classes with their IDs by calling the [ResourcePreset.list](../api-ref/grpc/ResourcePreset/list.md) method.
                    * `resources.disk_size`: Disk size, in bytes.
                    * `resources.disk_type_id`: [Disk type](../concepts/storage.md).

                * `zookeeper`: {{ ZK }} configuration:

                    * `resources.resource_preset_id`: Host class ID. You can get the list of available host classes with their IDs by calling the [ResourcePreset.list](../api-ref/grpc/ResourcePreset/list.md) method.
                    * `resources.disk_size`: Disk size, in bytes.
                    * `resources.disk_type_id`: Disk type.


                * `zone_id` and `brokers_count`: Availability zones and number of broker hosts (provided as an object with the `value` field) per zone.

                
                * `assign_public_ip`: Access to broker hosts from the internet, `true` or `false`.


                * `schema_registry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), `true` or `false`. The default value is `false`. You will not be able to edit this setting once you create the {{ mkf-name }} cluster.
                * `rest_api_config`: {{ KF }} REST API configuration. To enable sending {{ KF }} REST API requests, specify `enabled: true`.
                * `disk_size_autoscaling`: To prevent the cluster disk space from running out, set the storage [utilization thresholds](../concepts/storage.md#auto-rescale) (as a percentage of the total storage size) that will trigger storage expansion when reached:

                  {% include [autoscale-settings](../../_includes/mdb/mkf/api/grpc-autoscale-settings.md) %}

                  

                * `kafka_ui_config`: Use [{{ kafka-ui }}](../concepts/kafka-ui.md). For access to {{ kafka-ui }}, specify `enabled: true`.


            * `topic_specs`: Topic settings as an array of elements. Each element is for a separate topic and has the following structure:

                {% include [grpc-topic-specs](../../_includes/mdb/mkf/api/grpc-topic-specs.md) %}

            * `user_specs`: User settings as an array of elements, one per user. Each element has the following structure:

                {% include [rest-user-specs](../../_includes/mdb/mkf/api/grpc-user-specs.md) %}

            * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings, including for stopped clusters. Select one of these options:

                * `anytime`: Any time (default).
                * `weekly_maintenance_window`: On schedule:
                    * `day`: Day of week in `DDD` format, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                    * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

            * `deletion_protection`: Cluster protection against accidental deletion, `true` or `false`. The default value is `false`.

                {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}
            
            
            * `disk_encryption_key_id`: ID of the [custom KMS key](../../kms/concepts/key.md). Provide the KMS key ID to encrypt the disks. To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).

              {% note warning %}
                  
              You can enable disk encryption only when creating a cluster.
                  
              {% endnote %}


            
            You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. Run this request:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters' \
              --data '@body.json'
            ```

    1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Creating a cluster with {{ kraft-short-name }} {#create-cluster-kraft}

{% note warning %}

When creating a cluster with {{ kraft-short-name }}, do not specify the {{ ZK }} settings.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To create a {{ mkf-name }} cluster:

  1. In the [management console]({{ link-console-main }}), go to the appropriate [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:
     1. Enter a name and description for the {{ mkf-name }} cluster. The {{ mkf-name }} cluster name must be unique within the folder.
     1. {% include notitle [env](../../_includes/mdb/mkf/create-cluster.md#environment) %}

     1. Select {{ KF }} 3.6 or higher.
  1. {% include notitle [broker-class](../../_includes/mdb/mkf/create-cluster.md#broker-class) %}

  1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**:
     * Select the disk type.

       {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

       {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

       You cannot change the disk type for a {{ mkf-name }} cluster once the cluster is created.
     * Select the storage size to use for data.

  
  1. Under **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**, set the storage [utilization thresholds](../concepts/storage.md#auto-rescale) that will trigger storage expansion when reached:

     {% include [autoscale-settings](../../_includes/mdb/mkf/autoscale-settings.md) %}

  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**:
     1. Select one or more availability zones to place your {{ KF }} broker hosts in.
        
        {% include notitle [note-warning](../../_includes/mdb/mkf/create-cluster.md#note-warning) %}

     1. Select the [network](../../vpc/concepts/network.md#network).
     1. Select [subnets](../../vpc/concepts/network.md#subnet) in each availability zone for this network. To [create a new subnet](../../vpc/operations/subnet-create.md), click **{{ ui-key.yacloud.common.create }}** next to the availability zone in question.

        {% note info %}

        For an {{ KF }} cluster with multiple broker hosts, specify subnets in each availability zone even if you plan to place broker hosts only in some of them. You need these subnets to deploy three [{{ kraft-short-name }} hosts](../concepts/index.md), one per availability zone. For more information, see [Resource relationships](../concepts/index.md).

        {% endnote %}

     1. Select [security groups](../../vpc/concepts/security-groups.md) for the {{ mkf-name }} cluster's network traffic.
     1. To enable internet access to broker hosts, select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**. In this case, you can only connect to them using SSL. For more information, see [Connecting to topics in a cluster](connect/clients.md).


  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**:

     1. Specify the number of {{ KF }} broker hosts to place in each of the selected availability zones.

        When selecting the number of hosts, consider the following:
        * You cannot set the number of broker hosts manually if using [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}](../concepts/kraft.md#cluster-topology) as the coordination service.
        * You need to set the number of brokers manually if using [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-split-mode_sbrDd }}](../concepts/kraft.md#cluster-topology) as the coordination service. A new multi-host cluster will automatically get three dedicated {{ kraft-short-name }} hosts.
        * You need at least two hosts to enable replication in a {{ mkf-name }} cluster.
        * High availability of a {{ mkf-name }} cluster depends on meeting specific conditions.
      
     1. Under **{{ ui-key.yacloud.kafka.FormSections.field_coordination-service-type_sdoRj }}**, select one of these options:
        * **{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-split-mode_sbrDd }}**: Broker and {{ kraft-short-name }} metadata controller are on separate hosts.
        
        * **{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}**: One {{ KF }} host accommodates a broker and a {{ kraft-short-name }} metadata controller at the same time.

          You can create a cluster either in one or in three [availability zones](../../overview/concepts/geo-scope.md):
            * One availability zone: Three broker hosts.
            * Three availability zones: One broker host in each availability zone.

          You cannot set the number of broker hosts manually.

  1. If you specified more than one broker host, under **{{ ui-key.yacloud.kafka.section_kraft-resources }}**, specify the properties of the [{{ kraft-short-name }}](../concepts/index.md) hosts to place in each of the selected availability zones.
  1. Specify additional {{ mkf-name }} cluster settings, if required:

     {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

  1. Configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings), if required.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. {% include notitle [env](../../_includes/mdb/mkf/create-cluster.md#status) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a {{ mkf-name }} cluster:

  1. View the description of the CLI command to create a {{ mkf-name }} cluster:

     ```bash
     {{ yc-mdb-kf }} cluster create --help
     ```

  1. Specify the {{ mkf-name }} cluster parameters in the create command (not all parameters are given in the example):

     
     ```bash
     {{ yc-mdb-kf }} cluster create \
        --name <cluster_name> \
        --environment <environment> \
        --version <version> \
        --schema-registry \
        --network-name <network_name> \
        --subnet-ids <subnet_IDs> \
        --resource-preset <host_class> \
        --disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --disk-size <storage_size_in_GB> \
        --assign-public-ip <enable_public_access_to_cluster> \
        --security-group-ids <list_of_security_group_IDs> \
        --deletion-protection \
        --kafka-ui-enabled <true_or_false> \
        --disk-encryption-key-id <KMS_key_ID>
     ```


     Where:

     * `--environment`: Cluster environment, `prestable` or `production`.
     * `--version`: {{ KF }} version. Specify 3.6 or higher.
     * `--schema-registry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md).

         {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}
    
     * `--zone-ids` and `--brokers-count`: Availability zones and number of broker hosts per zone. 
     
       If you are creating a cluster with [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}](../concepts/kraft.md#cluster-topology), specify one of the available configurations:

       * `--zone-ids={{ region-id }}-a,{{ region-id }}-b,{{ region-id }}-d --brokers-count=1`: Three availability zones with one broker host per zone.
       * `--zone-ids=<one_availability_zone> --brokers-count=3`: One availability zone with three broker hosts.

     * `--resource-preset`: [Host class](../concepts/instance-types.md).
     * `--disk-type`: [Disk type](../concepts/storage.md).

        {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

     * {% include [deletion-protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}

     
     * {% include [kafka-ui-enabled](../../_includes/mdb/cli/kafka-ui-enabled.md) %}
     * {% include [disk-encryption-key-id-kafka](../../_includes/mdb/cli/disk-encryption-key-id-kafka.md) %}


     {% note tip %}

     You can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here, if required.

     {% endnote %}
  
  1. To use [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-split-mode_sbrDd }}](../concepts/kraft.md#cluster-topology), provide the {{ kraft-short-name }} host configuration.
       
     ```bash
     {{ yc-mdb-kf }} cluster create \
         ...
         --controller-resource-preset <host_class> \
         --controller-disk-size <storage_size_in_GB> \
         --controller-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
         ...

     ```

     Where:
     * `--controller-resource-preset`: {{ kraft-short-name }} [host class](../concepts/instance-types.md).
     * `--controller-disk-size`: Storage size.
     * `--controller-disk-type`: {{ kraft-short-name }} [disk type](../concepts/storage.md).

  1. {% include notitle [maintenance](../../_includes/mdb/mkf/create-cluster.md#maintenance) %}

  1. {% include notitle [auto-rescale](../../_includes/mdb/mkf/create-cluster.md#auto-rescale) %}


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a {{ mkf-name }} cluster:
  1. In the configuration file, describe the resources you are creating:
     * {{ mkf-name }} cluster: Description of the cluster and its hosts. You can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here, if required.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Here is a configuration file example:

     
     ```hcl
     resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
       environment         = "<environment>"
       name                = "<cluster_name>"
       network_id          = "<network_ID>"
       subnet_ids          = ["<list_of_subnet_IDs>"]
       security_group_ids  = ["<list_of_cluster_security_group_IDs>"]
       deletion_protection = <protect_cluster_against_deletion>

       config {
         version          = "<version>"
         zones            = ["<availability_zones>"]
         brokers_count    = <number_of_broker_hosts>
         assign_public_ip = "<enable_public_access_to_cluster>"
         schema_registry  = "<enable_data_schema_management>"
         kafka_ui {
           enabled = <use_Kafka_UI>
         }
         kafka {
           resources {
             disk_size          = <storage_size_in_GB>
             disk_type_id       = "<disk_type>"
             resource_preset_id = "<host_class>"
           }
           kafka_config {}
         }
       }
     }

     resource "yandex_vpc_network" "<network_name>" {
       name = "<network_name>"
     }

     resource "yandex_vpc_subnet" "<subnet_name>" {
       name           = "<subnet_name>"
       zone           = "<availability_zone>"
       network_id     = "<network_ID>"
       v4_cidr_blocks = ["<range>"]
     }
     ```


     Where:

     * `environment`: Cluster environment, `PRESTABLE` or `PRODUCTION`.
     * `version`: {{ KF }} version. Specify 3.6 or higher.
     * `zones` and `brokers_count`: Availability zones and number of broker hosts per zone.

       If you are creating a cluster with [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}](../concepts/kraft.md#cluster-topology), specify one of the available configurations:

       * `zones = ["{{ region-id }}-a","{{ region-id }}-b","{{ region-id }}-d"] brokers_count = 1`: Three availability zones with one broker host per zone.
       * `zones = ["<one_availability_zone>"] brokers_count = 3`: One availability zone with three broker hosts.

     * `deletion_protection`: Cluster protection against accidental deletion, `true` or `false`.

       {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}

     
     * `assign_public_ip`: Public access to the cluster, `true` or `false`.


     * `schema_registry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), `true` or `false`. The default value is `false`.

       {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

       

     * `kafka_ui`: This setting defines whether to use [{{ kafka-ui }} for {{ KF }}](../concepts/kafka-ui.md) and can be `true` or `false`. The default value is `false`.


     Add the `kraft` section to the cluster description to use [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-split-mode_sbrDd }}](../concepts/kraft.md#cluster-topology).

     ```hcl
     resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
       ...
       kraft {
         resources {
           resource_preset_id = "<host_class>"
           disk_type_id       = "<disk_type>"
           disk_size          = <storage_size_in_GB>
         }
       }
     }
     ```

     {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

     
     {% include [disk-encryption-key](../../_includes/mdb/mkf/terraform/disk-encryption-key.md) %}


  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a {{ mkf-name }} cluster.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     This will create all the resources you need in the specified folder, and the terminal will display the [FQDNs of the {{ mkf-name }} cluster hosts](../concepts/network.md#hostname). You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.create](../api-ref/Cluster/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        1. Create a file named `body.json` and paste the following code into it:

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
                "version": "<{{ KF }}_version>",
                "kafka": {
                  "resources": {
                    "resourcePresetId": "<{{ KF }}_host_class>",
                    "diskSize": "<storage_size_in_bytes>",
                    "diskTypeId": "<disk_type>"
                  }
                },
                "kraft": {
                  "resources": {
                    "resourcePresetId": "<{{ kraft-short-name }}_host_class>",
                    "diskSize": "<storage_size_in_bytes>",
                    "diskTypeId": "<disk_type>"                   
                  }
                },
                "zoneId": [
                  <list_of_availability_zones>
                ],
                "brokersCount": "<number_of_brokers_in_zone>",
                "assignPublicIp": <enable_public_access_to_cluster>,
                "schemaRegistry": <enable_data_schema_management>,
                "restApiConfig": {
                  "enabled": <enable_sending_requests_to_{{ KF }}_API>
                },
                "diskSizeAutoscaling": {
                  <automatic_storage_expansion_parameters>
                },
                "kafkaUiConfig": {
                  "enabled": <use_Kafka_UI>
                }
              },
              "topicSpecs": [
                {
                  "name": "<topic_name>",
                  "partitions": "<number_of_partitions>",
                  "replicationFactor": "<replication_factor>"
                },
                { <similar_settings_for_topic_2> },
                { ... },
                { <similar_settings_for_topic_N> }
              ],
              "userSpecs": [
                {
                  "name": "<username>",
                  "password": "<user_password>",
                  "permissions": [
                    {
                      "topicName": "<topic_name>",
                      "role": "<user's_role>"
                    }
                  ]
                },
                { <similar_settings_for_user_2> },
                { ... },
                { <similar_settings_for_user_N> }
              ],
              "maintenanceWindow": {
                "anytime": {},
                "weeklyMaintenanceWindow": {
                  "day": "<day_of_week>",
                  "hour": "<hour_UTC>"
                }
              },
              "deletionProtection": <protect_cluster_against_deletion>,
              "diskEncryptionKeyId": "<KMS_key_ID>"
            }
            ```


            Where:

            * `name`: Cluster name.
            * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
            * `networkId`: ID of the [network](../../vpc/concepts/network.md) where the cluster will be deployed.

            
            * `securityGroupIds`: [Security group](../../vpc/concepts/security-groups.md) IDs as an array of strings. Each string is a security group ID.


            * `configSpec`: Cluster configuration:

                * `version`: {{ KF }} version. Specify 3.6 or higher.
                * `kafka`: {{ KF }} configuration:

                    * `resources.resourcePresetId`: [Host class](../concepts/instance-types.md) ID. You can get the list of available host classes with their IDs by calling the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method.
                    * `resources.diskSize`: Disk size, in bytes.
                    * `resources.diskTypeId`: [Disk type](../concepts/storage.md).

                * `kraft`: [{{ kraft-short-name }}](../concepts/kraft.md) configuration:

                    * `resources.resourcePresetId`: Host class ID. You can get the list of available host classes with their IDs using the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method.
                    * `resources.diskSize`: Disk size, in bytes.
                    * `resources.diskTypeId`: Disk type.

                    {% include notitle [note-warning-combined-mode](../../_includes/mdb/mkf/create-cluster.md#note-warning-combined-mode) %}


                * `zoneId` and `brokersCount`: Availability zones and number of broker hosts per zone.

                  If you are creating a cluster with [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}](../concepts/kraft.md#cluster-topology), specify one of the available configurations:

                  * `"zoneId": ["{{ region-id }}-a","{{ region-id }}-b","{{ region-id }}-d"], "brokersCount": "1"`: Three availability zones with one broker host per zone.
                  * `"zoneId": ["<one_availability_zone>"], "brokersCount": "3"`: One availability zone with three broker hosts.

                
                * `assignPublicIp`: Access to broker hosts from the internet, `true` or `false`.


                * `schemaRegistry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), `true` or `false`. The default value is `false`. You will not be able to edit this setting once you create a {{ mkf-name }} cluster.
                * `restApiConfig`: {{ KF }} REST API configuration. For access to sending requests to the {{ KF }} REST API, specify `enabled: true`.
                * `diskSizeAutoscaling`: Storage [utilization thresholds](../concepts/storage.md#auto-rescale) (as a percentage of the total storage size) that will trigger storage expansion when reached:

                  {% include [autoscale-settings](../../_includes/mdb/mkf/api/rest-autoscale-settings.md) %}

                  

                * `kafkaUiConfig`: Use [{{ kafka-ui }}](../concepts/kafka-ui.md). For access to {{ kafka-ui }}, specify `enabled: true`.


            * `topicSpecs`: Topic settings as an array of elements, one per topic. Each element has the following structure:

                {% include [rest-topic-specs](../../_includes/mdb/mkf/api/rest-topic-specs.md) %}

            * `userSpecs`: User settings as an array of elements, one per user. Each element has the following structure:

                {% include [rest-user-specs](../../_includes/mdb/mkf/api/rest-user-specs.md) %}

            * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings, including for stopped clusters. Select one of these options:

                * `anytime`: At any time (default).
                * `weeklyMaintenanceWindow`: On schedule:
                    * `day`: Day of week in `DDD` format, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                    * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

            * `deletionProtection`: Cluster protection against accidental deletion, `true` or `false`. The default value is `false`.

                {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}
            
            
            * `diskEncryptionKeyId`: ID of the [custom KMS key](../../kms/concepts/key.md). Provide the KMS key ID to encrypt the disks. To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).

              {% note warning %}
                  
              You can enable disk encryption only when creating a cluster.
                  
              {% endnote %}


            
            You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. Run this request:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters' \
              --data '@body.json'
            ```

    1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService/Create](../api-ref/grpc/Cluster/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        1. Create a file named `body.json` and paste the following code into it:

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
                "version": "<{{ KF }}_version>",
                "kafka": {
                  "resources": {
                    "resource_preset_id": "<{{ KF }}_host_class>",
                    "disk_size": "<storage_size_in_bytes>",
                    "disk_type_id": "<disk_type>"
                  }
                },
                "kraft": {
                  "resources": {
                    "resource_preset_id": "<{{ kraft-short-name }}_host_class>",
                    "disk_size": "<storage_size_in_bytes>",
                    "disk_type_id": "<disk_type>"                   
                  }
                },
                "zone_id": [
                  <list_of_availability_zones>
                ],
                "brokers_count": {
                  "value": "<number_of_brokers_in_zone>"
                },
                "assign_public_ip": <enable_public_access_to_cluster>,
                "schema_registry": <enable_data_schema_management>,
                "rest_api_config": {
                  "enabled": <enable_sending_requests_to_{{ KF }}_API>
                },
                "disk_size_autoscaling": {
                  <automatic_storage_size_increase_parameters>
                },
                "kafka_ui_config": {
                  "enabled": <use_Kafka_UI>
                }
              },
              "topic_specs": [
                {
                  "name": "<topic_name>",
                  "partitions": {
                    "value": "<number_of_partitions>"
                  },
                  "replication_factor": {
                    "value": "<replication_factor>"
                  }
                },
                { <similar_settings_for_topic_2> },
                { ... },
                { <similar_settings_for_topic_N> }
              ],
              "user_specs": [
                {
                  "name": "<username>",
                  "password": "<user_password>",
                  "permissions": [
                    {
                      "topic_name": "<topic_name>",
                      "role": "<user's_role>"
                    }
                  ]
                },
                { <similar_settings_for_user_2> },
                { ... },
                { <similar_settings_for_user_N> }
              ],
              "maintenance_window": {
                "anytime": {},
                "weekly_maintenance_window": {
                  "day": "<day_of_week>",
                  "hour": "<hour_UTC>"
                }
              },
              "deletion_protection": <protect_cluster_against_deletion>,
              "disk_encryption_key_id": "<KMS_key_ID>"
            }
            ```


            Where:

            * `name`: Cluster name.
            * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
            * `network_id`: ID of the [network](../../vpc/concepts/network.md) where the cluster will be deployed.

            
            * `security_group_ids`: [Security group](../../vpc/concepts/security-groups.md) IDs as an array of strings. Each string is a security group ID.


            * `config_spec`: Cluster configuration:

                * `version`: {{ KF }} version. Specify 3.6 or higher.
                * `kafka`: {{ KF }} configuration:

                    * `resources.resource_preset_id`: [Host class](../concepts/instance-types.md) ID. You can get the list of available host classes with their IDs by calling the [ResourcePreset.list](../api-ref/grpc/ResourcePreset/list.md) method.
                    * `resources.disk_size`: Disk size, in bytes.
                    * `resources.disk_type_id`: [Disk type](../concepts/storage.md).

                * `kraft`: [{{ kraft-short-name }}](../concepts/kraft.md) configuration:

                    * `resources.resource_preset_id`: Host class ID. You can get the list of available host classes with their IDs by calling the [ResourcePreset.list](../api-ref/grpc/ResourcePreset/list.md) method.
                    * `resources.disk_size`: Disk size, in bytes.
                    * `resources.disk_type_id`: Disk type.
                    
                    {% include notitle [note-warning-combined-mode](../../_includes/mdb/mkf/create-cluster.md#note-warning-combined-mode) %}


                * `zone_id` and `brokers_count`: Availability zones and number of broker hosts (provided as an object with the `value` field) per zone.

                  If you are creating a cluster with [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}](../concepts/kraft.md#cluster-topology), specify one of the available configurations:

                  * `"zone_id": ["{{ region-id }}-a","{{ region-id }}-b","{{ region-id }}-d"], "brokers_count": {"value":"1"}`: Three availability zones with one broker host per zone.
                  * `"zone_id": ["<one_availability_zone>"], "brokers_count": {"value":"3"}`: One availability zone with three broker hosts.

                
                * `assign_public_ip`: Access to broker hosts from the internet, `true` or `false`.


                * `schema_registry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), `true` or `false`. The default value is `false`. You will not be able to edit this setting once you create the {{ mkf-name }} cluster.
                * `rest_api_config`: {{ KF }} REST API configuration. For access to sending requests to the {{ KF }} REST API, specify `enabled: true`.
                * `disk_size_autoscaling`: To prevent the cluster disk space from running out, set the storage [utilization thresholds](../concepts/storage.md#auto-rescale) (as a percentage of the total storage size) that will trigger storage expansion when reached:

                  {% include [autoscale-settings](../../_includes/mdb/mkf/api/grpc-autoscale-settings.md) %}

                  

                * `kafka_ui_config`: Use [{{ kafka-ui }}](../concepts/kafka-ui.md). For access to {{ kafka-ui }}, specify `enabled: true`.


            * `topic_specs`: Topic settings as an array of elements. Each element is for a separate topic and has the following structure:

                {% include [grpc-topic-specs](../../_includes/mdb/mkf/api/grpc-topic-specs.md) %}

            * `user_specs`: User settings as an array of elements, one per user. Each element has the following structure:

                {% include [rest-user-specs](../../_includes/mdb/mkf/api/grpc-user-specs.md) %}

            * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings, including for stopped clusters. Select one of these options:

                * `anytime`: At any time (default).
                * `weekly_maintenance_window`: On schedule:
                    * `day`: Day of week in `DDD` format, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                    * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

            * `deletion_protection`: Cluster protection against accidental deletion, `true` or `false`. The default value is `false`.

                {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}
            
            
            * `disk_encryption_key_id`: ID of the [custom KMS key](../../kms/concepts/key.md). Provide the KMS key ID to encrypt the disks. To learn more about disk encryption, see [Storage](../concepts/storage.md#disk-encryption).

              {% note warning %}
                  
              You can enable disk encryption only when creating a cluster.
                  
              {% endnote %}


            
            You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. Run this request:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters' \
              --data '@body.json'
            ```

    1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Creating a cluster copy {#duplicate}

You can create an {{ KF }} cluster with the settings of another one created earlier. To do this, import the original {{ KF }} cluster configuration to {{ TF }}. Then you can either create an identical copy or use the imported configuration as the baseline and modify it as needed. The import feature is useful when you need to replicate an {{ KF }} cluster with multiple settings.

To create an {{ KF }} cluster copy:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. In the same working directory, place a `.tf` file with the following contents:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "old" { }
        ```

    1. Save the ID of the original {{ KF }} cluster to an environment variable:

        ```bash
        export KAFKA_CLUSTER_ID=<cluster_ID>
        ```

        You can get the ID with the [list of clusters in the folder](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Import the original {{ KF }} cluster settings to the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_kafka_cluster.old ${KAFKA_CLUSTER_ID}
        ```

    1. Get the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from the terminal and paste it into the `.tf` file.
    1. Place the file in the new `imported-cluster` directory.
    1. Edit the copied configuration so that you can create a new cluster from it:

        * Specify the new cluster name in the `resource` string and the `name` parameter.
        * Delete `created_at`, `health`, `host`, `id`, and `status`.
        * Add the `subnet_ids` argument with the list of subnet IDs for each availability zone.
        * If the `maintenance_window` section contains `type = "ANYTIME"`, delete the `hour` setting.
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

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a {{ mkf-name }} cluster with the following test specifications:

  
  * Name: `mykf`.
  * Environment: `production`.
  * {{ KF }} version: 3.9.
  * Network: `{{ network-name }}`.
  * Subnet ID: `{{ subnet-id }}`.
  * Security group: `{{ security-group }}`.
  * Broker host class: `{{ host-class }}` (one host), availability zone: `{{ region-id }}-a`.
  * Network SSD storage (`{{ disk-type-example }}`): 10 GB.
  * Public access: Enabled.
  * Deletion protection: Enabled.


  Run this command:

  
  ```bash
  {{ yc-mdb-kf }} cluster create \
     --name mykf \
     --environment production \
     --version 3.9 \
     --network-name {{ network-name }} \
     --subnet-ids {{ subnet-id }} \
     --zone-ids {{ region-id }}-a \
     --brokers-count 1 \
     --resource-preset {{ host-class }} \
     --disk-size 10 \
     --disk-type {{ disk-type-example }} \
     --assign-public-ip \
     --security-group-ids {{ security-group }} \
     --deletion-protection
  ```



- {{ TF }} {#tf}

  Create a {{ mkf-name }} cluster with the following test specifications:
  * Cloud ID: `{{ tf-cloud-id }}`.
  * Folder ID: `{{ tf-folder-id }}`.
  * Name: `mykf`.
  * Environment: `PRODUCTION`.
  * {{ KF }} version: 3.9.
  * New network: `mynet` (new one), subnet: `mysubnet`, address range: `10.5.0.0/24`.
  * Security group: `mykf-sg` allowing internet connections to the {{ mkf-name }} cluster on port `9091`.
  * Broker host class: `{{ host-class }}` (one host), availability zone: `{{ region-id }}-a`.
  * Network SSD storage (`{{ disk-type-example }}`): 10 GB.

  
  * Public access: Enabled.


  * Deletion protection: Enabled.

  The configuration file for this {{ mkf-name }} cluster is as follows:

  ```hcl
  resource "yandex_mdb_kafka_cluster" "mykf" {
    environment         = "PRODUCTION"
    name                = "mykf"
    network_id          = yandex_vpc_network.mynet.id
    subnet_ids          = [ yandex_vpc_subnet.mysubnet.id ]
    security_group_ids  = [ yandex_vpc_security_group.mykf-sg.id ]
    deletion_protection = true

    config {
      assign_public_ip = true
      brokers_count    = 1
      version          = "3.9"
      kafka {
        resources {
          disk_size          = 10
          disk_type_id       = "{{ disk-type-example }}"
          resource_preset_id = "{{ host-class }}"
        }
        kafka_config {}
      }

      zones = [
        "{{ region-id }}-a"
      ]
    }
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

  resource "yandex_vpc_security_group" "mykf-sg" {
    name       = "mykf-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "Kafka"
      port           = 9091
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }
  ```


{% endlist %}

### Creating a cluster with {{ kraft-short-name }} in combined mode {#kafka-kraft}

In our example, we use the [configuration](../concepts/kraft.md#cluster-topology) with three availability zones, each hosting a single broker.

{% list tabs group=instructions %}

- CLI {#cli}

  Create a {{ mkf-name }} cluster with the following test specifications:

  * Name: `kafka-kraft`.
  * Environment: `production`.
  * {{ KF }} version: `3.9`.
  
  
  * Network ID: `enpc6eqfhmj2********`.
  * Subnet IDs:
    
    * `e9bhbia2scnk********`
    * `e2lfqbm5nt9r********`
    * `fl8beqmjckv8********`
  

  * One broker host in each of the following availability zones:

      
    * `ru-central1-a`
    * `ru-central1-b`
    * `ru-central1-d`
  

  * [Host class](../concepts/instance-types.md): `s2.micro`.
  * Network HDD storage (`network-hdd`): `10` GB.

  
  * Public access: Enabled.
  * Security group: `enp68jq81uun********`.


  Run this command:

  
  ```bash
  yc managed-kafka cluster create \
    --name kafka-kraft \
    --environment production \
    --version 3.9 \
    --network-id enpc6eqfhmj2******** \
    --subnet-ids e9bhbia2scnk********,e2lfqbm5nt9r********,fl8beqmjckv8******** \
    --zone-ids ru-central1-a,ru-central1-b,ru-central1-d \
    --brokers-count 1 \
    --resource-preset s2.micro \
    --disk-size 10 \
    --disk-type network-hdd \
    --assign-public-ip \
    --security-group-ids enp68jq81uun********
  ```



- {{ TF }} {#tf}

  Create a {{ mkf-name }} cluster with the following test specifications:

  * Name: `kafka-kraft`.
  * Environment: `production`.
  * {{ KF }} version: `3.9`.
  * New network: `kafka-net`, subnets in each availability zone:
    
    * `kafka-subnet-a` with the `10.1.0.0/24` address range.
    * `kafka-subnet-b` with the `10.2.0.0/24` address range.
    * `kafka-subnet-d` with the `10.3.0.0/24` address range.

  * One broker host in each of the following availability zones:
    
    * `ru-central1-a`
    * `ru-central1-b`
    * `ru-central1-d`
  
  * [Host class](../concepts/instance-types.md): `s2.micro`.
  * Network HDD storage (`network-hdd`): `10` GB.
  * Public access: Enabled.
  * Security group: `kafka-sg` allowing all incoming and outgoing traffic.

  The configuration file for this {{ mkf-name }} cluster is as follows:

  ```hcl
  resource "yandex_mdb_kafka_cluster" "kafka-kraft" {
    name                = "kafka-kraft"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.kafka-net.id
    subnet_ids          = [yandex_vpc_subnet.kafka-subnet-a.id, yandex_vpc_subnet.kafka-subnet-b.id, yandex_vpc_subnet.kafka-subnet-d.id]
    security_group_ids  = [yandex_vpc_security_group.kafka-sg.id]

    config {
      version          = "3.9"
      brokers_count    = 1
      zones            = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
      assign_public_ip = true
      
      kafka {
        resources {
          disk_size          = 10
          disk_type_id       = "network-hdd"
          resource_preset_id = "s2.micro"
        }

        kafka_config {}
      }
    }
  }

  resource "yandex_vpc_network" "kafka-net" {
    name = "kafka-net"
  }

  resource "yandex_vpc_subnet" "kafka-subnet-a" {
    name           = "kafka-subnet-a"
    zone           = "ru-central1-a"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.1.0.0/24"]
  }

  resource "yandex_vpc_subnet" "kafka-subnet-b" {
    name           = "kafka-subnet-b"
    zone           = "ru-central1-b"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.2.0.0/24"]
  }

  resource "yandex_vpc_subnet" "kafka-subnet-d" {
    name           = "kafka-subnet-d"
    zone           = "ru-central1-d"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.3.0.0/24"]
  }

  resource "yandex_vpc_security_group" "kafka-sg" {
    name       = "kafka-sg"
    network_id = yandex_vpc_network.kafka-net.id
  
    ingress {
      protocol       = "ANY"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      protocol       = "ANY"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ```


{% endlist %}

### Creating a cluster with {{ kraft-short-name }} on separate hosts (multi-host cluster) {#kafka-kraft-mh}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a {{ mkf-name }} cluster with the following test specifications:

  * Name: `kafka-kraft-mh`.
  * Environment: `production`.
  * {{ KF }} version: `3.9`.
  
  
  * Network ID: `enpc6eqfhmj2********`.
  * Subnet IDs:
    
    * `e9bhbia2scnk********`
    * `e2lfqbm5nt9r********`
    * `fl8beqmjckv8********`
  

  * Hosts: Two broker hosts in the `ru-central1-a` availability zone.
  * [Host class](../concepts/instance-types.md): `s2.micro`.
  * Network HDD storage (`network-hdd`): `10` GB.
  * [{{ kraft-short-name }}](../concepts/kraft.md) controller [host class](../concepts/instance-types.md): `s2.micro`.
  * [{{ kraft-short-name }}](../concepts/kraft.md) controller network SSD storage (`network-ssd`): `10` GB.

  
  * Public access: Enabled.
  * Security group: `enp68jq81uun********`.


  Run this command:

  
  ```bash
  yc managed-kafka cluster create \
    --name kafka-kraft-mh \
    --environment production \
    --version 3.9 \
    --network-id enpc6eqfhmj2******** \
    --subnet-ids e9bhbia2scnk********,e2lfqbm5nt9r********,fl8beqmjckv8******** \
    --zone-ids ru-central1-a \
    --brokers-count 2 \
    --resource-preset s2.micro \
    --disk-size 10 \
    --disk-type network-hdd \
    --controller-resource-preset s2.micro \
    --controller-disk-size 10 \
    --controller-disk-type network-ssd \
    --assign-public-ip \
    --security-group-ids enp68jq81uun********
  ```



- {{ TF }} {#tf}

  Create a {{ mkf-name }} cluster with the following test specifications:

  * Name: `kafka-kraft-mh`.
  * Environment: `production`.
  * {{ KF }} version: `3.9`.
  * New network: `kafka-net`, subnets in each availability zone:
    
    * `kafka-subnet-a` with the `10.1.0.0/24` address range.
    * `kafka-subnet-b` with the `10.2.0.0/24` address range.
    * `kafka-subnet-d` with the `10.3.0.0/24` address range.
  
  * Hosts: Two broker hosts in the `ru-central1-a` availability zone.
  * [Host class](../concepts/instance-types.md): `s2.micro`.
  * Network HDD storage (`network-hdd`): `10` GB.
  * [{{ kraft-short-name }}](../concepts/kraft.md) controller [host class](../concepts/instance-types.md): `s2.micro`.
  * [{{ kraft-short-name }}](../concepts/kraft.md) controller network SSD storage (`network-ssd`): `10` GB.
  * Public access: Enabled.
  * Security group: `kafka-sg` allowing all incoming and outgoing traffic.

  The configuration file for this {{ mkf-name }} cluster is as follows:

  ```hcl
  resource "yandex_mdb_kafka_cluster" "kafka-kraft-mh" {
    name                = "kafka-kraft-mh"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.kafka-net.id
    subnet_ids          = [yandex_vpc_subnet.kafka-subnet-a.id,yandex_vpc_subnet.kafka-subnet-b.id,yandex_vpc_subnet.kafka-subnet-d.id]
    security_group_ids  = [yandex_vpc_security_group.kafka-sg.id]

    config {
      version          = "3.9"
      brokers_count    = 2
      zones            = ["ru-central1-a"]
      assign_public_ip = true
      
      kafka {
        resources {
          disk_size          = 10
          disk_type_id       = "network-hdd"
          resource_preset_id = "s2.micro"
        }

        kafka_config {}
      }

      kraft {
        resources {
          resource_preset_id = "s2.micro"
          disk_type_id       = "network-ssd"
          disk_size          = 10
        }
      }
    }
  }

  resource "yandex_vpc_network" "kafka-net" {
    name = "kafka-net"
  }

  resource "yandex_vpc_subnet" "kafka-subnet-a" {
    name           = "kafka-subnet-a"
    zone           = "ru-central1-a"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.1.0.0/24"]
  }

  resource "yandex_vpc_subnet" "kafka-subnet-b" {
    name           = "kafka-subnet-b"
    zone           = "ru-central1-b"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.2.0.0/24"]
  }

  resource "yandex_vpc_subnet" "kafka-subnet-d" {
    name           = "kafka-subnet-d"
    zone           = "ru-central1-d"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.3.0.0/24"]
  }

  resource "yandex_vpc_security_group" "kafka-sg" {
    name       = "kafka-sg"
    network_id = yandex_vpc_network.kafka-net.id
  
    ingress {
      protocol       = "ANY"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      protocol       = "ANY"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ```


{% endlist %}

### Creating a cluster with {{ ZK }} on separate hosts (multi-host cluster) {#kafka-zk-mh}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a {{ mkf-name }} cluster with the following test specifications:

  * Name: `kafka-zk-mh`.
  * Environment: `production`.
  * {{ KF }} version: `3.9`.
  
  
  * Network ID: `enpc6eqfhmj2********`.
  * Subnet IDs:
    
    * `e9bhbia2scnk********`
    * `e2lfqbm5nt9r********`
    * `fl8beqmjckv8********`
  

  * Hosts: Two broker hosts in the `ru-central1-a` availability zone.
  * [Host class](../concepts/instance-types.md): `s2.micro`.
  * Network HDD storage (`network-hdd`): `10` GB.
  * {{ ZK }} [host class](../concepts/instance-types.md): `s2.micro`.
  * [{{ ZK }}](../concepts/index.md#zookeeper) network SSD storage (`network-ssd`): `10` GB.
  
  
  * Public access: Enabled.
  * Security group: `enp68jq81uun********`.


  Run this command:

  
  ```bash
  yc managed-kafka cluster create \
    --name kafka-zk-mh \
    --environment production \
    --version 3.9 \
    --network-id enpc6eqfhmj2******** \
    --subnet-ids e9bhbia2scnk********,e2lfqbm5nt9r********,fl8beqmjckv8******** \
    --zone-ids ru-central1-a \
    --brokers-count 2 \
    --resource-preset s2.micro \
    --disk-size 10 \
    --disk-type network-hdd \
    --zookeeper-resource-preset s2.micro \
    --zookeeper-disk-size 10 \
    --zookeeper-disk-type network-ssd \
    --assign-public-ip \
    --security-group-ids enp68jq81uun********
  ```  



- {{ TF }} {#tf}

  Create a {{ mkf-name }} cluster with the following test specifications:

  * Name: `kafka-zk-mh`.
  * Environment: `production`.
  * {{ KF }} version: `3.9`.
  * New network: `kafka-net`, subnets in each availability zone:
    
    * `kafka-subnet-a` with the `10.1.0.0/24` address range.
    * `kafka-subnet-b` with the `10.2.0.0/24` address range.
    * `kafka-subnet-d` with the `10.3.0.0/24` address range.
  
  * Hosts: Two broker hosts in the `ru-central1-a` availability zone.
  * [Host class](../concepts/instance-types.md): `s2.micro`.
  * Network HDD storage (`network-hdd`): `10` GB.
  * {{ ZK }} [host class](../concepts/instance-types.md): `s2.micro`.
  * [{{ ZK }}](../concepts/index.md#zookeeper) network SSD storage (`network-ssd`): `10` GB.
  * Public access: Enabled.
  * Security group: `kafka-sg` allowing all incoming and outgoing traffic.

  The configuration file for this {{ mkf-name }} cluster is as follows:

  ```hcl
  resource "yandex_mdb_kafka_cluster" "kafka-zk-mh" {
    name                = "kafka-zk-mh"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.kafka-net.id
    subnet_ids          = [yandex_vpc_subnet.kafka-subnet-a.id,yandex_vpc_subnet.kafka-subnet-b.id,yandex_vpc_subnet.kafka-subnet-d.id]
    security_group_ids  = [yandex_vpc_security_group.kafka-sg.id]

    config {
      version          = "3.9"
      brokers_count    = 2
      zones            = ["ru-central1-a"]
      assign_public_ip = true
      
      kafka {
        resources {
          disk_size          = 10
          disk_type_id       = "network-hdd"
          resource_preset_id = "s2.micro"
        }

        kafka_config {}
      }

      zookeeper {
        resources {
          resource_preset_id = "s2.micro"
          disk_type_id       = "network-ssd"
          disk_size          = 10
        }
      }
    }
  }

  resource "yandex_vpc_network" "kafka-net" {
    name = "kafka-net"
  }

  resource "yandex_vpc_subnet" "kafka-subnet-a" {
    name           = "kafka-subnet-a"
    zone           = "ru-central1-a"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.1.0.0/24"]
  }

  resource "yandex_vpc_subnet" "kafka-subnet-b" {
    name           = "kafka-subnet-b"
    zone           = "ru-central1-b"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.2.0.0/24"]
  }

  resource "yandex_vpc_subnet" "kafka-subnet-d" {
    name           = "kafka-subnet-d"
    zone           = "ru-central1-d"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.3.0.0/24"]
  }

  resource "yandex_vpc_security_group" "kafka-sg" {
    name       = "kafka-sg"
    network_id = yandex_vpc_network.kafka-net.id
  
    ingress {
      protocol       = "ANY"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      protocol       = "ANY"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ```


{% endlist %}  