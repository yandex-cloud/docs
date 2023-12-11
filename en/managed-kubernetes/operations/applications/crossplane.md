# Installing Crossplane with {{ yandex-cloud }} support

[Crossplane](https://crossplane.io/) is a freeware add-on to {{ k8s }}, which enables platform development teams to build infrastructure for multiple vendors and produce higher-level API services used by application development teams.

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md) with the `admin` [role](../../../iam/concepts/access-control/roles.md). It is required for Crossplane to run.
1. Create a [service account key](../../../iam/concepts/authorization/access-key.md) and save it to the file:

   ```bash
   yc iam key create --service-account-name <service_account_name> --output key.json
   ```

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) name and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **Applications available for installation**, select [Crossplane with {{ yandex-cloud }} support](/marketplace/products/yc/crossplane) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) for Crossplane or create a new one.
   * **Application name**: Enter a name for the application.
   * **Service account key**: Paste the contents of the [service account key](../../../iam/concepts/authorization/access-key.md) file you [previously obtained](#before-you-begin), or create a new one.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `{{ ui-key.yacloud.k8s.cluster.marketplace.label_release-status-DEPLOYED }}`.

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Crossplane, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_crossplane.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_crossplane.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set-file providerJetYC.creds=key.json \
     crossplane ./crossplane/
   ```

## Installation using the Helm GitHub repository {#helm-repo-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Create a namespace for Crossplane:

   ```bash
   kubectl create namespace <namespace>
   ```

1. Add the Helm GitHub repository:

   ```bash
   helm repo add crossplane-stable https://charts.crossplane.io/stable && \
   helm repo update
   ```

1. Install Crossplane:

   ```bash
   helm install crossplane --namespace crossplane-system crossplane-stable/crossplane
   ```

1. Make sure that Crossplane is installed and running:

   ```bash
   helm list -n crossplane-system && \
   kubectl get all -n crossplane-system
   ```

1. Install the Crossplane CLI:

   ```bash
   curl -sL https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh | sh && \
   sudo mv kubectl-crossplane $(dirname $(which kubectl))
   ```

1. Install the provider:

   ```bash
   kubectl crossplane install provider {{ registry }}/crp0kch415f0lke009ft/crossplane/provider-jet-yc:v0.1.33
   ```

   The current provider version is available in the [GitHub repository](https://github.com/yandex-cloud/provider-jet-yc).

## See also {#see-also}

* [Crossplane documentation](https://docs.crossplane.io/).