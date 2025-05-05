---
title: Installing Istio
description: Follow this guide to install Istio.
---

# Installing Istio


[Istio](https://istio.io/latest/about/service-mesh/) implements a _service mesh_, a low-latency infrastructure layer used to process a massive volume of network communications between services in a {{ managed-k8s-name }} cluster.

Istio provides:

* Encrypted service-to-service communication in a cluster.
* Authentication across services.
* Load balancing for HTTP, TCP, RPC, and WebSocket traffic.
* Detailed traffic monitoring based on extensive routing rules.

The application contains [Istio Ingress Gateway](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/), a component for setting up an entry point for external traffic.

{% note info %}

To use Istio, you need a node group with at least 6 GB of RAM.

{% endnote %}

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [Install kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the cluster you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Istio](/marketplace/products/yc/istio) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Create a new [namespace](../../concepts/index.md#namespace), e.g., `istio-space`. If you leave the default namespace, Istio may work incorrectly.
   * **Application name**: Specify the application name.
   * **Install add-ons**: Select this option to automatically install add-ons: the [Kiali](https://kiali.io/) management console, and such components as Grafana, Prometheus, [Jaeger](/marketplace/products/yc/jaeger-ydb-store), and [Loki](/marketplace/products/yc/loki).
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Istio, run this command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_istio.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_istio.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
   istio ./istio/
   ```

   If you set `namespace` to the default namespace, Istio may work incorrectly. We recommend you to specify a value different from all existing namespaces (e.g., `istio-space`).

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## See also {#see-also}

* [Istio documentation](https://istio.io/latest/docs/).
