# Creating a fixed-size instance group with a network load balancer

You can create a group of fixed-size instances along with a network load balancer that will evenly distribute the load across cloud resources. For more information, see [{#T}](../../../load-balancer/concepts/index.md) in the {{ load-balancer-full-name }} documentation.

{% include [warning.md](../../../_includes/instance-groups/warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

To create an instance group with a load balancer:

{% list tabs %}

- Management console
  1. In [management console]({{ link-console-main }}), select the folder where you want to create your instance group.
  1. From the list of services, select {{ compute-name }}.
  1. On the **Virtual machines** page, go to the **Instance groups** tab.
  1. Click **Create group**.
  1. Under **Basic parameters**:
      - Enter the **Name** and **Description** of the instance group. Naming requirements:

          {% include [name-format](../../../_includes/name-format.md) %}

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      - Select a [service account](../../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete group instances, assign the `editor` role to the service account. All operations in {{ ig-name }} are performed on behalf of the service account.
  1. In the **Allocation** section, select the desired **availability zones**. Group instances may reside in different availability zones and regions. [More about the geo scope of {{ yandex-cloud }}](../../../overview/concepts/geo-scope.md).
  1. In the **Instance template** section, click **Set** to set the basic instance configuration:
      - Under **Basic parameters**, enter the template **Description**:
      - Under **Images from {{ marketplace-name }}**, select a public [image](../../operations/images-with-pre-installed-software/get-list.md).
      - In the **Disks** section:
          - Select the [disk type](../../concepts/disk.md#disks_types).
          - Specify the **Size** of the disk.
          - To add more disks, click **Add disk**.
      - Under **Computing resources**:
          - Choose a [platform](../../concepts/vm-platforms.md).
          - Specify the required number of **vCPUs**, [guaranteed vCPU performance](../../concepts/performance-levels.md), and the amount of **RAM**.
          - {% include [include](../../../_includes/instance-groups/specify-preemptible-vm.md) %}
      - Under **Network settings**:
          - Select the [cloud network](../../../vpc/concepts/network.md#network) from the list, or specify its ID. If you don't have a network, click **Create a new network** to create one:
              - In the window that opens, enter a name for the new network and choose the **Subnet in the zone** to connect the instance to. Each network must have at least one [subnet](../../../vpc/concepts/network.md#subnet) (if there's no subnet, [create one](../../../vpc/operations/subnet-create.md).
          - In the **Public IP** field, choose a method for assigning an IP address:
              - **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
              - **No address**: Don't assign a public IP address.
      - Under **Access**, specify the data required to access the VM:
          - Specify a **Service account** to be linked to the instance.
          - Enter the username in the **Login** field.
          - In the **SSH key** field, paste the contents of the [public key file](../../quickstart/quick-create-linux.md#create-ssh).
          - If needed, **Grant access to the serial console**.
      - Click **Save**.
  1. Under **Allow when creating and updating**:
      - In the **Add above target value** field, specify the number of instances you can exceed the group size by.
      - In the field **Reduce below target value**, specify the number of instances you can reduce the group size by.
      - In the **Create simultaneously** field, specify how many instances can be created at the same time.
      - In the **Stop simultaneously** field, specify how many instances can be stopped at the same time.
      - In the **Stop VMs by strategy** field, specify one of the [strategies](../../concepts/instance-groups/policies/deploy-policy.md#strategy):
          - **Proactive**: {{ ig-name }} selects which instances to stop when updating or reducing the group on its own.
          - **Opportunistic**: {{ ig-name }} waits for the instances to stop on their own or by the user.
  1. In the **Scalability** section:
      - Select the **Proactive** [type of scaling](../../concepts/instance-groups/scale.md).
      - Specify the group size.
  1. Under **Integration with {{ load-balancer-name }}**, toggle the switch to the right of the **Create target group** field.
  1. Enter any **Name of the target group** and **Description of the target group**.
  1. If needed, enable the **Health check** to get information about the state of instances and their automatic recovery on failure.
      - In the **Type** field, select the protocol for the health checks: **HTTP** or **TCP**.
      - In the **Port** field, specify the port number from 1 to 32767 for {{ ig-name }} to send the health check requests to.
      - In the **Path** field (for the HTTP type), specify the URL path for the HTTP check requests sent from {{ ig-name }}.
      - In the **Waiting time, s** field, specify the response wait time from 1 to 60 seconds.
      - In the **Interval in sec** field, specify the interval between the repeat checks from 1 to 60 seconds. The interval must be at least 1 second longer than the timeout.
      - In the **Performance threshold** field, specify the number of successful health checks required for the instance to be considered healthy.
      - In the **Failure threshold** field, specify the number of failed health checks for the instance to be considered unhealthy.
  1. Click **Create**.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. View a description of the create instance group command in the CLI:

      ```
      {{ yc-compute-ig }} create --help
      ```

  1. Check whether there are networks in the folder:

      ```
      yc vpc network list
      ```

      If there aren't any, [create one](../../../vpc/operations/network-create.md).

  1. Select one of the [public images](../images-with-pre-installed-software/get-list.md) (for example, CentOS 7).

      {% include [standard-images.md](../../../_includes/standard-images.md) %}

  1. Create a YAML file with any name (for example, `specification.yaml`).

  1. In the created file, indicate the following:

      - General information about the group:

          ```
          name: first-fixed-group-with-balancer
          service_account_id: <ID>
          description: "This instance group was created from YAML config."
          ```

          Keys:

          | Key | Value |
          | ----- | ----- |
          | `name` | A name for the instance group. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters. |
          | `service_account_id` | ID of the service account. |
          | `description` | A description of the instance group. |

      - [Instance template](../../concepts/instance-groups/instance-template.md), for example:

          ```
          instance_template:
              platform_id: standard-v1
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

          Keys (the table contains the keys that directly define the instance parameters):

          | Key | Value |
          | ----- | ----- |
          | `platform_id` | Platform ID. |
          | `memory` | Amount of memory (RAM). |
          | `cores` | Number of processor cores (vCPUs). |
          | `mode` | Disk access mode.</br> - `READ_ONLY`: read-only access.</br>- `READ_WRITE`: read/write access. |
          | `image_id` | ID of the public image. |
          | `type_id` | Disk type. |
          | `size` | Disk size. |
          | `network_id` | The `default-net` ID. |
          | `primary_v4_address_spec` | IPv4 specification. You can allow public access to group instances by specifying the IP version for the public IP address. For more information, see [{#T}](../../concepts/instance-groups/instance-template.md#instance-template). |
          | `scheduling_policy` | Scheduling policy configuration. |
          | `preemptible` | A flag that enables the creation of [preemptible instances](../../concepts/preemptible-vm.md). If the value is `true`, a preemptible instance is created, if `false` (default), a regular instance is created.<br>When creating a preemptible instance group, keep in mind that the instances will terminate after 24 hours of continuous operation or earlier. It's possible that {{ ig-name }} won't be able to restart them immediately due to insufficient resources. This may occur in the event of a drastic increase of the computing resource utilization in {{ yandex-cloud }}. |

      - [Policies](../../concepts/instance-groups/policies/index.md):

          ```
          deploy_policy:
              max_unavailable: 1
              max_expansion: 0
          scale_policy:
              fixed_scale:
                  size: 3
          allocation_policy:
              zones:
                  - zone_id: ru-central1-a
          ```

          Keys:

          | Key | Value |
          | ----- | ----- |
          | `deploy_policy` | [Deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for instances in a group. |
          | `scale_policy` | [Scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for instances in a group. |
          | `allocation_policy` | [Allocation policy](../../concepts/instance-groups/policies/allocation-policy.md) for instances across zones and regions. |

      - {{ load-balancer-name }} target group:

          ```
          load_balancer_spec:
              target_group_spec:
                  name: first-target-group
          ```

          Keys:

          | Key | Value |
          | ----- | ----- |
          | `target_group_spec` | Specification of the {{ load-balancer-name }} target group associated with the instance group. |
          | `name` | A name for the {{ load-balancer-name }} target group. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters. |

          Full code for the `specification.yaml` file:

          ```
          name: first-fixed-group-with-balancer
          service_account_id: <ID>
          description: "This instance group was created from YAML config."
          instance_template:
              platform_id: standard-v1
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
                  - zone_id: ru-central1-a
          load_balancer_spec:
              target_group_spec:
                  name: first-target-group
          ```

  1. Create an instance group in the default folder:

      ```
      {{ yc-compute-ig }} create --file specification.yaml
      ```

      This command creates a group of three similar instances with the following characteristics:
      - Named `first-fixed-group-with-balancer`.
      - Running CentOS 7.
      - In the `default-net` network.
      - In the `ru-central1-a` availability zone.
      - With 2 vCPUs and 2 GB of RAM.
      - With a 32 GB network HDD.
      - With a target group named `first-target-group`.

  1. Create a [load balancer](../../../load-balancer/operations/load-balancer-create.md) and add the `first-target-group` target group to it .

- API

  Use the [create](../../api-ref/InstanceGroup/create.md).

- Terraform

  If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. In the configuration file, describe the parameters of resources that you want to create:

       {% note info %}

       If you already have suitable resources, such as a service account, cloud network, and subnet, you don't need to describe them again. Use their names and IDs in the appropriate parameters.

       {% endnote %}

     * `yandex_iam_service_account`: Description of a [service account](../../../iam/concepts/users/service-accounts.md). All operations in {{ ig-name }} are performed on behalf of the service account.

     * `yandex_resourcemanager_folder_iam_binding`: Description of access rights to the folder that the service account belongs to. To be able to create, update, and delete group instances, assign to the service account the [role](../../../iam/concepts/access-control/roles.md) `editor`.

     * `yandex_compute_instance_group`: Description of an [instance group](../../concepts/index.md):

       - General information about the group:

          | Field | Description |
          | ----- | ----- |
          | `name` | Name of the instance group. |
          | `folder_id` | Folder ID. |
          | `service_account_id` | ID of the service account. |

       - [Instance template](../../concepts/instance-groups/instance-template.md):

          | Field | Description |
          | ----- | ----- |
          | `platform_id` | [Platform](../../concepts/vm-platforms.md). |
          | `resources` | The number of vCPU cores and RAM available to the instance. The values must match the selected [platform](../../concepts/vm-platforms.md). |
          | `boot_disk` | Boot disk settings. Specify: </br>- ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).</br> - Disk access mode: `READ_ONLY` (read) or `READ_WRITE` (read and write). |
          | `network_interface` | Network configuration. Specify the network ID and subnet ID. |
          | `metadata` | In the metadata, pass the public key for accessing the instance via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md). |

       - [Policies](../../concepts/instance-groups/policies/index.md):

          | Field | Description |
          | ----- | ----- |
          | `deploy_policy` | [Deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for instances in a group. |
          | `scale_policy` | [Scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for instances in a group. |
          | `allocation_policy` | [Allocation policy](../../concepts/instance-groups/policies/allocation-policy.md) for instances across zones and regions. |

       - {{ load-balancer-name }} target group:

          | Field | Description |
          | ----- | ----- |
          | `target_group_name` | Name of the {{ load-balancer-name }} target group. |
          | `target_group_description` | Description of the {{ load-balancer-name }} target group. |

     * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md#network).

     * `yandex_vpc_subnet`: Description of the [subnet](../../../vpc/concepts/network.md#subnet) that the instance group will be connected to.

     Example configuration file structure:

     ```
     resource "yandex_iam_service_account" "ig-sa" {
       name        = "ig-sa"
       description = "service account to manage IG"
     }
     
     resource "yandex_resourcemanager_folder_iam_binding" "editor" {
       folder_id = "<folder ID>"
       role      = "editor"
       members   = [
         "serviceAccount:${yandex_iam_service_account.ig-sa.id}",
       ]
     }
     
     resource "yandex_compute_instance_group" "ig-1" {
       name               = "fixed-ig-with-balancer"
       folder_id          = "<folder ID>"
       service_account_id = "${yandex_iam_service_account.ig-sa.id}"
       instance_template {
         platform_id = "standard-v1"
         resources {
           memory = <RAM in GB>
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
           ssh-keys = "<user name>:<SSH key contents>"
         }
       }
     
       scale_policy {
         fixed_scale {
           size = <number of instances in a group>
         }
       }
     
       allocation_policy {
         zones = ["ru-central1-a"]
       }
     
       deploy_policy {
         max_unavailable = 1
         max_expansion   = 0
       }
     
       load_balancer {
         target_group_name        = "target-group"
         target_group_description = "load balancer target group"
       }
     }
     
     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }
     
     resource "yandex_vpc_subnet" "subnet-1" {
       name           = "subnet1"
       zone           = "ru-central1-a"
       network_id     = "${yandex_vpc_network.network-1.id}"
       v4_cidr_blocks = ["192.168.10.0/24"]
     }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  2. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.

     2. Run the check using the command:

        ```
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  3. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

        ```
        terraform apply
        ```

     2. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in [management console]({{ link-console-main }}).

{% endlist %}

