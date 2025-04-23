# Installing the {{ alb-name }} Ingress controller

To balance the load and distribute traffic between {{ k8s }} applications, you can use an [{{ alb-full-name }} Ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md). It will launch the L7 load balancer and its auxiliary resources when you create an `Ingress` resource in a {{ managed-k8s-name }} cluster.

## Getting started {#before-you-begin}

1. {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

1. {% include [check-sg-prerequsites](./security-groups/check-sg-prerequsites-lvl3.md) %}

    [Make sure](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md) you have configured {{ alb-name }} security groups.

    {% include [sg-common-warning](./security-groups/sg-common-warning.md) %}

1. Create an Ingress Controller [service account](../../iam/operations/sa/create.md) and [assign it the following roles for the folder](../../iam/operations/sa/assign-role-for-sa.md):
   * [alb.editor](../../application-load-balancer/security/index.md#alb-editor): To create the {{ alb-name }} resources.
   * [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin): To manage external network connectivity.
   * [certificate-manager.certificates.downloader](../../certificate-manager/security/index.md#certificate-manager-certificates-downloader): To use certificates registered in [{{ certificate-manager-full-name }}](../../certificate-manager/).
   * [compute.viewer](../../compute/security/index.md#compute-viewer): To use {{ managed-k8s-name }} cluster nodes in the L7 load balancer [target groups](../../application-load-balancer/concepts/target-group.md).
   * [smart-web-security.editor](../../smartwebsecurity/security/index.md#smart-web-security-editor): To connect your {{ sws-full-name }} [security profile](../../smartwebsecurity/concepts/profiles.md) to the L7 load balancer virtual host. This is an optional setting.
1. Create a service account [authorized access key](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) in JSON format and save it to the `sa-key.json` file:

   ```bash
   yc iam key create \
     --service-account-name <name_of_service_account_for_Ingress_controller> \
     --output sa-key.json
   ```

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the cluster you need and select the ![Marketplace](../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:

   * **Namespace**: Select a [namespace](../../managed-kubernetes/concepts/index.md#namespace) other than `default` or create a new one. If you select a default namespace, ALB Ingress Controller may run incorrectly.
   * **Application name**: Specify the application name.
   * **Folder ID**: Specify the [folder ID](../../resource-manager/operations/folder/get-id.md).
   * **Cluster ID**: Specify the [cluster ID](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md).
   * **Service account key**: Paste the contents of the `sa-key.json` file.
   * **Enable default health checks**: Select this option to install [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) in the node group network for application health checks.

      DaemonSet adds pods with traffic monitoring agents to each node. As a result, node and namespace isolation does not affect monitoring process, which means you get accurate traffic monitoring data. If the number of cluster nodes increases or decreases, DaemonSet adds or removes monitoring agents, respectively.

      You can skip this option if you do not need to run cluster health checks or if you are using your own health check solution. For more information on configuring health checks manually, see [{#T}](../../managed-kubernetes/tutorials/custom-health-checks.md).

1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#install-alb-helm}

1. {% include [helm-install](helm-install.md) %}

1. {% include [kubectl-install](kubectl-install.md) %}

1. Install [`jq`](https://stedolan.github.io/jq/) for stream processing of JSON files:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. To install the [Helm chart](https://helm.sh/docs/topics/charts/) with the Ingress controller, run this command:

   ```bash
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ mkt-k8s-key.yc_alb-ingress-controller.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_alb-ingress-controller.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set folderId=<folder_ID> \
     --set clusterId=<cluster_ID> \
     --set enableDefaultHealthChecks=<true_or_false> \
     --set-file saKeySecretKey=sa-key.json \
     yc-alb-ingress-controller ./yc-alb-ingress-controller-chart/
   ```

   {% include [Support OCI](../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

   If you set the `namespace` setting to `default`, ALB Ingress Controller may run incorrectly. We recommend you to specify a setting other than `default`.

   The `enableDefaultHealthChecks` option enables application health checks in a cluster. With this option selected, ALB Ingress controller installs [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) in the node group network.

   DaemonSet adds pods with traffic monitoring agents to each node. As a result, node and namespace isolation does not affect monitoring process, which means you get accurate traffic monitoring data. If the number of cluster nodes increases or decreases, DaemonSet adds or removes monitoring agents, respectively.

   You can skip this option if you do not need to run cluster health checks or if you are using your own health check solution. For more information on configuring health checks manually, see [{#T}](../../managed-kubernetes/tutorials/custom-health-checks.md).

## Use cases {#examples}

* [{{ alb-name }} Ingress controller configuration tutorial](../../managed-kubernetes/tutorials/alb-ingress-controller.md).
* [{{ alb-name }} Ingress controller logging configuration tutorial](../../managed-kubernetes/tutorials/alb-ingress-controller-log-options.md).

## See also {#see-also}

* Ingress controller official documentation description.
   * [{{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/).
   * [{{ alb-name }}](../../application-load-balancer/tools/k8s-ingress-controller/index.md).
* [Restrictions when updating ALB Ingress Controller](../../application-load-balancer/operations/k8s-ingress-controller-upgrade.md).
