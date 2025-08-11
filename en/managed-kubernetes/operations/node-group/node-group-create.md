---
title: Creating a node group
description: Follow this guide to create node groups.
---

# Creating a node group


A [node group](../../concepts/index.md#node-group) is a group of VMs in a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) that have the same configuration and run the user's containers.

Before creating a node group, [create](../kubernetes-cluster/kubernetes-cluster-create.md) a {{ managed-k8s-name }} cluster first and make sure that the [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) has enough [free resources](../../concepts/limits.md).

{% list tabs group=instructions %}

- Management console {#console}

  {% include [node-group-create](../../../_includes/managed-kubernetes/node-group-create.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to create a {{ managed-k8s-name }} node group:

     ```bash
     {{ yc-k8s }} node-group create --help
     ```

  1. Specify {{ managed-k8s-name }} node group parameters in the create command (we excluded some supported parameters from the example for brevity).

     ```bash
     {{ yc-k8s }} node-group create \
       --allowed-unsafe-sysctls <names_of_unsafe_kernel_parameters> \
       --cluster-name <cluster_name> \
       --cores <number_of_vCPUs> \
       --core-fraction <guaranteed_vCPU_share> \
       --daily-maintenance-window <update_window_settings> \
       --disk-size <storage_size_in_GB> \
       --disk-type <storage_type> \
       --fixed-size <fixed_number_of_nodes_in_group> \
       --max-expansion <expanding_group_size_when_updating> \
       --max-unavailable <number_of_unavailable_nodes_when_updating> \
       --location zone=[<availability_zone>],subnet-id=[<subnet_ID>] \
       --memory <amount_of_RAM_in_GB> \
       --name <node_group_name> \
       --network-acceleration-type <network_acceleration_type> \
       --network-interface security-group-ids=[<security_group_IDs>],ipv4-address=<IP_address_assignment_method> \
       --platform-id <platform_ID> \
       --container-runtime containerd \
       --preemptible \
       --public-ip \
       --template-labels <cloud_label_key=cloud_label_value> \
       --node-labels <k8s_label_key=k8s_label_value>
       --version <{{ k8s }}_version_on_group_nodes> \
       --node-name <node_name_template> \
       --node-taints <taint_policies> \
       --container-network-settings pod-mtu=<MTU_value_for_group_pods>
     ```

     Where:
     * `--allowed-unsafe-sysctls`: Permission for {{ managed-k8s-name }} group nodes to use [unsafe kernel parameters](../../concepts/index.md#node-group), comma-separated.
     * `--cluster-name`: Name of the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) to create the node group in.
     * `--cores`: Number of vCPUs for {{ managed-k8s-name }} nodes.
     * `--core-fraction`: [Guaranteed share of vCPUs](../../../compute/concepts/performance-levels.md) for {{ managed-k8s-name }} nodes.
     * `--daily-maintenance-window`: [Maintenance](../../concepts/release-channels-and-updates.md#updates) window settings.
     * `--disk-size`: [Disk size](../../../compute/concepts/disk.md#maximum-disk-size) of the {{ managed-k8s-name }} node.
     * `--disk-type`: [Disk type](../../../compute/concepts/disk.md#disks_types) of the {{ managed-k8s-name }} node: `network-nvme` or `network-hdd`.
     * Type of scaling:

       * `--fixed-size`: Fixed number of nodes in a {{ managed-k8s-name }} node group.
       * `--auto-scale`: Configuring [{{ managed-k8s-name }} cluster autoscaling](../../concepts/node-group/cluster-autoscaler.md):

         * `min`: Minimum number of nodes in the group.
         * `max`: Maximum number of nodes in the group.
         * `initial`: Initial number of nodes in the group.

       You cannot change the scaling type after you create a node group.

     * `--max-expansion`: Maximum number of nodes by which you can increase the size of the group when updating it.

       {% include [note-expansion-group-vm](../../../_includes/managed-kubernetes/note-expansion-group-vm.md) %}

     * `--max-unavailable`: Maximum number of unavailable nodes in the group when updating it.
     * `--location`: [Availability zone](../../../overview/concepts/geo-scope.md) and [subnet](../../../vpc/concepts/network.md#subnet) to host {{ managed-k8s-name }} nodes. You can specify more than one option but only a single subnet per zone. Use a separate `--location` parameter for each of the availability zones.

       {% include [autoscaled-node-group-restriction](../../../_includes/managed-kubernetes/autoscaled-node-group-restriction.md) %}

       If you provide `--location`, `--network-interface`, and `--public-ip` in the same command, you will [get an error](../../qa/troubleshooting.md#conflicting-flags). It is enough to specify the location of a {{ managed-k8s-name }} node group either in `--location` or `--network-interface`.

       {% include [assign-public-ip-addresses](../../../_includes/managed-kubernetes/assign-public-ip-addresses.md) %}

     * `--memory`: Amount of memory allocated for {{ managed-k8s-name }} nodes.
     * `--name`: {{ managed-k8s-name }} node group name.
     * `--network-acceleration-type`: Change [network acceleration](../../../compute/concepts/software-accelerated-network.md) type:
       * `standard`: No acceleration.
       * `software-accelerated`: Software-accelerated network.

       {% include [note-software-accelerated-network](../../../_includes/managed-kubernetes/note-software-accelerated-network.md) %}

     * `--network-interface`: Network settings:

       {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

     * `--platform-id`: {{ managed-k8s-name }} node [platform](../../../compute/concepts/vm-platforms.md).
     * `--container-runtime`: [containerd](https://containerd.io/) runtime environment.
     * `--preemptible`: Flag you set for [preemptible](../../../compute/concepts/preemptible-vm.md) VMs.
     * `--public-ip`: Flag you set if the {{ managed-k8s-name }} node group needs a [public IP address](../../../vpc/concepts/address.md#public-addresses).
     * `--template-labels`: Node group [cloud labels](../../concepts/index.md#node-labels). You can specify multiple labels separated by commas.
     * `--node-labels`: Node group [{{ k8s }} labels](../../concepts/index.md#node-labels).
     * `--version`: {{ k8s }} version on the {{ managed-k8s-name }} group nodes.
     * `--node-name`: {{ managed-k8s-name }} node name template. The name is unique if the template contains at least one of the following variables:

       {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

     * `--node-taints`: {{ k8s }} [taint policies](../../concepts/index.md#taints-tolerations). You can specify multiple values.
     * `--container-network-settings`: [MTU](https://en.wikipedia.org/wiki/Maximum_transmission_unit) value for network connections to group pods. This setting is not applicable for clusters with Calico or Cilium network policy controllers.

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

  1. To add metadata for nodes, use the `--metadata` or `--metadata-from-file` parameter.

        {% include [connect-metadata-list](../../../_includes/managed-kubernetes/connect-metadata-list.md) %}

        {% note warning %}

        {% include [node-group-metadata-warning](../../../_includes/managed-kubernetes/node-group-metadata-warning.md) %}

        {% endnote %}

        Add metadata using one of the following methods:

        * Using `--metadata`, specify one or more `key=value` pairs separated by commas.

            {% include [metadata-key-explicit](../../../_includes/managed-kubernetes/metadata-key-explicit.md) %}

        * Using `--metadata-from-file`, specify one or more `key=path_to_file_with_value` pairs separated by commas.

            {% include [metadata-key-from-file](../../../_includes/managed-kubernetes/metadata-key-from-file.md) %}

        {% include [node-group-metadata-postponed-update-note](../../../_includes/managed-kubernetes/node-group-metadata-postponed-update-note.md) %}

  1. To specify a [placement group](../../../compute/concepts/placement-groups.md) for {{ managed-k8s-name }} nodes:
     1. Get a list of placement groups using the `yc compute placement-group list` command.
     1. Provide a placement group name or ID in the `--placement-group` parameter when creating a {{ managed-k8s-name }} node group:

        ```bash
        {{ yc-k8s }} node-group create \
        ...
          --placement-group <placement_group_name_or_ID>
        ```

- {{ TF }} {#tf}

  To create a [{{ managed-k8s-name }} node group](../../concepts/index.md#node-group):

  1. In the folder containing the [cluster description file](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create), create a configuration file with the new {{ managed-k8s-name }} node group's parameters.

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_kubernetes_node_group" "<node_group_name>" {
       cluster_id = yandex_kubernetes_cluster.<cluster_name>.id
       name       = "<node_group_name>"
       ...
       instance_template {
         name       = "<node_name_template>"
         platform_id = "<platform_for_nodes>"
         network_acceleration_type = "<network_acceleration_type>"
         container_runtime {
           type = "containerd"
         }
         labels {
           "<cloud_label_name>"="<cloud_label_value>"
         }
         node_labels {
           "<{{ k8s }}_label_name>"="<{{ k8s }}_label_value>"
         }
         ...
       }
       ...
       scale_policy {
         <node_group_scaling_settings>
       }
       deploy_policy {
         max_expansion   = <expanding_group_size_when_updating>
         max_unavailable = <number_of_unavailable_nodes_when_updating>
       }
       ...
       allocation_policy {
         location {
           zone = "<availability_zone>"
         }
       }
     }
     ```

     Where:
     * `cluster_id`: [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) ID.
     * `name`: {{ managed-k8s-name }} node group name.
     * `instance_template`: {{ managed-k8s-name }} node parameters:
       * `name`: {{ managed-k8s-name }} node name template. The name is unique if the template contains at least one of the following variables:

         {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

       * `platform_id`: {{ managed-k8s-name }} node [platform](../../../compute/concepts/vm-platforms.md).
       * `network_acceleration_type`: [Network acceleration](../../../compute/concepts/software-accelerated-network.md) type:
         * `standard`: No acceleration.
         * `software-accelerated`: Software-accelerated network.

         {% include [note-software-accelerated-network](../../../_includes/managed-kubernetes/note-software-accelerated-network.md) %}

       * `container_runtime`, `type`: [containerd](https://containerd.io/) runtime environment.
       * `labels`: Node group [cloud labels](../../concepts/index.md#node-labels). You can specify multiple labels separated by commas.
       * `node_labels`: Node group [{{ k8s }} labels](../../concepts/index.md#node-labels).
       * `scale_policy`: Scaling settings.

         You cannot change the scaling type after you create a node group.

       * `deploy_policy`: Group deployment settings:
         * `max_expansion`: Maximum number of nodes by which you can increase the size of the group when updating it.

           {% include [note-expansion-group-vm](../../../_includes/managed-kubernetes/note-expansion-group-vm.md) %}

         * `max_unavailable`: Maximum number of unavailable nodes in the group when updating it.

       * `allocation_policy`: Placement settings. These contain the `location` section with the `zone` parameter that represents the [availability zone](../../../overview/concepts/geo-scope.md) you want to place the group nodes in. You can place nodes of a group with the fixed scaling type in multiple availability zones. To do this, specify each of the availability zones you need in a separate `location` section.

         {% include [autoscaled-node-group-restriction](../../../_includes/managed-kubernetes/autoscaled-node-group-restriction.md) %}

     * To create a node group with a constant number of nodes, add a `fixed_scale` section:

       ```hcl
       resource "yandex_kubernetes_node_group" "<node_group_name>" {
         ...
         scale_policy {
           fixed_scale {
             size = <number_of_nodes_in_group>
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
             min     = <minimum_number_of_nodes_in_node_group>
             max     = <maximum_number_of_nodes_in_node_group>
             initial = <initial_number_of_nodes_in_node_group>
           }
         }
       }
       ```
       
     * To add metadata for nodes, provide it in the `instance_template.metadata` parameter.

        {% include [connect-metadata-list](../../../_includes/managed-kubernetes/connect-metadata-list.md) %}

        {% note warning %}

        {% include [node-group-metadata-warning](../../../_includes/managed-kubernetes/node-group-metadata-warning.md) %}

        {% endnote %}

        Add metadata using one of the following methods:

        * Specify one or more `key=value` pairs.

            {% include [metadata-key-explicit](../../../_includes/managed-kubernetes/metadata-key-explicit.md) %}

        * Specify one or more `key=file(path_to_file_with_value)` pairs.

            {% include [metadata-key-from-file](../../../_includes/managed-kubernetes/metadata-key-from-file.md) %}

        ```hcl
        resource "yandex_kubernetes_node_group" "<node_group_name>" {
          ...
          instance_template {
            metadata = {
              "key_1" = "value"
              "key_2" = file("<path_to_file_with_value>")
              ...
            }
            ...
          }
          ...
        }
        ```

        {% include [node-group-metadata-postponed-update-note](../../../_includes/managed-kubernetes/node-group-metadata-postponed-update-note.md) %}

     * To add [DNS records](../../../dns/concepts/resource-record.md):

       {% include [node-name](../../../_includes/managed-kubernetes/tf-node-name.md) %}

     For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-nodegroup }}).
  1. Make sure the configuration files are correct.

     {% include [terraform-create-cluster-step-2](../../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Create a {{ managed-k8s-name }} node group.

     {% include [terraform-create-cluster-step-3](../../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API {#api}

  Use the [create](../../managed-kubernetes/api-ref/NodeGroup/create.md) API method and include the following information in the request:
  * [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) ID in the `clusterId` parameter. You can get it with the [list of {{ managed-k8s-name }} clusters in the folder](../kubernetes-cluster/kubernetes-cluster-list.md#list).
  * [{{ managed-k8s-name }} node group configuration](../../concepts/index.md#config) in the `nodeTemplate` parameter.
  * [Network acceleration type](../../../compute/concepts/software-accelerated-network.md) in the `nodeTemplate.networkSettings.type` parameter.

    {% include [note-software-accelerated-network](../../../_includes/managed-kubernetes/note-software-accelerated-network.md) %}

  * [containerd](https://containerd.io/) runtime environment in the `nodeTemplate.containerRuntimeSettings.type` parameter.
  * Node group [cloud labels](../../concepts/index.md#node-labels) in the `nodeTemplate.labels` parameter.
  * Node group [{{ k8s }} labels](../../concepts/index.md#node-labels) in the `nodeLabels` parameter.
  * [Scaling settings](../../concepts/autoscale.md#ca) in the `scalePolicy` parameter.
  
    You cannot change the scaling type after you create a node group.

  * Node group deployment settings in the `deployPolicy` parameter:
    * `maxExpansion`: Maximum number of nodes by which you can increase the size of the group when updating it.

      {% include [note-expansion-group-vm](../../../_includes/managed-kubernetes/note-expansion-group-vm.md) %}

    * `maxUnavailable`: Maximum number of unavailable nodes in the group when updating it.

  * {{ managed-k8s-name }} node group [placement settings](../../../overview/concepts/geo-scope.md) in the `allocationPolicy` parameters.

    {% include [autoscaled-node-group-restriction](../../../_includes/managed-kubernetes/autoscaled-node-group-restriction.md) %}

  * [Maintenance](../../concepts/release-channels-and-updates.md#updates) window settings in the `maintenancePolicy` parameters.
  * List of settings being changed in the `updateMask` parameter.

    {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

  * For nodes to use [non-replicated disks](../../../compute/concepts/disk.md#disks_types), provide the `network-ssd-nonreplicated` value for the `nodeTemplate.bootDiskSpec.diskTypeId` parameter.

    You can only change the size of non-replicated disks in 93 GB increments. The maximum size of this type of disk is 4 TB.

    {% include [Non-replicated disks have no redundancy](../../../_includes/managed-kubernetes/nrd-no-backup-note.md) %}

  * To enable {{ managed-k8s-name }} group nodes to use [unsafe kernel parameters](../../concepts/index.md#node-group), provide their names in the `allowedUnsafeSysctls` parameter.

  * To set [taint policies](../../concepts/index.md#taints-tolerations), provide their values in the `nodeTaints` parameter.

  * To set a template for {{ managed-k8s-name }} node names, provide it in the `nodeTemplate.name` parameter. The name is unique if the template contains at least one of the following variables:

    {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  * To add metadata for nodes, provide it in the `nodeTemplate.metadata` parameter.

    {% include [connect-metadata-list](../../../_includes/managed-kubernetes/connect-metadata-list.md) %}

    {% note warning %}

    {% include [node-group-metadata-warning](../../../_includes/managed-kubernetes/node-group-metadata-warning.md) %}

    {% endnote %}

    Add metadata by specifying one or more `key=value` pairs separated by commas.

    {% include [metadata-key-explicit](../../../_includes/managed-kubernetes/metadata-key-explicit.md) %}

    {% include [node-group-metadata-postponed-update-note](../../../_includes/managed-kubernetes/node-group-metadata-postponed-update-note.md) %}

  * To add [DNS records](../../../dns/concepts/resource-record.md), provide their settings in the `nodeTemplate.v4AddressSpec.dnsRecordSpecs` parameter. In a DNS record's FQDN, you can use the `nodeTemplate.name` node name template with variables.

{% endlist %}

Creating a group of {{ managed-k8s-name }} nodes may take a few minutes depending on the number of nodes.

{% include [node-vm-explained-short](../../../_includes/managed-kubernetes/node-vm-explained-short.md) %}

{% include [node-vm-manipulation-warning](../../../_includes/managed-kubernetes/node-vm-manipulation-warning.md) %}

## Examples {#examples}

Create a node group for the {{ managed-k8s-name }} cluster with the following test characteristics:

* Name: `k8s-demo-ng`.
* Description: `Test node group`.
* Node name template: `test-{instance.short_id}-{instance_group.id}`.
* [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster): Specify the [ID](../kubernetes-cluster/kubernetes-cluster-list.md) of an existing cluster, e.g., `{{ cluster-id }}`.
* [{{ k8s }} version](../../concepts/release-channels-and-updates.md) on group nodes: `1.29`.
* Node [platform](../../../compute/concepts/vm-platforms.md): `standard-v3`.
* Number of vCPUs for the nodes: Two.
* [Guaranteed vCPU share](../../../compute/concepts/performance-levels.md): 50%.
* [Disk size](../../../compute/concepts/disk.md#maximum-disk-size): 64 GB.
* [Disk type](../../../compute/concepts/disk.md#disks_types): `network-ssd`.
* Number of nodes: One.
* Number of nodes that {{ managed-k8s-name }} can create in the group during its [update](../../concepts/release-channels-and-updates.md#node-group): No more than three.
* Number of nodes that the service can delete from the group during its update: No more than one.
* RAM: 2 GB.
* [Update](../../concepts/release-channels-and-updates.md#updates) time: From 22:00 to 08:00 UTC.
* [Network acceleration](../../../compute/concepts/software-accelerated-network.md) type: `standard` (no acceleration).
* Network settings:
  * [Security group ID](../../../vpc/operations/security-group-get-info.md), e.g., `{{ security-group }}`.
  * [Subnet ID](../../../vpc/operations/subnet-get-info.md), e.g., `e9bj3s90g9hm********`.
  * Assigning public and internal IP addresses to nodes: Enabled.
* [{{ k8s }} label](../../concepts/index.md#node-labels): `node-label1=node-value1`.
* {{ k8s }} [taint policy](../../concepts/index.md#taints-tolerations): `taint1=taint-value1:NoSchedule`.
* [Cloud label](../../concepts/index.md#node-labels): `template-label1=template-value1`.
* Permission to use [unsafe kernel parameters](../../concepts/index.md#config): Enabled. Added the `kernel.msg*` and `net.core.somaxconn` parameters.
* VM being the only node of the group: [Preemptible](../../../compute/concepts/preemptible-vm.md).

{% list tabs group=instructions %}

- CLI {#cli}

  Run this command:

  ```bash
  {{ yc-k8s }} node-group create \
    --name k8s-demo-ng \
    --description 'Test node group' \
    --node-name test-{instance.short_id}-{instance_group.id} \
    --cluster-id {{ cluster-id }} \
    --version 1.29 \
    --platform-id standard-v3 \
    --cores 2 \
    --core-fraction 50 \
    --disk-size 64 \
    --disk-type network-ssd \
    --fixed-size 1 \
    --max-expansion 3 \
    --max-unavailable 1 \
    --memory 2 \
    --daily-maintenance-window 'start=22:00,duration=10h' \
    --network-acceleration-type standard \
    --network-interface security-group-ids={{ security-group }},subnets=e9bj3s90g9hm********,ipv4-address=nat \
    --node-labels node-label1=node-value1 \
    --node-taints taint1=taint-value1:NoSchedule \
    --template-labels template-label1=template-value1 \
    --allowed-unsafe-sysctls='kernel.msg*,net.core.somaxconn' \
    --preemptible
  ```

- {{ TF }}

  1. Place the node group configuration file in the same folder as the [cluster description file](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create).

      ```hcl
      resource "yandex_kubernetes_node_group" "k8s-demo-ng" {
        name        = "k8s-demo-ng"
        description = "Test node group"
        cluster_id  = "{{ cluster-id }}"
        version     = "1.29"
        instance_template {
          name = "test-{instance.short_id}-{instance_group.id}"
          platform_id = "standard-v3"
          resources {
            cores         = 2
            core_fraction = 50
            memory        = 2
          }
          boot_disk {
            size = 64
            type = "network-ssd"
          }
          network_acceleration_type = "standard"
          network_interface {
            security_group_ids = ["{{ security-group }}"]
            subnet_ids         = ["e9bj3s90g9hm********"]
            nat                = true
          }
          scheduling_policy {
            preemptible = true
          }
        }
        scale_policy {
          fixed_scale {
            size = 1
          }
        }
        deploy_policy {
          max_expansion   = 3
          max_unavailable = 1
        }
        maintenance_policy {
          auto_upgrade = true
          auto_repair  = true
          maintenance_window {
            start_time = "22:00"
            duration   = "10h"
          }
        }
        node_labels = {
          node-label1 = "node-value1"
        }
        node_taints = ["taint1=taint-value1:NoSchedule"]
        labels = {
          "template-label1" = "template-value1"
        }
        allowed_unsafe_sysctls = ["kernel.msg*", "net.core.somaxconn"]
      }
      ```

  1. Check that the configuration file is correct.

      {% include [terraform-create-cluster-step-2](../../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Create a {{ managed-k8s-name }} node group.

      {% include [terraform-create-cluster-step-3](../../../_includes/mdb/terraform-create-cluster-step-3.md) %}

{% endlist %}
