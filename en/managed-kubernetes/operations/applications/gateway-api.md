# Installing Gateway API

[Gateway API](https://github.com/kubernetes-sigs/gateway-api) is a collection of API resources that model networking in a [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster). These include `GatewayClass`, `Gateway`, `HTTPRoute`, and more.

In {{ managed-k8s-name }}, Gateway API launches [{{ alb-full-name }}](../../../application-load-balancer/) and the requisite auxiliary resources when a {{ k8s }} user declares a `Gateway` resource in a cluster.

## Before you begin {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [kubectl-install](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Install the [`jq` utility](https://stedolan.github.io/jq/) for JSON filtering:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. [Create a service account](../../../iam/operations/sa/create.md), which is required for Gateway API:
1. [Assign it the roles](../../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor`: To create the required resources.
   * `vpc.publicAdmin`: To manage [external connectivity](../../../vpc/security/index.md#roles-list).
   * `certificate-manager.admin`: To use certificates registered in [{{ certificate-manager-full-name }}](../../../certificate-manager/).
   * `compute.viewer`: To use {{ managed-k8s-name }} cluster nodes in balancer [target groups](../../../application-load-balancer/concepts/target-group.md).
1. Create a [static key](../../../iam/operations/sa/create-access-key.md) and save it to a file named `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <name of service account for Gateway API> \
     --output sa-key.json
   ```

## Installing from {{ marketplace-full-name }} {#marketplace-install}

1. Go to the folder page and select **{{ managed-k8s-name }}**.
1. Click the name of the desired cluster and open the **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Gateway API](/marketplace/products/yc/gateway-api) and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter an application name.
   * **Folder ID**: Specify a [folder ID](../../../resource-manager/operations/folder/get-id.md).
   * **Network ID**: Specify a [cloud network](../../../vpc/concepts/network.md#network) ID.
   * **Subnet ID**: Specify a [subnet](../../../vpc/concepts/network.md#subnet) ID.
   * **Service account key**: Paste the contents of the `sa-key.json` file.
1. Click **Install**.

## Installation using a Helm chart {#helm-install}

1. [Install the Helm package manager]{% if lang == "ru" %}(https://helm.sh/ru/docs/intro/install/){% endif %}{% if lang == "en" %}(https://helm.sh/docs/intro/install/){% endif %}.
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Gateway API, run the command below:

   ```bash
    export HELM_EXPERIMENTAL_OCI=1 && \
    helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/gateway-api/gateway-api-helm/gateway-api \
      --version 0.4.16 \
      --untar && \
    helm install \
      --namespace gateway-api \
      --create-namespace \
      --set folderId='<folder ID>' \
      --set networkId='<cloud network ID>' \
      --set subnetId='<subnet ID>' \
      --set-file saKeySecretKey='<path to previously generated sa-key.json>' \
      gateway-api ./gateway-api
   ```

## See also {#see-also}

[{{ k8s }} Gateway API documentation](https://gateway-api.sigs.k8s.io/).
[{{ alb-name }} documentation](../../../application-load-balancer/).