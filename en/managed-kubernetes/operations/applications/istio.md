# Installing Istio

[Istio](https://istio.io/latest/about/service-mesh/) is designed for setting up a _service mesh_, a low-latency infrastructure layer for handling a large amount of network communications across services in {{ managed-k8s-name }} clusters.

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

1. {% include [Install kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the cluster name and select the ![image](../../../_assets/marketplace.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **Applications available for installation**, select [Istio](/marketplace/products/yc/istio) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Configure the application:
   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for Istio. We do not recommend installing the application in the `default` namespace.
   * **Application name**: Enter an application name.
   * **Install add-ons**: Select this option to automatically install add-ons: the [Kiali](https://kiali.io/) management console, and such components as Grafana, Prometheus, [Jaeger](/marketplace/products/yc/jaeger-ydb-store), and [Loki](/marketplace/products/yc/loki).
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Istio, run this command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_istio.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_istio.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
   istio ./istio/
   ```

## See also {#see-also}

* [Istio documentation](https://istio.io/latest/docs/).
