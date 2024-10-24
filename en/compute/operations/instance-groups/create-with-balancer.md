# Creating a fixed-size instance group with a network load balancer


You can create a fixed-size [instance group](../../concepts/instance-groups/index.md) integrated with [{{ network-load-balancer-full-name }}](../../../network-load-balancer/). A {{ network-load-balancer-name }} [target group](../../../network-load-balancer/concepts/target-resources.md) will be automatically created along with the [instance](../../concepts/vm.md) group. You can attach it to your [load balancer](../../../network-load-balancer/concepts/index.md) and distribute the load across the instances in the group at the network level. For more information, see [{#T}](../../concepts/instance-groups/balancers.md).

{% include [warning.md](../../../_includes/instance-groups/warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

{% include [password-reset-note](../../../_includes/compute/password-reset-note.md) %}

To create an instance group with a network load balancer:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create your instance group in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Click **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
     * Enter a name and description of the instance group. The naming requirements are as follows:

       {% include [name-format](../../../_includes/name-format.md) %}

       {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     * Select a [service account](../../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete VM instances in the instance group, assign the `editor` [role](../../../iam/concepts/access-control/roles.md) to the service account. By default, all operations with instance groups are performed on behalf of the service account.

       {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

     * Enable the **{{ ui-key.yacloud.compute.groups.create.field_deletion-protection }}** option, if needed. You cannot delete a group with this option enabled.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select the required ones in the **{{ ui-key.yacloud.compute.groups.create.field_zone }}** field. Instance groups may reside in [different availability zones](../../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** to configure a basic instance:
     * Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a description for the [template](../../concepts/instance-groups/instance-template.md).
     * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select a system to be deployed on the VM instance's boot [disk](../../concepts/disk.md).
     * Under **{{ ui-key.yacloud.compute.instances.create.section_disk }}**:
       * Select the [disk type](../../../compute/concepts/disk.md#disks_types).
       * Specify the disk size.
       * To add more disks, click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
     * Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
       * Choose a [platform](../../../compute/concepts/vm-platforms.md).
       * Enter the required number of vCPUs, [guaranteed vCPU performance](../../concepts/performance-levels.md), and the amount of RAM.
       * {% include [include](../../../_includes/instance-groups/specify-preemptible-vm.md) %}
       * (Optional) Enable a [software-accelerated network](../../concepts/software-accelerated-network.md).
     * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

       {% include [network-settings-group](../../../_includes/compute/network-settings-group.md) %}

     * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the data for access to the instance:
       * Select a service account to link to the instance.
       * If you selected a Linux [image](../../concepts/image.md), fill out the fields **{{ ui-key.yacloud.compute.instances.create.field_user }}** and **{{ ui-key.yacloud.compute.instances.create.field_key }}**. For a key, use the contents of the [public key](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.
       * Select `{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}`, if needed.
     * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**:
     * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-expansion }}** field, specify the number of instances you can exceed the group size by.

         {% include [max-expansion-notice](../../../_includes/instance-groups/max-expansion-notice.md) %}
     * In the field **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}**, specify the number of instances you can decrease the group size by.
     * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-creating }}** field, specify how many instances can be created at the same time.
     * In **{{ ui-key.yacloud.compute.groups.create.field_deploy-startup-duration }}**, specify the period after which the VM instance will start receiving the load.
     * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-deleting }}** field, specify how many instances can be stopped at the same time.
     * In the **{{ ui-key.yacloud.compute.groups.create.field_deploy-strategy }}** field, specify one of the [strategies](../../concepts/instance-groups/policies/deploy-policy.md#strategy):
       * `{{ ui-key.yacloud.compute.groups.create.value_strategy-proactive }}`: {{ compute-name }} itself chooses which instances to stop when updating or scaling down the group.
       * `{{ ui-key.yacloud.compute.groups.create.value_strategy-opportunistic }}`: {{ compute-name }} waits for the instances to stop on their own or be stopped by the user.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**:
     * Select the `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed }}` [scaling type](../../../compute/concepts/instance-groups/scale.md).
     * Specify the instance group size.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_ylb }}**, enable the **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** option.
  1. Specify the target group settings. For more information, see [{#T}](../../concepts/instance-groups/balancers.md#settings-nlb).
  1. If needed, enable the **{{ ui-key.yacloud.compute.groups.create.section_health-check }}** to get information about the state of instances and their automatic recovery on failure.
     * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** field, select the protocol for the health checks: `{{ ui-key.yacloud.common.label_http }}` or `{{ ui-key.yacloud.common.label_tcp }}`.
     * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** field (for the HTTP type), specify the URL path for the instance group to send HTTP check requests.
     * Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}**, specify the port number from 1 to 32767 on which the instance group will send health check requests.
     * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}** field, specify the response waiting time from 1 to 60 seconds.
     * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}** field, specify the interval between the repeat checks from 1 to 60 seconds. The interval must be at least 1 second longer than the waiting time.
     * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}** field, specify the number of successful health checks required for the instance to be considered healthy.
     * In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}** field, specify the number of failed health checks for the instance to be considered unhealthy.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_variables }}**, enter the `{{ ui-key.yacloud.common.label_key }}`-`{{ ui-key.yacloud.common.value }}` pairs, if needed.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../../cli/) command to create an instance group:

     ```bash
     {{ yc-compute-ig }} create --help
     ```

  1. Check whether the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) contains any [networks](../../../vpc/concepts/network.md#network):

     ```bash
     yc vpc network list
     ```

     If there are none, [create a network](../../../vpc/operations/network-create.md).
  1. Select one of the {{ marketplace-full-name }} public images, e.g., [CentOS 7](/marketplace/products/yc/centos-7).

     {% include [standard-images.md](../../../_includes/standard-images.md) %}

  1. Create a YAML file with any name, e.g., `specification.yaml`.
  1. In the created file, indicate the following:
     * General information about the instance group:

       ```yaml
       name: first-fixed-group-with-balancer
       service_account_id: <service_account_ID>
       description: "This instance group was created using a YAML configuration file."
       ```

       Where:
       * `name`: Instance group name. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name may be up to 63 characters long.
       * `service_account_id`: Service account ID.

         {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

       * `description`: Instance group description.
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
             security_group_ids:
               - enps0ar5s3ti********
         scheduling_policy:
           preemptible: false
         placement_policy:
           placement_group_id: rmppvhrgm77g********
       ```

       {% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

       Where:
       * `platform_id`: [Platform](../../concepts/vm-platforms.md) ID.
       * `memory`: Amount of memory (RAM).
       * `cores`: Number of processor cores (vCPUs).
       * `mode`: [Disk](../../concepts/disk.md) access mode.
         * `READ_ONLY`: Read-only access.
         * `READ_WRITE`: Read/write access.
       * `image_id`: Public image ID. You can view image IDs in the [management console]({{ link-console-main }}) when creating a VM or in [{{ marketplace-name }}](/marketplace) on the image page under **Product IDs**.
       * `type_id`: Disk type.
       * `size`: Disk size.
       * `network_id`: `default-net` network ID.
       * `primary_v4_address_spec`: IPv4 specification. You can allow public access to the group's instances by specifying the IP version for the [public IP address](../../../vpc/concepts/address.md#public-addresses). For more information, see [{#T}](../../concepts/instance-groups/instance-template.md#instance-template).
       * `security_group_ids`: List of [security group](../../../vpc/concepts/security-groups.md) IDs.
       * `scheduling_policy`: Scheduling policy configuration.
       * `preemptible`: Flag for creating [preemptible VMs](../../concepts/preemptible-vm.md).
         * `true`: Create a preemptible VM.
         * `false` (default): Create a regular VM.

         When creating a preemptible instance group, keep in mind that the VM instances will terminate after 24 hours of continuous operation or earlier. VMs may not be able to restart immediately due to insufficient resources. This may occur in the event of a sharp increase in the use of {{ yandex-cloud }} computing resources.
       * `placement_policy`: (Optional) [Instance placement group](../../concepts/placement-groups.md) parameters:
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
       * `allocation_policy`: Instance [allocation policy](../../concepts/instance-groups/policies/allocation-policy.md) between [availability zones](../../../overview/concepts/geo-scope.md).
     * {{ network-load-balancer-name }} [target group](../../../network-load-balancer/concepts/target-resources.md):

       ```yaml
       load_balancer_spec:
         target_group_spec:
           name: first-target-group
       ```

       Where:
       * `target_group_spec`: Specification of the {{ network-load-balancer-name }} target group linked with the instance group.
       * `name`: Name for the {{ network-load-balancer-name }} target group. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name may be up to 63 characters long.

       For more information about target group settings, see [{#T}](../../concepts/instance-groups/balancers.md#settings-nlb).

     Full code for the `specification.yaml` file:

     ```yaml
     name: first-fixed-group-with-balancer
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
       load_balancer_spec:
         target_group_spec:
           name: first-target-group
     ```

  1. Create an instance group in the default folder:

     ```bash
     {{ yc-compute-ig }} create --file specification.yaml
     ```

     This command creates a group of three same-type VMs with the following configuration:
     * Name: `first-fixed-group-with-balancer`
     * OS: CentOS 7
     * Network: `default-net`
     * Availability zone: `{{ region-id }}-a`
     * vCPUs: 2; RAM: 2 GB
     * Network HDD: 32 GB
     * Target group: `first-target-group`
  1. [Create a network load balancer](../../../network-load-balancer/operations/load-balancer-create.md) and add `first-target-group` to it.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the parameters of the resources you want to create:

     ```hcl
     resource "yandex_iam_service_account" "ig-sa" {
       name        = "ig-sa"
       description = "Service account for managing the instance group."
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
       deletion_protection = "<deletion_protection>"
       instance_template {
         platform_id = "standard-v3"
         resources {
           memory = <RAM_GB>
           cores  = <number_of_vCPU_cores>
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
           size = <number_of_VMs_in_group>
         }
       }

       allocation_policy {
         zones = ["{{ region-id }}-a"]
       }

       deploy_policy {
         max_unavailable = 1
         max_expansion   = 0
       }

       load_balancer {
         target_group_name        = "target-group"
         target_group_description = "{{ network-load-balancer-name }} target group"
       }
     }

     resource "yandex_lb_network_load_balancer" "lb-1" {
       name = "network-load-balancer-1"

       listener {
         name = "network-load-balancer-1-listener"
         port = 80
         external_address_spec {
           ip_version = "ipv4"
         }
       }

       attached_target_group {
         target_group_id = yandex_compute_instance_group.ig-1.load_balancer.0.target_group_id

         healthcheck {
           name = "http"
           http_options {
             port = 80
             path = "/index.html"
           }
         }
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
     * `yandex_iam_service_account`: [Service account](../../../iam/concepts/users/service-accounts.md) description. All operations with instance groups are performed on behalf of the service account.

       {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

     * `yandex_resourcemanager_folder_iam_member`: Description of access permissions to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the service account belongs to. To be able to create, update, and delete VM instances in the instance group, assign the `editor` [role](../../../iam/concepts/access-control/roles.md) to the service account.
     * `yandex_compute_instance_group`: Instance group description:
       * General information about the instance group:
         * `name`: Instance group name.
         * `folder_id`: Folder ID.
         * `service_account_id`: Service account ID.
         * `deletion_protection`: Instance group deletion protection, `true` or `false`. You cannot delete an instance group with this option enabled. The default value is `false`.
       * [Instance template](../../concepts/instance-groups/instance-template.md):
         * `platform_id`: [Platform](../../concepts/vm-platforms.md).
         * `resources`: Number of vCPU cores and RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
         * `boot_disk`: Boot [disk](../../concepts/disk.md) settings.
           * ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).
           * Disk access mode: `READ_ONLY` or `READ_WRITE`.
         * `network_interface`: [Network](../../../vpc/concepts/network.md#network) configurations. Specify the IDs of your network, [subnet](../../../vpc/concepts/network.md#subnet), and [security groups](../../../vpc/concepts/security-groups.md).
         * `metadata`: In [metadata](../../concepts/vm-metadata.md), provide the public key for SSH access to the VM. For more information, see [{#T}](../../concepts/vm-metadata.md).
       * [Policies](../../concepts/instance-groups/policies/index.md):
         * `deploy_policy`: [Deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for VMs in the group.
         * `scale_policy`: [Scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for VMs in the group.
         * `allocation_policy`: VM [allocation policy](../../concepts/instance-groups/policies/allocation-policy.md) between [availability zones](../../../overview/concepts/geo-scope.md).
       * {{ network-load-balancer-name }} [target group](../../../network-load-balancer/concepts/target-resources.md):
         * `target_group_name`: Name of the {{ network-load-balancer-name }} target group.
         * `target_group_description`: Description of the {{ network-load-balancer-name }} target group.
       For more information about target group settings, see [{#T}](../../concepts/instance-groups/balancers.md#settings-nlb).
     * `yandex_vpc_network`: Description of the cloud network.
     * `yandex_vpc_subnet`: Description of the subnet the instance group will connect to.
     * `yandex_lb_network_load_balancer`: Description of the [{{ network-load-balancer-name }} network load balancer](../../../network-load-balancer/concepts/index.md) the target group will connect to.

     {% note info %}

     If you already have suitable resources, such as a service account, cloud network, subnet, and network load balancer, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

     {% endnote %}

     For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [create](../../instancegroup/api-ref/InstanceGroup/create.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md) gRPC API call.

{% endlist %}