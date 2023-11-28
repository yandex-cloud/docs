# Installing NodeLocal DNS

[NodeLocal DNS](/marketplace/products/yc/node-local-dns) reduces the load from DNS requests by running a cache on every [node](../../concepts/index.md#node-group) in a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster). This improves {{ managed-k8s-name }} cluster performance and fault tolerance.

## Getting started {#before-you-begin}

1. {% include [kubectl installation](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Get the [internal IP address](../../../vpc/concepts/address.md#internal-addresses) of the `kube-dns` service:

   ```bash
   kubectl get svc kube-dns -n kube-system -o jsonpath="{.spec.clusterIP}"
   ```

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ managed-k8s-name }} cluster and select the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** ![Marketplace](../../../_assets/marketplace.svg) tab.
1. Under **Applications available for installation**, select [NodeLocal DNS](/marketplace/products/yc/node-local-dns) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Configure the application:
   * **Namespace**: Select the `kube-system` [namespace](../../concepts/index.md#namespace).
   * **Application name**: Specify the name for the application to be deployed in the {{ managed-k8s-name }} cluster.
   * **ClusterIp address for kube-dns**: Specify the IP obtained [before starting](#before-you-begin).
   * **Work with Cilium**: Select this option if a cluster uses the [Cilium network policy controller](../../concepts/network-policy.md#cilium).
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `{{ ui-key.yacloud.k8s.cluster.marketplace.label_release-status-DEPLOYED }}`.

After installing NodeLocal DNS, use the following values:
* {{ managed-k8s-name }} cluster zone: `cluster.local`
* NodeLocal DNS cache address: `169.254.20.10`
* Application port for external queries: `53`
* Port for collecting metrics in Prometheus format: `9253`

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/), from NodeLocal DNS, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 &&\
   helm pull oci://{{ mkt-k8s-key.yc_node-local-dns.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_node-local-dns.helmChart.tag }} \
     --untar && \
   KUBE_DNS_IP="$(kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP})" && \
   helm install \
     --set config.cilium=false \
     --set config.clusterIp=$KUBE_DNS_IP \
     node-local-dns ./chart/
   ```

For more information about local DNS caching, see [{#T}](../../tutorials/node-local-dns.md).