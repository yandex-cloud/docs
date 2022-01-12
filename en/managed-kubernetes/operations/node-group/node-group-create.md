# Creating a node group

To create a node group, [create a {{ k8s }} cluster](../kubernetes-cluster/kubernetes-cluster-create.md) first.

## Create a node group {#node-group-create}

{% list tabs %}

- Management console

  {% include [node-group-create](../../../_includes/managed-kubernetes/node-group-create.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Create a node group:

  ```bash
  yc managed-kubernetes node-group create \
    --name my-node-group \
    --cluster-name test-k8s \
    --platform-id standard-v3 \
    --location subnet-name=yc-auto-subnet-0,zone=ru-central1-a \
    --public-ip \
    --network-interface security-group-ids=[my-security-group1,my-security-group2],subnets=[yc-auto-subnet-0],ipv4-address=nat \
    --cores 2 \
    --memory 4 \
    --core-fraction 50 \
    --disk-type network-ssd \
    --disk-size 96 \
    --fixed-size 2 \
    --version 1.13 \
    --daily-maintenance-window start=22:00,duration=10h
  ```

  Command execution result:

  ```bash
  done (1m17s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
      start_time:
        hours: 22
      duration: 36000s
  ```

  Where:
  * `--name`: Name of the node group.
  * `--cluster-name`: Name of the {{ k8s }} cluster where the node group is created.
  * `--platform-id`: The [platform](../../../compute/concepts/vm-platforms.md) to host the nodes.
  * `--network-interface`: Network settings:

    {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

  * `--memory`: Amount of memory allocated for the nodes.
  * `--cores`: Number of vCPUs for the nodes.
  * `--core-fraction`: [Guaranteed vCPU performance](../../../compute/concepts/performance-levels.md) for the nodes.
  * `--preemptible`: Flag indicating that [VM instances](../../../compute/concepts/vm.md) should be [preemptible](../../../compute/concepts/preemptible-vm.md).
  * `--disk-type`: The type of the disk on the node.
  * `--disk-size`: Size of the disk on the node.
  * `--fixed-size`: Number of nodes in the node group.
  * `--version`: The {{ k8s }} version on the nodes.
  * `--daily-maintenance-window`: The maintenance window settings.

  {% include [user-data](../../../_includes/managed-kubernetes/user-data.md) %}

- Terraform

  In [{#T}](../kubernetes-cluster/kubernetes-cluster-create.md), you created a {{ k8s }} cluster using Terraform. Use the same `.tf` configuration file to create a node group in the cluster.

  If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. In the configuration file, describe the parameters of resources that you want to create. You can add multiple records at the same time.
     * `yandex_kubernetes_node_group`: Node group parameters:
       * `cluster_id`: ID of a {{ k8s }} cluster where the node group is created.
       * `name`: Name of the {{ k8s }} node group.
       * `description`: Description of the node group.
       * `version`: {{ k8s }} version for a node group.
     * `labels`: A [set of labels](node-label-management.md) for a node group:
       * `key`: Label values.
     * `instance_template`: [VM] description for a node group:
       * `platform_id`: The [platform](../../../compute/concepts/vm-platforms.md) to host a node group.
       * `network_interface`: Network interface settings:
         * `nat`: Flag that enables NAT for the node group compute instances.
         * `subnet_ids`: Subnet IDs.
       * `resources`: Resources available to the VM:
         * `memory`: The amount of RAM.
         * `cores`: Number of vCPU cores.
       * `boot_disk`: Boot disk settings. Specify the ID of the selected image. You can find out the image ID from the [list of public images](../../../compute/operations/images-with-pre-installed-software/get-list.md).
         * `size`: Disk size of the node in GB. Minimum size: 64 GB.
         * `type`: Disk type.
     * `scheduling_policy`: Scheduling policy setting:
        * `preemptible`: Flag indicating that preemptible VMs are created.
     * `scale_policy`: [Scaling policy](../../../compute/concepts/instance-groups/policies/scale-policy.md) settings:
       * `fixed_scale`: Key defining a group of fixed-size instances.
       * `size`: Number of VMs in the group.
     * `allocation_policy`: [Distribution policy](../../../compute/concepts/instance-groups/policies/allocation-policy.md) settings:
       * `location`: Recurrent field indicating the availability zones (networks and subnets) that will be used by the node group.
         * `zone`: Availability zone.
     * `maintenance_policy`: Update policy settings:
       * `auto_upgrade`: Flag indicating that it's allowed to automatically update a node group.

       * `auto_repair`: Flag indicating that it's allowed to [automatically restore](../../../compute/concepts/instance-groups/autohealing.md) a node group. Currently not supported.

       * `maintenance_window`: Maintenance window settings. You can use the settings to specify the preferred start time for cluster node maintenance (for example, you can select the time when the cluster is least loaded with requests): Enter the maintenance `day`,`start_time`, and `duration` in the relevant parameters.

         To specify the interval of the time of day, you must specify only two fields for all days: `start_time` and `duration`.

         To allow maintenance only on certain days of the week, specify all the fields. Only one time interval is allowed for each day of the week.

     ```hcl
     resource "yandex_kubernetes_node_group" "my_node_group" {
       cluster_id  = "${yandex_kubernetes_cluster.zonal_cluster_resource_name.id}"
       name        = "MyNodes"
       description = "MyNodes description"
       version     = "1.17"

       labels = {
         "key" = "value"
       }
       instance_template {
         platform_id = "standard-v2"
         network_interface {
           nat        = true
           subnet_ids = ["${yandex_vpc_subnet.subnet_resource_name.id}"]
         }
         resources {
           memory = 2
           cores  = 2
         }
         boot_disk {
           type = "network-hdd"
           size = 64
         }
         scheduling_policy {
           preemptible = false
         }
       }
       scale_policy {
         fixed_scale {
           size = 1
         }
       }
       allocation_policy {
         location {
           zone = "ru-central1-a"
         }
       }
       maintenance_policy {
         auto_upgrade = true
         auto_repair  = true
         maintenance_window {
           day        = "monday"
           start_time = "15:00"
           duration   = "3h"
         }
         maintenance_window {
           day        = "friday"
           start_time = "10:00"
           duration   = "4h30m"
         }
       }
     }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  1. Run the check using the command:

     ```bash
     terraform plan
     ```

     Command execution result:

     ```bash
     Refreshing Terraform state in-memory prior to plan...
     The refreshed state will be used to calculate this plan, but will not be
     persisted to local or remote state storage.
     ...
     Note: You didn't specify an "-out" parameter to save this plan, so Terraform
     can't guarantee that exactly these actions will be performed if
     "terraform apply" is subsequently run.
     ```

     The terminal will display a list of resources with parameters. This is a test step. No resources are created. If there are errors in the configuration, Terraform points them out.

     {% note alert %}

     You're charged for all resources created using Terraform. Check the plan carefully.

     {% endnote %}

  1. To create resources, run the command:

     ```bash
     terraform apply
     ```

     Command execution result:

     ```bash
     An execution plan has been generated and is shown below.
     Resource actions are indicated with the following symbols:
     + create
     ...
     Terraform will perform the actions described above.
     Only 'yes' will be accepted to approve.

     Enter a value:
     ```

  1. Confirm resource creation: type `yes` in the terminal and press **Enter**.

     ```bash
     Enter a value: yes
     ```

  1. Check the resources and their settings in the [management console]({{ link-console-main }}).

- API

  To create a node group, use the [create](../../api-ref/NodeGroup/create.md) method for the [NodeGroup](../../api-ref/NodeGroup/) resource.

{% endlist %}