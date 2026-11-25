---
title: Creating a node group on {{ baremetal-name }} servers
description: Create a node group on {{ baremetal-name }} servers in the {{ managed-k8s-name }} cluster. Prepare the network and select the server configuration.
---

# Creating a node group on {{ baremetal-name }} servers

{% note info %}

You can create, modify, and delete node groups on {{ baremetal-name }} servers only via the management console.

{% endnote %}

In the {{ managed-k8s-name }} cluster, you can create a [node group](../../concepts/index.md#node-group) on {{ baremetal-name }} dedicated servers. {{ baremetal-extend-managed-k8s-name }} will rent the servers, auto-configure them, and connect them to your cluster. By default, server rent period is one day.

## Getting started {#before-you-begin}

To create a node group on {{ baremetal-name }} servers, you need a {{ managed-k8s-name }} cluster version 1.35 with a public master address and active [Cilium tunnel mode](../../../managed-kubernetes/concepts/network-policy.md#cilium) (Cilium CNI). You can use an existing cluster if these criteria are met. Tunnel mode can only be activated at the cluster creation step.

If there is no suitable cluster, prepare the infrastructure:

1. [Create a service account](../../../iam/operations/sa/create.md) and [assign](../../../iam/operations/sa/assign-role-for-sa.md) it the `k8s.tunnelClusters.agent` and `vpc.publicAdmin` roles for the folder you are going to create the cluster in.
1. [Create](../../../vpc/operations/security-group-create.md) and [configure](../../../managed-kubernetes/operations/connect/security-groups.md) security groups for the  cluster.

   {% note warning %}

   The configuration of security groups determines performance and availability of the cluster and the services and applications running in it.

   {% endnote %}

1. [Create a cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md):

   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** field, select `1.35`.
   * In the **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}** and **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}** fields, select the new service account.
   * In the **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}** section, select `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}` in the **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}** field to connect to the master over the internet.
   * In the **{{ ui-key.yacloud.mdb.forms.field_security-group }}** field, specify the security groups you prepared.
   * In the **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}** section, enable **{{ ui-key.yacloud.k8s.clusters.create.field_tunnel-mode }}** to use tunnel mode.

In **{{ ui-key.yacloud.k8s.cluster.switch_cluster-overview }}** → **{{ ui-key.yacloud.common.overview }}**, in the **Network settings** section, view the cluster CIDR, and service CIDRs. You will need these to set up routing.

## Create a virtual router {#create-routing-instance}

A {{ cr-name }} [virtual router](../../../cloud-router/concepts/routing-instance.md) serves for communication between the {{ baremetal-name }} private network and the {{ managed-k8s-name }} master's cloud network.

If you already have a suitable router, [add to it](../../../cloud-router/operations/ri-prefixes-upsert.md#upsert-prefixes) the cluster CIDR, and service CIDRs as announced IP prefixes of the master's cloud network and proceed to [create a node group](#create-node-group).

{% note info %}

To create a virtual router, you need the `cloud-router.editor` [role](../../../cloud-router/security/index.md#cloudrouter-editor).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the cluster.
  1. [Navigate]({{ link-console-main }}/link/cloud-router) to **{{ ui-key.yacloud.ui.constants.label_cloud-router_kBGNL }}**.
  1. Click **{{ ui-key.yacloud.cloud-router.router.create-router_v4cPC }}**.
  1. Enter a name and description for your virtual router.
  1. Optionally, add [labels](../../../resource-manager/concepts/labels.md) and activate **{{ ui-key.yacloud.common.deletion-protection }}**.
  1. In the **{{ ui-key.yacloud.cloud-router.router.networks_fbzKL }}** field, select the cloud network the cluster's master resides in.
  1. In the selected network's section, add IP prefixes for: CIDRs of its subnets, CIDR of the cluster, and CIDRs of the services.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create a node group {#create-node-group}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the cluster.
  1. Go to the **{{ ui-key.yacloud.k8s.cluster.switch_cluster-overview }}** tab and select the **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}** section.
  1. Click **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}** and select ![objects-align-justify-horizontal](../../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create-baremetal-ng }}**.
  1. In the **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.step_configuration }}** step:

     1. Specify **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.field_node-count }}**. This value is used to select configurations with sufficient number of available servers and does not define the group size. You can set the group size in the next step.
     1. Select a [server configuration](../../../baremetal/concepts/server-configurations.md) with appropriate CPUs, RAM, and disk type and size.

     The availability of configurations depends on the [server pool](../../../baremetal/concepts/servers.md#server-pools). A private subnet groups together the servers of the same pool, so in the next step, create or select a subnet from a pool the selected configuration is available in.

  1. In the **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.step_settings }}** step:

     1. Specify a node group name. Optionally, add a description and labels.
     1. Make sure the **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.field_k8s-version }}** field is set to `1.35`.
     1. Optionally, update **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.field_node-count }}**.
     1. In the **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.section_network-interfaces }}** section for the first interface, click **{{ ui-key.yacloud.common.create }}** in the **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.field_private-subnet }}** field:

        1. Specify a name for the private subnet. Optionally, add a description and labels.
        1. Enable **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
        1. In the **{{ ui-key.yacloud.baremetal.field_network-id }}** field, select an existing [VRF](../../../baremetal/concepts/private-network.md#vrf-segment) or create a new one.
        1. Fill in the **{{ ui-key.yacloud.baremetal.field_CIDR_rwYMi }}** and **{{ ui-key.yacloud.baremetal.field_gateway_t7LLk }}** fields. The subnet must belong to the `10.0.0.0/8`, `172.16.0.0/12`, or `192.168.0.0/16` range. The subnet ranges of the same VRF must not intersect with each other, cloud network subnets, cluster CIDR, and service CIDRs.
        1. Enable **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}**. Check the auto-populated IP address range and edit it as necessary.
        1. Save the subnet.

        You can select an existing subnet from a pool the selected configuration is available in. The subnet must belong to VRF and have [DHCP enabled](../../../baremetal/concepts/dhcp.md#dhcp-private) in its settings.

     1. Enable **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.label_internet-access }}** for the second interface. Public IP addresses will be assigned automatically.

        Public IP addresses ensure connection to nodes from the internet and allow nodes to access external resources, e.g., Docker image registries ([{{ container-registry-name }}](../../../container-registry/concepts/index.md), [{{ cloud-registry-name }}](../../../cloud-registry/concepts/index.md), or [Docker Hub](https://hub.docker.com/)), as well as [{{ objstorage-name }} buckets](../../../storage/concepts/bucket.md).

     1. Configure **{{ ui-key.yacloud.k8s.MaintenanceSection.maintenance-window-field-with-none-option_tx5Wn }}** and specify **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.field_max-unavailable }}**.

     1. Add the `node-type=baremetal` label in the **{{ ui-key.yacloud.k8s.node-groups.create.field_node-labels }}** field. You will later need it to start a test pod on group's nodes. Add other labels and **{{ ui-key.yacloud.k8s.node-groups.create.field_node-taints }}** as needed.

  1. Click **{{ ui-key.yacloud.k8s.baremetal-node-groups.create.settings.action_create-node-group }}**.

{% endlist %}

The group will appear in the list of node groups of the **{{ ui-key.yacloud.k8s.cluster.node-groups.label_type-baremetal }}** type. The service will rent and configure the selected number of servers. To connect nodes to the cluster, set up a private connection between the subnet's VRF and the master's cloud network.

## Create a private connection {#create-prc}

Wait until the virtual router is ready and create a {{ interconnect-name }} [private connection](../../../baremetal/concepts/private-network.md#private-connection-to-vpc) in {{ baremetal-name }}. If the selected subnet's VRF is already connected to the master's cloud network via a pre-configured router, proceed to [test the node group](#check-node-group).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}) select the folder of the VRF of the node group subnet.
  1. [Navigate]({{ link-console-main }}/link/baremetal) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, go to ![icon](../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks_kHgng }}** and select the VRF of the node group subnet.
  1. Under **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}**, click **{{ ui-key.yacloud.baremetal.action_add-vrf-interconnect }}**.
  1. In the **{{ ui-key.yacloud.baremetal.label_vrf-interconnect-select-type }}** field, select `{{ ui-key.yacloud.baremetal.field_interconnect-from-folder }}` and specify the pre-configured `Routing Instance` in the list that appears.

     The form will display the CIDRs of the {{ vpc-name }} subnets that will be announced in {{ interconnect-name }}. Make sure the cluster CIDR, and service CIDRs are specified among the prefixes.

     {% note warning %}

     For connectivity setup, the address ranges of {{ baremetal-name }} subnets must not intersect with the ranges of connected cloud and local networks, cluster CIDR, and service CIDRs.

     {% endnote %}

  1. Click **{{ ui-key.yacloud.common.save }}**.
  1. Wait for the connection status to change from `CREATING` to `READY` in the **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}** section. If the connection status changed to `ERROR`, contact [support]({{ link-console-support }}/tickets/create).

{% endlist %}

## Check the node group {#check-node-group}

1. [Install kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) and [configure a connection to the cluster](../../../managed-kubernetes/operations/connect/index.md#kubectl-connect).
1. Look up the status of nodes with the label set when creating the group:

   ```bash
   kubectl get nodes -l node-type=baremetal
   ```

   Wait for the nodes to change their status to `Ready`.

### Create a pod {#create-pod}

1. Save the pod manifest into the `busybox.yaml` file:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: busybox
   spec:
     restartPolicy: OnFailure
     nodeSelector:
       node-type: baremetal
     containers:
       - name: busybox
         image: cr.yandex/mirror/busybox:latest
         command: ["sh", "-c", "echo 'Hello from BareMetal'; sleep 3600"]
   ```

   The `nodeSelector` field limits the pod's locations to nodes labeled `node-type=baremetal`. If you have set taint policies for the group, add relevant [tolerations](../../../managed-kubernetes/concepts/index.md#taints-tolerations) to the manifest.

1. Create a pod:

   ```bash
   kubectl create -f busybox.yaml
   ```

### Test the pod {#check-pod}

1. View the pod info:

   ```bash
   kubectl get pod busybox -o wide
   kubectl describe pod busybox
   ```

   Wait for the `Running` status. The `NODE` field should specify one of the {{ baremetal-name }} nodes obtained in the previous step. In the `Events` section of the `describe` command, make sure the image is loaded and the container is created and started.

1. View the pod logs:

   ```bash
   kubectl logs busybox
   ```

   Result:

   ```text
   Hello from BareMetal
   ```

1. After the check, delete the test pod:

   ```bash
   kubectl delete pod busybox
   ```

## What's next {#whats-next}

* [Create a workload](../../../managed-kubernetes/operations/kubernetes-console/workloads.md#create-workload) in the cluster.
* [Edit the node group](../../../managed-kubernetes/operations/baremetal-group/update-baremetal.md), e.g., by increasing or decreasing the number of servers.
* Delete the [node group](../../../managed-kubernetes/operations/baremetal-group/delete-baremetal.md), [cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md), and the cluster's reserved static [public IP address](../../../vpc/operations/address-delete.md) if you no longer need these resources. Release the address prior to deletion: it must not be used by the cluster or other resources.
