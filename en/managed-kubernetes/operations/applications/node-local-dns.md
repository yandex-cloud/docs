# Installing NodeLocal DNS

[NodeLocal DNS](/marketplace/products/yc/node-local-dns) reduces the load from DNS requests by running a cache on every [node](../../concepts/index.md#node-group) in a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster). This improves {{ managed-k8s-name }} cluster performance and fault tolerance.

## Getting started {#before-you-begin}

{% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

{% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ managed-k8s-name }} cluster you need and select the ![Marketplace](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [NodeLocal DNS](/marketplace/products/yc/node-local-dns) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Select the `kube-system` [namespace](../../concepts/index.md#namespace).

      {% include [Namespace warning](../../../_includes/managed-kubernetes/kube-system-namespace-warning.md) %}

   * **Application name**: Specify the name for the application to be deployed in the {{ managed-k8s-name }} cluster.
   * **Internal IP address of the kube-dns service**: Address for accessing NodeLocal DNS Cache. Requests sent from application pods to the address in the field are routed to [local DNS](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#iptables-notrack) based on the iptables rules.

      The field contains the `ClusterIP` address of `kube-dns` in the `kube-system` namespace. You can get the value of the field using the following command:

      ```bash
      kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP}
      ```

      Since {{ yandex-cloud }} adds the `kube-dns` service when creating the cluster, the IP address of the service is pre-defined. Therefore, you cannot change it in the **kube-dns internal IP address** field.

   * **Work with Cilium**: Select this option if a cluster uses the [Cilium network policy controller](../../concepts/network-policy.md#cilium).
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

After installing NodeLocal DNS, use the following values:
* {{ managed-k8s-name }} cluster zone: `cluster.local`
* NodeLocal DNS cache address: `169.254.20.10`
* Application port for external queries: `53`
* Port for collecting metrics in Prometheus format: `9253`

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Get an address to access the NodeLocal DNS Cache. You will need the address to install the [Helm chart](https://helm.sh/docs/topics/charts/):

   ```bash
   kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP}
   ```

   The command contains the `ClusterIP` address of `kube-dns` in the `kube-system` namespace. `kube-dns` is installed automatically during cluster creation, so its IP address is pre-defined.

   Requests sent from application pods to the address you get are routed to [local DNS](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#iptables-notrack) based on the iptables rules.

1. To install a Helm chart from NodeLocal DNS, run this command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_node-local-dns.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_node-local-dns.helmChart.tag }} \
     --untar && \
   helm install \
     --set config.cilium=false \
     --set config.clusterIp="<kube-dns_IP_address>" \
     --namespace kube-system \
     node-local-dns ./node-local-dns/
   ```

   {% include [Namespace warning](../../../_includes/managed-kubernetes/kube-system-namespace-warning.md) %}

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

For more information on how to set up local DNS caching, see [{#T}](../../tutorials/node-local-dns.md).
