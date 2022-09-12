# Installing NodeLocal DNS

[NodeLocal DNS](../marketplace/products/yc/node-local-dns) reduces the load from DNS requests by running a cache on every [node](../../concepts/index.md#node-group) in a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster). This improves cluster performance and fault tolerance.

## Before you begin {#before-you-begin}

1. {% include [Install kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Get the [internal IP address](../../../vpc/concepts/address.md#internal-addresses) of the `kube-dns` service:

   ```bash
   kubectl get svc kube-dns -n kube-system -o jsonpath="{.spec.clusterIP}"
   ```

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the folder page and select **{{ managed-k8s-name }}**.
1. Click the name of the desired cluster and open the **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation** select [NodeLocal DNS](/marketplace/products/yc/node-local-dns) and click **Use**.
1. Configure the application:
   * **Namespace**: Select the `kube-system` [namespace](../../concepts/index.md#namespace).
   * **Application name**: Specify the name under which the application will be deployed in the cluster.
   * **ClusterIp address for kube-dns**: Specify the IP obtained [before proceeding with these steps](#before-you-begin).
   * **Work with Cilium**: Select this option if a cluster uses the [Cilium network policy controller](../../concepts/network-policy.md#cilium).
1. Click **Install**.

After installing NodeLocal DNS, use the following values:
* {{ k8s }} cluster zone: `cluster.local`.
* NodeLocal DNS cache address: `169.254.20.10`.
* Application port for external queries: `53`.
* Port for collecting metrics in Prometheus format: `9253`.

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../../../_includes/application-load-balancer/k8s-ingress-controller-install-helm.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/), from NodeLocal DNS, run the command below:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 &&\
   helm pull oci://{{ registry }}/yc-marketplace/yandex/dns/node-local-dns --version 1.3 --untar && \
   KUBE_DNS_IP="$(kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP})" && \
   helm install node-local-dns node-local-dns/. \
     --set config.cilium=false \
     --set config.clusterIp=$KUBE_DNS_IP
   ```

For more information about local DNS caching, see [{#T}](../../tutorials/node-local-dns.md).