# Continuous deployment of containerized applications using GitLab

[GitLab](https://about.gitlab.com/) is a [continuous integration](https://en.wikipedia.org/wiki/Continuous_integration) tool. This scenario describes how to build an application in a Docker container and deploy it from the container on a {{ k8s }} cluster with GitLab using {{ yandex-cloud }} tools. After each commit, a script runs in GitLab that describes the steps for building a Docker image and applying a new {{ k8s }} cluster configuration, which specifies the application to be deployed. To configure the infrastructure required for storing source code, building Docker images, and deploying applications, follow these steps:
* [Before you start](#before-you-begin)

{% if product == "yandex-cloud" %}

  * [Required paid resources](#paid-resources)
  
{% endif %}

  * [Install additional dependencies](#prepare)
* [Create a VM from the GitLab image](#create-gitlab)
* [Configure GitLab](#configure-gitlab)
* [Create a {{ container-registry-short-name }} resource](#cr-create)
* [Create {{ k8s }} resources](#k8s-create)
  * [Create a cluster](#k8s-create-cluster)
  * [Create a node group](#k8s-create-node-group)
* [Connect the {{ k8s }} cluster to the GitLab build runners](#runners)
* [Configure a Docker image build and deployment from CI](#ci)

If you no longer need the VM and cluster, [delete them](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of this infrastructure includes:
* A fee for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* A fee for storing created Docker images (see [{{ container-registry-full-name }} pricing](../../container-registry/pricing.md)).
* A fee for using the {{ k8s }} master (see [{{ managed-k8s-full-name }} pricing](../../managed-kubernetes/pricing.md)).

{% endif %}

### Install additional dependencies {#prepare}

To run the script, install the following in the local environment:
* [The {{ yandex-cloud }} command line interface](../../cli/operations/install-cli.md).
* [jq](https://stedolan.github.io/jq/).
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

## Create a VM from the GitLab image {#create-gitlab}

Run GitLab on a VM with a public IP address:

{% include [create-gitlab](../../_includes/managed-gitlab/create.md) %}

## Create a registry in {{ container-registry-name }} {#cr-create}

To store Docker images, you need a registry in {{ container-registry-short-name }}.

{% include [create-cluster](../../_includes/container-registry/create-registry.md) %}

Save the registry ID: you'll need it for the next steps.

## Configure GitLab {#configure-gitlab}

{% include [initialize-gitlab](../../_includes/managed-gitlab/initialize.md) %}

## Create a test application

Create a test application that can be deployed in a {{ k8s }} cluster:
1. Add the Docker image configuration.
   1. In the left panel of GitLab, go to **Project** and select **Details**.
   1. On the project page, click **New file**.
   1. Name the file `Dockerfile`. Add the Docker image configuration to it:

      ```Dockerfile
      FROM alpine:3.10
      CMD echo "Hello"
      ```

   1. Add a comment to the commit in the **Commit message** field: `Dockerfile for test application`.
   1. Click **Commit changes**.
1. Add the configuration for deploying the Docker image in the {{ k8s }} cluster:
   1. In the left panel, go to **Project** and select **Details**.
   1. To the right of the project name, click **+** and select **New file** from the drop-down menu.
   1. Name the file `k8s.yaml`. Add the configuration for creating a [namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) and [deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) to it:

      ```yaml
      apiVersion: v1
      kind: Namespace
      metadata:
        name: hello-world
      ---
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: hello-world-deployment
        namespace: hello-world
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: hello
        template:
          metadata:
            namespace: hello-world
            labels:
              app: hello
          spec:
            containers:
              - name: hello-world
                image: cr.yandex/<registry ID>/hello:__VERSION__
                imagePullPolicy: Always
      ```

   1. In the given file, replace the `<registry ID>` with the ID of your previously created registry.
   1. Add a comment to the commit in the **Commit message** field: `Docker image deployment config`.
   1. Click **Commit changes**.

## Create {{ k8s }} resources {#k8s-create}

Create the {{ k8s }} resources necessary to run the scripts: a cluster and node group.

1. If you don't have a network, [create one](../../vpc/operations/network-create.md).
1. If you don't have any subnets, [create them](../../vpc/operations/subnet-create.md) in the availability zones where you will create a {{ k8s }} cluster and node group.
1. Create [service accounts](../../iam/operations/sa/create.md):
   * A service account for resources with the [{{ roles-editor }}](../../resource-manager/security/#roles-list) role for the folder where the {{ k8s }} cluster will be created. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
   * A service account for nodes with the [{{ roles-cr-pusher }}](../../container-registry/security/index.md#required-roles) role for the folder containing the Docker image registry. The nodes push the Docker images built in GitLab to the registry on behalf of this service account.

   You can use the same service account for both operations.

### Create a cluster {#k8s-create-cluster}

{% include [create-cluster](../../_includes/managed-kubernetes/cluster-create.md) %}

Save the cluster ID: you need it for the next steps.

### Create a node group {#k8s-create-node-group}

It may take several minutes to create the {{ k8s }} cluster. When the cluster's status changes to `RUNNING`, you can start creating a node group in this cluster.

{% include [create-node-group](../../_includes/managed-kubernetes/node-group-create.md) %}

{% include [k8s-get-token](../../_includes/managed-gitlab/k8s-get-token.md) %}

## Connect the {{ k8s }} cluster to the GitLab build runners {#runners}

{% include notitle [k8s-runner-gitlab](../../_includes/managed-gitlab/k8s-runner.md) %}

## Configure a Docker image build and deployment from CI {#ci}

{% include [configure-ci-gitlab](../../_includes/managed-gitlab/configure-ci.md) %}

## Delete the created resources {#clear-out}

If you no longer need the deployed applications and {{ k8s }} cluster:
* Delete the node group and the {{ k8s }} cluster.
* [Delete the created VMs](../../compute/operations/vm-control/vm-delete.md).
* Delete the created [Docker images](../../container-registry/operations/docker-image/docker-image-delete.md) and the [registry in {{ container-registry-short-name }}](../../container-registry/operations/registry/registry-delete.md).
* Delete the created [subnets](../../vpc/operations/subnet-delete.md) and [networks](../../vpc/operations/network-delete.md).
* Delete the created [service accounts](../../iam/operations/sa/delete.md).

#### See also {#see-also}

* [Creating test VMs using GitLab CI](../../tutorials/testing/ci-for-snapshots.md)