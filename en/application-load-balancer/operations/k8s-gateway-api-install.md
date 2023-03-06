# Installing {{ alb-name }} Gateway API for {{ managed-k8s-name }}

[Gateway API {{ alb-name }} for {{ managed-k8s-full-name }}](../tools/k8s-gateway-api/index.md) is provided as{% if product == "yandex-cloud" %} a {{ marketplace-name }} product or{% endif %} a chart of the [Helm]{% if lang == "ru" %}(https://helm.sh/ru/){% else %}(https://helm.sh/){% endif %} package manager for {{ k8s }}.

## Before you begin {#before-you-begin}

1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}

1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

1. Create and configure a service account for working with the Gateway API:

   1. {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. [Create a service account](../../iam/operations/sa/create.md), which is required for Gateway API:
   1. [Assign it the roles](../../iam/operations/sa/assign-role-for-sa.md):
      * `alb.editor`: To create the required resources.
      * `vpc.publicAdmin`: To manage [external connectivity](../../vpc/security/index.md#roles-list).
      * `certificate-manager.certificates.admin`: To manage certificates registered in [{{ certificate-manager-full-name }}](../../certificate-manager/).
      * `compute.viewer`: To use {{ managed-k8s-name }} cluster nodes in balancer [target groups](../../application-load-balancer/concepts/target-group.md).
   1. Create an [authorized key](../../iam/operations/sa/create-access-key.md) for the service account and save it to a file named `sa-key.json`:

      ```bash
      yc iam key create \
        --service-account-name <name_of_ service_account_for__Gateway_API> \
        --output sa-key.json
      ```

{% if product == "yandex-cloud" %}

## Installation using {{ marketplace-full-name }} {#install-alb-marketplace}

1. Go to the folder page and select **{{ managed-k8s-name }}**.
1. Click the name of the desired cluster and select the **{{ marketplace-short-name }}** ![Marketplace](../../_assets/marketplace.svg) tab.
1. Under **Applications available for installation**, select [Gateway API](/marketplace/products/yc/gateway-api) and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../managed-kubernetes/concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter an application name.
   * **Folder ID**: Select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create load balancers in.
   * **Network ID**: Select the [network](../../vpc/concepts/network.md) to [host the load balancers](../concepts/application-load-balancer.md#lb-location).
   * **Subnet ID**: Select the [subnet](../../vpc/concepts/network.md#subnet) to [host the load balancers](../concepts/application-load-balancer.md#lb-location). Currently, load balancers created through the Gateway API can only be placed in the same subnet.
   * **Secret Key**: Paste the contents of the `sa-key.json` file.
1. Click **Install**.

{% endif %}

## Installation using a Helm chart {#install-alb-helm}

1. {% include [Helm Install](../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Kubectl Install](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Install the `jq` [utility](https://stedolan.github.io/jq/) for JSON filtering:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. Create a [namespace](../../managed-kubernetes/concepts/index.md#namespace):

   ```bash
   kubectl create namespace yc-alb-ingress
   ```

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the Ingress controller, run the commands:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/gateway-api/gateway-api-helm/gateway-api \
     --version {{ alb-gateway-api-version }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --set folderId=<folder_ID> \
     --set networkId=<network_ID> \
     --set subnetId=<subnet_ID> \
     --set-file saKeySecretKey=sa-key.json \
     yc-alb-gateway-api ./yc-alb-gateway-api-chart/
   ```

## See also {#see-also}

* [Gateway API project description](https://gateway-api.sigs.k8s.io/).
* [Reference of {{ alb-name }} tools for {{ managed-k8s-name }}](../k8s-ref/index.md).