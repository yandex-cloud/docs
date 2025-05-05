# Installing Gateway API

[Gateway API](https://github.com/kubernetes-sigs/gateway-api) is a collection of API resources that model network communications in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), including `GatewayClass`, `Gateway`, `HTTPRoute`, etc.

In {{ managed-k8s-name }}, Gateway API launches [{{ alb-full-name }}](../../application-load-balancer/) and its auxiliary resources when a {{ k8s }} user announces the `Gateway` resource in a {{ managed-k8s-name }} cluster.

## Getting started {#before-you-begin}

1. {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

1. [Create a Gateway API service account](../../iam/operations/sa/create.md).
1. [Assign the following roles to the service account](../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor`: To create resources.
   * `vpc.publicAdmin`: To manage [external connectivity](../../vpc/security/index.md#roles-list).
   * `certificate-manager.admin`: To use [certificates](../../certificate-manager/concepts/index.md#types) registered in [{{ certificate-manager-full-name }}](../../certificate-manager/).
   * `compute.viewer`: To use {{ managed-k8s-name }} cluster [nodes](../../managed-kubernetes/concepts/index.md#node-group) in balancer [target groups](../../application-load-balancer/concepts/target-group.md).
1. Create an [authorized key](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) for your service account and save it to the `sa-key.json` file:

   ```bash
   yc iam key create \
     --service-account-name <name_of_service_account_for_Gateway_API> \
     --output sa-key.json
   ```

1. {% include [check-sg-prerequsites](./security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](./security-groups/sg-common-warning.md) %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ managed-k8s-name }} cluster you need and select the ![Marketplace](../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Gateway API](/marketplace/products/yc/gateway-api) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Create a new [namespace](../../managed-kubernetes/concepts/index.md#namespace), e.g., `gateway-api-space`. If you leave the default namespace, Gateway API may work incorrectly.
   * **Application name**: Specify the application name.
   * **Folder ID**: Select the folder where you want to create your load balancers.
   * **Network ID**: Select the [cloud network](../../vpc/concepts/network.md#network) where your [load balancers](../../application-load-balancer/concepts/application-load-balancer.md#lb-location) will reside.
   * **Subnet ID 1**, **Subnet ID 2**, **Subnet ID 3**: Select [subnets](../../vpc/concepts/network.md#subnet) where your [load balancers](../../application-load-balancer/concepts/application-load-balancer.md#lb-location) will reside.
   * **Service account key**: Paste the contents of the `sa-key.json` file or create a new [service account](../../iam/concepts/users/service-accounts.md) [key](../../iam/concepts/authorization/key.md).
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](helm-install.md) %}
1. {% include [Install and configure kubectl](kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Gateway API, run this command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_gateway-api.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_gateway-api.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set folderId='<folder_ID>' \
     --set networkId='<cloud_network_ID>' \
     --set subnet1Id='<subnet_1_ID>' \
     --set subnet2Id='<subnet_2_ID>' \
     --set subnet3Id='<subnet_3_ID>' \
     --set-file saKeySecretKey='<path_to_sa-key.json>' \
     gateway-api ./gateway-api/
   ```

   In this command, specify the network and its subnets where your [load balancers](../../application-load-balancer/concepts/application-load-balancer.md#lb-location) will reside.

   If you set `namespace` to the default namespace, Gateway API may work incorrectly. We recommend that you specify a value different from all existing namespaces (e.g., `gateway-api-space`).

   {% include [Support OCI](../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Use cases {#examples}

* [{#T}](../../managed-kubernetes/tutorials/marketplace/gateway-api.md).

## See also {#see-also}

* [Gateway API project description](https://gateway-api.sigs.k8s.io/).
* [Gateway API description and configuration information](../../application-load-balancer/tools/k8s-gateway-api/index.md) in the {{ alb-name }} guides.
