# Installing the {{ alb-name }} Ingress controller

To balance the load and distribute traffic between {{ k8s }} applications, use the {{ alb-full-name }} [Ingress controller](../../../application-load-balancer/tools/k8s-ingress-controller/index.md). It runs the load balancer and the necessary auxiliary resources when the user creates an `Ingress` resource in a {{ managed-k8s-name }} cluster.

## Before you begin {#before-you-begin}

1. {% include [k8s-ingress-controller-create-cluster](../../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}

1. {% include [k8s-ingress-controller-create-node-group](../../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

## Creating a service account {#create-sa-key}.

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md) for the Ingress controller to run.
1. [Assign it the roles](../../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor`: To create the required resources.
   * `vpc.publicAdmin`: To manage [external connectivity](../../../vpc/security/index.md#roles-list).
   * `certificate-manager.certificates.downloader`: To use certificates registered in [{{ certificate-manager-full-name }}](../../../certificate-manager/).
   * `compute.viewer`: To use {{ managed-k8s-name }} cluster nodes in balancer [target groups](../../../application-load-balancer/concepts/target-group.md).
1. Create an [authorized key](../../../iam/operations/sa/create-access-key.md) and save it to a file named `key.json`:

   ```bash
   yc iam key create \
     --service-account-name <name of service account for Ingress controller> \
     --output sa-key.json
   ```

## Installation using {{ marketplace-full-name }} {#install-alb-marketplace}

1. Go to the folder page and select **{{ managed-k8s-name }}**.
1. Click the name of the desired cluster and select the **{{ marketplace-short-name }}** ![Marketplace](../../../_assets/marketplace.svg) tab.
1. Under **Applications available for installation**, select [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter an application name.
   * **Folder ID**: Specify a [folder ID](../../../resource-manager/operations/folder/get-id.md).
   * **Cluster ID**: Specify a [cluster ID](../kubernetes-cluster/kubernetes-cluster-list.md).
   * **Service account key**: Paste the contents of the `sa-key.json` file.
1. Click **Install**.

## Installation using a Helm chart {#install-alb-helm}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [kubectl-install](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Install the `jq` [utility](https://stedolan.github.io/jq/) for JSON filtering:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. Create a [namespace](../../concepts/index.md#namespace):

   ```bash
   kubectl create namespace yc-alb-ingress
   ```

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the Ingress controller, run the commands:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ registry }}/yc/yc-alb-ingress-controller-chart \
     --version=v{{ alb-ingress-version }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --set folderId=<folder ID> \
     --set clusterId=<cluster ID> \
     --set-file saKeySecretKey=sa-key.json \
     yc-alb-ingress-controller ./yc-alb-ingress-controller-chart/
   ```

## See also {#see-also}

* [Description of Ingress controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) in {{ k8s }} documentation.
* [Practical guideline for configuring the {{ alb-name }} Ingress controller](../../tutorials/alb-ingress-controller.md).
* [Reference for the {{ alb-name }} Ingress controller](../../../application-load-balancer/k8s-ref/index.md).