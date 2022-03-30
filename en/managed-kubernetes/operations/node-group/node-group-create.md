# Creating a node group

To create a [node group](../../concepts/index.md#node-group), first [create a {{ k8s }} cluster](../kubernetes-cluster/kubernetes-cluster-create.md).

## Create a node group {#node-group-create}

{% list tabs %}

- Management console

  {% include [node-group-create](../../../_includes/managed-kubernetes/node-group-create.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to create a node group:

     ```bash
     {{ yc-k8s }} node-group create --help
     ```

  1. Specify node group parameters in the create command (the list of supported parameters in the example is not exhaustive):

     ```bash
     {{ yc-k8s }} node-group create \
       --allowed-unsafe-sysctls=<comma-separated list of unsafe kernel parameters> \
       --cluster-name <cluster name> \
       --cores <number of vCPUs> \
       --core-fraction <guaranteed vCPU share> \
       --daily-maintenance-window <update window settings> \
       --disk-size <storage size in GB> \
       --disk-type <storage type: network-nvme or network-hdd> \
       --fixed-size <fixed number of nodes in the group> \
       --location <cluster host placement settings> \
       --memory <amount of RAM in GB> \
       --name <node group name> \
       --network-acceleration-type <standard or software-accelerated> \
       --network-interface security-group-ids=[<security group IDs>],subnets=[<subnet names>],ipv4-address=<nat or auto> \
       --platform-id <platform ID> \
       --preemptible \
       --public-ip \
       --version <{{ k8s }} version on group nodes> \
       --node-taints <taint policy labels>
     ```

     Where:
     * `--allowed-unsafe-sysctls`: Permits the group's nodes to use [unsafe kernel parameters](../../concepts/index.md#node-group), separated by commas.
     * `--cluster-name`: Name of the {{ k8s }} cluster where the node group is created.
     * `--cores`: Number of vCPUs for the nodes.
     * `--core-fraction`: [Guaranteed vCPU performance](../../../compute/concepts/performance-levels.md) for the nodes.
     * `--daily-maintenance-window`: The maintenance window settings.
     * `--disk-size`: The [size of the disk](../../../compute/concepts/disk.md#maximum-disk-size) on the node.
     * `--disk-type`: The [type of the disk](../../../compute/concepts/disk.md#disks_types) on the node.
     * `--fixed-size`: The number of nodes in the node group.
     * `--location`: The [availability zone](../../../overview/concepts/geo-scope.md), [network](../../../vpc/concepts/network.md#network), and [subnet](../../../vpc/concepts/network.md#subnet) to host the nodes on. You can specify several options.
     * `--memory`: Amount of memory allocated for the nodes.
     * `--name`: Name of the node group.
     * `--network-acceleration-type`: The type of [network acceleration](../../../compute/concepts/software-accelerated-network.md):
       * `standard`: Without acceleration.
       * `software-accelerated`: Software-accelerated network.
     * `--network-interface`: Network settings.

       {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

     * `--platform-id`: The [platform](../../../compute/concepts/vm-platforms.md) to host the nodes.
     * `--preemptible`: The flag specifying that the VMs must be [preemptible](../../../compute/concepts/preemptible-vm.md).
     * `--public-ip`: The flag specifying that the node group needs a [public IP address](../../../vpc/concepts/address.md#public-addresses).
     * `--version`: {{ k8s }} version on the group's nodes.
     * `--node-taints`: Labels of [taint policies](../../concepts/index.md#taints-tolerations) from {{ k8s }}. You can specify multiple labels.

     {% include [user-data](../../../_includes/managed-kubernetes/user-data.md) %}

     Command output:

     ```bash
     done (1m17s)
     id: catpl8c44kiibp20u4f3
     cluster_id: catcsqidoos7tq0513us
     ...
         start_time:
           hours: 22
         duration: 36000s
     ```

  {% include [user-data](../../../_includes/managed-kubernetes/user-data.md) %}

  1. To specify a [placement group](../../../compute/concepts/placement-groups.md) for nodes:
     1. Retrieve a list of placement groups using the `yc compute placement-group list` command.
     1. Pass a placement group name or ID in the `--placement group` parameter when creating a node group:

        ```bash
        {{ yc-k8s }} node-group-create \
        ...
          --placement-group <placement group name or ID>
        ```

- Terraform

  In [{#T}](../kubernetes-cluster/kubernetes-cluster-create.md), you created a {{ k8s }} cluster using Terraform. Use the same `.tf` configuration file to create a node group in the cluster.

  1. In the configuration file, describe the parameters of resources that you want to create. You can add multiple records at the same time.
     * `yandex_kubernetes_node_group`: Node group parameters:
       * `cluster_id`: ID of a {{ k8s }} cluster where the node group is created.
       * `name`: Name of the {{ k8s }} node group.
       * `description`: Description of the node group.
       * `version`: {{ k8s }} version for a node group.
     * `labels`: A [set of labels](node-label-management.md) for a node group:
       * `key`: Label values.
     * `instance_template`: VM description for a node group:
     * `node_taints`: Labels of [taint policies](../../concepts/index.md#taints-tolerations) from {{ k8s }}:
       * `key`: Policy values.
     * `instance_template`: VM description for a node group:
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
       * `placement_policy`: (optional) placement group configuration:
         * `placement_group_id`: ID of a [placement group](../../../compute/concepts/placement-groups.md) for nodes.
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
       * `maintenance_window`: Maintenance window settings. You can use the settings to specify the preferred start time for cluster node maintenance (for example, you can select the time when the cluster is least loaded with requests). Enter the maintenance `day`,`start_time`, and `duration` in the relevant parameters.

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
       node_taints = [
         "key=value:effect"
       ]
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
         placement_policy {
           placement_group_id = "my_placement_group_id"
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

     Command output:

     ```text
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

     Command output:

     ```
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

  Use the [create](../../api-ref/NodeGroup/create.md) method and pass the following in the call:
  * The cluster ID in the `clusterId` parameter. You can get it together with a [list of clusters in the folder](../kubernetes-cluster/kubernetes-cluster-list.md#list).
  * [Node group configuration](../../concepts/index.md#config) in the `nodeTemplate` parameter.
  * [Scaling settings](../../concepts/autoscale.md#ca) in the `scalePolicy` parameter.
  * [The placement settings](../../../overview/concepts/geo-scope.md) of a node group in the `allocationPolicy` parameters.
  * Update window settings in the `maintenancePolicy` parameters.
  * List of settings to be changed in the `updateMask` parameter.

    {% include [updateMask warning](../../../_includes/mdb/warning-default-settings.md) %}

  To specify a [placement group](../../../compute/concepts/placement-groups.md) for cluster nodes, pass the ID of the placement group in the `nodeTemplate.placementPolicy.placementGroupId` parameter.

  For nodes to use non-replicated disks, pass the `network-ssd-nonreplicated` value for the `nodeTemplate.bootDiskSpec.diskTypeId` parameter.

  You can only change the size of non-replicated disks in 93 GB increments. The maximum size of this type of disk is 4 TB.

  {% include [nrd-no-backup-note](../../../_includes/managed-kubernetes/nrd-no-backup-note.md) %}

  To allow the group's nodes to use [unsafe kernel parameters](../../concepts/index.md#node-group), pass their names in the `allowedUnsafeSysctls` parameter.

  To set labels for [taint policies](../../concepts/index.md#taints-tolerations), pass their values in the `nodeTaints` parameter.

{% endlist %}