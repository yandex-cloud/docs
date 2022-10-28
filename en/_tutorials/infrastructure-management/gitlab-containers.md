[{{ GL }}](https://about.gitlab.com/) is a tool for [Continuous integration, CI]({{ links.wiki.ci }}).

This tutorial describes:
* Building an application into a Docker container.
* Deploying an application from a container in a [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) via {{ GL }} using the {{ yandex-cloud }} tools.

Each commit to {{ GL }} is followed by:
* Running a script that includes steps to build the [Docker image](../../container-registry/concepts/docker-image.md).
* Applying a new {{ k8s }} cluster configuration specifying the application to be deployed.

To set up the infrastructure needed to store the source code, build the Docker image, and deploy your applications, follow these steps:
1.[Before you start](#before-you-begin).

   {% if product == "yandex-cloud" %}

   1. [Review the list of paid resources available](#paid-resources).

   {% endif %}

   1. [Install additional dependencies](#prepare).
1. [Create {{ managed-k8s-name }} resources](#k8s-create).
1. [Create a {{ GL }} instance](#create-gitlab).
1. [Configure {{ GL }}](#configure-gitlab).
1. [Create a registry in {{ container-registry-full-name }}](#cr-create).
1. [Create a test application](#app-create).
1. [Create a {{ GLR }}](#runners).
1. [Configure building and deploying a Docker image from CI](#ci).

If you no longer need the created resources, [delete them](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

Infrastructure support costs include payments for the following resources:
* [Disks](../../compute/concepts/disk.md) and continuously running [VMs](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Usage of a dynamic [public IP](../../vpc/concepts/ips.md) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Storage of created Docker images (see [{{ container-registry-name }} pricing](../../container-registry/pricing.md)).
* Usage of a [{{ k8s }} master](../../managed-kubernetes/concepts/index.md#master) (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).

{% endif %}

### Install additional dependencies {#prepare}

To run the script, install the following in the local environment:
* [{{ yandex-cloud }} command line interface (YC CLI)](../../cli/operations/install-cli.md).
* [jq](https://stedolan.github.io/jq/).
* [{{ k8s }} CLI (kubectl)]{% if lang == "ru" %}(https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/){% endif %}{% if lang == "en" %}(https://kubernetes.io/docs/tasks/tools/install-kubectl/){% endif %}.
* [Helm](https://helm.sh/).

## Create a VM from the {{ GL }} image {#create-gitlab}

Run {{ GL }} on a VM with a public IP address:

{% include [create-gitlab](../../_includes/managed-gitlab/create.md) %}

## Configure {{ GL }} {#configure-gitlab}

{% include [Create a project](../../_includes/managed-gitlab/initialize.md) %}

## Create a registry in {{ container-registry-name }} {#cr-create}

To store Docker images, you need a {{ container-registry-name }} [registry](../../container-registry/concepts/registry.md).

{% include [create-cluster](../../_includes/container-registry/create-registry.md) %}

Save the registry ID: you'll need it for the next steps.

## Configure {{ GL }} {#configure-gitlab}

{% include [initialize-gitlab](../../_includes/managed-gitlab/initialize.md) %}

## Create a test application {#app-create}

Create a test application that can be deployed in a {{ k8s }} cluster:
1. Add the Docker image configuration.
   1. On the left-hand panel in {{ GL }}, select **Repository** and click the **Files** tab.
   1. On the project page, click **New file**.
   1. Name the file `Dockerfile`. Add the Docker image configuration to it:

      ```Dockerfile
      FROM alpine:3.10
      CMD echo "Hello"
      ```

   1. Add a comment to the commit in the **Commit message** field: `Dockerfile for test application`.
   1. Click **Commit changes**.
1. Add the configuration for deploying the Docker image in the {{ k8s }} cluster:
   1. On the left-hand panel, select **Repository** and click the **Files** tab.
   1. To the right of the project name, click **+** and select **New file** from the drop-down menu.
   1. Name the file `k8s.yaml`. Add a configuration to create a [namespace](../../managed-kubernetes/concepts/index.md#namespace) and [deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/):

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
                image: {{ registry }}/<registry ID>/hello:__VERSION__
                imagePullPolicy: Always
      ```

   1. In the given file, replace the `<registry ID>` with the ID of your previously created registry.
   1. Add a comment to the commit in the **Commit message** field: `Docker image deployment config`.
   1. Click **Commit changes**.

## Create {{ k8s }} resources {#k8s-create}

Create the {{ k8s }} resources necessary to run the scripts: a cluster and node group.
1. If you don't have a [network](../../vpc/concepts/network.md#network), [create one](../../vpc/operations/network-create.md).
1. If you don't have any [subnets](../../vpc/concepts/network.md#subnet), [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and node group will be created.
1. Create [service accounts](../../iam/operations/sa/create.md):
   * A service account for the resources with the [{{ roles-editor }}](../../resource-manager/security/index.md#roles-list) role to the folder where the {{ k8s }} cluster is being created. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
   * A service account for nodes with the [{{ roles-cr-pusher }}](../../container-registry/security/index.md#required-roles) role for the folder with the Docker image registry. The nodes push the Docker images built in {{ GL }} to the registry on behalf of this service account.

   You can use the same service account for both operations.

### Create a cluster {#k8s-create-cluster}

{% include [create-cluster](../../_includes/managed-kubernetes/cluster-create.md) %}

Save the cluster ID: you need it for the next steps.

### Create a node group {#k8s-create-node-group}

It may take several minutes to create the {{ k8s }} cluster. When the cluster's status changes to `RUNNING`, you can start creating a node group in this cluster.

{% include [create-node-group](../../_includes/managed-kubernetes/node-group-create.md) %}

{% include [k8s-get-token](../../_includes/managed-gitlab/k8s-get-token.md) %}

## Create a {{ GL }} Runner {#runners}

{% include notitle [k8s-runner-gitlab](../../_includes/managed-gitlab/k8s-runner.md) %}

## Configure a Docker image build and deployment from CI {#ci}

{% include [configure-ci-gitlab](../../_includes/managed-gitlab/configure-ci.md) %}

## Delete the created resources {#clear-out}

If you no longer need the deployed applications and {{ k8s }} cluster:
* [Delete the {{ k8s }} node group](../../managed-kubernetes/operations/node-group/node-group-delete.md) and the [{{ k8s }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
* [Delete the created VMs](../../compute/operations/vm-control/vm-delete.md).
* [Delete the created Docker images](../../container-registry/operations/docker-image/docker-image-delete.md) and [{{ container-registry-name }} registry](../../container-registry/operations/registry/registry-delete.md).
* [Delete the created subnets](../../vpc/operations/subnet-delete.md) and [networks](../../vpc/operations/network-delete.md).
* [Delete the created service accounts](../../iam/operations/sa/delete.md).

#### See also {#see-also}

* [Creating test VMs using {{ GL }} CI](../../tutorials/testing/ci-for-snapshots.md)