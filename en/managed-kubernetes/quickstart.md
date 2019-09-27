# Getting started

Create a [cluster {{ k8s }}](concepts/index.md#kubernetes-cluster) and [node group](concepts/index.md#node-group) and manage them using kubectl, the {{ k8s}} command-line interface.

## Before you start {#before-you-begin}

To start working with {{ managed-k8s-short-name }}:
1. Go to the [management console]({{ link-console-main }}). Then log in to Yandex.Cloud or sign up if don't already have an account.
1. [On the billing page]({{ link-console-billing }}), make sure that a [billing account](../billing/concepts/billing-account.md) is linked and that its status is `ACTIVE` or `TRIAL_ACTIVE`. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder, [create one](../resource-manager/operations/folder/create.md).
1. Install the [Kubernetes CLI (kubectl)](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
1. Make sure you have enough [resources available in the cloud](concepts/limits.md).
1. If you don't have a network, [create one](../vpc/operations/network-create.md).
1. If you don't have any subnets, [create them](../vpc/operations/subnet-create.md) in the availability zones where your {{ k8s }} cluster and node group will be created.
1. Create [service accounts](../iam/operations/sa/create.md):
    - A service account for resources with the [{{ roles-editor }}](../resource-manager/security/#roles-list) role for the folder where the {{ k8s }} cluster will be created. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
    - A service account for nodes with the [{{ roles-cr-puller }}](../container-registry/security/index.md#required-roles) role for the folder with the Docker image registry. Nodes will download the Docker images they require from the registry on behalf of this account.

    You can use the same service account for both operations.

## Create a cluster {{ k8s }} {#kubernetes-cluster-create}

To create a {{ k8s }} cluster:
1. In the [management console]({{ link-console-main }}), select a folder to create your {{ k8s }} cluster in.
1. In the list of services, select **{{ managed-k8s-name }}**.
1. Click **Create cluster**.
1. Enter a name and description for the {{ k8s }} cluster. Naming requirements:

    {% include [name-format](../_includes/name-format.md) %}

1. Under **Master configuration**:
    - Select the [availability zone](../overview/concepts/geo-scope.md) to create a [master](concepts/index.md#master) in.
    - Select a **service account for resources** to use when creating resources.
    - Select a **service account for nodes** that nodes will use to access the Docker image registry.
    - In the **Public IP** field, choose a method for assigning an IP address:
        - **Auto**: Assign a random IP address from the Yandex.Cloud IP pool.
        - **No address**: Don't assign a public IP address.
    - In the **Network format** field, choose how networks are displayed:
        - **List**: Available networks are displayed as a list. If you don't have a cloud network, click **Create network**:
            - In the window that opens, enter a name for the network. Specify that subnets should be created. Click **Create network**. By default, networks are created with subnets in each availability zone.
        - **ID**: Enter the unique ID of the required networks.
1. Under **Cluster network settings**:
    - Specify the **cluster CIDR** — a range of IP addresses for allocating pod addresses.
    - Specify the **service CIDR** — a range of IP addresses for allocating service addresses.
    - (optional) Specify the **Gateway address**: if you don't want to create nodes with public IPs, [configure a VM as a NAT gateway](operations/nat-instance.md) and enter the internal IP address of this VM here.
1. Click **Create cluster**.

## Add credentials to the kubectl configuration file {#add-conf}

{% list tabs %}

- CLI

    {% include [cli-install](../_includes/cli-install.md) %}

    {% include [default-catalogue](../_includes/default-catalogue.md) %}

    To add {{ k8s }} cluster credentials to the kubectl configuration file:

    1. Run the command:

        ```
        $ yc managed-kubernetes cluster get-credentials test-k8s-cluster --external
        ```
        - By default, credentials are added to the `$HOME/.kube/config` directory.
        - If you need to change the configuration location, use the `--kubeconfig <file path>` flag.

    1. Check the kubectl configuration after adding the credentials:

        ```
        $ kubectl config view
        apiVersion: v1
        clusters:
        - cluster:
            certificate-authority-data: DATA+OMITTED
        ...
        ```

{% endlist%}

## Create a node group {#node-group-create}

To create a node group:
1. In the [management console]({{ link-console-main }}), select a folder to create your {{ k8s }} node group in.
1. In the list of services, select **{{ managed-k8s-name }}**.
1. Select the {{ k8s }} cluster to create a node group for.
1. On the {{ k8s }} cluster page, go to the **Node groups** tab.
1. Click **Create node group**.
1. Enter a name and description for the node group. Naming requirements:

    {% include [name-format](../_includes/name-format.md) %}

1. Specify the number of nodes in the group.
1. Under **Computing resources**:
    - Select the [platform](../compute/concepts/vm-platforms.md).
    - Specify the [guaranteed share](../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.
    - (optional) Specify that the VM must be [preemptible](../compute/concepts/preemptible-vm.md).
1. Under **Storage**:
    - Specify the **Disk type**:
        - **HDD**: A standard network drive. Network block storage on an HDD.
        - **SSD**: A fast network drive. Network block storage on an SSD.
    - Specify the disk size.
1. Under **Network settings**:
    - In the **Public IP** field, choose a method for assigning an IP address:
        - **Auto**: Assign a random IP address from the Yandex.Cloud IP pool.
        - **No address**: Don't assign a public IP address.
    - Specify how nodes should be distributed across availability zones and networks.
    - (optional) Click **Add location** and specify an additional availability zone and network to create nodes in different zones.
1. Under **Access**, specify the information required to access the node:
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the [public key](operations/node-connect-ssh.md#creating-ssh-keys) file.

1. Click **Create node group**.

## What's next {#what-is-next}

- Read about [service concepts](concepts/index.md).
- Learn how to [work with a {{ k8s }} cluster and node groups](operations/index.md).
