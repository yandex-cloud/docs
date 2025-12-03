---
title: Installing Kubernetes Node Remediation
description: Follow this guide to install Kubernetes Node Remediation.
---

# Installing Kubernetes Node Remediation

[Kubernetes Node Remediation](https://www.medik8s.io/) is a tool comprising several {{ k8s }} operators that provide automatic recovery of failed {{ managed-k8s-name }} cluster nodes and high availability for stateful workloads.

The solution features two controllers:

* Node Healthcheck Controller, which tracks failures.
* Self Node Remediation Controller, which moves the workload away from unhealthy nodes and restores them.

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Installation from {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of your cluster and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Kubernetes Node Remediation](/marketplace/products/yc/kubernetes-node-remediation) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Create a new [namespace](../../concepts/index.md#namespace), e.g., `remediation-space`. If you leave the default namespace, Kubernetes Node Remediation may work incorrectly.
   * **Application name**: Specify the application name.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.
1. [Create the `NodeHealthCheck` resource](#create-resource).

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Kubernetes Node Remediation, run this command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_kubernetes-node-remediation.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_kubernetes-node-remediation.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
   kubernetes-node-remediation ./kubernetes-node-remediation/
   ```

   If you specify the default `namespace`, Kubernetes Node Remediation may work incorrectly. We recommend specifying a value different from all the existing namespaces, e.g., `remediation-space`.

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

1. [Create the `NodeHealthCheck` resource](#create-resource).

## Creating the NodeHealthCheck resource {#create-resource}

1. Create a file with the `NodeHealthCheck` description:

    ```yml
    apiVersion: remediation.medik8s.io/v1alpha1
    kind: NodeHealthCheck
    metadata:
      name: nodehc-sample
    spec:
      minHealthy: 51%
      remediationTemplate:
        apiVersion: self-node-remediation.medik8s.io/v1alpha1
        kind: SelfNodeRemediationTemplate
        name: self-node-remediation-automatic-strategy-template
        namespace: <application_namespace>
      selector:
        matchLabels:
          beta.kubernetes.io/os: linux
      unhealthyConditions:
      - duration: 60s
        status: "False"
        type: Ready
      - duration: 60s
        status: Unknown
        type: Ready
    ```

    Where:

    * `spec.minHealthy`: Minimum percentage of healthy nodes required to initiate recovery.
    * `spec.unhealthyConditions`: List of [node status conditions](https://kubernetes.io/docs/reference/node/node-status/) the controller uses to determine if the node is unhealthy.

        * `duration`: Time for a condition to persist before node recovery starts.
        * `type`: Condition type.
        * `status`: Expected status for recognizing a node as unhealthy.

        In the above example, the NodeHealthCheck controller will initiate recovery if the `Ready` condition type for a node indicates that it is unavailable or in a down state for 60 seconds.

    [Learn more about resource fields](https://github.com/medik8s/node-healthcheck-operator/blob/main/docs/configuration.md).

1. Navigate to the directory with the file and run this command:

    ```bash
    kubectl apply -f <file_name>
    ```
