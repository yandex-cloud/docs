## Getting started {#before-you-begin}

For the ![objects-align-justify-horizontal](../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create-baremetal-ng }}** item to appear in the node group creation menu, do the following:

1. [Create a {{ managed-k8s-name }} 1.35 cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) with [Cilium tunnel mode](../../managed-kubernetes/concepts/network-policy.md#cilium) (Cilium CNI) enabled, or make sure an existing cluster meets these requirements. Tunnel mode can only be activated at the step of creating a cluster.
1. Check the cluster network settings to get the [cluster CIDR and service CIDR](../../managed-kubernetes/quickstart.md#kubernetes-cluster-create).
1. Set up a private {{ baremetal-name }} subnet. Make sure it belongs to a VRF and [DHCP is enabled](../../baremetal/concepts/dhcp.md#dhcp-private) in its settings. If there is no suitable subnet, [create one](../../baremetal/operations/subnet-create.md).
1. [Create a private connection](../../baremetal/operations/create-vpc-connection.md) between the VRF and cloud network hosting the {{ managed-k8s-name }} master. Use a virtual {{ cr-name }} for the connection.
1. [Add](../../cloud-router/operations/ri-prefixes-upsert.md#upsert-prefixes) the cluster CIDR and service CIDR to the virtual router as announced IP prefixes of the master's cloud network.

## Create a node group {#create-node-group}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the cluster.
  1. Go to the **{{ ui-key.yacloud.k8s.cluster.switch_cluster-overview }}** tab and select the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** section.
  1. Click **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}** and select ![objects-align-justify-horizontal](../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create-baremetal-ng }}**.
  1. In the **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.step_configuration }}** step:

     1. Specify **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.field_node-count }}**. This value is used to select configurations with sufficient number of available servers and does not define the group size. You can set the group size in the next step.
     1. Select a [server configuration](../../baremetal/concepts/server-configurations.md) with appropriate CPUs, RAM, and disk type and size.

     The availability of configurations depends on the [server pool](../../baremetal/concepts/servers.md#server-pools). A private subnet connects servers from the same pool, so in the next step, select a subnet from the pool where the selected configuration is available.

  1. In the **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.step_settings }}** step:

     1. Specify a node group name. Optionally, add a description and labels.
     1. Make sure the **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.field_k8s-version }}** field is set to `1.35`.
     1. Optionally, update **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.field_node-count }}**.
     1. Under **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.section_network-interfaces }}**, in the **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.field_private-subnet }}** field for the first interface, select the subnet you set up from the pool where the selected configuration is available. The subnet must have DHCP enabled, and the subnet VRF must be connected to the master's cloud network.
     1. If your nodes require internet access, enable **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.label_internet-access }}** for the second interface. Public IP addresses will be assigned automatically. Internet access is optional for the {{ baremetal-name }} node group.
     1. Configure **{{ ui-key.yacloud.k8s.MaintenanceSection.maintenance-window-field-with-none-option_tx5Wn }}** and specify **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.field_max-unavailable }}**.

     1. Add **{{ ui-key.yacloud.k8s.node-groups.create.field_node-taints }}** and **{{ ui-key.yacloud.k8s.node-groups.create.field_node-labels }}** as needed.

  1. Click **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.action_create-node-group }}**.

{% endlist %}

After the node group is created, {{ baremetal-extend-managed-k8s-name }} will rent the selected number of servers, configure them, and connect them to the cluster. The group will appear in the list of node groups of the **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-baremetal }}** type.

#### Useful links {#see-also}

* [{#T}](../../managed-kubernetes/operations/baremetal-group/update-baremetal.md)
* [{#T}](../../managed-kubernetes/operations/baremetal-group/delete-baremetal.md)
* [{#T}](../../baremetal/concepts/extend/managed-kubernetes.md)
* [{#T}](../../baremetal/operations/create-vpc-connection.md)
* [{#T}](../../cloud-router/operations/ri-prefixes-upsert.md)
* [{#T}](../../baremetal/concepts/dhcp.md)
