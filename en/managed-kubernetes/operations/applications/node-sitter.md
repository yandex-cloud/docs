---
title: Installing node-sitter
description: Follow this guide to install node-sitter.
---

# Installing node-sitter


**node-sitter** is a tool for implementing application fault tolerance in a node group with preemptible VMs.

The `node-sitter` features include:

* Pod eviction when cluster nodes on preemptible VMs shut down.
* Installation of additional trusted root certificates.
* Configuring container image downloads via a proxy.
* Advanced `kubelet` launch settings.

## Getting started {#before-you-begin}

1. [Create a node group](../node-group/node-group-create.md) with the following parameters:

   * **{{ ui-key.yacloud.compute.instances.create.section_platform }}**: Select **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}**.
   * Under **{{ ui-key.yacloud.component.compute.resources.field_advanced }}**, enable **{{ ui-key.yacloud.component.compute.resources.field_preemptible }}**.
   * Under **{{ ui-key.yacloud.k8s.node-groups.create.section_additional }}**, add a custom taint policy for the application, e.g., `node-sitter: 1`.

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Installation from {{ marketplace-full-name }} {#marketplace-install}

1. In the [management console]({{ link-console-main }}), select a folder.
1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Select your [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster).
1. Click the **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) tab and select **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [node-sitter](/marketplace/products/yc/node-sitter) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Create a new [namespace](../../concepts/index.md#namespace), e.g., `node-sitter`. If you leave the default namespace, node-sitter may work incorrectly.
   * **Application name**: Specify the application name.
   * **Install node-drainer**: Leave this option enabled so the integrated `node-drainer` script prevents pods in the `Error` or `Completed` state from appearing on the nodes of the preemptible VM group.
   * **Tolerations key name**: Specify the key name of the taint policy you set [previously](#before-you-begin). `node-sitter` pods will configure new nodes in the preemptible VM group before user load is distributed to them. After the nodes are successfully configured, `node-sitter` will remove the taint policy so user applications can run on these nodes. If you skip this setting, the system will configure the nodes while starting user applications.
   * (Optional) **Trusted certificates**: Copy the contents of the PEM file with x.509 certificates to install them into the trusted certificate storage on the nodes of the preemptible VM group. When recreating nodes, the certificates will be reinstalled.
   * (Optional) **Parameters for kubelet**: Specify additional parameters for running `kubelet` on the nodes of the preemptible VM group.
   * (Optional) **Proxy settings**: Specify proxy settings for downloading container images on the nodes of the preemptible VM group. The settings are provided via the `HTTP_PROXY` and `HTTPS_PROXY` environment variables.
   * (Optional) **Proxy exclusions**: Specify a list of websites to access without a proxy. To provide the value, use the `NO_PROXY` environment variable.

1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

1. Wait for the application status to change to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [kubectl-install](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with node-sitter, run the following command, specifying the parameters of the resources you created [earlier](#before-you-begin):

    ```bash
    helm pull oci://{{ mkt-k8s-key.yc_node-sitter.helmChart.name }} \
       --version {{ mkt-k8s-key.yc_node-sitter.helmChart.tag }} \
       --untar && \
    helm install \
       --namespace <namespace_for_node_sitter> \
       --create-namespace \
       --set node_drainer_enabled='true' \
       --set toleration_name='<taint_policy_name>' \
       --set custom_certs='<PEM_trusted_certificates>' \
       --set custom_kubelet_flags='<additional_kubelet_launch_options>' \
       --set containerd_proxy='<proxy_settings_for_downloading_images>' \
      node-sitter ./node-sitter
    ```

    Installation parameters:

    * `--namespace`: [Namespace](../../concepts/index.md#namespace) where the application will be deployed.

      If you set the default `namespace`, node-sitter may work incorrectly. We recommend specifying a value different from all the existing namespaces, e.g., `node-sitter-space`.

    * `node_drainer_enabled`: When set to `true`, the integrated `node-drainer` script prevents pods in the `Error` or `Completed` state from appearing on the nodes of the preemptible VM group.
    * `toleration_name`: Key name of the taint policy key you set [previously](#before-you-begin). `node-sitter` pods will configure new nodes in the preemptible VM group before user load is distributed to them. After the nodes are successfully configured, `node-sitter` will remove the taint policy so user applications can run on these nodes. If you skip this setting, the system will configure the nodes while starting user applications.
    * `custom_certs`: Contents of the X.509 certificate file in PEM format for installation into the trusted certificate storage on the nodes of the preemptible VM group. When recreating nodes, the certificates will be reinstalled.
    * `custom_kubelet_flags`: Advanced settings for running `kubelet` on nodes in the preemptible VM group.
    * `containerd_proxy`: Proxy settings for downloading container images on the nodes of the preemptible VM group. The settings are provided via the `HTTP_PROXY` and `HTTPS_PROXY` environment variables.

    {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}
