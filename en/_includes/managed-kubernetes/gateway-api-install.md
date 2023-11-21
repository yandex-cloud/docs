# Installing the Gateway API

The [Gateway API](https://github.com/kubernetes-sigs/gateway-api) is a collection of API resources that model networking in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). These include `GatewayClass`, `Gateway`, `HTTPRoute`, and more.

In {{ managed-k8s-name }}, the Gateway API launches [{{ alb-full-name }}](../../application-load-balancer/) and the required auxiliary resources when a {{ k8s }} user declares a `Gateway` resource in a {{ managed-k8s-name }} cluster.

## Getting started {#before-you-begin}

1. {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

1. [Create a service account](../../iam/operations/sa/create.md) required for the Gateway API.
1. [Assign it the roles](../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor`: To create the required resources.
   * `vpc.publicAdmin`: To manage [external connectivity](../../vpc/security/index.md#roles-list).
   * `certificate-manager.admin`: To use [certificates](../../certificate-manager/concepts/index.md#types) registered in [{{ certificate-manager-full-name }}](../../certificate-manager/).
   * `compute.viewer`: To use {{ managed-k8s-name }} cluster [nodes](../../managed-kubernetes/concepts/index.md#node-group) in balancer [target groups](../../application-load-balancer/concepts/target-group.md).
1. Create a [static key](../../iam/operations/sa/create-access-key.md) and save it to a file named `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <name_of_service_account_for_Gateway_API> \
     --output sa-key.json
   ```


## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ managed-k8s-name }} cluster you need and select the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** ![Marketplace](../../_assets/marketplace.svg) tab.
1. Under **Applications available for installation**, select [Gateway API](/marketplace/products/yc/gateway-api) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../managed-kubernetes/concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter a name for the application.
   * **Folder ID**: Select the folder to create load balancers in.
   * **Network ID**: Select the [cloud network](../../vpc/concepts/network.md#network) to [host the load balancers](../../application-load-balancer/concepts/application-load-balancer.md#lb-location).
   * **Subnet ID 1**, **Subnet ID 2**, **Subnet ID 3**: Select the [subnets](../../vpc/concepts/network.md#subnet) to [host the load balancers](../../application-load-balancer/concepts/application-load-balancer.md#lb-location).
   * **Service account key**: Paste the contents of the `sa-key.json` file or create a new [service account](../../iam/concepts/users/service-accounts.md) [key](../../iam/concepts/authorization/key.md).
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `{{ ui-key.yacloud.k8s.cluster.marketplace.label_release-status-DEPLOYED }}`.


## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](helm-install.md) %}
1. {% include [Install and configure kubectl](kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the Gateway API, run the command below:

   ```bash
    export HELM_EXPERIMENTAL_OCI=1 && \
    helm pull oci://{{ mkt-k8s-key.yc_gateway-api.helmChart.name }} \
      --version {{ mkt-k8s-key.yc_gateway-api.helmChart.tag }} \
      --untar && \
    helm install \
      --namespace <namespace> \
      --create-namespace \
      --set folderId='<folder_ID>' \
      --set networkId='<cloud_network_ID>' \
      --set subnetId='<subnet_ID>' \
      --set-file saKeySecretKey='<path_to_generated_sa-key.json>' \
      gateway-api ./gateway-api/
   ```

## See also {#see-also}

* [Gateway API project description](https://gateway-api.sigs.k8s.io/).
* [{{ alb-name }} documentation](../../application-load-balancer/).
* [Reference of {{ alb-name }} tools for {{ managed-k8s-name }}](../../application-load-balancer/k8s-ref/index.md).