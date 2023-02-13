# Creating a node group

To create a [node group](../../concepts/index.md#node-group), [create a {{ k8s }} cluster](../kubernetes-cluster/kubernetes-cluster-create.md) first.

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
       --daily-maintenance-window <maintenance window settings> \
       --disk-size <storage size in GB> \
       --disk-type <storage type: network-nvme or network-hdd> \
       --fixed-size <fixed number of nodes in group> \
       --location <cluster host location settings> \
       --memory <GB of RAM> \
       --name <node group name> \
       --network-acceleration-type <standard or software-accelerated> \
       --network-interface security-group-ids=[<security group IDs>],subnets=[<subnet names>],ipv4-address=<nat or auto> \
       --platform-id <platform ID> \
       --container-runtime <container runtime environment> \
       --preemptible \
       --public-ip \
       --template-labels <resource labels> \
       --version <{{ k8s }} version on group nodes> \
       --node-name <node name template> \
       --node-taints <taint policy labels>
     ```

     Where:
     * `--allowed-unsafe-sysctls`: Permission for group nodes to use [unsafe kernel parameters](../../concepts/index.md#node-group), comma-separated.
     * `--cluster-name`: Name of the [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) where the node group is created.
     * `--cores`: The number of vCPUs for the nodes.
     * `--core-fraction`: [reserved vCPU fraction](../../../compute/concepts/performance-levels.md) for nodes.
     * `--daily-maintenance-window`: [Maintenance](../../concepts/release-channels-and-updates.md#updates) window settings.
     * `--disk-size`: The [size of the disk](../../../compute/concepts/disk.md#maximum-disk-size) on the node.
     * `--disk-type`: [Type of the disk](../../../compute/concepts/disk.md#disks_types) on the node.
     * `--fixed-size`: The number of nodes in the node group.
     * `--location`: [Availability zone](../../../overview/concepts/geo-scope.md), [network](../../../vpc/concepts/network.md#network), and [subnet](../../../vpc/concepts/network.md#subnet) to host the nodes on. You can specify several options.
     * `--memory`: The amount of memory allocated for the nodes.
     * `--name`: The name of the node group.
     * `--network-acceleration-type`: The type of [network acceleration](../../../compute/concepts/software-accelerated-network.md):
       * `standard`: No acceleration.
       * `software-accelerated`: Software-accelerated network.
     * `--network-interface`: Network settings:

       {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

     * `--platform-id`: [Platform](../../../compute/concepts/vm-platforms.md) for nodes.
     * `--container-runtime`: [Container runtime environment](../../concepts/index.md#config), `docker` or `containerd`.
     * `--preemptible`: Flag specified if the VM instances should be [preemptible](../../../compute/concepts/preemptible-vm.md).
     * `--public-ip`: Flag specified if the node group needs a [public IP address](../../../vpc/concepts/address.md#public-addresses).
     * `--template-labels`: [{{ yandex-cloud }} resource labels](../../../overview/concepts/services.md#labels) in `<label name>=<label value>` format for VMs representing the group nodes. You can specify multiple labels separated by commas.
     * `--version`: {{ k8s }} version on group nodes.
     * `--node-name`: Node name template. The name is unique if the template contains at least one of the variables:

       {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

     * `--node-taints`: {{ k8s }} [taint policy](../../concepts/index.md#taints-tolerations) labels. You can specify multiple labels.

     {% include [user-data](../../../_includes/managed-kubernetes/user-data.md) %}

     Result:

     ```bash
     done (1m17s)
     id: catpl8c44kiibp20u4f3
     cluster_id: catcsqidoos7tq0513us
     ...
         start_time:
           hours: 22
         duration: 36000s
     ```

  1. To specify a [placement group](../../../compute/concepts/placement-groups.md) for the nodes:
     1. Retrieve a list of placement groups using the `yc compute placement-group list` command.
     1. Pass a placement group name or ID in the `--placement group` parameter when creating a node group:

        ```bash
        {{ yc-k8s }} node-group create \
        ...
          --placement-group <placement group name or ID>
        ```

- {{ TF }}

  To create a [node group](../../concepts/index.md#node-group):
  1. In the folder containing the [cluster description file](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create), create a configuration file with the parameters of a new node group:
     * Node group name.
     * [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) ID as `cluster_id`.
     * Node [platform](../../../compute/concepts/vm-platforms.md).
     * [Container runtime environment](../../concepts/index.md#config) setting in the `container_runtime` parameter.
     * [{{ yandex-cloud }} resource labels](../../../overview/concepts/services.md#labels) for VMs representing the group nodes, under `nodeTemplate.labels`.
     * Scaling settings under `scale_policy`.

     Example configuration file structure:

     ```hcl
     resource "yandex_kubernetes_node_group" "<node group name>" {
       cluster_id = yandex_kubernetes_cluster.<cluster name>.id
       name       = "<node group name>"
       ...
       instance_template {
         name       = "<node name template>"
         platform_id = "<node platform>"
         container_runtime {
          type = "<container runtime environment>"
         }
         labels {
           "<label name>"="<label value>"
         }
         ...
       }
       ...
       scale_policy {
         <node group scaling settings>
       }
     }
     ```

     Where:
     * `cluster_id`: ID of the [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster).
     * `name`: Node group name.
     * `instance_template`: Node parameters:
       * `name`: Node name template. The name is unique if the template contains at least one of the variables:

         {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

       * `platform_id`: [Platform](../../../compute/concepts/vm-platforms.md) for nodes.
       * `container_runtime`:
         * `type`: [Container runtime environment](../../concepts/index.md#config) (`docker` or `containerd`).
       * `labels`: [{{ yandex-cloud }} resource labels](../../../overview/concepts/services.md#labels) for VMs representing the group nodes. You can specify multiple labels separated by commas.
       * `scale_policy`: Scaling settings.

     {% note warning %}

     The node group configuration file must be in the same folder as the [cluster description file](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create).

     {% endnote %}

     * To create a node group with a constant number of nodes, add a `fixed_scale` section:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node group name>" {
         ...
         scale_policy {
           fixed_scale {
             size = <number of nodes in group>
           }
         }
       }
       ```

     * To create a group with [autoscaling](../../concepts/node-group/cluster-autoscaler.md), add an `auto_scale` section:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node group name>" {
         ...
         scale_policy {
           auto_scale {
             min     = <minimum number of nodes in group>
             max     = <maximum number of nodes in group>
             initial = <initial number of nodes in group>
           }
         }
       }
       ```

      * To add [DNS records](../../../dns/concepts/resource-record.md):

        {% include [node-name](../../../_includes/managed-kubernetes/tf-node-name.md) %}

     For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).
  1. Make sure that the configuration files are valid.

     {% include [terraform-create-cluster-step-2](../../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Create a cluster.

     {% include [terraform-create-cluster-step-3](../../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API

  Use the [create](../../api-ref/NodeGroup/create.md) API method and pass the following information in the request:
  * [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) ID in the `clusterId` parameter. You can retrieve it with a [list of clusters in the folder](../kubernetes-cluster/kubernetes-cluster-list.md#list).
  * [Node group configuration](../../concepts/index.md#config) as `nodeTemplate`.
  * [Container runtime environment](../../concepts/index.md#config) in the `nodeTemplate.containerRuntimeSettings.type` parameter.
  * [{{ yandex-cloud }} resource labels](../../../overview/concepts/services.md#labels) for VMs representing the group nodes, in the `nodeTemplate.labels` parameter.
  * [Scaling settings](../../concepts/autoscale.md#ca) as `scalePolicy`.
  * Node group [placement settings](../../../overview/concepts/geo-scope.md) as `allocationPolicy`.
  * [Update](../../concepts/release-channels-and-updates.md#updates) window settings in the `maintenancePolicy` parameters.
  * List of settings to be changed in the `updateMask` parameter.

  {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

  For nodes to use [non-replicated disks](../../../compute/concepts/disk.md#disks_types), pass the `network-ssd-nonreplicated` value for the `nodeTemplate.bootDiskSpec.diskTypeId` parameter.

  You can only change the size of non-replicated disks in 93 GB increments. The maximum size of this type of disk is 4 TB.

  {% include [Non-replicated disks have no redundancy](../../../_includes/managed-kubernetes/nrd-no-backup-note.md) %}

  To enable the nodes in a group to use [unsafe kernel parameters](../../concepts/index.md#node-group), pass their names in as `allowedUnsafeSysctls`.

  To set [taint policy labels](../../concepts/index.md#taints-tolerations), pass their values in as `nodeTaints`.

  To set a node name template, pass it in the `nodeTemplate.name` parameter. The name is unique if the template contains at least one of the variables:

  {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  To add [DNS records](../../../dns/concepts/resource-record.md), pass their settings in the `nodeTemplate.v4AddressSpec.dnsRecordSpecs` parameter. In a DNS record's FQDN, you can use the `nodeTemplate.name` node name template with variables.

{% endlist %}

{% note alert %}

After you create a node group, {{ compute-full-name }} will display one or more VMs with autogenerated names. Do not update the names of the VMs that belong to a {{ managed-k8s-name }} cluster. This will disrupt the operation of the node group and the entire cluster.

{% endnote %}