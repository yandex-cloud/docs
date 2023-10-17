---
title: "Getting started with managed {{ k8s }}"
description: "In this tutorial, you will create a {{ k8s }} cluster and node group and learn how to manage them using kubectl, the {{ k8s }} command line interface. To get started, create a {{ k8s }} cluster, add credentials to the kubectl configuration file, and create a node group."
---

# Getting started with {{ managed-k8s-name }}

Create a {{ managed-k8s-name }} [cluster](concepts/index.md#kubernetes-cluster) and [node group](concepts/index.md#node-group) and manage them using kubectl, the {{ k8s }} command-line interface.

## Getting started {#before-you-begin}

To get started with {{ managed-k8s-name }}:
1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or create an account if you do not have one yet.


1. On the [**Billing**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).


1. If you do not have a [folder](../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../resource-manager/operations/folder/create.md).
1. Install the {{ k8s }} command line tool, [kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl/).
1. Make sure you have enough [resources available in the cloud](concepts/limits.md).
1. If you do not have a [network](../vpc/concepts/network.md#network) yet, [create one](../vpc/operations/network-create.md).
1. If you do not have any [subnets](../vpc/concepts/network.md#subnet), [create them](../vpc/operations/subnet-create.md) in the [availability zones](../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and node group will be created.
1. Create [service accounts](../iam/operations/sa/create.md):
   * With the [{{ roles-editor }}](../iam/concepts/access-control/roles.md#editor) role to the folder where the cluster is being created. This service account will be used to create resources that the {{ managed-k8s-name }} cluster needs.
   * With the [{{ roles-cr-puller }}](../iam/concepts/access-control/roles.md#cr-images-puller) role for the folder containing a [Docker image](../container-registry/concepts/docker-image.md) [registry](../container-registry/concepts/registry.md). Nodes will download the Docker images they require from the registry on behalf of this account.

   You can use the same service account for both operations.

   {% include [k8s.tunnelClusters.agent role](../_includes/managed-kubernetes/note-tunnelClusters-agent.md) %}

## Create a {{ managed-k8s-name }} cluster {#kubernetes-cluster-create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ managed-k8s-name }} cluster.
1. Select **{{ managed-k8s-name }}**.
1. Click **Create cluster**.
1. Enter a name for the cluster. It must be unique within the folder.
1. (Optional) Enter a cluster description.
1. **Service account for resources**: Specify a [service account](../iam/concepts/users/service-accounts.md) with the [{{ roles-editor }}](../iam/concepts/access-control/roles.md#editor) role for creating resources.
1. **Service account for nodes**: Specify a service account with the [{{ roles-cr-puller }}](../iam/concepts/access-control/roles.md#cr-images-puller) role that nodes will use to access the Docker image registry.
1. Specify a [release channel](concepts/release-channels-and-updates.md). You cannot edit this setting after you create a cluster.
1. Under **Master configuration**:
   * **{{ k8s }} version**: Select a {{ k8s }} version to install on the [master](concepts/index.md#master).
   * **Public address**: Select the IP address assignment method:
     * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
     * **No address**: Do not assign a public IP address.
   * **Master type**: Select the type of the master:
     * **Zone**: A single master host will be created in the selected availability zone. Specify a cloud network and select a subnet that the master host will be on.
     * **Region**: A single master host will be created in every availability zone. Specify a cloud network and subnet for each availability zone.
   * Select [security groups](operations/connect/security-groups.md) for the cluster's network traffic.

1. Under **Cluster network settings**:
   * **Cluster CIDR**: Specify an IP range to allocate addresses to pods from.
   * **Service CIDR**: Specify an IP range to allocate IP addresses to services from.
   * Set the node subnet mask and the maximum number of pods in a node.
1. Click **Create cluster**.

For more information, see the [step-by-step instructions for creating a cluster](operations/kubernetes-cluster/kubernetes-cluster-create.md).

## Add credentials to the kubectl configuration file {#add-conf}

{% list tabs %}

- CLI

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}

  To add {{ managed-k8s-name }} cluster credentials to the kubectl configuration file:
  1. Run the following command:

     ```bash
     yc managed-kubernetes cluster get-credentials test-k8s-cluster --external
     ```

     * By default, credentials are added to the `$HOME/.kube/config` directory.
     * If you need to change the configuration location, use the `--kubeconfig <file path>` flag.
  1. Check the kubectl configuration after adding the credentials:

     ```bash
     kubectl config view
     ```

     Command result:

     ```yml
     apiVersion: v1
     clusters:
       - cluster:
         certificate-authority-data: DATA+OMITTED
     ...
     ```

{% endlist %}

## Create a node group {#node-group-create}

To create a node group:
1. In the [management console]({{ link-console-main }}), select the folder where the required {{ managed-k8s-name }} cluster was created.
1. In the list of services, select **{{ managed-k8s-name }}**.
1. Select the {{ managed-k8s-name }} cluster to create a node group for.
1. On the {{ managed-k8s-name }} cluster page, click the ![nodes-management.svg](../_assets/nodes-management.svg) **Nodes manager** tab.
1. Click **Create node group**.
1. Enter a name and description for the node group.
1. Specify the **{{ k8s }} version** for the node.
1. Under **Scaling**, select a type:
   * **Fixed**: The number of nodes in the group remains unchanged. Specify the number of nodes in the group.
   * **Automatic**: The number of nodes in the group can be controlled using [automatic cluster scaling](concepts/autoscale.md#ca).
1. Under **Allow when creating and updating**, specify the maximum number of [virtual machines](../compute/concepts/vm.md) by which you can exceed and reduce the group size.
1. Under **Computing resources**:
   * Choose a [platform](../compute/concepts/vm-platforms.md).
   * Specify the requisite number of vCPUs and [guaranteed vCPU performance](../compute/concepts/performance-levels.md) as well as the amount of RAM.
   * (Optional) Specify that you want the VM to be [preemptible](../compute/concepts/preemptible-vm.md).
1. Under **Storage**:
   * Specify the **Disk type** for the group's nodes:
     * **HDD**: Standard network drive. Network block storage on an HDD.
     * **SSD**: Fast network drive. Network block storage on an SSD.
     * **Non-replicated SSD**: Network drive with enhanced performance achieved by removing redundancy.

     For more information about disk types, see the [{{ compute-full-name }} documentation](../compute/concepts/disk.md#disks_types).
  * Specify the disk size for the group's nodes.
1. Under **Network settings**:
   * In the **Public IP** field, choose a method for assigning an IP address:
     * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
     * **No address**: Do not assign a public IP address.
   * Select [security groups](operations/connect/security-groups.md).
   * Select an availability group and subnet to deploy the group's nodes to.
1. Under **Access**, specify the information required to access the group nodes over SSH:
   * **Login**: Enter the username.
   * **SSH key**: Insert the contents of the [public key](operations/node-connect-ssh.md#creating-ssh-keys) file.
1. Click **Create**.

For more information, see the [step-by step instructions for creating node groups](operations/node-group/node-group-create.md).

## What's next {#what-is-next}

* Read about [service concepts](concepts/index.md).
* Learn how to [work with a {{ managed-k8s-name }} cluster and node groups](operations/index.md).
* Read [questions and answers](qa/all.md).
* Review the [recommendations for using {{ k8s }}](concepts/usage-recommendations.md).