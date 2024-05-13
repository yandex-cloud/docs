---
title: "Creating an {{ ES }} cluster"
description: "A cluster in the Managed Service for {{ ES }} is a group of multiple linked {{ ES }} hosts. When creating an {{ ES }} cluster, specify parameters separately for your hosts with the **Master Node** role and the **Data Node** role."
keywords:
  - "Creating an {{ ES }} cluster"
  - "{{ ES }} cluster"
  - "{{ ES }}"
---

# Creating an {{ ES }} cluster

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

A [{{ mes-name }} cluster](../concepts/index.md) is a group of multiple linked {{ ES }} hosts. cluster provides high search performance by distributing search and indexing tasks across all hosts with the _Data node_ [role](../concepts/hosts-roles.md). To learn more about roles in the {{ mes-name }} cluster, see [{#T}](../concepts/hosts-roles.md).

{% note info %}

* The number of hosts with the _Data node_ role you can create along with an {{ ES }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

{% endnote %}

## Creating a cluster {#create-cluster}

{% note info %}

As of June 13, 2022, the `Gold` [edition](../concepts/es-editions.md) in {{ mes-name }} clusters is no longer supported. You cannot create a new cluster with this edition.

{% endnote %}

When creating a {{ mes-name }} cluster, specify parameters separately for the hosts with the _Master node_ and the _Data node_ roles.

You can use hosts only with the _Data node_ role, without creating dedicated hosts for the _Master node_ role. In this case, hosts with the _Data node_ role combine the two roles.

{% list tabs group=instructions %}

- Management console {#console}

   To create a {{ mes-name }} cluster:

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a {{ mes-name }} cluster.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:
      1. Enter a name and description for the {{ mes-name }} cluster. The {{ mes-name }} cluster name must be unique within the folder.
      1. Select the environment where you want to create the {{ mes-name }} cluster (you cannot change the environment once the cluster is created):
         * `PRODUCTION`: For stable versions of your apps.
         * `PRESTABLE`: For testing purposes. The prestable environment is similar to the production environment and likewise covered by the SLA, but it is the first to get new functionalities, improvements, and bug fixes. In the prestable environment, you can test compatibility of new versions with your application.
      1. Select the {{ ES }} version from the list.
      1. Select the [{{ ES }} edition](../concepts/es-editions.md).

      
      1. Select a service account with the `storage.editor` role from the drop-down list or create a new one if you plan to use data from an {{ objstorage-name }} bucket with [restricted access](../../storage/concepts/bucket#bucket-access). For more information about setting up service accounts, see [Configuring access to {{ objstorage-name }}](s3-access.md).


   
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the [cloud network](../../vpc/concepts/network.md#network) to host the {{ mes-name }} cluster and the [security group](../../vpc/concepts/security-groups.md) for cluster network traffic. You may also need to [set up security groups](cluster-connect.md#configuring-security-groups) to connect to the {{ mes-name }} cluster.


   1. Under **{{ ui-key.yacloud.mdb.forms.section_user }}**, specify the `admin` user password.

     {% include [mes-superuser](../../_includes/mdb/mes-superuser.md) %}

   1. Configure hosts with the _Data node_ role by opening the **Data node** tab:
      1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the platform, host type, and host class.

         The host class defines the technical characteristics of [VM instances](../../compute/concepts/vm.md) {{ ES }} nodes are deployed on. All available options are listed under [Host classes](../concepts/instance-types.md). When you change the host class for a {{ mes-name }} cluster, the characteristics of all existing instances also change.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**:
         * Select the [disk type](../concepts/storage.md).

            {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

         * Select the storage size to use for data.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, select the configuration of the hosts created together with the {{ mes-name }} cluster:
         1. To add a host, click **{{ ui-key.yacloud.mdb.forms.button_add-host }}**.
         1. To change the added host, hover over the host line and click ![image](../../_assets/console-icons/pencil.svg).

            When changing the host, you can: {#change-data-node-settings}
            * Select the [availability zone](../../overview/concepts/geo-scope.md) and [subnet](../../vpc/concepts/network.md#subnet).
            * Enable public access.

               {% note warning %}

               You cannot enable public access to a host after creating a {{ mes-name }} cluster.

               {% endnote %}

               If public access is enabled for an {{ ES }} host with the _Data node_ role, you can connect to this host, or Kibana hosted on it, over the internet. For more information, see [Connecting to a cluster](cluster-connect.md).

               {% include [mes-tip-public-kibana](../../_includes/mdb/mes-tip-connecting-to-public-kibana.md) %}

   1. If necessary, configure the hosts with the _Master node_ role by opening the **Master node** tab:
      1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the platform, host type, and host class.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, configure storage the same way as for hosts with the _Data node_ role.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, click **{{ ui-key.yacloud.elasticsearch.button_add-hosts }}**. Three hosts are added. To change one of the added hosts, hover over the host line and click ![image](../../_assets/console-icons/pencil.svg).

         When changing the host, you can: {#change-master-node-settings}
         * Select the availability zone and subnet.
         * Enable public access.

            {% note tip %}

            We do not recommend enabling public access for hosts with the _Master node_ role as it may be unsafe.

            {% endnote %}

   1. Configure additional {{ mes-name }} cluster settings, if required:

      {% include [extra-settings](../../_includes/mdb/mes/extra-settings.md) %}

   1. Configure the [DBMS settings](../concepts/settings-list.md), if required.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a {{ mes-name }} cluster:
   1. Check whether the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) has any [subnets](../../vpc/concepts/network.md#subnet) for the {{ mes-name }} cluster hosts:

      ```bash
      yc vpc subnet list
      ```

      
      If there are no subnets in the folder, [create the required subnets](../../vpc/operations/subnet-create.md) in [{{ vpc-full-name }}](../../vpc/).


   1. View a description of the create {{ mes-name }} cluster CLI command:

      ```bash
      {{ yc-mdb-es }} cluster create --help
      ```

   1. Specify the {{ mes-name }} cluster parameters in the create command (the example shows only some of the parameters):

      
      ```bash
      {{ yc-mdb-es }} cluster create \
        --name <cluster_name> \
        --environment <environment> \
        --network-name <network_name> \
        --host zone-id=<availability_zone>,subnet-id=<subnet_ID>,assign-public-ip=<public_access>,type=<host_type> \
        --datanode-resource-preset <Data_node_host_class> \
        --datanode-disk-size <storage_size_GB> \
        --datanode-disk-type <Data_node_disk_type> \
        --masternode-resource-preset <Master_node_host_class> \
        --masternode-disk-size <Master_node_storage_size_GB> \
        --masternode-disk-type <Master_node_disk_type> \
        --security-group-ids <list_of_security_group_IDs> \
        --version <{{ ES }}_version> \
        --edition <{{ ES }}_edition> \
        --admin-password <admin_password> \
        --plugins=<plugin_1_name>,...,<plugin_N_name> \
        --deletion-protection=<deletion_protection>
      ```


      Where:

      * `--environment`: `prestable` or `production`.
      * `--host`: Host parameters:
         * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
         * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
         * `assign-public-ip`: Internet access to the host via a public IP, `true` or `false`.
         * `type`: Host role, `datanode` or `masternode`.
      * `--datanode-resource-preset`: Host class with the Data node role.
      * `--datanode-disk-size`: Storage size in gigabytes for hosts with the Data node role.
      * `--datanode-disk-type`: Storage type for hosts with the Data node role.
      * `--masternode-resource-preset`: Class of hosts with the Master Node role.
      * `--masternode-disk-size`: Storage size in gigabytes for hosts with the Master node role.
      * `--masternode-disk-type`: Storage type for hosts with the Master node role.
      * `--version` (optional): {{ ES }} version, {{ versions.tf.str }}.
      * `--edition` (optional): {{ ES }} edition, `basic` or `platinum`.
      * `--deletion-protection`: Cluster deletion protection, `true` or `false`.

      Enter the `subnet-id` if the selected [availability zone](../../overview/concepts/geo-scope.md) includes more than one subnet.

      {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

      {% note info %}

      When creating a {{ mes-name }} cluster, the `anytime` [maintenance](../concepts/maintenance.md) mode is set by default. You can set a specific maintenance window when [updating the {{ mes-name }} cluster settings](cluster-update.md#change-additional-settings).

      {% endnote %}

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   
   {% include [terraform-install](../../_includes/terraform-install.md) %}


   To create a {{ mes-name }} cluster:
   1. In the configuration file, describe the parameters of the resources you want to create:
      * Database cluster: Description of the {{ mes-name }} cluster and its hosts.

      * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

      * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

      Here is an example of the configuration file structure:

      
      
      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster_name>" {
        name                = "<cluster_name>"
        environment         = "<environment>"
        network_id          = "<network_ID>"
        deletion_protection = "<deletion_protection>"

        config {
          version = "<{{ ES }}_version>"
          edition = "<{{ ES }}_edition>"

          admin_password = "<admin_password>"

          data_node {
            resources {
              resource_preset_id = "<host_class>"
              disk_type_id       = "<disk_type>"
              disk_size          = <storage_size_GB>
            }
          }

          master_node {
            resources {
              resource_preset_id = "<host_class>"
              disk_type_id       = "<disk_type>"
              disk_size          = <storage_size_GB>
            }
          }

          plugins = [ "<list_of_plugin_names>" ]

        }

        security_group_ids = [ "<list_of_security_group_IDs>" ]

        host {
          name             = "<host_name>"
          zone             = "<availability_zone>"
          type             = "<host_role>"
          assign_public_ip = <public_access>
          subnet_id        = "<subnet_ID>"
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
      * `deletion_protection`: Deletion protection, `true` or `false`.
      * `version` (optional): {{ ES }} version, {{ versions.tf.str }}.
      * `edition` (optional): {{ ES }} edition, `basic` or `platinum`.
      * `host`: Host parameters:
         * `name`: Host name.
         * `zone`: [Availability zone](../../overview/concepts/geo-scope.md).
         * `type`: Host role, `DATA_NODE` or `MASTER_NODE`.
         * `assign_public_ip`: Public access to the host, `true` or `false`.
         * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.

      If the {{ mes-name }} cluster deletion protection is activated, this does not protect the DB contents.

      1. {% include [Maintenance window](../../_includes/mdb/mes/terraform/maintenance-window.md) %}

      For more information about resources you can create with {{ TF }}, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a {{ mes-name }} cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

   To create a {{ mes-name }} cluster, use the [create](../api-ref/Cluster/create.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) gRPC API call and provide the following in the request:
   * ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ mes-name }} cluster should be placed, in the `folderId` parameter.
   * {{ mes-name }} cluster name in the `name` parameter.
   * {{ ES }} version in the `configSpec.version` parameter.
   * {{ ES }} edition in the `configSpec.edition` parameter.
   * {{ mes-name }} cluster configuration in the `configSpec` parameter, including:
      * Class of hosts with the _Master node_ role in the `configSpec.elasticsearchSpec.masterNode.resources` parameter. If you do not want to create dedicated hosts with the _Master node_ role, do not set values for the group of `configSpec.elasticsearchSpec.masterNode` parameters.
      * Class of hosts with the _Data node_ role in the `configSpec.elasticsearchSpec.dataNode.resources` parameter.
   * Configuration of the {{ mes-name }} cluster hosts in one or more `hostSpecs` parameters.
   * [Network](../../vpc/concepts/network.md#network) ID in the `networkId` parameter.


   * [Security group](../../vpc/concepts/security-groups.md) IDs in the `securityGroupIds` parameter.


   * List of plugins in the `configSpec.elasticsearchSpec.plugins` parameter.
   * Settings for the [maintenance window](../concepts/maintenance.md) (including those for disabled {{ mes-name }} clusters) in the `maintenanceWindow` parameter.

{% endlist %}


{% note warning %}

If you specified security group IDs when creating a {{ mes-name }} cluster, you may also need to [set up security groups](cluster-connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}


## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

   To create a {{ mes-name }} cluster with a single host, provide a single `--host` parameter.

   Create a {{ mes-name }} cluster with the following test characteristics:
   * Name: `my-es-clstr`
   * Version: `{{ versions.cli.latest }}`
   * Edition: `Platinum`
   * Environment: `PRODUCTION`
   * Network: `default`


   * Security group ID: `enpp2s8l3irh********`.


   * Single publicly available `{{ host-class }}` host with the _Data node_ role in the `{{ subnet-id }}` subnet, in the `{{ region-id }}-a` availability zone.
   * Network SSD storage (`{{ disk-type-example }}`): 20 GB.
   * Username: `admin` with the `esadminpwd` password.
   * Protection against accidental {{ mes-name }} cluster deletion: Enabled.

   Run the following command:

   
   ```bash
   {{ yc-mdb-es }} cluster create \
     --name my-es-clstr \
     --environment production \
     --network-name default \
     --host zone-id={{ region-id }}-a,assign-public-ip=true,type=datanode \
     --datanode-resource-preset {{ host-class }} \
     --datanode-disk-type={{ disk-type-example }} \
     --datanode-disk-size=20 \
     --admin-password=esadminpwd \
     --security-group-ids enpp2s8l3irh******** \
     --version {{ versions.cli.latest }} \
     --edition platinum \
     --deletion-protection=true
   ```


- {{ TF }} {#tf}

   Create a {{ mes-name }} cluster. The configuration file for the {{ mes-name }} cluster is as follows:

   
   
   ```hcl
   resource "yandex_mdb_elasticsearch_cluster" "my-es-clstr" {
     name                = "my-es-clstr"
     environment         = "PRODUCTION"
     network_id          = yandex_vpc_network.mynet.id
     deletion_protection = "true"

     config {
       edition = "basic"
       version = "{{ versions.tf.latest }}"

       admin_password = "esadminpwd"

       data_node {
         resources {
           resource_preset_id = "s2.micro"
           disk_type_id       = "network-ssd"
           disk_size          = 20
         }
       }

     }

     security_group_ids = [ yandex_vpc_security_group.es-sg.id ]

     host {
       name             = "node"
       zone             = "{{ region-id }}-a"
       type             = "DATA_NODE"
       assign_public_ip = true
       subnet_id        = yandex_vpc_subnet.mysubnet.id
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

   resource "yandex_vpc_security_group" "es-sg" {
     name       = "es-sg"
     network_id = yandex_vpc_network.mynet.id

     ingress {
       description    = "Kibana"
       port           = 443
       protocol       = "TCP"
       v4_cidr_blocks = [ "0.0.0.0/0" ]
     }

     ingress {
       description    = "Elasticsearch"
       port           = 9200
       protocol       = "TCP"
       v4_cidr_blocks = [ "0.0.0.0/0" ]
     }
   }
   ```




   Where the following test configuration is used:
   * Name: `my-es-clstr`.
   * Version: `{{ versions.tf.latest }}`.
   * Edition: `Basic`.
   * Environment: `PRODUCTION`.
   * {{ mes-name }} cluster `deletion protection`: Enabled. You cannot delete a {{ mes-name }} cluster with this option enabled.
   * Cloud ID: `{{ tf-cloud-id }}`.
   * Folder ID: `{{ tf-folder-id }}`.
   * New network: `mynet`.


   * New `es-sg` security group allowing an internet connection to the {{ mes-name }} cluster on ports 443 (Kibana) and 9200 ({{ ES }}).


   * Single publicly available `{{ host-class }}` host with the _Data node_ role in the `mysubnet` subnet, in the `{{ region-id }}-a` availability zone. The `mysubnet` subnet will have a range of `10.5.0.0/24`.
   * Network SSD storage (`{{ disk-type-example }}`): 20 GB.
   * Username: `admin` with the `esadminpwd` password.

{% endlist %}
