---
title: Getting started with managed {{ k8s }}
description: In this tutorial, you will create a {{ managed-k8s-name }} cluster and node group and learn how to manage them using kubectl, the {{ k8s }} command line interface. To get started, create a {{ managed-k8s-name }} cluster, add credentials to the kubectl configuration file, and create a node group.
---

# Getting started with {{ managed-k8s-name }}


Create a [{{ managed-k8s-name }} cluster](concepts/index.md#kubernetes-cluster) and [node group](concepts/index.md#node-group) and manage them using kubectl, the {{ k8s }} command line tool.

## Getting started {#before-you-begin}

To get started with {{ managed-k8s-name }}:
1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.
1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have a linked [billing account](../billing/concepts/billing-account.md) and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a [folder](../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../resource-manager/operations/folder/create.md).
1. Install the {{ k8s }} CLI, [kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl/).
1. Make sure you have enough [resources available in the cloud](concepts/limits.md).
1. If you do not have a [network](../vpc/concepts/network.md#network) yet, [create one](../vpc/operations/network-create.md).
1. If you do not have any [subnets](../vpc/concepts/network.md#subnet) yet, [create them](../vpc/operations/subnet-create.md) in the [availability zones](../overview/concepts/geo-scope.md) where your {{ managed-k8s-name }} cluster and node group will be created.
1. Create [service accounts](../iam/operations/sa/create.md):

   * Service account with the `k8s.clusters.agent` and `vpc.publicAdmin` [roles for the folder](security/index.md#yc-api) where the {{ managed-k8s-name }} cluster is created. This service account will be used to create the resources required for the {{ managed-k8s-name }} cluster.
   * Service account with the [{{ roles-cr-puller }}](../container-registry/security/index.md#container-registry-images-puller) role for the folder containing the [Docker image](../container-registry/concepts/docker-image.md) [registry](../container-registry/concepts/registry.md). {{ managed-k8s-name }} nodes will pull the required Docker images from the registry on behalf of this account.

   You can use the same service account for both operations.

   {% include [k8s.tunnelClusters.agent role](../_includes/managed-kubernetes/note-tunnelClusters-agent.md) %}
1. [Configure security groups](operations/connect/security-groups.md#rules-internal) for the network traffic of your {{ managed-k8s-name }} cluster.

## Create a {{ managed-k8s-name }} cluster {#kubernetes-cluster-create}

1. In the management console, select the folder where you want to create a {{ managed-k8s-name }} cluster.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click **{{ ui-key.yacloud.k8s.clusters.button_create }}**.
1. Enter the {{ managed-k8s-name }} cluster name. It must be unique within the folder.
1. (Optional) Enter the {{ managed-k8s-name }} cluster description.
1. **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}**: Specify a [service account](../iam/concepts/users/service-accounts.md) with the `k8s.clusters.agent` annd `vpc.publicAdmin` roles to use for creating resources.
1. **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}**: Specify a service account with the [{{ roles-cr-puller }}](../container-registry/security/index.md#container-registry-images-puller) role that {{ managed-k8s-name }} nodes will use to access the Docker image registry.
1. Specify a [release channel](concepts/release-channels-and-updates.md). You will not be able to edit this setting once you create a {{ managed-k8s-name }} cluster.
1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**:
   * **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}**: Select a {{ k8s }} version to install on the [{{ managed-k8s-name }}](concepts/index.md#master) master.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}**: Select the [IP address](../vpc/concepts/address.md) assignment method:
     * `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP pool.
     * `{{ ui-key.yacloud.k8s.clusters.create.switch_none }}`: Not to assign a public IP address.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_master-type }}**: Select the master type:
     * `{{ ui-key.yacloud.k8s.clusters.create.option_master-type-basic }}`: To create a single master host in the selected availability zone. Specify a cloud network and select a subnet for the master host.
     * `{{ ui-key.yacloud.k8s.clusters.create.option_master-type-highly-available }}`: To create a single master host in each availability zone. Specify a cloud network and subnet for each availability zone.
   * Select [security groups](operations/connect/security-groups.md) for the {{ managed-k8s-name }} cluster's network traffic.
1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}**:
   * **{{ ui-key.yacloud.k8s.clusters.create.field_cluster-cidr }}**: Specify an IP range to allocate addresses to [pods](concepts/index.md#pod) from.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_service-cidr }}**: Specify an IP range to allocate IP addresses to [services](concepts/index.md#service) from.
   * Set the {{ managed-k8s-name }} node subnet mask and the maximum number of pods per node.
1. Click **{{ ui-key.yacloud.common.create }}**.

For more information, see the [step-by-step guide for creating a {{ managed-k8s-name }} cluster](operations/kubernetes-cluster/kubernetes-cluster-create.md).

## Create a node group {#node-group-create}

To create a {{ managed-k8s-name }} node group:
1. In the [management console]({{ link-console-main }}), select the folder where the required {{ managed-k8s-name }} cluster was created.
1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Select the {{ managed-k8s-name }} cluster to create a node group for.
1. On the {{ managed-k8s-name }} cluster page, go to the ![nodes-management.svg](../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
1. Click **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**.
1. Enter a name and description for the {{ managed-k8s-name }} node group.
1. In the **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** field, select a {{ k8s }} version for {{ managed-k8s-name }} nodes.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_scale }}**, select its type:
   * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-fixed }}`, to keep the number of nodes in the {{ managed-k8s-name }} group constant. Specify the number of nodes in the {{ managed-k8s-name }} group.
   * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-auto }}`, to control the number of nodes in the {{ managed-k8s-name }} group via [{{ managed-k8s-name }}](concepts/autoscale.md#ca) cluster autoscaling.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_deploy }}**, specify the maximum number of [instances](../compute/concepts/vm.md) by which you can exceed or reduce the size of the {{ managed-k8s-name }} group.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
   * Select a [platform](../compute/concepts/vm-platforms.md).
   * Specify the required number of vCPUs, [guaranteed vCPU performance](../compute/concepts/performance-levels.md), and the amount of RAM.
   * Optionally, make the VM instance [preemptible](../compute/concepts/preemptible-vm.md) by checking the relevant box.
   * Optionally, enable a [software-accelerated network](../compute/concepts/software-accelerated-network.md).

1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_disk }}**:
   * Specify the **{{ ui-key.yacloud.k8s.node-groups.create.field_disk-type }}** for the {{ managed-k8s-name }} group nodes:
     * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-hdd }}`: Standard network drive; HDD network block storage.
     * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd }}`: Fast network drive; SSD network block storage.
     * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}`: Network drive with enhanced performance achieved by eliminating redundancy. You can only change the size of this type of disk in 93 GB increments.
     * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-io-m3 }}`: Network drive with the same performance characteristics as `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}`, plus redundancy. You can only change the size of this type of disk in 93 GB increments.

     For more information about disk types, see the [{{ compute-full-name }} documentation](../compute/concepts/disk.md#disks_types).
   * Specify the disk size for the {{ managed-k8s-name }} group nodes.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**:
   * In the **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** field, select an IP address assignment method:
     * `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP pool.
     * `{{ ui-key.yacloud.k8s.node-groups.create.switch_none }}`: Not to assign a public IP address.
   * Select [security groups](operations/connect/security-groups.md).
   * Select an availability zone and subnet to deploy the {{ managed-k8s-name }} group nodes in.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_access }}**, specify the information required to access the {{ managed-k8s-name }} group nodes over SSH:
   * **{{ ui-key.yacloud.compute.instances.create.field_user }}**: Enter the username.
   * **{{ ui-key.yacloud.compute.instances.create.field_key }}**: Insert the contents of the [public key](operations/node-connect-ssh.md#creating-ssh-keys) file.
1. Click **{{ ui-key.yacloud.common.create }}**.

For more information, see the [step-by-step guide for creating {{ managed-k8s-name }} node groups](operations/node-group/node-group-create.md).

## Add credentials to the kubectl configuration file {#add-conf}

With kubectl, you can manage the {{ managed-k8s-name }} cluster. To configure the utility to work with the created cluster, add its credentials to the kubectl configuration file:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}

  1. Run this command:

     ```bash
     yc managed-kubernetes cluster get-credentials test-k8s-cluster --external
     ```

     {% note tip %}

     {% include [note-connect-button](../_includes/managed-kubernetes/note-connect-button.md) %}

     {% endnote %}

     * By default, credentials are added to the `$HOME/.kube/config` directory.
     * If you need to change the configuration location, use `--kubeconfig <file_path>`.
     
  1. Check the `kubectl` configuration after adding the credentials:

     ```bash
     kubectl config view
     ```

     Result:

     ```yml
     apiVersion: v1
     clusters:
       - cluster:
         certificate-authority-data: DATA+OMITTED
     ...
     ```
  1. Check the connection to the cluster:
  
     ```bash
     kubectl get nodes
     ```

     The command will return information about the node group you created:
   
     ```bash
     NAME                       STATUS  ROLES   AGE  VERSION
     cl17i6943n92********-itif  Ready   <none>  31m  v1.13.3
     ```
  
     To learn more about connecting to a {{ managed-k8s-name }} cluster, see [Connection method overview](operations/connect/index.md).

{% endlist %}

## What's next {#what-is-next}

* Read about [service concepts](concepts/index.md).
* Learn how to [work with a {{ managed-k8s-name }} cluster and node groups](operations/index.md).
* Read [questions and answers](qa/all.md).
* Review the [recommendations for using {{ k8s }}](concepts/usage-recommendations.md).