# Creating an automatically scaled instance group

You can create an automatically scaled [group of identical instances](../../concepts/instance-groups/index.md). The size of this instance group will be managed automatically. For more information, see [{#T}](../../concepts/instance-groups/scale.md#auto-scale).

{% include [warning.md](../../../_includes/instance-groups/warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

To create an automatically scaled instance group:

{% list tabs %}

- Management console

   {% include [create-autoscaled-group-via-concole.md](../../../_includes/instance-groups/create-autoscaled-group-via-concole.md) %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to create an instance group:

      ```bash
      {{ yc-compute-ig }} create --help
      ```

  1. Check whether there are [networks](../../../vpc/concepts/network.md#network) in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc vpc network list
      ```

      If there are not any, [create one](../../../vpc/operations/network-create.md).
  1. Select one of the {{ marketplace-full-name }} public images, e.g., [CentOS 7](/marketplace/products/yc/centos-7).

     {% include [standard-images.md](../../../_includes/standard-images.md) %}

  1. Create a YAML file with any name (for example, `specification.yaml`).
  1. In the created file, indicate the following:
     * General information about the instance group:

         ```yaml
         name: first-autoscaled-group
         service_account_id: <ID>
         description: "This instance group was created from YAML config."
         ```

         Where:
         * `name`: Name of the instance group. The name must be unique within the folder. It may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name may not be longer than 63 characters.
         * `service_account_id`: [Service account](../../../iam/concepts/users/service-accounts.md) ID.

            {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

     * `description`: Description of the instance group.

     * [Instance template](../../concepts/instance-groups/instance-template.md), such as:

         ```yaml
         instance_template:
           platform_id: standard-v3
           resources_spec:
             memory: 2g
             cores: 2
           boot_disk_spec:
             mode: READ_WRITE
             disk_spec:
               image_id: fdvk34al8k5n********
               type_id: network-hdd
               size: 32g
           network_interface_specs:
             - network_id: c64mknqgnd8a********
               primary_v4_address_spec: {}
           scheduling_policy:
             preemptible: false
         ```

         {% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

         Where:
         * `platform_id`: [Platform](../../concepts/vm-platforms.md) ID.
         * `memory`: Amount of RAM.
         * `cores`: Number of processor cores (vCPUs).
         * `mode`: [Disk](../../concepts/disk.md) access mode.
            * `READ_ONLY`: Read-only access.
            * `READ_WRITE`: Read/write access.
         * `image_id`: ID of the public image. You can view it in the [management console]({{ link-console-main }}) when creating a VM or in [{{ marketplace-name }}](/marketplace) on the image page under **Product IDs**.
         * `type_id`: Disk type.
         * `size`: Disk size.
         * `network_id`: ID of `default-net`.
         * `primary_v4_address_spec`: IPv4 specification. You can allow public access to the group's instances by specifying the IP version for the [public IP address](../../../vpc/concepts/address.md#public-addresses). For more information, see [{#T}](../../concepts/instance-groups/instance-template.md#instance-template).
         * `scheduling_policy`: Scheduling policy configuration.
         * `preemptible`: Flag indicating whether [preemptible VMs](../../concepts/preemptible-vm.md) are created.
            * `true`: Create a preemptible VM.
            * `false` (default): Create a regular VM.

            When creating a preemptible instance group, keep in mind that the VM instances will terminate after 24 hours of continuous operation or earlier. It is possible that {{ ig-name }} will not be able to restart them immediately due to insufficient resources. This may occur in the event of a sharp increase in the use of {{ yandex-cloud }} computing resources.
     * [Policies](../../concepts/instance-groups/policies/index.md):

       ```yaml
       deploy_policy:
         max_unavailable: 1
         max_expansion: 0
       scale_policy:
         auto_scale:
           initial_size: 5
           max_size: 15
           min_zone_size: 3
           measurement_duration: 30s
           warmup_duration: 60s
           stabilization_duration: 120s
           cpu_utilization_rule: 0.75
       allocation_policy:
         zones:
           - zone_id: {{ region-id }}-a
       ```

       Where:
       * `deploy_policy`: [Deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for instances in the group.
       * `scale_policy`: [Scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for instances in the group.
       * `allocation_policy`: [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) VM instances by [availability zone](../../../overview/concepts/geo-scope.md) and region.

     Full code for the `specification.yaml` file:

     ```yaml
     name: first-autoscaled-group
     service_account_id: ajed6ilf11qg********
     description: "This instance group was created from YAML config."
     instance_template:
       platform_id: standard-v3
       resources_spec:
         memory: 2g
         cores: 2
       boot_disk_spec:
         mode: READ_WRITE
         disk_spec:
           image_id: fdvk34al8k5n********
           type_id: network-hdd
           size: 32g
       network_interface_specs:
         - network_id: c64mknqgnd8a********
           primary_v4_address_spec: {}
     deploy_policy:
       max_unavailable: 1
       max_expansion: 0
     scale_policy:
       auto_scale:
         initial_size: 5
         max_size: 15
         min_zone_size: 3
         measurement_duration: 30s
         warmup_duration: 60s
         stabilization_duration: 120s
         cpu_utilization_rule:
           utilization_target: 75
     allocation_policy:
       zones:
         - zone_id: {{ region-id }}-a
     ```

  1. Create an instance group in the default folder:

     ```bash
     {{ yc-compute-ig }} create --file specification.yaml
     ```

     This command creates an automatically scaled instance group with the following characteristics:
     * Named `first-autoscaled-group`.
     * Running CentOS 7.
     * In the `default-net` network.
     * In the `{{ region-id }}-a` availability zone.
     * With 2 vCPUs and 2 GB of RAM.
     * With a 32 GB network HDD.

- API

  Use the [create](../../api-ref/InstanceGroup/create.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Create](../../api-ref/grpc/instance_group_service.md#Create) gRPC API call.

- {{ TF }}

  If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_iam_service_account" "ig-sa" {
        name        = "ig-sa"
        description = "service account to manage IG"
      }

      resource "yandex_resourcemanager_folder_iam_member" "editor" {
        folder_id = "<folder_ID>"
        role      = "editor"
        member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
      }

      resource "yandex_compute_instance_group" "ig-1" {
        name                = "autoscaled-ig"
        folder_id           = "<folder_ID>"
        service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
        deletion_protection = "<deletion_protection:_true_or_false>"
        instance_template {
          platform_id = "standard-v3"
          resources {
            memory = <amount_of_RAM_in_GB>
            cores  = <number_of_vCPU_cores>
          }

          boot_disk {
            mode = "READ_WRITE"
            initialize_params {
              image_id = "<image_ID>"
            }
          }

          network_interface {
            network_id = "${yandex_vpc_network.network-1.id}"
            subnet_ids = ["${yandex_vpc_subnet.subnet-1.id}"]
          }

          metadata = {
            ssh-keys = "<username>:<SSH_key_contents>"
          }
        }

        scale_policy {
          auto_scale {
            initial_size           = 3
            measurement_duration   = 60
            cpu_utilization_target = 75
            min_zone_size          = 3
            max_size               = 15
            warmup_duration        = 60
            stabilization_duration = 120
          }
        }

        allocation_policy {
          zones = ["{{ region-id }}-a"]
        }

        deploy_policy {
          max_unavailable = 1
          max_expansion   = 0
        }
      }

      resource "yandex_vpc_network" "network-1" {
        name = "network1"
      }

      resource "yandex_vpc_subnet" "subnet-1" {
        name           = "subnet1"
        zone           = "{{ region-id }}-a"
        network_id     = "${yandex_vpc_network.network-1.id}"
        v4_cidr_blocks = ["192.168.10.0/24"]
      }
      ```

      Where:
      * `yandex_iam_service_account`: Description of a [service account](../../../iam/concepts/users/service-accounts.md). All operations in {{ ig-name }} are performed on behalf of the service account.
      * `yandex_resourcemanager_folder_iam_member`: Description of access rights to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the service account belongs to. To be able to create, update, and delete group instances, assign the `editor` [role](../../../iam/concepts/access-control/roles.md) to the service account.
      * `yandex_compute_instance_group`: Description of the instance group.
         * General information about the instance group:
            * `name`: Name of the instance group.
            * `folder_id`: ID of the folder.
            * `service_account_id`: Service account ID.
            * `deletion_protection`: Instance group deletion protection. You cannot delete an instance group with this option enabled. The default value is `false`.
         * [Instance template](../../concepts/instance-groups/instance-template.md):
            * `platform_id`: [Platform](../../concepts/vm-platforms.md).
            * `resources`: Number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
            * `boot_disk`: Boot [disk](../../concepts/disk.md) settings.
               * ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).
               * Disk access mode: `READ_ONLY` (read) or `READ_WRITE` (read and write).
            * `network_interface`: [Network](../../../vpc/concepts/network.md#network) settings. Specify the network ID and [subnet](../../../vpc/concepts/network.md#subnet) ID.
            * `metadata`: In the [metadata](../../concepts/vm-metadata.md), provide the public key for VM access via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
         * [Policies](../../concepts/instance-groups/policies/index.md):
            * `deploy_policy`: [Deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for instances in the group.
            * `scale_policy`: [Scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for instances in the group.
            * `allocation_policy`: [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) VM instances by [availability zone](../../../overview/concepts/geo-scope.md) and region.
      * `yandex_vpc_network`: Description of the cloud network.
      * `yandex_vpc_subnet`: Description of the subnet the instance group will connect to.

       {% note info %}

       If you already have suitable resources, such as a service account, cloud network, and subnet, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

       {% endnote %}

     For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).
  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      All the resources you need will then be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

{% endlist %}