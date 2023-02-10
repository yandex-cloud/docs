# Installing Argo CD

[Argo CD](https://argo-cd.readthedocs.io) is a declarative, GitOps tool for continuous delivery to {{ k8s }}.

## Before you begin {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the name of the desired cluster and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Argo CD](/marketplace/products/yc/argo-cd) and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) for Argo CD or create a new one.
   * **Application name**: Enter an application name.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.
1. Get the administrator's password (`admin`):

   ```bash
   kubectl --namespace <namespace> get secret argocd-initial-admin-secret \
     --output jsonpath="{.data.password}" | base64 -d
   ```

To access the application via `localhost`:
1. Enable `port forward`:

   ```bash
   kubectl port-forward service/<application name>-argocd-server \
     --namespace <namespace> 8080:443
   ```

1. Follow the link `http://localhost:8080` and log in with administrator credentials.

## Installation using a Helm chart {#helm-install}

1. {% include [Helm](../../../_includes/application-load-balancer/k8s-ingress-controller-install-helm.md) %}

1. Create a namespace for Argo CD:

   ```bash
   kubectl create namespace <namespace name>
   ```

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Argo CD, run the following command:

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/argo/chart/argo-cd --version 4.5.3-1 --untar && \
   helm install argo-cd argo-cd/. --namespace <namespace>
   ```

## See also {#see-also}

* [Argo CD documentation](https://argo-cd.readthedocs.io/en/stable/operator-manual/).