---
title: "Getting started with managed Kubernetes"
description: "In this tutorial, you will create a Kubernetes cluster, and a node group, learn how to manage them using kubectl - the Kubernetes shell. First, create a Kubernetes cluster, add credentials to the kubectl configuration file, create a node group."
---

# Getting started with {{ managed-k8s-name }}

Create a [{{ k8s }} cluster](concepts/index.md#kubernetes-cluster) and [node group](concepts/index.md#node-group) and manage them using kubectl, the {{ k8s}} command-line interface.

## Before you start {#before-you-begin}

To start working with {{ managed-k8s-name }}:
1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if you don't have an account yet.

{% if product == "yandex-cloud" %}

1. [On the billing page]({{ link-console-billing }}), make sure that a [billing account](../billing/concepts/billing-account.md) is linked and that its status is `ACTIVE` or `TRIAL_ACTIVE`. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).

{% endif %}

1. If you don't have a folder, [create one](../resource-manager/operations/folder/create.md).
1. Install the [Kubernetes CLI (kubectl)]({{ k8s-docs }}/tasks/tools/install-kubectl/).
1. Make sure you have enough [resources available in the cloud](concepts/limits.md).
1. If you don't have a network, [create one](../vpc/operations/network-create.md).
1. If you don't have any subnets, [create them](../vpc/operations/subnet-create.md){% if product == "yandex-cloud" %} in the availability zones where your {{ k8s }} cluster and node group will be created{% endif %}.
1. Create [service accounts](../iam/operations/sa/create.md):
   * A service account for resources with the [{{ roles-editor }}](../resource-manager/security/index.md#roles-list) role for the folder where the {{ k8s }} cluster will be created. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
   * A service account for nodes with the [{{ roles-cr-puller }}](../container-registry/security/index.md#required-roles) role for the folder with the Docker image registry. Nodes will download the Docker images they require from the registry on behalf of this account.

   You can use the same service account for both operations.

## Create a {{ k8s }} cluster {#kubernetes-cluster-create}

{% include [create-cluster](../_includes/managed-kubernetes/cluster-create.md) %}

## Add credentials to the kubectl configuration file {#add-conf}

{% list tabs %}

- CLI

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}

  To add {{ k8s }} cluster credentials to the kubectl configuration file:

  1. Run the command:

     ```bash
     yc managed-kubernetes cluster get-credentials test-k8s-cluster --external
     ```

     * By default, credentials are added to the `$HOME/.kube/config` directory.
     * If you need to change the configuration location, use the `--kubeconfig <file path>` flag.
  1. Check the kubectl configuration after adding the credentials:

     ```
     kubectl config view
     ```

     Result:

     ```
     apiVersion: v1
     clusters:
     - cluster:
     certificate-authority-data: DATA+OMITTED
     ...
     ```

{% endlist %}

## Create a node group {#node-group-create}

{% include [create-node-group](../_includes/managed-kubernetes/node-group-create.md) %}

## What's next {#what-is-next}

* Read about [service concepts](concepts/index.md).
* Learn how to [work with a {{ k8s }} cluster and node groups](operations/index.md).