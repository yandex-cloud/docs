# Creating an {{ KF }} cluster


A [{{ mkf-name }} cluster](../concepts/index.md) is one or more [broker hosts](../concepts/brokers.md) where [topics and their partitions](../concepts/topics.md) are located. [Producers and consumers](../concepts/producers-consumers.md) can work with these topics by connecting to {{ mkf-name }} cluster hosts.

{% note info %}


* The number of broker hosts you can create together with a {{ mkf-name }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).


{% endnote %}

{% include [mkf-zk-hosts](../../_includes/mdb/mkf-zk-hosts.md) %}

## Creating a cluster with {{ KF }} 3.5 or lower {#create-cluster}

Prior to creating a cluster, calculate the [minimum storage size](../concepts/storage.md#minimal-storage-size) for topics.


If you specify security group IDs when creating a {{ mkf-name }} cluster, you may also need to [configure security groups](connect/index.md#configuring-security-groups) to connect to the cluster.


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
      1. Select {{ KF }} version 3.5 or lower.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the [platform](../../compute/concepts/vm-platforms.md), host type, and host class.

      The host class defines the technical specifications of the [VMs](../../compute/concepts/vm.md) that {{ KF }} brokers will be deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).

      [Changing the host class](cluster-update.md#change-brokers) for a {{ mkf-name }} cluster changes the characteristics of all instances already created.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**:
      * Select the disk type.

         {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

         
         {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}


         You cannot change the disk type for a {{ mkf-name }} cluster once you create it.
      * Select the storage size to use for data.

   
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**:
      1. Select one or more [availability zones](../../overview/concepts/geo-scope.md) to host {{ KF }} brokers. If you create a {{ mkf-name }} cluster with one availability zone, you will not be able to increase the number of zones and brokers in the future.
      1. Select a [network](../../vpc/concepts/network.md#network).
      1. Select [subnets](../../vpc/concepts/network.md#subnet) in each availability zone for this network. To [create a new subnet](../../vpc/operations/subnet-create.md), click **{{ ui-key.yacloud.common.label_create-new_female }}** next to the availability zone in question.

         {% note info %}

         For a {{ mkf-name }} cluster with multiple broker hosts, you need to specify subnets in each availability zone even if you plan to host brokers only in some of them. These subnets are required to host three [{{ ZK }} hosts](../concepts/index.md), one in each availability zone. For more information, see [Resource relationships in the service](../concepts/index.md).

         {% endnote %}

      1. Select [security groups](../../vpc/concepts/security-groups.md) for the {{ mkf-name }} cluster's network traffic.
      1. To access broker hosts from the internet, select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**. In this case, you can only connect to them over an SSL connection. For more information, see [Connecting to topics in a cluster](connect/clients.md).


   1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**:
      1. Specify the number of {{ KF }} broker hosts to be located in each of the selected availability zones.

         When choosing the number of hosts, keep in mind that:
         * Replication is possible if there are at least two hosts per {{ mkf-name }} cluster.

         
         * If you selected `local-ssd` or `network-ssd-nonreplicated` under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, you need to add at least three hosts to the {{ mkf-name }} cluster.


         * To make your {{ mkf-name }} cluster fault-tolerant, you will need to meet [certain conditions](../concepts/index.md#fault-tolerance).
         * Adding more than one host to the {{ mkf-name }} cluster automatically adds three {{ ZK }} hosts.

      
      1. (Optional) Select groups of [dedicated hosts](../../compute/concepts/dedicated-host.md) to host the {{ mkf-name }} cluster.

         {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


   1. If you specify several broker hosts, under **{{ ui-key.yacloud.kafka.section_zookeeper-resources }}**, specify the characteristics of the [{{ ZK }} hosts](../concepts/index.md) to place in each of the selected availability zones.
   1. Configure additional {{ mkf-name }} cluster settings, if required:

      {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

   1. Configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings), if required.
   1. Click **{{ ui-key.yacloud.common.create }}**.
   1. Wait until the {{ mkf-name }} cluster is ready: its status on the {{ mkf-name }} dashboard will change to `Running`, and its state to `Alive`. This may take some time.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a {{ mkf-name }} cluster:

   1. View a description of the create {{ mkf-name }} cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster create --help
      ```

   1. Specify the {{ mkf-name }} cluster parameters in the create command (the example shows only some of the parameters):

      
      ```bash
      {{ yc-mdb-kf }} cluster create \
        --name <cluster_name> \
        --environment <environment> \
        --version <version> \
        --network-name <network_name> \
        --subnet-ids <subnet_IDs> \
        --brokers-count <number_of_brokers_per_zone> \
        --resource-preset <host_class> \
        --disk-type <disk_type> \
        --disk-size <storage_size_in_GB> \
        --assign-public-ip <public_access> \
        --security-group-ids <list_of_security_group_IDs> \
        --deletion-protection <deletion_protection>
      ```


      Where:

      * `--environment`: Cluster environment, `prestable` or `production`.
      * `--version`: {{ KF }} {{ versions.cli.str-without-latest }}.
      * `--resource-preset`: [Host class](../concepts/instance-types.md).
      * `--disk-type`: [Disk type](../concepts/storage.md).

         {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

      * {% include [deletion-protection](../../_includes/mdb/cli/deletion-protection.md) %}

         {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

      {% note tip %}

      You can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here, if required.

      {% endnote %}

   1. To set up a [maintenance window](../concepts/maintenance.md) (for disabled {{ mkf-name }} clusters as well), provide the required value in the `--maintenance-window` parameter when creating your cluster:

      ```bash
      {{ yc-mdb-kf }} cluster create \
        ...
        --maintenance-window type=<maintenance_type>,`
                            `day=<day_of_week>,`
                            `hour=<hour> \
      ```

      Where `type` is the maintenance type:

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}


   
   1. To create a {{ mkf-name }} cluster hosted on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), specify the host IDs as a comma-separated list in the `--host-group-ids` parameter when creating the cluster:

      ```bash
      {{ yc-mdb-kf }} cluster create \
        ...
        --host-group-ids=<IDs_of_groups_of_dedicated_hosts>
      ```

      {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a {{ mkf-name }} cluster:
   1. In the configuration file, describe the resources you are creating:
      * {{ mkf-name }} cluster: Description of a cluster and its hosts. You can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here, if required.

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
        deletion_protection = <deletion_protection>

        config {
          assign_public_ip = "<public_access>"
          brokers_count    = <number_of_brokers>
          version          = "<version>"
          schema_registry  = "<data_schema_management>"
          kafka {
            resources {
              disk_size          = <storage_size_GB>
              disk_type_id       = "<disk_type>"
              resource_preset_id = "<host_class>"
            }
            kafka_config {}
          }

          zones = [
            "<availability_zones>"
          ]
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
      * `deletion_protection`: Cluster deletion protection, `true` or `false`.
      * `assign_public_ip`: Public access to the cluster, `true` or `false`.
      * `version`: {{ KF }} {{ versions.tf.str-without-latest }}.
      * `schema_registry`: Data schema management, `true` or `false`.



      {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

      {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a {{ mkf-name }} cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      After this, all required resources will be created in the specified folder, and the [FQDNs of the {{ mkf-name }} cluster hosts](../concepts/network.md#hostname) will be displayed in the terminal. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API {#api}

   To create a {{ mkf-name }} cluster, use the [create](../api-ref/Cluster/create.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) gRPC API call and provide the following in the request:
   * ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to host the {{ mkf-name }} cluster in the `folderId` parameter.
   * {{ mkf-name }} cluster name in the `name` parameter.
   * {{ KF }} version {{ versions.cli.str-without-latest }} in the `configSpec.version` parameter.

   
   * [Security group](../../vpc/concepts/security-groups.md) IDs in the `securityGroupIds` parameter.


   * Settings for the [maintenance window](../concepts/maintenance.md) (for disabled {{ mkf-name }} clusters as well) in the `maintenanceWindow` parameter.
   * {{ mkf-name }} cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

   To manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), set the `configSpec.schemaRegistry` parameter to `true`. You cannot edit this setting after you create a {{ mkf-name }} cluster.


   
   To create a {{ mkf-name }} cluster deployed on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), provide a list of host IDs in the `hostGroupIds` parameter.

   {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


{% endlist %}

## Creating a cluster with {{ KF }} 3.6 or higher {#higher-version}

{{ mkf-name }} clusters with {{ KF }} 3.6 or higher support [{{ kraft-name }}](../concepts/kraft.md) (abbreviated as {{ kraft-short-name }}). It is used instead of {{ ZK }} to store metadata.

You can create a cluster with {{ kraft-short-name }} only using a specific configuration and not in all {{ yandex-cloud }} interfaces. That is why the cluster creation process is different for {{ KF }} 3.6 or higher.

Prior to creating a cluster, calculate the [minimum storage size](../concepts/storage.md#minimal-storage-size) for topics.


If you specify security group IDs when creating a {{ mkf-name }} cluster, you may also need to [configure security groups](connect/index.md#configuring-security-groups) to connect to the cluster.


{% note warning %}

When creating a cluster with {{ kraft-short-name }}, do not specify the {{ ZK }} settings.

{% endnote %}

{% list tabs group=instructions %}

* CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a {{ mkf-name }} cluster:

   1. View a description of the create {{ mkf-name }} cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster create --help
      ```

   1. Specify the {{ mkf-name }} cluster parameters in the create command (the example shows only some of the parameters):

      ```bash
      {{ yc-mdb-kf }} cluster create \
         --name <cluster_name> \
         --environment prestable \
         --version 3.6 \
         --network-name <network_name> \
         --subnet-ids <subnet_IDs> \
         --zone-ids <availability_zones> \
         --brokers-count <number_of_brokers_per_zone> \
         --resource-preset <host_class> \
         --disk-type <disk_type> \
         --disk-size <storage_size_in_GB> \
         --assign-public-ip <public_access> \
         --security-group-ids <list_of_security_group_IDs> \
         --deletion-protection <deletion_protection>
      ```

      Where:

      * `--environment`: `prestable` cluster environment. Only this environment supports {{ KF }} 3.6.
      * `--version`: {{ KF }} {{ versions.cli.latest }}.
      * `--zone-ids` and `--brokers-count`: Availability zones and number of brokers per zone. Specify one of the available configurations:

         * `--zone-ids={{ region-id }}-a,{{ region-id }}-b,{{ region-id }}-d --brokers-count=1`.
         * `--zone-ids=<one_availability_zone> --brokers-count=3`.

      * `--resource-preset`: [Host class](../concepts/instance-types.md).
      * `--disk-type`: [Disk type](../concepts/storage.md).

         {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

      * {% include [deletion-protection](../../_includes/mdb/cli/deletion-protection.md) %}

         {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

      {% note tip %}

      You can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here, if required.

      {% endnote %}

   1. To set up a [maintenance window](../concepts/maintenance.md) (for disabled {{ mkf-name }} clusters as well), provide the required value in the `--maintenance-window` parameter when creating your cluster:

      ```bash
      {{ yc-mdb-kf }} cluster create \
         ...
         --maintenance-window type=<maintenance_type>,`
                             `day=<day_of_week>,`
                             `hour=<hour> \
      ```

      Where `type` is the maintenance type:

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}


   
   1. To create a {{ mkf-name }} cluster hosted on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), specify the host IDs as a comma-separated list in the `--host-group-ids` parameter when creating the cluster:

      ```bash
      {{ yc-mdb-kf }} cluster create \
         ...
         --host-group-ids=<IDs_of_groups_of_dedicated_hosts>
      ```

      {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


* {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a {{ mkf-name }} cluster:

   1. In the configuration file, describe the resources you are creating:

      * {{ mkf-name }} cluster: Description of a cluster and its hosts. You can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here, if required.

      * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

      * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
        environment         = "PRESTABLE"
        name                = "<cluster_name>"
        network_id          = "<network_ID>"
        subnet_ids          = ["<subnet_IDs>"]
        security_group_ids  = ["<security_group_IDs>"]
        deletion_protection = <deletion_protection>

        config {
          version          = "3.6"
          zones            = ["<availability_zones>"]
          brokers_count    = <number_of_brokers>
          assign_public_ip = "<public_access>"
          schema_registry  = "<data_schema_management>"
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

      * `environment`: `PRESTABLE` cluster environment. Only this environment supports {{ KF }} 3.6.
      * `deletion_protection`: Cluster deletion protection, `true` or `false`.
      * `version`: {{ KF }} {{ versions.tf.latest }}.
      * `zones` and `brokers_count`: Availability zones and number of brokers per zone. Specify one of the available configurations:

         * `zones = ["{{ region-id }}-a","{{ region-id }}-b","{{ region-id }}-d"] brokers_count = 1`.
         * `zones = ["<one_availability_zone>"] brokers_count = 3`.

      * `assign_public_ip`: Public access to the cluster, `true` or `false`.
      * `schema_registry`: Data schema management, `true` or `false`.

      {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

      {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a {{ mkf-name }} cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      After this, all required resources will be created in the specified folder, and the [FQDNs of the {{ mkf-name }} cluster hosts](../concepts/network.md#hostname) will be displayed in the terminal. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

* API {#api}

   To create a {{ mkf-name }} cluster, use the [create](../api-ref/Cluster/create.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) gRPC API call and provide the following in the request:

   * ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to host the {{ mkf-name }} cluster in the `folderId` parameter.
   * {{ mkf-name }} cluster name in the `name` parameter.
   * `PRESTABLE` environment in the `environment` parameter.
   * {{ KF }} version 3.6 in the `configSpec.version` parameter.
   * Availability zones in the `configSpec.zoneId` parameter. You can specify either one or three availability zones.
   * Number of broker hosts in the `configSpec.brokersCount` parameter. If you specify one availability zone, set the number of brokers to three. In case of three availability zones, set the number of brokers to one.

   
   * [Security group](../../vpc/concepts/security-groups.md) IDs in the `securityGroupIds` parameter.


   * Settings for the [maintenance window](../concepts/maintenance.md) (for disabled {{ mkf-name }} clusters as well) in the `maintenanceWindow` parameter.
   * {{ mkf-name }} cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

   To manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), set the `configSpec.schemaRegistry` parameter to `true`. You cannot edit this setting after you create a {{ mkf-name }} cluster.


   
   To create a {{ mkf-name }} cluster deployed on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), provide a list of host IDs in the `hostGroupIds` parameter.

   {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


{% endlist %}

To make sure that the created cluster is using the {{ kraft-short-name }} protocol, get information about the cluster hosts:

{% list tabs group=instructions %}

* Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Click the name of the cluster you created.
   1. In the left-hand panel, select **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.

{% endlist %}

If there are no {{ ZK }} hosts, it means the cluster uses {{ kraft-short-name }}.

## Creating a cluster copy {#duplicate}

You can create an {{ KF }} cluster with the settings of another one created earlier. To do so, you need to import the configuration of the source {{ KF }} cluster to {{ TF }}. Thus you can either create an identical copy or use the imported configuration as the baseline and modify it as needed. Importing is a convenient option when the source {{ KF }} cluster has lots of settings and you need to create a similar one.

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

   1. Write the ID of the initial {{ KF }} cluster to the environment variable:

      ```bash
      export KAFKA_CLUSTER_ID=<cluster_ID>
      ```

      You can request the ID with a [list of clusters in the folder](../../managed-kafka/operations/cluster-list.md#list-clusters).

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

      * Specify a new cluster name in the `resource` string and the `name` parameter.
      * Delete the `created_at`, `health`, `host`, `id`, and `status` parameters.
      * Add the `subnet_ids` parameter with the list of subnet IDs for each availability zone.
      * If the `maintenance_window` section specifies the `type = "ANYTIME"` parameter value, delete the `hour` parameter.
      * (Optional) Make further modifications if you are looking for more customization.

   1. In the `imported-cluster` directory, [get the authentication data](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).

   1. In the same directory, [configure and initialize a provider](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). There is no need to create a provider configuration file manually, you can [download it](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

   1. Place the configuration file in the `imported-cluster` directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you did not add the authentication credentials to environment variables, specify them in the configuration file.

   1. Check that the {{ TF }} configuration files are correct:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

   Create a {{ mkf-name }} cluster with the following test characteristics:

   
   * Name: `mykf`
   * Environment: `Production`
   * {{ KF }} version: 3.5
   * Network: `{{ network-name }}`
   * Subnet ID: `{{ subnet-id }}`
   * Security group: `{{ security-group }}`
   * Number of `{{ host-class }}` hosts in the `{{ region-id }}-a` availability zone: 1
   * Number of brokers: 1
   * Network SSD storage (`{{ disk-type-example }}`): 10 GB
   * Public access: Allowed
   * Protection against accidental {{ mkf-name }} cluster deletion: Enabled


   Run the following command:

   
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
     --deletion-protection true
   ```


- {{ TF }} {#tf}

   Create a {{ mkf-name }} cluster with the following test characteristics:
   * Cloud ID: `{{ tf-cloud-id }}`
   * Folder ID: `{{ tf-folder-id }}`
   * Name: `mykf`
   * Environment: `PRODUCTION`
   * {{ KF }} version: 3.5
   * Network and subnet: `mynet`, `mysubnet`

   
   * Security group: `mykf-sg` (allow ingress connections to the {{ mkf-name }} cluster on port `9091`)


   * Number of `{{ host-class }}` hosts in the `{{ region-id }}-a` availability zone: 1
   * Number of brokers: 1
   * Network SSD storage (`{{ disk-type-example }}`): 10 GB
   * Public access: Allowed
   * Protection against accidental {{ mkf-name }} cluster deletion: Enabled

   The configuration file for this {{ mkf-name }} cluster is as follows:

   
   
   ```hcl
   resource "yandex_mdb_kafka_cluster" "mykf" {
     environment         = "PRODUCTION"
     name                = "mykf"
     network_id          = yandex_vpc_network.mynet.id
     subnet_ids          = yandex_vpc_subnet.mysubnet.id
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
