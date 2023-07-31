# Creating a {{ KF }} cluster

A [{{ mkf-name }} cluster](../concepts/index.md) is one or more [broker hosts](../concepts/brokers.md) where [topics and their partitions](../concepts/topics.md) are located. [Producers and consumers](../concepts/producers-consumers.md) can work with these topics by connecting to cluster hosts.

{% note info %}


* The number of broker hosts you can create together with a {{ KF }} cluster depends on the selected [disk type](../concepts/storage.md#storage-type-selection) and [host class](../concepts/instance-types.md#available-flavors).
* Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).


{% endnote %}

{% include [mkf-zk-hosts](../../_includes/mdb/mkf-zk-hosts.md) %}

## How to create a {{ mkf-name }} cluster {#create-cluster}

Prior to creating a {{ mkf-name }} cluster, calculate the [minimum storage size](../concepts/storage.md#minimal-storage-size) for topics.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click **Create cluster**.
   1. Under **Basic parameters**:
      1. Enter a name and description of the {{ mkf-name }} cluster. It must be unique within the folder.
      1. Select the environment where you want to create the {{ mkf-name }} cluster (you cannot change the environment once the cluster is created):
         * `PRODUCTION`: For stable versions of your apps.
         * `PRESTABLE`: For testing, including the {{ mkf-name }} service itself. The prestable environment is updated first with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
      1. Select the {{ KF }} version.
      1. To [manage topics via the {{ KF }} Admin API](../concepts/topics.md#management):
         1. Enable **Manage topics via the API**.
         1. After creating your {{ mkf-name }} cluster, [create an admin user](cluster-accounts.md#create-user).

         {% include [mkf-admin-api-alert](../../_includes/mdb/mkf/admin-api-alert.md) %}

      1. To manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), enable the **Data Schema Registry** setting.

         {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

   1. Under **Host class**, select the [platform](../../compute/concepts/vm-platforms.md), host type, and host class.

      The host class defines the technical specifications of the [VMs](../../compute/concepts/vm.md) that {{ KF }} brokers will be deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).

      When [changing the host class](cluster-update.md#change-brokers) for the {{ mkf-name }} cluster, the characteristics of all existing instances change, too.
   1. Under **Storage**:
      * Select the disk type.
        
         
         {% include [storages-step-settings](../../_includes/mdb/settings-storages.md) %}


         You can't change the disk type for {{ mkf-name }} clusters after creation.
      * Select the size of storage to be used for data.

   
   1. Under **Network settings**:
      1. Select one or more [availability zones](../../overview/concepts/geo-scope.md) to host {{ KF }} brokers. If you create a {{ mkf-name }} cluster with one availability zone, you will not be able to increase the number of zones and brokers in the future.
      1. Select the [network](../../vpc/concepts/network.md#network).
      1. Select [subnets](../../vpc/concepts/network.md#subnet) in each availability zone for this network. To [create a new subnet](../../vpc/operations/subnet-create.md), click **Create new** subnet next to the desired availability zone.

         {% note info %}

         For a {{ mkf-name }} cluster with multiple broker hosts, you need to specify subnets in each availability zone even if you plan to host brokers only in some of them. These subnets are required to host three [{{ ZK }} hosts](../concepts/index.md), one in each availability zone. For more information, see [Resource relationships in {{ mkf-name }}](../concepts/index.md).

         {% endnote %}

      1. Select [security groups](../../vpc/concepts/security-groups.md) for the {{ mkf-name }} cluster's network traffic.

         {% include [security-groups-note-services](../../_includes/vpc/security-groups-note-services.md) %}

      1. To access broker hosts from the internet, select **Public access**. In this case, you can only connect to them over an SSL connection. For more information, see [{#T}](connect.md).


   1. Under **Hosts**:
      1. Specify the number of {{ KF }} broker hosts to be located in each of the selected availability zones.

         When choosing the number of hosts, keep in mind that:

         * Replication is possible if there are at least two hosts per {{ mkf-name }} cluster.
                  * If you selected `local-ssd` or `network-ssd-nonreplicated` under **Storage**, you need to add at least three hosts to the {{ mkf-name }} cluster.
         * To make your {{ mkf-name }} cluster fault-tolerant, you will need to meet [certain conditions](../concepts/index.md#fault-tolerance).
         * Adding more than one host to the {{ mkf-name }} cluster automatically adds three {{ ZK }} hosts.

      
      1. (Optional) Select groups of [dedicated hosts](../../compute/concepts/dedicated-host.md) to host the {{ mkf-name }} cluster on.

         {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


   1. If you specify two or more broker hosts, then under **{{ ZK }} host class**, specify the characteristics of the [{{ ZK }} hosts](../concepts/index.md) to place in each of the selected availability zones.

   1. Configure additional cluster settings, if required:

      {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

   1. Configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings), if required.
   1. Click **Create cluster**.
   1. Wait until the {{ mkf-name }} cluster is ready: its status on the {{ mkf-name }} dashboard will change to **Running** and its state to **Alive**. This may take some time.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the create {{ mkf-name }} cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster create --help
      ```

   1. Specify the {{ mkf-name }} cluster parameters in the create command (in our example, there are only some of the supported parameters):

      
      ```bash
      {{ yc-mdb-kf }} cluster create \
        --name <cluster name> \
        --environment <environment: prestable or production> \
        --version <{{ KF }} version: {{ versions.cli.str }}> \
        --network-name <network name> \
        --brokers-count <number of brokers in zone> \
        --resource-preset <host class> \
        --disk-type <disk type> \
        --disk-size <storage size, GB> \
        --assign-public-ip <public access> \
        --security-group-ids <security group ID list> \
        --deletion-protection=<cluster deletion protection: true or false>
      ```


      {% note tip %}

      You can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here, if required.

      {% endnote %}

      {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

   1. To set up a [maintenance window](../concepts/maintenance.md) (including for disabled {{ mkf-name }} clusters), provide the required value in the `--maintenance-window` parameter when creating the cluster:

      ```bash
      {{ yc-mdb-kf }} cluster create \
      ...
         --maintenance-window type=<maintenance type: anytime or weekly>,`
                             `day=<day of week for weekly>,`
                             `hour=<hour for weekly>
      ```

      Where:
      * `type`: Maintenance type:
         * `anytime`: Any time.
         * `weekly`: On a schedule.
      * `day`: Day of the week in `DDD` format for `weekly`. For example, `MON`.
      * `hour`: Hour in `HH` format for `weekly`. For example, `21`.
   1. To [manage topics via the {{ KF }} Admin API](../concepts/topics.md#management):
      1. When creating a {{ mkf-name }} cluster, set the `--unmanaged-topics` parameter to `true`:

         ```bash
         {{ yc-mdb-kf }} cluster create \
           ...
           --unmanaged-topics true
         ```

         You cannot edit this setting after you create a {{ mkf-name }} cluster.
      1. After creating a cluster, [create an admin user](./cluster-accounts.md#create-user).

   
   1. {% include [datatransfer access](../../_includes/mdb/cli/datatransfer-access-create.md) %}

   1. To create a {{ mkf-name }} cluster hosted on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), specify the host IDs as a comma-separated list in the `--host-group-ids` parameter when creating the cluster:

      ```bash
      {{ yc-mdb-kf }} cluster create \
        ...
        --host-group-ids <IDs of dedicated host groups>
      ```

      {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   
   If you do not have {{ TF }} yet, [install it and configure the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


   To create a cluster:
   1. In the configuration file, describe the parameters of the resources you want to create:
      * {{ mkf-name }} cluster: Description of a cluster and its hosts. You can also configure the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) here, if required.

      * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

      * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

      Example of the configuration file structure:

      
      
      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        environment         = "<environment: PRESTABLE or PRODUCTION>"
        name                = "<cluster name>"
        network_id          = "<network ID>"
        security_group_ids  = ["<list of cluster security group IDs>"]
        deletion_protection = <cluster deletion protection: true or false>

        config {
          assign_public_ip = "<cluster public access: true or false>"
          brokers_count    = <number of brokers>
          version          = "<{{ KF }} version: {{ versions.tf.str }}>"
          schema_registry  = "<data schema management: true or false>"
          kafka {
            resources {
              disk_size          = <storage size, GB>
              disk_type_id       = "<disk type>"
              resource_preset_id = "<host class>"
            }
          }

          zones = [
            "<availability zones>"
          ]
        }
      }

      resource "yandex_vpc_network" "<network name>" {
        name = "<network name>"
      }

      resource "yandex_vpc_subnet" "<subnet name>" {
        name           = "<subnet name>"
        zone           = "<availability zone>"
        network_id     = "<network ID>"
        v4_cidr_blocks = ["<range>"]
      }
      ```




      {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

      {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a {{ mkf-name }} cluster.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      After this, all required resources will be created in the specified folder and the [IP addresses](../../vpc/concepts/address.md) of the [VMs](../../compute/concepts/vm.md) will be displayed in the terminal. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API

   To create a cluster, use the [create](../api-ref/Cluster/create.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) gRPC API call and provide the following in the request:
   * ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ mkf-name }} cluster should be placed, in the `folderId` parameter.
   * {{ mkf-name }} cluster name in the `name` parameter.

   
   * [Security group](../../vpc/concepts/security-groups.md) identifiers in the `securityGroupIds` parameter.


   * Settings for the [maintenance window](../concepts/maintenance.md) (including those for disabled {{ mkf-name }} clusters) in the `maintenanceWindow` parameter.
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

   To [manage topics via the {{ KF }} Admin API](../concepts/topics.md#management):
   1. Pass `true` for the `unmanagedTopics` parameter. You cannot edit this setting after you create a {{ mkf-name }} cluster.
   1. After creating your {{ mkf-name }} cluster, [create an admin user](./cluster-accounts.md#create-user).

   To manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), pass the `true` value for the `configSpec.schemaRegistry` parameter. You cannot edit this setting after you create a {{ mkf-name }} cluster.

   {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

   
   To create a {{ mkf-name }} cluster deployed on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), provide a list of host IDs in the `hostGroupIds` parameter.

   {% include [Dedicated hosts note](../../_includes/mdb/mkf/note-dedicated-hosts.md) %}


{% endlist %}


{% note warning %}

If you specified security group IDs when creating a {{ mkf-name }} cluster, you may also need to [configure security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}


## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

{% list tabs %}

- CLI

   Create a {{ mkf-name }} cluster with test characteristics:

   
   * With the name `mykf`.
   * In the `production` environment.
   * With {{ KF }} version `{{ versions.cli.latest }}`.
   * In the `{{ network-name }}` network.
   * In the security group `{{ security-group }}`.
   * With one `{{ host-class }}` host in the `{{ region-id }}-a` availability zone.
   * With one broker.
   * With network SSD storage (`{{ disk-type-example }}`) of 10 GB.
   * With public access.
   * With protection against accidental cluster deletion.


   Run the following command:

   
   ```bash
   {{ yc-mdb-kf }} cluster create \
     --name mykf \
     --environment production \
     --version {{ versions.cli.latest }} \
     --network-name {{ network-name }} \
     --zone-ids {{ region-id }}-a \
     --brokers-count 1 \
     --resource-preset {{ host-class }} \
     --disk-size 10 \
     --disk-type {{ disk-type-example }} \
     --assign-public-ip \
     --security-group-ids {{ security-group }} \
     --deletion-protection=true
   ```


- {{ TF }}

   Create a {{ mkf-name }} cluster with test characteristics:
   * In the cloud with the `{{ tf-cloud-id }}` ID.
   * In the folder with the `{{ tf-folder-id }}` ID.
   * With the name `mykf`.
   * In the `PRODUCTION` environment.
   * With {{ KF }} version `{{ versions.tf.latest }}`.
   * In the new `mynet` network with the subnet `mysubnet`.

   
   * In the new security group `mykf-sg` allowing connection to the cluster from the Internet via port `9091`.


   * With one `{{ host-class }}` host in the `{{ region-id }}-a` availability zone.
   * With one broker.
   * With network SSD storage (`{{ disk-type-example }}`) of 10 GB.
   * With public access.
   * With protection against accidental cluster deletion.

   The configuration file for the {{ mkf-name }} cluster looks like this:

   
   
   ```hcl
   resource "yandex_mdb_kafka_cluster" "mykf" {
     environment         = "PRODUCTION"
     name                = "mykf"
     network_id          = yandex_vpc_network.mynet.id
     security_group_ids  = [ yandex_vpc_security_group.mykf-sg.id ]
     deletion_protection = true

     config {
       assign_public_ip = true
       brokers_count    = 1
       version          = "{{ versions.tf.latest }}"
       kafka {
         resources {
           disk_size          = 10
           disk_type_id       = "{{ disk-type-example }}"
           resource_preset_id = "{{ host-class }}"
         }
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