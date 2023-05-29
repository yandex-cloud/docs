# Installing Argo CD

[Argo CD](https://argo-cd.readthedocs.io) is a declarative GitOps tool for continuous delivery to {{ k8s }}.

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [kubectl-install](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the name of the desired cluster and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Argo CD](/marketplace/products/yc/argo-cd) and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) for Argo CD or create a new one.
   * **Application name**: Enter an application name.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.
1. Get the administrator password (`admin`):

   ```bash
   kubectl --namespace <namespace> get secret argocd-initial-admin-secret \
     --output jsonpath="{.data.password}" | base64 -d
   ```

To access the application via `localhost`:
1. Configure ArgoCD port forwarding onto the local computer:

   ```bash
   kubectl port-forward service/<application_name>-argocd-server \
     --namespace <namespace> 8080:443
   ```

1. Follow the link `http://localhost:8080` and log in with administrator credentials.

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Argo CD, run the following command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_argo-cd.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_argo-cd.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     argo-cd ./argo-cd/
   ```

## See also {#see-also}

* [Argo CD documentation](https://argo-cd.readthedocs.io/en/stable/operator-manual/).