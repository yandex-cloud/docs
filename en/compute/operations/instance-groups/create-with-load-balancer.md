# Creating a fixed-size instance group with an L7 load balancer

You can create a fixed-size [instance group](../../concepts/instance-groups/index.md) integrated with [{{ alb-full-name }}](../../../application-load-balancer/index.yaml). A {{ alb-name }} target group will be automatically created along with the instance group. You can link it to your load balancer and distribute the load across the instances in the group at the application level. For more information, see [{#T}](../../concepts/instance-groups/balancers.md).

{% include [alb-warning.md](../../../_includes/instance-groups/alb-warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

{% include [password-reset-note](../../../_includes/compute/password-reset-note.md) %}

To create an instance group with an L7 load balancer:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create your instance group in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
   1. Click **{{ ui-key.yacloud.compute.groups.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
      * Enter a name and description of the instance group. The naming requirements are as follows:

         {% include [name-format](../../../_includes/name-format.md) %}

         {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Select a [service account](../../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete instances in the instance group, assign the `editor` [role](../../../iam/concepts/access-control/roles.md) to the service account. By default, all operations in {{ ig-name }} are performed on behalf of a service account.

         {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

      * Enable the **{{ ui-key.yacloud.compute.groups.create.field_deletion-protection }}** option, if needed. You cannot delete a group with this option enabled.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select the required ones in the **{{ ui-key.yacloud.compute.groups.create.field_zone }}** field. Instances of a group may reside in [different availability zones and regions](../../../overview/concepts/geo-scope.md).
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** to set up the configuration for a basic instance:
      * Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a description for the [template](../../concepts/instance-groups/instance-template.md).
      * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select a system to be deployed on the VM instance's boot [disk](../../concepts/disk.md).
      * Under **{{ ui-key.yacloud.compute.instances.create.section_disk }}**:
         * Select the [disk type](../../../compute/concepts/disk.md#disks_types).
         * Specify disk size.
         * To add more disks, click **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.
      * Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
         * Choose a [platform](../../../compute/concepts/vm-platforms.md).
         * Enter the required number of vCPUs, [guaranteed vCPU performance](../../concepts/performance-levels.md), and the amount of RAM.

         * {% include [include](../../../_includes/instance-groups/specify-preemptible-vm.md) %}

      * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

         {% include [network-settings-group](../../../_includes/compute/network-settings-group.md) %}

      * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:
         * Select a service account to link to the instance.
         * If you selected a Linux [image](../../concepts/image.md), fill out the fields **{{ ui-key.yacloud.compute.instances.create.field_user }}** and **{{ ui-key.yacloud.compute.instances.create.field_key }}**. For a key, use the contents of the [public key](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.
         * Select `{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}`, if needed.
      * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**:
      * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-expansion }}** field, specify the number of instances you can exceed the group size by.
      * In the field **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}**, specify the number of instances you can decrease the group size by.
      * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-creating }}** field, specify how many instances can be created at the same time.
      * In **{{ ui-key.yacloud.compute.groups.create.field_deploy-startup-duration }}**, specify the period after which the VM instance will start receiving the load.
      * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-deleting }}** field, specify how many instances can be stopped at the same time.
      * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-strategy }}** field, specify one of the [strategies](../../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy):
         * `{{ ui-key.yacloud.compute.groups.create.value_strategy-proactive }}`: {{ ig-name }} selects which instances to stop when updating or reducing the group on its own.
         * `{{ ui-key.yacloud.compute.groups.create.value_strategy-opportunistic }}`: {{ ig-name }} waits for the instances to stop on their own or by the user.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**:
      * Select the `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed }}`[scaling type](../../../compute/concepts/instance-groups/scale.md).
      * Specify the instance group size.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_alb }}**, enable the **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** option.
   1. Specify the target group settings. For more information, see [{#T}](../../concepts/instance-groups/balancers.md#settings-alb).
   1. If needed, enable the **{{ ui-key.yacloud.compute.groups.create.section_health-check }}** to get information about the state of instances and their automatic recovery on failure.
      * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** field, select the protocol for the health checks: `{{ ui-key.yacloud.common.label_http }}` or `{{ ui-key.yacloud.common.label_tcp }}`.
      * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** field (for the HTTP type), specify the URL path for the HTTP check requests sent from {{ ig-name }}.
      * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** field, specify the port number from 1 to 32767 for {{ ig-name }} to send the health check requests to.
      * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}** field, specify the response wait time from 1 to 60 seconds.
      * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}** field, specify the interval between the repeat checks from 1 to 60 seconds. The interval must be at least 1 second longer than the timeout.
      * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}** field, specify the number of successful health checks required for the instance to be considered healthy.
      * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}** field, specify the number of failed health checks for the instance to be considered unhealthy.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_variables }}**, enter the `{{ ui-key.yacloud.common.label_key }}`-`{{ ui-key.yacloud.common.label_value }}` pairs, if needed.
   1. Click **{{ ui-key.yacloud.common.create }}**.

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
         name: first-fixed-group-with-l7-balancer
         service_account_id: <ID>
         description: "This instance group was created from YAML config."
         ```

         Where:
         * `name`: Name of the instance group. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name may be up to 63 characters long.
         * `service_account_id`: Service account ID.

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
           placement_policy:
             placement_group_id: rmppvhrgm77g********
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
         * `image_id`: ID of the public image. You can view image IDs in the [management console]({{ link-console-main }}) when creating a VM or in [{{ marketplace-name }}](/marketplace) on the image page under **Product IDs**.
         * `type_id`: Disk type.
         * `size`: Disk size.
         * `network_id`: ID of the `default-net` network.
         * `primary_v4_address_spec`: IPv4 specification. You can allow public access to the group's instances by specifying the IP version for the [public IP address](../../../vpc/concepts/address.md#public-addresses). For more information, see [{#T}](../../concepts/instance-groups/instance-template.md#instance-template).
         * `scheduling_policy`: Scheduling policy configuration.
         * `preemptible`: Flag indicating whether [preemptible VMs](../../concepts/preemptible-vm.md) are created.
            * `true`: Create a preemptible VM.
            * `false` (default): Create a regular VM.

            When creating a preemptible instance group, keep in mind that the VM instances will terminate after 24 hours of continuous operation or earlier. {{ ig-name }} may not be able to restart them immediately due to insufficient resources. This may occur in the event of a sharp increase in the use of {{ yandex-cloud }} computing resources.
         * `placement_policy`: (Optional) [VM placement group](../../concepts/placement-groups.md) parameters:
            * `placement_group_id`: Placement group ID.
      * [Policies](../../concepts/instance-groups/policies/index.md):

         ```yaml
         deploy_policy:
           max_unavailable: 1
           max_expansion: 0
         scale_policy:
           fixed_scale:
             size: 3
         allocation_policy:
           zones:
             - zone_id: {{ region-id }}-a
               instance_tags_pool:
               - first
               - second
               - third
         ```

         Where:
         * `deploy_policy`: [Deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for instances in the group.
         * `scale_policy`: [Scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for instances in the group.
         * `allocation_policy`: [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) VM instances by [availability zone](../../../overview/concepts/geo-scope.md) and region.
      * {{ alb-full-name }} [target group](../../../application-load-balancer/concepts/target-group.md):

         ```yaml
         application_load_balancer_spec:
           target_group_spec:
             name: first-target-group
         ```

         Where:
         * `target_group_spec`: Specification of the {{ alb-name }} target group associated with the instance group.
         * `name`: Any name of the {{ alb-name }} target group. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name may be up to 63 characters long.

         For more information about the target group settings, see [{#T}](../../concepts/instance-groups/balancers.md#settings-alb).

     Full code for the `specification.yaml` file:

     ```yaml
     name: first-fixed-group-with-l7-balancer
     service_account_id: <ID>
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
       placement_policy:
          placement_group_id: rmppvhrgm77g********
     deploy_policy:
       max_unavailable: 1
       max_expansion: 0
     scale_policy:
        fixed_scale:
         size: 3
     allocation_policy:
       zones:
         - zone_id: {{ region-id }}-a
           instance_tags_pool:
           - first
           - second
           - third
     application_load_balancer_spec:
       target_group_spec:
         name: first-target-group
     ```

   1. Create an instance group in the default folder:

      ```bash
      {{ yc-compute-ig }} create --file specification.yaml
      ```

      This command creates a group of three similar instances with the following configuration:
      * Named `first-fixed-group-with-l7-balancer`.
      * Running CentOS 7.
      * In the `default-net` network.
      * In the `{{ region-id }}-a` availability zone.
      * With 2 vCPUs and 2 GB of RAM.
      * With a 32 GB network HDD.
      * With a target group named `first-target-group`.

   After that, you can add the `first-target-group` target group to a [new](../../../application-load-balancer/operations/backend-group-create.md) or [existing group of {{ alb-name }} backends](../../../application-load-balancer/operations/backend-group-update.md), a backend group to a [new](../../../application-load-balancer/operations/http-router-create.md) or [existing HTTP router](../../../application-load-balancer/operations/http-router-update.md), and a router to a [new](../../../application-load-balancer/operations/application-load-balancer-create.md) or [existing L7 load balancer](../../../application-load-balancer/operations/application-load-balancer-update.md).

- {{ TF }}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

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
        name                = "fixed-ig-with-balancer"
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
          fixed_scale {
            size = <number_of_instances_in_the_group>
          }
        }

        allocation_policy {
          zones = ["{{ region-id }}-a"]
        }

        deploy_policy {
          max_unavailable = 1
          max_expansion   = 0
        }

        application_load_balancer {
          target_group_name        = "target-group"
          target_group_description = "load balancer target group"
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
      * `yandex_iam_service_account`: Description of the [service account](../../../iam/concepts/users/service-accounts.md). All operations in {{ ig-name }} are performed on behalf of the service account.

         {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

      * `yandex_resourcemanager_folder_iam_member`: Description of access rights to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the service account belongs to. To be able to create, update, and delete instances in the instance group, assign the `editor` [role](../../../iam/concepts/access-control/roles.md) to the service account.
      * `yandex_compute_instance_group`: Description of the instance group:
         * General information about the instance group:
            * `name`: Name of the instance group.
            * `folder_id`: Folder ID.
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
         * {{ alb-full-name }} [target group](../../../application-load-balancer/concepts/target-group.md):
            * `target_group_name`: Name of the target group.
            * `target_group_description`: Description of the target group.
               For more information about target group settings, see [{#T}](../../concepts/instance-groups/balancers.md#settings-alb).
      * `yandex_vpc_network`: Description of the cloud network.
      * `yandex_vpc_subnet`: Description of the subnet the instance group will connect to.

      {% note info %}

      If you already have suitable resources, such as a service account, cloud network, and subnet, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

      {% endnote %}

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).
   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API

   Use the [create](../../api-ref/InstanceGroup/create.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Create](../../api-ref/grpc/instance_group_service.md#Create) gRPC API call.

{% endlist %}
