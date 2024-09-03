# Installing Gateway API

[Gateway API](https://github.com/kubernetes-sigs/gateway-api) is a collection of API resources that model networking in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). These include `GatewayClass`, `Gateway`, `HTTPRoute`, and more.

In {{ managed-k8s-name }}, Gateway API launches [{{ alb-full-name }}](../../application-load-balancer/) and the required auxiliary resources when a {{ k8s }} user declares a `Gateway` resource in a {{ managed-k8s-name }} cluster.

## Getting started {#before-you-begin}

1. {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

1. [Create a service account](../../iam/operations/sa/create.md) required for the Gateway API.
1. [Assign the following roles to the service account](../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor`: To create the required resources.
   * `vpc.publicAdmin`: To manage [external connectivity](../../vpc/security/index.md#roles-list).
   * `certificate-manager.admin`: To use [certificates](../../certificate-manager/concepts/index.md#types) registered in [{{ certificate-manager-full-name }}](../../certificate-manager/).
   * `compute.viewer`: To use {{ managed-k8s-name }} cluster [nodes](../../managed-kubernetes/concepts/index.md#node-group) in balancer [target groups](../../application-load-balancer/concepts/target-group.md).
1. Create an [authorized key](../../iam/operations/authorized-key/create.md) for the service account and save it to the `sa-key.json` file:

   ```bash
   yc iam key create \
     --service-account-name <name_of_service_account_for_Gateway_API> \
     --output sa-key.json
   ```

1. {% include [check-sg-prerequsites](./security-groups/check-sg-prerequsites-lvl3.md) %}

   {% include [sg-common-warning](./security-groups/sg-common-warning.md) %}


## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ managed-k8s-name }} cluster and select the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**![Marketplace](../../_assets/console-icons/shopping-cart.svg) tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Gateway API](/marketplace/products/yc/gateway-api) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../managed-kubernetes/concepts/index.md#namespace) or create a new one.
   * **Application name**: Specify the app name.
   * **Folder ID**: Select the folder to create load balancers in.
   * **Network ID**: Select the [cloud network](../../vpc/concepts/network.md#network) to [host the load balancers](../../application-load-balancer/concepts/application-load-balancer.md#lb-location).
   * **Subnet ID 1**, **Subnet ID 2**, **Subnet ID 3**: Select the [subnets](../../vpc/concepts/network.md#subnet) to [host the load balancers](../../application-load-balancer/concepts/application-load-balancer.md#lb-location).
   * **Service account key**: Paste the contents of the `sa-key.json` file or create a new [service account](../../iam/concepts/users/service-accounts.md) [key](../../iam/concepts/authorization/key.md).
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.


## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](helm-install.md) %}
1. {% include [Install and configure kubectl](kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Gateway API, run the command below:

   
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
      --set subnet1Id='<subnet_ID_1>' \
      --set subnet2Id='<subnet_ID_2>' \
      --set subnet3Id='<subnet_ID_3>' \
      --set-file saKeySecretKey='<path_to_the_sa-key.json_file>' \
      gateway-api ./gateway-api/
   ```


   In the command, specify the network and its subnets to host the [load balancers](../../application-load-balancer/concepts/application-load-balancer.md#lb-location).

## Use cases {#examples}

* [{#T}](../../managed-kubernetes/tutorials/marketplace/gateway-api.md)

## See also {#see-also}

* [Gateway API project description](https://gateway-api.sigs.k8s.io/).
* [Gateway API description and configuration](../../application-load-balancer/tools/k8s-gateway-api/index.md) in the {{ alb-name }} documentation.
