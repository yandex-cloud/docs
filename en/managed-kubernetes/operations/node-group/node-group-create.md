# Creating a node group

To create a [node group](../../concepts/index.md#node-group), [create a {{ managed-k8s-name }} cluster](../kubernetes-cluster/kubernetes-cluster-create.md) first and make sure that the [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) has enough [free resources](../../concepts/limits.md).

## Create a node group {#node-group-create}

{% list tabs group=instructions %}

- Management console {#console}

   {% include [node-group-create](../../../_includes/managed-kubernetes/node-group-create.md) %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Check the description of the CLI command for creating a {{ managed-k8s-name }} node group:

      ```bash
      {{ yc-k8s }} node-group create --help
      ```

   1. Specify {{ managed-k8s-name }} node group parameters in the create command (we excluded some supported parameters from the example for brevity).

      ```bash
      {{ yc-k8s }} node-group create \
        --allowed-unsafe-sysctls=<names_of_unsafe_kernel_parameters,_comma-separated> \
        --cluster-name <cluster_name> \
        --cores <number_of_vCPUs> \
        --core-fraction <guaranteed_vCPU_share> \
        --daily-maintenance-window <maintenance_window_settings> \
        --disk-size <storage_size_in_GB> \
        --disk-type <storage_type:_network-nvme_or_network-hdd> \
        --fixed-size <fixed_number_of_nodes_per_group> \
        --location <location_settings_for_cluster_hosts> \
        --memory <amount_of_RAM_in_GB> \
        --name <node_group_name> \
        --network-acceleration-type <standard_or_software-accelerated> \
        --network-interface security-group-ids=[<security_group_IDs>],subnets=[<subnet_names>],ipv4-address=<nat_or_auto> \
        --platform-id <platform_ID> \
        --container-runtime <container_runtime_environment> \
        --preemptible \
        --public-ip \
        --template-labels <node_group_cloud_labels> \
        --version <{{ k8s }}_version_on_group_nodes> \
        --node-name <node_name_template> \
        --node-taints <taint_policies>
      ```

      Where:
      * `--allowed-unsafe-sysctls`: Permission for {{ managed-k8s-name }} group nodes to use [unsafe kernel parameters](../../concepts/index.md#node-group), comma-separated.
      * `--cluster-name`: Name of the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) where the node group is created.
      * `--cores`: Number of vCPUs for {{ managed-k8s-name }} nodes.
      * `--core-fraction`: [Guaranteed share of vCPUs](../../../compute/concepts/performance-levels.md) for {{ managed-k8s-name }} nodes.
      * `--daily-maintenance-window`: [Maintenance](../../concepts/release-channels-and-updates.md#updates) window settings.
      * `--disk-size`: [Disk size](../../../compute/concepts/disk.md#maximum-disk-size) of the {{ managed-k8s-name }} node.
      * `--disk-type`: [Disk type](../../../compute/concepts/disk.md#disks_types) of the {{ managed-k8s-name }} node.
      * `--fixed-size`: Number of nodes in the {{ managed-k8s-name }} node group.
      * `--location`: [Availability zone](../../../overview/concepts/geo-scope.md), [network](../../../vpc/concepts/network.md#network), and [subnet](../../../vpc/concepts/network.md#subnet) to host {{ managed-k8s-name }} nodes. You can specify several options.

         If you transmit `--location`, `--network-interface`, and `--public-ip` in the same command, you will [get an error](../../qa/troubleshooting.md#conflicting-flags). It is sufficient to specify the location of a {{ managed-k8s-name }} node group either in `--location` or `--network-interface`.

         {% include [assign-public-ip-addresses](../../../_includes/managed-kubernetes/assign-public-ip-addresses.md) %}

      * `--memory`: Amount of memory allocated for {{ managed-k8s-name }} nodes.
      * `--name`: Name of the {{ managed-k8s-name }} node group.
      * `--network-acceleration-type`: Type of [network acceleration](../../../compute/concepts/software-accelerated-network.md):
         * `standard`: No acceleration.
         * `software-accelerated`: Software-accelerated network.

         {% include [note-software-accelerated-network](../../../_includes/managed-kubernetes/note-software-accelerated-network.md) %}

      * `--network-interface`: Network settings:

         {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

      * `--platform-id`: [Platform](../../../compute/concepts/vm-platforms.md) for {{ managed-k8s-name }} nodes.
      * `--container-runtime`: [Container runtime environment](../../concepts/index.md#config), `docker` or `containerd`.
      * `--preemptible`: Flag specified if the VM instances should be [preemptible](../../../compute/concepts/preemptible-vm.md).
      * `--public-ip`: Flag you set if the {{ managed-k8s-name }} node group needs a [public IP address](../../../vpc/concepts/address.md#public-addresses).
      * `--template-labels`: [Node group cloud labels](../../../resource-manager/concepts/labels.md) in `<label_name>=<label_value>` format. You can specify multiple labels separated by commas.
      * `--version`: {{ k8s }} version on {{ managed-k8s-name }} group nodes.
      * `--node-name`: Name template for {{ managed-k8s-name }} nodes. The name is unique if the template contains at least one of the following variables:

         {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

      * `--node-taints`: {{ k8s }} [taint policies](../../concepts/index.md#taints-tolerations). You can specify multiple policies.

      {% include [user-data](../../../_includes/managed-kubernetes/user-data.md) %}

      Result:

      ```text
      done (1m17s)
      id: catpl8c44kii********
      cluster_id: catcsqidoos7********
      ...
          start_time:
            hours: 22
          duration: 36000s
      ```

   1. To specify a [placement group](../../../compute/concepts/placement-groups.md) for {{ managed-k8s-name }} nodes:
      1. Retrieve a list of placement groups using the `yc compute placement-group list` command.
      1. Provide a placement group name or ID in the `--placement group` flag when creating a {{ managed-k8s-name }} node group:

         ```bash
         {{ yc-k8s }} node-group create \
         ...
           --placement-group <placement_group_name_or_ID>
         ```

- {{ TF }} {#tf}

   To create a [{{ managed-k8s-name }} node group](../../concepts/index.md#node-group):
   1. In the folder containing the [cluster description file](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create), create a configuration file with the parameters of a new {{ managed-k8s-name }} node group:
      * {{ managed-k8s-name }} node group name.
      * [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) ID as `cluster_id`.
      * {{ managed-k8s-name }} node [platform](../../../compute/concepts/vm-platforms.md).
      * [Container runtime environment](../../concepts/index.md#config) setting in the `container_runtime` parameter.
      * [Node group cloud labels](../../../resource-manager/concepts/labels.md) in the `nodeTemplate.labels` section.
      * Scaling settings under `scale_policy`.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_kubernetes_node_group" "<node_group_name>" {
        cluster_id = yandex_kubernetes_cluster.<cluster_name>.id
        name       = "<node_group_name>"
        ...
        instance_template {
          name       = "<node_name_template>"
          platform_id = "<node_platform>"
          network_acceleration_type = "<network_acceleration_type>"
          container_runtime {
           type = "<container_runtime_environment>"
          }
          labels {
            "<label_name>"="<label_value>"
          }
          ...
        }
        ...
        scale_policy {
          <node_group_scaling_settings>
        }
      }
      ```

      Where:
      * `cluster_id`: ID of the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster).
      * `--name`: Name of the {{ managed-k8s-name }} node group.
      * `instance_template`: {{ managed-k8s-name }} node parameters:
         * `name`: {{ managed-k8s-name }} node name template. The name is unique if the template contains at least one of the following variables:

            {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

         * `platform_id`: {{ managed-k8s-name }} node [platform](../../../compute/concepts/vm-platforms.md).
         * `network_acceleration_type`: [Network acceleration](../../../compute/concepts/software-accelerated-network.md) type:
            * `standard`: No acceleration.
            * `software-accelerated`: Software-accelerated network.

            {% include [note-software-accelerated-network](../../../_includes/managed-kubernetes/note-software-accelerated-network.md) %}

         * `container_runtime`:
            * `type`: [Container runtime environment](../../concepts/index.md#config) (`docker` or `containerd`).

         * `labels`: [Node group cloud labels](../../../resource-manager/concepts/labels.md). You can specify multiple labels separated by commas.
         * `scale_policy`: Scaling settings.

      {% note warning %}

      The {{ managed-k8s-name }} node group configuration file must be in the same folder as the [cluster description file](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create).

      {% endnote %}

      * To create a node group with a constant number of nodes, add a `fixed_scale` section:

         ```hcl
         resource "yandex_kubernetes_node_group" "<node_group_name>" {
           ...
           scale_policy {
             fixed_scale {
               size = <number_of_nodes_per_group>
             }
           }
         }
         ```

      * To create a {{ managed-k8s-name }} node group with [autoscaling](../../concepts/node-group/cluster-autoscaler.md), add an `auto_scale` section:

         ```hcl
         resource "yandex_kubernetes_node_group" "<node_group_name>" {
           ...
           scale_policy {
             auto_scale {
               min     = <minimum_number_of_nodes_per_group>
               max     = <maximum_number_of_nodes_per_group>
               initial = <initial_number_of_nodes_per_group>
             }
           }
         }
         ```

      * To add [DNS records](../../../dns/concepts/resource-record.md):

         {% include [node-name](../../../_includes/managed-kubernetes/tf-node-name.md) %}

      For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).
   1. Make sure the configuration files are valid.

      {% include [terraform-create-cluster-step-2](../../../_includes/mdb/terraform-create-cluster-step-2.md) %}

   1. Create a {{ managed-k8s-name }} cluster.

      {% include [terraform-create-cluster-step-3](../../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API {#api}

   Use the [create](../../api-ref/NodeGroup/create.md) API method and include the following information in the request:
   * [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) ID in the `clusterId` parameter. You can get it with a [list of {{ managed-k8s-name }} clusters in the folder](../kubernetes-cluster/kubernetes-cluster-list.md#list).
   * [{{ managed-k8s-name }} node group configuration](../../concepts/index.md#config) as `nodeTemplate`.
   * [Network acceleration type](../../../compute/concepts/software-accelerated-network.md) in the `nodeTemplate.networkSettings.type` parameter.

      {% include [note-software-accelerated-network](../../../_includes/managed-kubernetes/note-software-accelerated-network.md) %}

   * [Container runtime environment](../../concepts/index.md#config) in the `nodeTemplate.containerRuntimeSettings.type` parameter.
   * [Node group cloud labels](../../../resource-manager/concepts/labels.md) in the `nodeTemplate.labels` parameter.
   * [Scaling settings](../../concepts/autoscale.md#ca) as `scalePolicy`.
   * {{ managed-k8s-name }} node group [placement settings](../../../overview/concepts/geo-scope.md) in the `allocationPolicy` parameters.
   * [Maintenance](../../concepts/release-channels-and-updates.md#updates) window settings in the `maintenancePolicy` parameters.
   * List of settings to be changed in the `updateMask` parameter.

   {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

   For nodes to use [non-replicated disks](../../../compute/concepts/disk.md#disks_types), pass the `network-ssd-nonreplicated` value for the `nodeTemplate.bootDiskSpec.diskTypeId` parameter.

   You can only change the size of non-replicated disks in 93 GB increments. The maximum size of this type of disk is 4 TB.

   {% include [Non-replicated disks have no redundancy](../../../_includes/managed-kubernetes/nrd-no-backup-note.md) %}

   To enable {{ managed-k8s-name }} group nodes to use [unsafe kernel parameters](../../concepts/index.md#node-group), provide their names in the `allowedUnsafeSysctls` parameter.

   To set [taint policies](../../concepts/index.md#taints-tolerations), provide their values in the `nodeTaints` parameter.

   To set a template for {{ managed-k8s-name }} node names, provide it in the `nodeTemplate.name` parameter. The name is unique if the template contains at least one of the following variables:

   {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

   To add [DNS records](../../../dns/concepts/resource-record.md), pass their settings in the `nodeTemplate.v4AddressSpec.dnsRecordSpecs` parameter. In a DNS record's FQDN, you can use the `nodeTemplate.name` node name template with variables.

{% endlist %}

{% note alert %}

After you create a {{ managed-k8s-name }} node group, {{ compute-full-name }} will display one or more VMs with automatically generated names. Do not update the names of the VMs that belong to a {{ managed-k8s-name }} cluster. This will disrupt the operation of the node group and the entire {{ managed-k8s-name }} cluster.

{% endnote %}