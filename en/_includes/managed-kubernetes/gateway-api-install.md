# Installing Gateway API

[Gateway API](https://github.com/kubernetes-sigs/gateway-api) is a collection of API resources that model networking in a [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). These include `GatewayClass`, `Gateway`, `HTTPRoute`, and more.

In {{ managed-k8s-name }}, Gateway API launches [{{ alb-full-name }}](../../application-load-balancer/) and the required auxiliary resources when a {{ k8s }} user declares a `Gateway` resource in a cluster.

## Getting started {#before-you-begin}

1. {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

1. {% include [kubectl-install](kubectl-install.md) %}
1. [Create a service account](../../iam/operations/sa/create.md), which is required for Gateway API.
1. [Assign it the roles](../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor`: To create the required resources.
   * `vpc.publicAdmin`: To manage [external connectivity](../../vpc/security/index.md#roles-list).
   * `certificate-manager.admin`: To use certificates registered in [{{ certificate-manager-full-name }}](../../certificate-manager/).
   * `compute.viewer`: To use {{ managed-k8s-name }} cluster nodes in balancer [target groups](../../application-load-balancer/concepts/target-group.md).
1. Create a [static key](../../iam/operations/sa/create-access-key.md) and save it to a file named `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <name of service account for Gateway API> \
     --output sa-key.json
   ```


## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the folder page and select **{{ managed-k8s-name }}**.
1. Click the name of the cluster you need and select the ![Marketplace](../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Gateway API](/marketplace/products/yc/gateway-api) and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../managed-kubernetes/concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter an application name.
   * **Folder ID**: Select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create load balancers in.
   * **Network ID**: Select the [cloud network](../../vpc/concepts/network.md#network) to [host the load balancers](../../application-load-balancer/concepts/application-load-balancer.md#lb-location).
   * **Subnet ID 1**, **Subnet ID 2**, **Subnet ID 3**: Select the [subnets](../../vpc/concepts/network.md#subnet) to [host the load balancers](../../application-load-balancer/concepts/application-load-balancer.md#lb-location).
   * **Secret Key**: Paste the contents of the `sa-key.json` file or create a new service account key.
1. Click **Install**.


## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](helm-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Gateway API, run the command below:

   ```bash
    export HELM_EXPERIMENTAL_OCI=1 && \
    helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/gateway-api/gateway-api-helm/gateway-api \
      --version <Helm chart version> \
      --untar && \
    helm install \
      --namespace <namespace> \
      --create-namespace \
      --set folderId='<folder ID>' \
      --set networkId='<cloud network ID>' \
      --set subnetId='<subnet ID>' \
      --set-file saKeySecretKey='<path to previously generated sa-key.json>' \
      gateway-api ./gateway-api/
   ```

   You can check the current version of the Helm chart on the [application page](/marketplace/products/yc/gateway-api#docker-images).

## See also {#see-also}

* [Gateway API project description](https://gateway-api.sigs.k8s.io/).
* [{{ alb-name }} documentation](../../application-load-balancer/).
* [Reference of {{ alb-name }} tools for {{ managed-k8s-name }}](../../application-load-balancer/k8s-ref/index.md).