# Getting started

Create a [{{ k8s }} cluster](concepts/index.md#kubernetes-cluster) and a [node group](concepts/index.md#node-group) and configure kubectl to work with them.

## Before you start {#before-begin}

To get started, you will need:

1. A folder in Yandex.Cloud. If you don't have a folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. CLI: [Yandex CLI](../cli/quickstart.md) and [Kubernetes CLI (kubectl)](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

1. [A network](../vpc/operations/network-create.md).

1. [Subnets](../vpc/operations/subnet-create.md) in the availability zones where a {{ k8s }} cluster and node group will be created.

1. [A service account](../iam/operations/sa/create.md)  with `editor` permissions on the folder.

1. Available resources in the cloud within the [quotas](concepts/limits.md).

## Creating a {{ k8s }} cluster {#create-kubernetes-cluster}

1. See the description of the CLI's create {{ k8s }} cluster command:

    ```
    $ yc managed-kubernetes cluster create --help
    ```

1. Create a {{ k8s }} cluster:

    ```
    $ yc managed-kubernetes cluster create \
    --name test-k8s-cluster \ # Kubernetes cluster name
    --network-name default \ # Network name
    --zone ru-central1-c \ # Availability zone 
    --subnet-name subnet-c \ # Subnet name 
    --public-ip \ # Specify if external access is required
    --cluster-ipv4-range 10.13.0.0/16 \ # Range for creating a subnet for pods
    --service-ipv4-range 10.14.0.0/16 \ # Range for creating a subnet for services
    --service-account-id bfbqqeo6jk****** \ # ID of the service account that resources are allocated for
    --node-service-account-id bfbqqeo6jk******  # ID of the service account to access the container registry 
    .........................................................done
    id: catcafja9ktuc7ven4le
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-04-09T10:14:30Z"
    name: test-k8s-cluster
    status: RUNNING
    health: HEALTHY
    ...
    ```

    {% note info %}

    The `--node-service-account-id` are currently not used. You can specify any existing service account in it.

    {% endnote %}

1. Add the credentials to the kubectl configuration file:

    ```
    $ yc managed-kubernetes cluster get-credentials test-k8s-cluster --external
    ```
    - By default, the credentials are added to `$HOME/.kube/config`.
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

## Creating a node group {#create-node-group}

1. See the description of the CLI's create {{ k8s }} node group command:

    ```
    $ yc managed-kubernetes node-group create --help
    ```

1. Create a node group:

    ```
    $ yc managed-kubernetes node-group create \
    --name test-nodegroup \ # Node group name
    --cluster-name test-k8s-cluster \ # Kubernetes cluster name
    --fixed-size 2 \ # Number of nodes in the group
    --location zone=ru-central1-c,subnet-name=subnet-c \ # You can set this flag multiple times to create nodes in different availability zones
    --public-ip # Mandatory flag. Nodes require access to the internet
    ...........................................................done
    id: catvhf4iv6dt8hguut9i
    cluster_id: catcafja9ktuc7ven4le
    created_at: "2019-04-09T10:56:22Z"
    name: test-nodegroup
    status: RUNNING
    ...
    ```

    By default, nodes are created with the following characteristics:
    - 1 vCPU
    - 4 GB RAM
    - 96 GB of disk space

1. You can now get a list of nodes and manage them using kubectl:

    ```
    $ kubectl get nodes
    NAME                        STATUS   ROLES    AGE   VERSION
    cl1ec3le3qv3g2k441sd-abis   Ready    <none>   11m   v1.13.3
    cl1ec3le3qv3g2k441sd-ikac   Ready    <none>   11m   v1.13.3
    ```

