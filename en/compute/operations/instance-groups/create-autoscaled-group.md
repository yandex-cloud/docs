---
title: Creating an autoscaling instance group
description: Follow this guide to create an autoscaling instance group.
---

# Creating an autoscaling instance group


You can create an [autoscaling](../../concepts/instance-groups/scale.md#auto-scale) [group of same-type instances](../../concepts/instance-groups/index.md). This [instance](../../concepts/vm.md) group will scale up or down automatically.

{% include [warning.md](../../../_includes/instance-groups/warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

To be able to create, update, and delete VMs in the group, [assign](../../../iam/operations/sa/assign-role-for-sa.md) the [compute.editor](../../security/index.md#compute-editor) role to the service account.

To create an autoscaling instance group:

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-autoscaled-group-via-concole.md](../../../_includes/instance-groups/create-autoscaled-group-via-concole.md) %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for creating an instance group:

     ```bash
     {{ yc-compute-ig }} create --help
     ```

  1. Check whether the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) contains any [networks](../../../vpc/concepts/network.md#network):

     ```bash
     yc vpc network list
     ```

     If there are no networks, [create one](../../../vpc/operations/network-create.md).
  1. Select one of the {{ marketplace-full-name }} public images, e.g., [CentOS 7](/marketplace/products/yc/centos-7).

     {% include [standard-images.md](../../../_includes/standard-images.md) %}

  1. Create a YAML file with any name, e.g., `specification.yaml`.
  1. Define the following in the file you created:
     * General information about the instance group:

       ```yaml
       name: first-autoscaled-group
       service_account_id: <service_account_ID>
       description: "This instance group was created using a YAML configuration file."
       ```

       Where:
       * `name`: Instance group name. The name must be unique within the folder. It can only contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name can be up to 63 characters long.
       * `service_account_id`: [Service account](../../../iam/concepts/users/service-accounts.md) ID.

          To be able to create, update, and delete VMs in the group, [assign](../../../iam/operations/sa/assign-role-for-sa.md) the [compute.editor](../../security/index.md#compute-editor) role to the service account.

         {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

       * `description`: Instance group description.
     * [Instance template](../../concepts/instance-groups/instance-template.md), such as the following:

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
             security_group_ids:
               - enps0ar5s3ti********
         scheduling_policy:
           preemptible: false
       ```

       {% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

       Where:
       * `platform_id`: [Platform](../../concepts/vm-platforms.md) ID.
       * `memory`: Amount of memory (RAM).
       * `cores`: Number of processor cores (vCPUs).
       * `mode`: [Disk](../../concepts/disk.md) access mode.
         * `READ_ONLY`: Read-only access.
         * `READ_WRITE`: Read/write access.
       * `image_id`: Public image ID. You can view it in the [management console]({{ link-console-main }}) when creating a VM or in [{{ marketplace-name }}](/marketplace) on the image page under **Product IDs**.
       * `type_id`: Disk type.
       * `size`: Disk size.
       * `network_id`: `default-net` network ID.
       * `primary_v4_address_spec`: IPv4 specification. You can allow public access to the group instances by specifying the IP version for the [public IP address](../../../vpc/concepts/address.md#public-addresses). For more information, see [{#T}](../../concepts/instance-groups/instance-template.md#instance-template).
       * `security_group_ids`: List of [security group](../../../vpc/concepts/security-groups.md) IDs.
       * `scheduling_policy`: Scheduling policy configuration.
       * `preemptible`: Flag for creating [preemptible instances](../../concepts/preemptible-vm.md).
         * `true`: Create a preemptible instance.
         * `false` (default): Create a regular instance.

         When creating a preemptible instance group, keep in mind that the VM instances will terminate after 24 hours of continuous operation or earlier. VM instances may not be able to restart immediately due to insufficient resources. This may occur in the event of a sharp increase in the use of {{ yandex-cloud }} computing resources.
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
       * `deploy_policy`: Instance [deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for the group.
       * `scale_policy`: Instance [scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for the group.
       * `allocation_policy`: [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) instances across [availability zones](../../../overview/concepts/geo-scope.md).

     Full code for the `specification.yaml` file:

     ```yaml
     name: first-autoscaled-group
     service_account_id: <service_account_ID>
     description: "This instance group was created using a YAML configuration file."
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
           security_group_ids:
             - enps0ar5s3ti********
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

     This command will create an autoscaling instance group with the following configuration:
     * Name: `first-autoscaled-group`.
     * OS: CentOS 7.
     * Network: `default-net`.
     * Availability zone: `{{ region-id }}-a`.
     * vCPU: 2, RAM: 2 GB.
     * Network [HDD](../../concepts/disk.md#disks-types): 32 GB.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, define the parameters of the resources you want to create:

     ```hcl
     resource "yandex_iam_service_account" "ig-sa" {
       name        = "ig-sa"
       description = "Service account for managing the instance group."
     }

     resource "yandex_resourcemanager_folder_iam_member" "compute_editor" {
       folder_id = "<folder_ID>"
       role      = "compute.editor"
       member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
     }

     resource "yandex_compute_instance_group" "ig-1" {
       name               = "autoscaled-ig"
       folder_id          = "<folder_ID>"
       service_account_id = "${yandex_iam_service_account.ig-sa.id}"
       deletion_protection = "<deletion_protection>"
       instance_template {
         platform_id = "standard-v3"
         resources {
           memory = <RAM_in_GB>
           cores  = <number_of_vCPUs>
         }

         boot_disk {
           mode = "READ_WRITE"
           initialize_params {
             image_id = "<image_ID>"
           }
         }

         network_interface {
           network_id         = "${yandex_vpc_network.network-1.id}"
           subnet_ids         = ["${yandex_vpc_subnet.subnet-1.id}"]
           security_group_ids = ["<list_of_security_group_IDs>"]
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
     * `yandex_iam_service_account`: [Service account](../../../iam/concepts/users/service-accounts.md) description. All instance group operations are performed on behalf of the service account.
     * `yandex_resourcemanager_folder_iam_member`: Description of access permissions for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the service account belongs to. To be able to create, update, and delete VM instances in the instance group, assign the `compute.editor` [role](../../security/index.md#compute-editor) to the service account.
     * `yandex_compute_instance_group`: Instance group description.
       * General information about the instance group:
         * `name`: Instance group name.
         * `folder_id`: Folder ID.
         * `service_account_id`: [Service account](../../../iam/concepts/users/service-accounts.md) ID.
         * `deletion_protection`: Instance group protection against deletion, `true` or `false`. You cannot delete an instance group with this option enabled. The default value is `false`.
       * [Instance template](../../concepts/instance-groups/instance-template.md):
         * `platform_id`: [Platform](../../concepts/vm-platforms.md).
         * `resources`: Number of vCPUs and amount of RAM available to the VM instance. The values must match the selected platform.
         * `boot_disk`: Boot [disk](../../concepts/disk.md) settings.
           * ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).
           * Disk access mode: `READ_ONLY` or `READ_WRITE`.
         * `network_interface`: [Network](../../../vpc/concepts/network.md#network) settings. Specify the IDs of your network, [subnet](../../../vpc/concepts/network.md#subnet), and [security groups](../../../vpc/concepts/security-groups.md).
         * `metadata`: In [metadata](../../concepts/vm-metadata.md), provide the public key for SSH access to the VM. For more information, see [{#T}](../../concepts/vm-metadata.md).
       * [Policies](../../concepts/instance-groups/policies/index.md):
         * `deploy_policy`: Instance [deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for the group.
         * `scale_policy`: Instance [scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for the group.
         * `allocation_policy`: [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) instances across [availability zones](../../../overview/concepts/geo-scope.md).
     * `yandex_vpc_network`: Cloud network description.
     * `yandex_vpc_subnet`: Description of the subnet to connect the instance group to.

       {% note info %}

       If you already have suitable resources, such as a service account, cloud network, and subnet, you do not need to redefine them. Specify their names and IDs in the appropriate parameters.

       {% endnote %}

     For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [create](../../instancegroup/api-ref/InstanceGroup/create.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md) gRPC API call.

{% endlist %}

{% include [password-reset-note](../../../_includes/compute/password-reset-note.md) %}