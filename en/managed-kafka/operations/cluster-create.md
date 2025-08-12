# Creating an {{ KF }} cluster


A [{{ mkf-name }} cluster](../concepts/index.md) is one or more [broker hosts](../concepts/brokers.md) where [topics and their partitions](../concepts/topics.md) are located. [Producers and consumers](../concepts/producers-consumers.md) can work with these topics by connecting to {{ mkf-name }} cluster hosts.

{% note info %}

* The number of broker hosts you can create together with a {{ mkf-name }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

{% endnote %}


{% note info %}

Starting March 1, 2025, support for {{ KF }} 2.8, 3.0, 3.1, 3.2, and 3.3 is discontinued. You cannot create a cluster with these versions.

{% endnote %}


## Differences in cluster configuration with {{ ZK }} and {{ kraft-name }} protocol {#zk-vs-kraft}

If you create a cluster with {{ KF }} 3.5 and more than one host, three dedicated {{ ZK }} hosts will be added to the cluster.

Clusters with {{ KF }} 3.6 or higher support [{{ kraft-name }}](../concepts/kraft.md) ({{ kraft-short-name }} for short). It is used instead of {{ ZK }} to store metadata.

When creating a cluster with the {{ kraft-short-name }} protocol, the following configuration restrictions apply:

* You can create a cluster with only one or three [availability zones](../../overview/concepts/geo-scope.md).
* Limited number of broker hosts:
  * If you select one availability zone, you can create one or three broker hosts.
  * If you select three availability zones, you can only create one broker host.

For more information about the differences in cluster configurations with {{ ZK }} and {{ kraft-short-name }}, see [Resource relationships in {{ mkf-name }}](../../managed-kafka/concepts/index.md).


## Getting started {#before-you-begin}

1. Calculate the [minimum storage size](../concepts/storage.md#minimal-storage-size) for topics.
1. [Assign](../../iam/operations/roles/grant.md) the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role and the [{{ roles.mkf.editor }} role or higher](../security/index.md#roles-list) to your {{ yandex-cloud }} account.

If you specify security group IDs when creating a {{ mkf-name }} cluster, you may also need to [configure security groups](connect/index.md#configuring-security-groups) to connect to the cluster.


## Creating a cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  To create a {{ mkf-name }} cluster:

  1. In the [management console]({{ link-console-main }}), go to the appropriate [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:
     1. Enter a name and description for the {{ mkf-name }} cluster. The {{ mkf-name }} cluster name must be unique within the folder.
     1. Select the environment where you want to create the {{ mkf-name }} cluster (you cannot change the environment once the cluster is created):
        * `PRODUCTION`: For stable versions of your apps.
        * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
     1. Select the {{ KF }} version.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the [platform](../../compute/concepts/vm-platforms.md), host type, and host class.

     The host class defines the technical specifications of [VMs](../../compute/concepts/vm.md) the {{ KF }} nodes are deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).

     When you [change the host class](cluster-update.md#change-brokers) for a {{ mkf-name }} cluster, the specifications of all existing instances also change.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**:
     * Select the disk type.

       {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

       {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

       You cannot change the disk type for an {{ mkf-name }} cluster once you create it.
     * Select the storage size to use for data.

  
  1. Under **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**, set the storage [utilization thresholds](../concepts/storage.md#auto-rescale) that will trigger an increase in storage size when reached:

     {% include [autoscale-settings](../../_includes/mdb/mkf/autoscale-settings.md) %}

  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**:
     1. Select one or more availability zones to place your {{ KF }} broker hosts in.
        If you create a {{ mkf-name }} cluster with one availability zone, you will not be able to increase the number of zones and broker hosts later on.
        For clusters with {{ KF }} version 3.6 and higher, you can select only one or three availability zones.
     1. Select a [network](../../vpc/concepts/network.md#network).
     1. Select [subnets](../../vpc/concepts/network.md#subnet) in each availability zone for this network. To [create a new subnet](../../vpc/operations/subnet-create.md), click **{{ ui-key.yacloud.common.create }}** next to the availability zone in question.

        {% note info %}

        For a cluster with {{ KF }} 3.5 and multiple broker hosts, specify subnets in each availability zone even if you plan to place broker hosts only in some of them. These subnets are required to host three [{{ ZK }}](../concepts/index.md) hosts, one in each availability zone. For more information, see [Resource relationships in the service](../concepts/index.md).

        {% endnote %}

     1. Select [security groups](../../vpc/concepts/security-groups.md) for the {{ mkf-name }} cluster's network traffic.
     1. To access broker hosts from the internet, select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**. In this case, you can only connect to them over an SSL connection. For more information, see [Connecting to topics in a cluster](connect/clients.md).


  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**:
     1. Specify the number of {{ KF }} broker hosts to be located in each of the selected availability zones.

        When choosing the number of hosts, keep in mind that:
        * In {{ KF }} versions 3.6 and higher the [number of broker hosts depends](#zk-vs-kraft) on the selected availability zones:

           * One availability zone: one or three broker hosts. To use three broker hosts, enable the **{{ ui-key.yacloud.kafka.field_kraft-combined-mode }}** setting.
           * Three availability zones: one broker host.

           You cannot set the number of broker hosts manually.

        * Replication is possible if there are at least two hosts per {{ mkf-name }} cluster.

        * If you selected `local-ssd` or `network-ssd-nonreplicated` under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, you need to add at least three hosts to the {{ mkf-name }} cluster.

        * There are [conditions](../concepts/ha-cluster.md) to satisfy to enable high availability of a {{ mkf-name }} cluster.
        * If you add more than one host to a cluster with {{ KF }} 3.5, three {{ ZK }} hosts will be automatically added as well.

     
     1. Optionally, select groups of [dedicated hosts](../../compute/concepts/dedicated-host.md) to host the {{ mkf-name }}cluster.

        {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


  1. If you are creating a cluster with version 3.5 and have specified more than one broker host, under **{{ ui-key.yacloud.kafka.section_zookeeper-resources }}**, specify the characteristics of the [{{ ZK }} hosts](../concepts/index.md) to place in each of the selected availability zones.
  1. Configure additional {{ mkf-name }} cluster settings, if required:

     {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

  1. Configure the [{{ KF }}](../concepts/settings-list.md#cluster-settings) settings, if required.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Wait until the {{ mkf-name }} cluster is ready: its status on the {{ mkf-name }} dashboard will change to `Running`, and its state, to `Alive`. This may take some time.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% note warning %}

  When creating a cluster with {{ kraft-short-name }}, do not specify the {{ ZK }} settings.

  {% endnote %}

  To create a {{ mkf-name }} cluster:

  1. See the description of the CLI command for creating a {{ mkf-name }} cluster:

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
        --assign-public-ip <public_access> \
        --security-group-ids <list_of_security_group_IDs> \
        --deletion-protection
        --kafka-ui-enabled <true_or_false>
     ```


     Where:

     * `--environment`: Cluster environment, `prestable` or `production`.
     * `--version`: {{ KF }} version, {{ versions.cli.str }}.
     * `--schema-registry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md).

         {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

     * `--zone-ids` and `--brokers-count`: Availability zones and number of broker hosts per zone.

        For [clusters with {{ KF }} version 3.6 and higher](#zk-vs-kraft), only the following configurations are available:

        * `--zone-ids={{ region-id }}-a,{{ region-id }}-b,{{ region-id }}-d --brokers-count=1`
        * `--zone-ids=<one_availability_zone> --brokers-count=1`
        * `--zone-ids=<one_availability_zone> --brokers-count=3`

     * `--resource-preset`: [Host class](../concepts/instance-types.md).
     * `--disk-type`: [Disk type](../concepts/storage.md).

        {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

     * {% include [deletion-protection](../../_includes/mdb/cli/deletion-protection.md) %}

        Even with cluster deletion protection enabled, one can still delete a user or topic or connect manually and delete the data.
    
     * {% include [kafka-ui-enabled](../../_includes/mdb/cli/kafka-ui-enabled.md) %}

     {% note tip %}

     You can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here, if required.

     {% endnote %}

  1. To set up a [maintenance window](../concepts/maintenance.md) (including for disabled {{ mkf-name }} clusters), provide the required value in the `--maintenance-window` parameter when creating your cluster:

     ```bash
     {{ yc-mdb-kf }} cluster create \
        ...
        --maintenance-window type=<maintenance_type>,`
                            `day=<day_of_week>,`
                            `hour=<hour> \
     ```

     Where `type` is the maintenance type:

     {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

  1. To prevent the cluster disk space from running out, create a cluster that will [increase the storage space automatically](../concepts/storage.md#auto-rescale).

     ```bash
     {{ yc-mdb-kf }} cluster create \
        ...
        --disk-size-autoscaling disk-size-limit=<maximum_storage_size_in_bytes>,`
                               `planned-usage-threshold=<scheduled_increase_percentage>,`
                               `emergency-usage-threshold=<immediate_increase_percentage>
     ```

     {% include [description-of-parameters](../../_includes/mdb/mkf/disk-auto-scaling.md) %}

     {% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


  
  1. To create a {{ mkf-name }} cluster based on [dedicated host](../../compute/concepts/dedicated-host.md) groups, specify their IDs as a comma-separated list in the `--host-group-ids` parameter when creating the cluster:

     ```bash
     {{ yc-mdb-kf }} cluster create \
        ...
        --host-group-ids <dedicated_host_group_IDs>
     ```

     {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% note warning %}

  When creating a cluster with {{ kraft-short-name }}, do not specify the {{ ZK }} settings.

  {% endnote %}

  To create a {{ mkf-name }} cluster:
  1. In the configuration file, describe the resources you are creating:
     * {{ mkf-name }} cluster: Description of the cluster and its hosts. You can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here, if required.

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Here is an example of the configuration file structure:

     
     ```hcl
     resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
       environment         = "<environment>"
       name                = "<cluster_name>"
       network_id          = "<network_ID>"
       subnet_ids          = ["<list_of_subnet_IDs>"]
       security_group_ids  = ["<list_of_cluster_security_group_IDs>"]
       deletion_protection = <cluster_deletion_protection>

       config {
         version          = "<version>"
         zones            = ["<availability_zones>"]
         brokers_count    = <number_of_broker_hosts>
         assign_public_ip = "<public_access>"
         schema_registry  = "<data_schema_management>"
         kafka_ui {
           enabled = <true_or_false>
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
     * `version`: {{ KF }} version, {{ versions.tf.str }}.
     * `zones` and `brokers_count`: Availability zones and number of broker hosts per zone.

       If you are creating a [cluster with {{ KF }} version 3.6 or higher](#zk-vs-kraft), specify one of the available configurations:

       * `zones = ["{{ region-id }}-a","{{ region-id }}-b","{{ region-id }}-d"] brokers_count = 1`
       * `zones = ["<one_availability_zone>"] brokers_count = 1`
       * `zones = ["<one_availability_zone>"] brokers_count = 3`

     * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

       Even with cluster deletion protection enabled, one can still delete a user or topic or connect manually and delete the data.

     * `assign_public_ip`: Public access to the cluster, `true` or `false`.
     * `schema_registry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), `true` or `false`. The default value is `false`.

       {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}
      
     * `kafka_ui`: This setting defines whether to use [{{ kafka-ui }} for {{ KF }}](../concepts/kafka-ui.md) and can be `true` or `false`. The default value is `false`.

     {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a {{ mkf-name }} cluster.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     After this, all required resources will be created in the specified folder, and the [FQDNs of the {{ mkf-name }}](../concepts/network.md#hostname) cluster hosts will be displayed in the terminal. You can check the new resources and their configuration in the [management console]({{ link-console-main }}).

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    {% note warning %}

    When creating a cluster with {{ kraft-short-name }}, do not specify the {{ ZK }} settings.

    {% endnote %}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.create](../api-ref/Cluster/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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
                    "resourcePresetId": "<{{ ZK }}_host_class> ",
                    "diskSize": "<storage_size_in_bytes>",
                    "diskTypeId": "<disk_type>"                   
                  }
                },
                "zoneId": [
                  <list_of_availability_zones>
                ],
                "brokersCount": "<number_of_brokers_in_zone>",
                "assignPublicIp": <public_access:_true_or_false>,
                "schemaRegistry": <data_schema_management:_true_or_false>,
                "restApiConfig": {
                  "enabled": <send_requests_to_{{ KF }}_API:_true_or_false>
                },
                "diskSizeAutoscaling": {
                  <automatic_storage_size_increase_parameters>
                },
                "kafkaUiConfig": {
                  "enabled": <use_{{ kafka-ui }}:_true_or_false>
                }
              },
              "topicSpecs": [
                {
                  "name": "<topic_name>",
                  "partitions": "<number_of_partitions>",
                  "replicationFactor": "<replication_factor>"
                },
                { <similar_list_of_settings_for_topic_2> },
                { ... },
                { <similar_list_of_settings_for_topic_N> }
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
                { <similar_configuration_for_user_2> },
                { ... },
                { <similar_configuration_for_user_N> }
              ],
              "maintenanceWindow": {
                "anytime": {},
                "weeklyMaintenanceWindow": {
                  "day": "<day_of_week>",
                  "hour": "<hour_UTC>"
                }
              },
              "deletionProtection": <cluster_deletion_protection:_true_or_false>
            }
            ```


            Where:

            * `name`: Cluster name.
            * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
            * `networkId`: ID of the [network](../../vpc/concepts/network.md) the cluster will be in.

            
            * `securityGroupIds`: [Security group](../../vpc/concepts/security-groups.md) IDs as an array of strings. Each string is a security group ID.


            * `configSpec`: Cluster configuration:

                * `version`: {{ KF }} version, {{ versions.cli.str }}.
                * `kafka`: {{ KF }} configuration:

                    * `resources.resourcePresetId`: [Host class](../concepts/instance-types.md) ID. You can request the list of available host classes with their IDs using the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method.
                    * `resources.diskSize`: Disk size in bytes.
                    * `resources.diskTypeId`: [Disk type](../concepts/storage.md).

                * `zookeeper`: [{{ ZK }}](../concepts/index.md#zookeeper) configuration.

                    * `resources.resourcePresetId`: Host class ID. You can request the list of available host classes with their IDs using the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method.
                    * `resources.diskSize`: Disk size in bytes.
                    * `resources.diskTypeId`: Disk type.


                * `zoneId` and `brokersCount`: Availability zones and number of broker hosts per zone.

                  If you are creating a [cluster with {{ KF }} version 3.6 or higher](#zk-vs-kraft), specify one of the available configurations:

                  * `"zoneId": ["{{ region-id }}-a","{{ region-id }}-b","{{ region-id }}-d"], "brokersCount": "1"`
                  * `"zoneId": ["<one_availability_zone>"], "brokersCount": "1"`
                  * `"zoneId": ["<one_availability_zone>"], "brokersCount": "3"`

                * `assignPublicIp`: Internet access to the broker hosts, `true` or `false`.
                * `schemaRegistry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), `true` or `false`. The default value is `false`. You will not be able to edit this setting once you create a {{ mkf-name }} cluster.
                * `restApiConfig`: {{ KF }} REST API configuration. For access to sending requests to the {{ KF }} REST API, specify `enabled: true`.
                * `diskSizeAutoscaling`: Set the storage [utilization thresholds](../concepts/storage.md#auto-rescale) (as a percentage of the total storage size), that will trigger an increase in storage size when reached:

                  {% include [autoscale-settings](../../_includes/mdb/mkf/api/rest-autoscale-settings.md) %}

                * `kafkaUiConfig`: Use [{{ kafka-ui }}](../concepts/kafka-ui.md). Specify `enabled: true` to access {{ kafka-ui }}.

            * `topicSpecs`: Topic settings as an array of elements. Each element is for a separate topic and has the following structure:

                {% include [rest-topic-specs](../../_includes/mdb/mkf/api/rest-topic-specs.md) %}

            * `userSpecs`: User settings as an array of elements, one for each user. Each element has the following structure:

                {% include [rest-user-specs](../../_includes/mdb/mkf/api/rest-user-specs.md) %}

            * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). Select one of the options:

                * `anytime`: At any time (default).
                * `weeklyMaintenanceWindow`: On schedule:
                    * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                    * `hour`: Hour of day (UTC) in `HH` format, from `1` to `24`.

            * `deletionProtection`: Cluster protection from accidental deletion, `true` or `false`. The default value is `false`.

                Even with cluster deletion protection enabled, one can still delete a user or topic or connect manually and delete the data.

            
            To create a {{ mkf-name }} cluster based on [dedicated host](../../compute/concepts/dedicated-host.md) groups, provide a list of host group IDs in the `hostGroupIds` parameter.

            {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


            
            You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. Run this request:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters' \
              --data '@body.json'
            ```

    1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    {% note warning %}

    When creating a cluster with {{ kraft-short-name }}, do not specify the {{ ZK }} settings.

    {% endnote %}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService/Create](../api-ref/grpc/Cluster/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                    "resource_preset_id": "<{{ ZK }}_host_class> ",
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
                "assign_public_ip": <public_access:_true_or_false>,
                "schema_registry": <data_schema_management:_true_or_false>,
                "rest_api_config": {
                  "enabled": <send_requests_to_{{ KF }}_API:_true_or_false>
                },
                "disk_size_autoscaling": {
                  <automatic_storage_size_increase_parameters>
                },
                "kafka_ui_config": {
                  "enabled": <use_{{ kafka-ui }}:_true_or_false>
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
                { <similar_list_of_settings_for_topic_2> },
                { ... },
                { <similar_list_of_settings_for_topic_N> }
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
                { <similar_configuration_for_user_2> },
                { ... },
                { <similar_configuration_for_user_N> }
              ],
              "maintenance_window": {
                "anytime": {},
                "weekly_maintenance_window": {
                  "day": "<day_of_week>",
                  "hour": "<hour_UTC>"
                }
              },
              "deletion_protection": <cluster_deletion_protection:_true_or_false>
            }
            ```


            Where:

            * `name`: Cluster name.
            * `environment`: Cluster environment, `PRODUCTION` or `PRESTABLE`.
            * `network_id`: ID of the [network](../../vpc/concepts/network.md) the cluster will be in.

            
            * `security_group_ids`: [Security group](../../vpc/concepts/security-groups.md) IDs as an array of strings. Each string is a security group ID.


            * `config_spec`: Cluster configuration:

                * `version`: {{ KF }} version, {{ versions.cli.str }}.
                * `kafka`: {{ KF }} configuration:

                    * `resources.resource_preset_id`: [Host class](../concepts/instance-types.md) ID. You can request the list of available host classes with their IDs using the [ResourcePreset.list](../api-ref/grpc/ResourcePreset/list.md) call.
                    * `resources.disk_size`: Disk size in bytes.
                    * `resources.disk_type_id`: [Disk type](../concepts/storage.md).

                * `zookeeper`: [{{ ZK }}](../concepts/index.md#zookeeper) configuration.

                    * `resources.resource_preset_id`: Host class ID. You can request the list of available host classes with their IDs using the [ResourcePreset.list](../api-ref/grpc/ResourcePreset/list.md) call.
                    * `resources.disk_size`: Disk size in bytes.
                    * `resources.disk_type_id`: Disk type.


                * `zone_id` and `brokers_count`: Availability zones and number of broker hosts per zone (this number is provided as an object with the `value` field).

                  If you are creating a [cluster with {{ KF }} version 3.6 or higher](#zk-vs-kraft), specify one of the available configurations:

                  * `"zone_id": ["{{ region-id }}-a","{{ region-id }}-b","{{ region-id }}-d"], "brokers_count": {"value":"1"}`
                  * `"zone_id": ["<one_availability_zone>"], "brokers_count": {"value":"1"}`
                  * `"zone_id": ["<one_availability_zone>"], "brokers_count": {"value":"3"}`

                * `assign_public_ip`: Internet access to the broker hosts, `true` or `false`.
                * `schema_registry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), `true` or `false`. The default value is `false`. You will not be able to edit this setting once you create a {{ mkf-name }} cluster.
                * `rest_api_config`: {{ KF }} REST API configuration. For access to sending requests to the {{ KF }} REST API, specify `enabled: true`.
                * `disk_size_autoscaling`: To prevent the cluster disk space from running out, set the storage [utilization thresholds](../concepts/storage.md#auto-rescale) (as a percentage of the total storage size) that will trigger an increase in storage size when reached:

                  {% include [autoscale-settings](../../_includes/mdb/mkf/api/grpc-autoscale-settings.md) %}
                
                * `kafka_ui_config`: Use [{{ kafka-ui }}](../concepts/kafka-ui.md). Specify `enabled: true` to access {{ kafka-ui }}.

            * `topic_specs`: Topic settings as an array of elements. Each element is for a separate topic and has the following structure:

                {% include [grpc-topic-specs](../../_includes/mdb/mkf/api/grpc-topic-specs.md) %}

            * `user_specs`: User settings as an array of elements, one for each user. Each element has the following structure:

                {% include [rest-user-specs](../../_includes/mdb/mkf/api/grpc-user-specs.md) %}

            * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). Select one of these options:

                * `anytime`: At any time (default).
                * `weekly_maintenance_window`: On schedule:
                    * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                    * `hour`: Hour of day (UTC) in `HH` format, from `1` to `24`.

            * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`. The default value is `false`.

                Even with cluster deletion protection enabled, one can still delete a user or topic or connect manually and delete the data.

            
            To create a {{ mkf-name }} cluster based on [dedicated host](../../compute/concepts/dedicated-host.md) groups, provide a list of host group IDs in the `host_group_ids` parameter.

            {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


            
            You can request the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).


        1. Run this request:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters' \
              --data '@body.json'
            ```

    1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

To make sure the cluster created with {{ KF }} version 3.6 or higher uses the {{ kraft-short-name }} protocol, get information about the cluster hosts:

{% include [list-hosts](../../_includes/mdb/mkf/list-hosts.md) %}

If there are no {{ ZK }} hosts, it means the cluster uses {{ kraft-short-name }}.

## Creating a cluster copy {#duplicate}

You can create an {{ KF }} cluster using the settings of another one created earlier. To do so, you need to import the configuration of the source {{ KF }} cluster to {{ TF }}. This way you can either create an identical copy or use the imported configuration as the baseline and modify it as needed. Importing a configuration is a good idea when the source {{ KF }} cluster has a lot of settings and you need to create a similar one.

To create a {{ KF }} cluster copy:

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

    1. Write the ID of the initial {{ KF }} cluster to the environment variable:

        ```bash
        export KAFKA_CLUSTER_ID=<cluster_ID>
        ```

        You can get the ID with the [list of clusters in the folder](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Import the settings of the initial {{ KF }} cluster into the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_kafka_cluster.old ${KAFKA_CLUSTER_ID}
        ```

    1. Get the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from the terminal and paste it into the `.tf` file.
    1. Place the file in the new `imported-cluster` directory.
    1. Modify the copied configuration so that you can create a new cluster from it:

        * Specify the new cluster name in the `resource` string and the `name` parameter.
        * Delete `created_at`, `health`, `host`, `id`, and `status`.
        * Add the `subnet_ids` parameter with the list of subnet IDs for each availability zone.
        * If the `maintenance_window` section has `type = "ANYTIME"`, delete the `hour` parameter.
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

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a {{ mkf-name }} cluster with the following test specifications:

  
  * Name: `mykf`.
  * Environment: `production`.
  * {{ KF }} version: 3.5.
  * Network: `{{ network-name }}`.
  * Subnet ID: `{{ subnet-id }}`.
  * Security group: `{{ security-group }}`.
  * Host class: `{{ host-class }}`, availability zone: `{{ region-id }}-a`.
  * With one broker host.
  * Network SSD storage (`{{ disk-type-example }}`): 10 GB.
  * Public access: Allowed.
  * Deletion protection: Enabled.


  Run this command:

  
  ```bash
  {{ yc-mdb-kf }} cluster create \
     --name mykf \
     --environment production \
     --version 3.5 \
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
  * {{ KF }} version: 3.5.
  * New network: `mynet`, subnet: `mysubnet`.

  
  * Security group: `mykf-sg` (allow ingress connections to the {{ mkf-name }} cluster on port `9091`).


  * Host class: `{{ host-class }}`, availability zone: `{{ region-id }}-a`.
  * With one broker host.
  * Network SSD storage (`{{ disk-type-example }}`): 10 GB.
  * Public access: Allowed.
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
      version          = "3.5"
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
