# Creating a fixed-size instance group with an L7 network load balancer

You can create a fixed-size [instance group](../../concepts/instance-groups/index.md) along with an L7 load balancer that will distribute incoming HTTP or gRPC traffic across VM instances. For more information, see [{#T}](../../../application-load-balancer/concepts/index.md).

{% include [alb-warning.md](../../../_includes/instance-groups/alb-warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

To create an instance group with an L7 load balancer:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create your instance group in.
   1. In the list of services, select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **Instance groups**.
   1. Click **Create group**.
   1. Under **Basic parameters**:
      * Enter the **Name** and **Description** of the instance group. The naming requirements are as follows:

         {% include [name-format](../../../_includes/name-format.md) %}

         {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Select a [service account](../../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete group instances, assign the `editor` [role](../../../iam/concepts/access-control/roles.md) to the service account. All operations in {{ ig-name }} are performed on behalf of the service account.
      * Enable **Deletion protection** if needed. You cannot delete an instance group with this option enabled.
   1. In the **Allocation** section, select the desired **availability zones**. Instances of a group may reside in different availability zones and regions. [More about the geo scope of {{ yandex-cloud }}](../../../overview/concepts/geo-scope.md).
   1. Under **Instance template**, click **Define** to set up the configuration for a basic instance:
      * Under **Basic parameters**, enter the [template](../../concepts/instance-groups/instance-template.md) **Description**:
      * Under **Image/boot disk selection**, select a system to be deployed on the VM instance's boot [disk](../../concepts/disk.md).
      * In the **Disks** section:
         * Select the [disk type](../../concepts/disk.md#disks_types).
         * Specify the **Size** of the disk.
         * Specify the disk **Contents**.
         * (optional) To add more disks, click **Add disk**.
      * Under **Computing resources**:
         * Choose a [platform](../../concepts/vm-platforms.md).
         * Enter the required number of **vCPUs**, [guaranteed vCPU performance](../../concepts/performance-levels.md), and the amount of **RAM**.

         * {% include [include](../../../_includes/instance-groups/specify-preemptible-vm.md) %}

      * Under **Network settings**:

         {% include [network-settings-group](../../../_includes/compute/network-settings-group.md) %}

      * Under **Access**, specify the information required to access the instance:
         * Specify a **Service account** to be linked to the instance.
         * If you selected a Linux [image](../../concepts/image.md), fill out **Login** and **SSH key**. As the key, use the [public key](../vm-connect/ssh.md#creating-ssh-keys) file contents.
         * If you selected a Windows image, enter the **Password** for your `Administrator` user.
         * **Enable access to the serial console**, if required.
      * Click **Save**.
   1. Under **Allow when creating and updating**:
      * In the **Add above target value** field, specify the number of instances you can exceed the group size by.
      * In the field **Reduce below target value**, specify the number of instances you can decrease the group size by.
      * In the **Create simultaneously** field, specify how many instances can be created at the same time.
      * In **Start time**, specify the period after which the VM instance will start receiving the load.
      * In the **Stop simultaneously** field, specify how many instances can be stopped at the same time.
      * In the **Stop VMs by strategy** field, specify one of the [strategies](../../concepts/instance-groups/policies/deploy-policy.md#strategy):
         * **Proactive**: {{ ig-name }} selects which instances to stop when updating or reducing the group on its own.
         * **Opportunistic**: {{ ig-name }} waits for the instances to stop on their own or by the user.
   1. In the **Scalability** section:
      * Select the **Fixed** [scaling type](../../concepts/instance-groups/scale.md).
      * Specify the instance group size.
   1. Under **Integration with {{ alb-name }}**, enable **Create target group**.
   1. Enter the **Name of the target group** and **Description of the target group**.
   1. If needed, enable the **Health check** to get information about the state of instances and their automatic recovery on failure.
      * In the **Type** field, select the protocol for the health checks: **HTTP** or **TCP**.
      * In the **Path** field (for the HTTP type), specify the URL path for the HTTP check requests sent from {{ ig-name }}.
      * In the **Port** field, specify the port number from 1 to 32767 for {{ ig-name }} to send the health check requests to.
      * In the **Waiting time, s** field, specify the response wait time from 1 to 60 seconds.
      * In the **Interval in sec** field, specify the interval between the repeat checks from 1 to 60 seconds. The interval must be at least 1 second longer than the timeout.
      * In the **Performance threshold** field, specify the number of successful health checks required for the instance to be considered healthy.
      * In the **Failure threshold** field, specify the number of failed health checks for the instance to be considered unhealthy.
   1. Under **Custom variables**, enter the **Key**-**Value** pairs if needed.
   1. Click **Create**.

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
         * `name`: Name of the instance group. The name must be unique within the folder. It may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name may not be longer than 63 characters.
         * `service_account_id`: Service account ID.
         * `description`: Description of the instance group.
      * [Instance template](../../concepts/instance-groups/instance-template.md), such as:

         ```
         instance_template:
             platform_id: standard-v3
             resources_spec:
                 memory: 2g
                 cores: 2
             boot_disk_spec:
                 mode: READ_WRITE
                 disk_spec:
                     image_id: fdvk34al8k5nltb58shr
                     type_id: network-hdd
                     size: 32g
             network_interface_specs:
                 - network_id: c64mknqgnd8avp6edhbt
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
         * `image_id`: ID of the public image. You can view image IDs in the [management console]({{ link-console-main }}) when creating a VM or in [{{ marketplace-name }}](/marketplace) on the image page under **Product IDs**.
         * `type_id`: Disk type.
         * `size`: Disk size.
         * `network_id`: ID of `default-net`.
         * `primary_v4_address_spec`: IPv4 specification. You can allow public access to group instances by specifying the IP version for the [public IP address](../../../vpc/concepts/address.md#public-addresses). For more information, see [{#T}](../../concepts/instance-groups/instance-template.md#instance-template).
         * `scheduling_policy`: Scheduling policy configuration.
         * `preemptible`: Flag indicating that [preemptible VMs](../../concepts/preemptible-vm.md) are created.
            * `true`: Create a preemptible VM.
            * `false` (default): Create a regular VM.

            When creating a preemptible instance group, keep in mind that the VM instances will terminate after 24 hours of continuous operation or earlier. It's possible that {{ ig-name }} won't be able to restart them immediately due to insufficient resources. This may occur in the event of a drastic increase in {{ yandex-cloud }} computing resource utilization.
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
         * `name`: Any name of the {{ alb-name }} target group. The name must be unique within the folder. It may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name may not be longer than 63 characters.

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
         image_id: fdvk34al8k5nltb58shr
         type_id: network-hdd
         size: 32g
     network_interface_specs:
       - network_id: c64mknqgnd8avp6edhbt
         primary_v4_address_spec: {}
   deploy_policy:
     max_unavailable: 1
     max_expansion: 0
   scale_policy:
     fixed_scale:
       size: 3
   allocation_policy:
     zones:
       - zone_id: {{ region-id }}-a
   application_load_balancer_spec:
     target_group_spec:
       name: first-target-group
   ```

   1. Create an instance group in the default folder:

      ```bash
      {{ yc-compute-ig }} create --file specification.yaml
      ```

      This command creates a group of three similar instances with the following characteristics:
      * Named `first-fixed-group-with-l7-balancer`.
      * Running CentOS 7.
      * In the `default-net` network.
      * In the `{{ region-id }}-a` availability zone.
      * With 2 vCPUs and 2 GB of RAM.
      * With a 32 GB network HDD.
      * With a target group named `first-target-group`.

   After that, you can add the `first-target-group` target group to a [new](../../../application-load-balancer/operations/backend-group-create.md) or [existing group of {{ alb-name }} backends](../../../application-load-balancer/operations/backend-group-update.md), a backend group to a [new](../../../application-load-balancer/operations/http-router-create.md) or [existing HTTP router](../../../application-load-balancer/operations/http-router-update.md), and a router to a [new](../../../application-load-balancer/operations/application-load-balancer-create.md) or [existing L7 load balancer](../../../application-load-balancer/operations/application-load-balancer-update.md).

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the provider {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. In the configuration file, describe the parameters of the resources you want to create:

      ```yaml
      resource "yandex_iam_service_account" "ig-sa" {
        name        = "ig-sa"
        description = "service account to manage IG"
      }

      resource "yandex_resourcemanager_folder_iam_member" "editor" {
        folder_id = "<folder ID>"
        role      = "editor"
        member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
      }

      resource "yandex_compute_instance_group" "ig-1" {
        name               = "fixed-ig-with-balancer"
        folder_id          = "<folder ID>"
        service_account_id = "${yandex_iam_service_account.ig-sa.id}"
        instance_template {
          platform_id = "standard-v3"
          resources {
            memory = <amount of RAM in GB>
            cores  = <number of vCPU cores>
          }

          boot_disk {
            mode = "READ_WRITE"
            initialize_params {
              image_id = "<image ID>"
            }
          }

          network_interface {
            network_id = "${yandex_vpc_network.network-1.id}"
            subnet_ids = ["${yandex_vpc_subnet.subnet-1.id}"]
          }

          metadata = {
            ssh-keys = "<username>:<SSH key contents>"
          }
        }

        scale_policy {
          fixed_scale {
            size = <number of instances in the group>
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
      * `yandex_iam_service_account`: Description of a [service account](../../../iam/concepts/users/service-accounts.md). All operations in {{ ig-name }} are performed on behalf of the service account.
      * `yandex_resourcemanager_folder_iam_member`: Description of access rights to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the service account belongs to. To be able to create, update, and delete group instances, assign the `editor` [role](../../../iam/concepts/access-control/roles.md) to the service account.
      * `yandex_compute_instance_group`: Description of the instance group:
         * General information about the instance group:
            * `name`: Name of the instance group.
            * `folder_id`: ID of the folder.
            * `service_account_id`: Service account ID.
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
      * `yandex_vpc_network`: Description of the cloud network.
      * `yandex_vpc_subnet`: Description of the subnet the instance group will connect to.

      {% note info %}

      If you already have suitable resources, such as a service account, cloud network, and subnet, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

      {% endnote %}

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).
   1. Make sure the configuration files are valid.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.
   1. Deploy cloud resources.
      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Once you are done, all the resources you need will be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

- API

   Use the [create](../../api-ref/InstanceGroup/create.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Create](../../api-ref/grpc/instance_group_service.md#Create) gRPC API call.

{% endlist %}