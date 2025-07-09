---
title: Creating a fixed-size instance group with an L7 load balancer
description: Follow this guide to create a fixed-size instance group with an L7 load balancer.
---

# Creating a fixed-size instance group with an L7 load balancer


You can create a fixed-size [instance group](../../concepts/instance-groups/index.md) integrated with [{{ alb-full-name }}](../../../application-load-balancer/). An {{ alb-name }} [target group](../../../application-load-balancer/concepts/target-group.md) will be automatically created along with the [instance](../../concepts/vm.md) group. You can link it to your [load balancer](../../../application-load-balancer/concepts/index.md) and distribute the load across the instances in the group at the application level. For more information, see [{#T}](../../concepts/instance-groups/balancers.md).

{% include [alb-warning.md](../../../_includes/instance-groups/alb-warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

To create, update, and delete VM instances in the group, as well as integrate the group with an {{ alb-name }} L7 load balancer, you will need to [assign](../../../iam/operations/sa/assign-role-for-sa.md) the [compute.editor](../../security/index.md#compute-editor) and [alb.editor](../../../application-load-balancer/security/index.md#alb-editor) roles to a service account.

{% include [password-reset-note](../../../_includes/compute/password-reset-note.md) %}

To create an instance group with an L7 load balancer:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your instance group.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Click **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
     * Enter a name and description for your instance group. The naming requirements are as follows:

       {% include [name-format](../../../_includes/name-format.md) %}

       {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     * Select the [service account](../../../iam/concepts/users/service-accounts.md) from the list or create a new one. To create, update, and delete VM instances in the group, as well as integrate the group with an {{ alb-name }} L7 load balancer, you will need to [assign](../../../iam/operations/sa/assign-role-for-sa.md) the [compute.editor](../../security/index.md#compute-editor) and [alb.editor](../../../application-load-balancer/security/index.md#alb-editor) roles to a service account. By default, all operations you perform with an instance group are run under a service account.

       {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

     * Enable **{{ ui-key.yacloud.compute.groups.create.field_deletion-protection }}**, if required. You cannot delete a group while it is enabled.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select the required zones in the **{{ ui-key.yacloud.compute.groups.create.field_zone }}** field. Instances from a single group may reside in [different availability zones](../../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** to configure a basic instance:
     * Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a description for the [template](../../concepts/instance-groups/instance-template.md).
     * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the system to deploy on the VM instance boot [disk](../../concepts/disk.md).
     * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**:
       * Select the [disk type](../../../compute/concepts/disk.md#disks_types).
       * Specify the disk size.
       * To add more disks, click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
     * Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
       * Select a [platform](../../../compute/concepts/vm-platforms.md).
       * Enter the required number of vCPUs, [guaranteed vCPU share](../../concepts/performance-levels.md), and the amount of RAM.
       * {% include [include](../../../_includes/instance-groups/specify-preemptible-vm.md) %}
       * Optionally, enable a [software-accelerated network](../../concepts/software-accelerated-network.md).
     * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

       {% include [network-settings-group](../../../_includes/compute/network-settings-group.md) %}

     * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the VM access credentials:
       * Select the service account to link to the VM instance.
       * If you selected a Linux [image](../../concepts/image.md), fill out the **{{ ui-key.yacloud.compute.instances.create.field_user }}** and **{{ ui-key.yacloud.compute.instances.create.field_key }}** fields. Provide the contents of the [public key](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file as the key value.
       * Enable `{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}`, if required.
     * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**:
      * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-expansion }}** field, specify the maximum number of instances the group size can be scaled up by.

          {% include [max-expansion-notice](../../../_includes/instance-groups/max-expansion-notice.md) %}
      * In the field **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}**, specify the maximum number of instances the group size can be scaled down by.
      * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-creating }}** field, specify how many instances can be created at the same time.
      * In **{{ ui-key.yacloud.compute.groups.create.field_deploy-startup-duration }}**, specify the period after which the instance will start receiving traffic.
      * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-deleting }}** field, specify how many instances can be stopped at the same time.
      * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-strategy }}** field, specify one of these [strategies](../../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy):
        * `{{ ui-key.yacloud.compute.groups.create.value_strategy-proactive }}`: {{ ig-name }} automatically selects which instances to stop when updating or scaling down the group.
        * `{{ ui-key.yacloud.compute.groups.create.value_strategy-opportunistic }}`: {{ ig-name }} waits for the instances to stop on their own or for the user to stop them.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**:
     * Select the `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed }}` [scaling type](../../../compute/concepts/instance-groups/scale.md).
     * Specify the instance group size.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_alb }}**, enable **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}**.
  1. Specify the target group settings. For more information, see [{#T}](../../concepts/instance-groups/balancers.md#settings-alb).
  1. Optionally, enable **{{ ui-key.yacloud.compute.groups.create.section_health-check }}** to get information about the state of instances and automatically recover them in case of failure.
     * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** field, select the protocol for health checks: `{{ ui-key.yacloud.common.label_http }}` or `{{ ui-key.yacloud.common.label_tcp }}`.
     * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** field (for the HTTP type), specify the URL path {{ ig-name }} will use to send HTTP check requests.
     * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** field, specify the port number (between 1 and 32767) for {{ ig-name }} to send health check requests to.
     * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}** field, specify a response timeout of 1 to 60 seconds.
     * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}** field, specify a health check interval of 1 to 60 seconds. The interval must be at least 1 second longer than the response timeout.
     * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}** field, specify the number of successful health checks required to consider the instance healthy.
     * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}** field, specify the number of failed health checks required to consider the instance unhealthy.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_variables }}**, enter the `{{ ui-key.yacloud.common.label_key }}`-`{{ ui-key.yacloud.common.value }}` pairs, if required.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating an instance group:

     ```bash
     {{ yc-compute-ig }} create --help
     ```

  1. Check whether the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) contains any [networks](../../../vpc/concepts/network.md#network):

     ```bash
     yc vpc network list
     ```

     If there are no networks, [create one](../../../vpc/operations/network-create.md).
  1. Select one of the {{ marketplace-full-name }} public [images](../../concepts/image.md), e.g., [CentOS 7](/marketplace/products/yc/centos-7).

     {% include [standard-images.md](../../../_includes/standard-images.md) %}

  1. Create a YAML file with any name, e.g., `specification.yaml`.
  1. Define the following in the file you created:
     * General information about the instance group:

       ```yaml
       name: first-fixed-group-with-l7-balancer
       service_account_id: <service_account_ID>
       description: "This instance group was created using a YAML configuration file."
       ```

       Where:
       * `name`: Instance group name. The name must be unique within the folder. It can only contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name can be up to 63 characters long.
       * `service_account_id`: [Service account](../../../iam/concepts/users/service-accounts.md) ID.

         To create, update, and delete VM instances in the group, as well as integrate the group with an {{ alb-name }} L7 load balancer, you will need to [assign](../../../iam/operations/sa/assign-role-for-sa.md) the [compute.editor](../../security/index.md#compute-editor) and [alb.editor](../../../application-load-balancer/security/index.md#alb-editor) roles to a service account. By default, all operations you perform with an instance group are run under a service account.

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
         placement_policy:
           placement_group_id: rmppvhrgm77g********
         scheduling_policy:
           preemptible: false
         ```

         {% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

         Where:
         * `platform_id`: [Platform](../../concepts/vm-platforms.md) ID.
         * `memory`: Amount of RAM.
         * `cores`: Number of vCPUs.
         * `mode`: [Disk](../../concepts/disk.md) access mode.
           * `READ_ONLY`: Read-only access.
           * `READ_WRITE`: Read/write access.
         * `image_id`: Public image ID. You can view image IDs in the [management console]({{ link-console-main }}) when creating an instance or in [{{ marketplace-name }}](/marketplace) on the image page under **Product IDs**.
         * `type_id`: [Disk type](../../../compute/concepts/disk.md#disks_types).
         * `size`: Disk size.
         * `network_id`: `default-net` network ID.
         * `primary_v4_address_spec`: IPv4 specification. You can allow public access to the group instances by specifying the IP version for the [public IP address](../../../vpc/concepts/address.md#public-addresses). For more information, see [{#T}](../../concepts/instance-groups/instance-template.md#instance-template).
         * `security_group_ids`: List of [security group](../../../vpc/concepts/security-groups.md) IDs.
         * `scheduling_policy`: Scheduling policy configuration.
         * `preemptible`: Flag for creating [preemptible instances](../../concepts/preemptible-vm.md).
           * `true`: Create a preemptible instance.
           * `false` (default): Create a regular instance.

           When creating a preemptible instance group, keep in mind that the VM instances will terminate after 24 hours of continuous operation or earlier. {{ ig-name }} may not be able to restart them immediately due to insufficient resources. This may occur in the event of a sharp increase in the use of {{ yandex-cloud }} computing resources.
         * `placement_policy` (optional): [Instance placement group](../../concepts/placement-groups.md) parameters:
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
       * `deploy_policy`: Instance [deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for the group.
       * `scale_policy`: Instance [scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for the group.
       * `allocation_policy`: [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) instances across [availability zones](../../../overview/concepts/geo-scope.md).
     * {{ alb-full-name }} [target group](../../../application-load-balancer/concepts/target-group.md):

       ```yaml
       application_load_balancer_spec:
         target_group_spec:
           name: first-target-group
       ```

       Where:
       * `target_group_spec`: Specification of the {{ alb-name }} target group linked to the instance group.
       * `name`: Name for the {{ alb-name }} target group. The name must be unique within the folder. It can only contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name can be up to 63 characters long.

       For more information about target group settings, see [{#T}](../../concepts/instance-groups/balancers.md#settings-alb).

     Full code for the `specification.yaml` file:

     ```yaml
     name: first-fixed-group-with-l7-balancer
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

     This command will create a group of three same-type instances with the following configuration:
     * Name: `first-fixed-group-with-l7-balancer`.
     * OS: CentOS 7.
     * Network: `default-net`.
     * Availability zone: `{{ region-id }}-a`.
     * vCPUs: 2; RAM: 2 GB.
     * Network HDD: 32 GB.
     * Target group: `first-target-group`.

  After that, you will be able to add `first-target-group` to a [new](../../../application-load-balancer/operations/backend-group-create.md) or [existing group of {{ alb-name }} backends](../../../application-load-balancer/operations/backend-group-update.md), a backend group to a [new](../../../application-load-balancer/operations/http-router-create.md) or [existing HTTP router](../../../application-load-balancer/operations/http-router-update.md), and a router to a [new](../../../application-load-balancer/operations/application-load-balancer-create.md) or [existing L7 load balancer](../../../application-load-balancer/operations/application-load-balancer-update.md).

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

     resource "yandex_resourcemanager_folder_iam_member" "load-balancer-editor" {
       folder_id = "<folder_ID>"
       role      = "alb.editor"
       member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
     }

     resource "yandex_compute_instance_group" "ig-1" {
       name                = "fixed-ig-with-balancer"
       folder_id           = "<folder_ID>"
       service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
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
         fixed_scale {
           size = <number_of_instances_in_group>
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
         target_group_description = "{{ network-load-balancer-name }} target group"
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
     * `yandex_iam_service_account`: [Service account](../../../iam/concepts/users/service-accounts.md) description. In {{ ig-name }}, all operations are performed under a service account.

       {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

     * `yandex_resourcemanager_folder_iam_member`: Description of the service account's access permissions for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder), where:
       * `role = "compute.editor"`: Service account gets the [compute.editor](../../security/index.md#compute-editor) role to create, update, and delete the group's VMs.
       * `role = "alb.editor"`: Service account gets the [alb.editor](../../../application-load-balancer/security/index.md#alb-editor) role to integrate the instance group with an {{ alb-name }}.
     * `yandex_compute_instance_group`: Instance group description:
       * General information about the instance group:
         * `name`: Instance group name.
         * `folder_id`: Folder ID.
         * `service_account_id`: Service account ID.
         * `deletion_protection`: Instance group protection against deletion, `true` or `false`. You cannot delete a group while the value is `true`. The default value is `false`.
       * [Instance template](../../concepts/instance-groups/instance-template.md):
         * `platform_id`: [Platform](../../concepts/vm-platforms.md).
         * `resources`: Number of vCPUs and amount of RAM available to the VM instance. The values must match the selected platform.
         * `boot_disk`: Boot [disk](../../concepts/disk.md) settings.
           * ID of the selected [image](../../concepts/image.md). You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).
           * Disk access mode: `READ_ONLY` or `READ_WRITE`.
         * `network_interface`: [Network](../../../vpc/concepts/network.md#network) settings. Specify the IDs of your network, [subnet](../../../vpc/concepts/network.md#subnet), and [security groups](../../../vpc/concepts/security-groups.md).
         * `metadata`: In [metadata](../../concepts/vm-metadata.md), provide the [public key](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) for SSH access to the instance. For more information, see [{#T}](../../concepts/vm-metadata.md).
       * [Policies](../../concepts/instance-groups/policies/index.md):
         * `deploy_policy`: Instance [deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for the group.
         * `scale_policy`: Instance [scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for the group.
         * `allocation_policy`: [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) instances across [availability zones](../../../overview/concepts/geo-scope.md).
       * {{ alb-full-name }} [target group](../../../application-load-balancer/concepts/target-group.md):
         * `target_group_name`: Target group name.
         * `target_group_description`: Target group description.
         For more information about target group settings, see [{#T}](../../concepts/instance-groups/balancers.md#settings-alb).
     * `yandex_vpc_network`: Cloud network description.
     * `yandex_vpc_subnet`: Description of the subnet to which you connect the instance group.

     {% note info %}

     If you already have suitable resources, such as a service account, cloud network, and subnet, you do not need to redefine them. Specify their names and IDs in the appropriate parameters.

     {% endnote %}

     For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [create](../../instancegroup/api-ref/InstanceGroup/create.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md) gRPC API call.

{% endlist %}