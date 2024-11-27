# Installing Crossplane with {{ yandex-cloud }} support

[Crossplane](https://crossplane.io/) is a freeware add-on to {{ k8s }} that enables platform development teams to build infrastructure for multiple vendors and produce higher-level service APIs for application development teams.

You can install Crossplane in any of the following ways:
* [Using {{ marketplace-full-name }} in the management console](#marketplace-install).
* [Using a Helm chart from the {{ marketplace-name }} repository](#helm-install).
* [Using a Helm chart from the Crossplane repository](#helm-repo-install).

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md) with the `admin` [role](../../../iam/concepts/access-control/roles.md) for the folder where you want to manage resources using Crossplane.
1. Create an [authorized key](../../../iam/concepts/authorization/key.md) for the service account and save it to a file:

   ```bash
   yc iam key create \
     --service-account-name <service_account_name> \
     --output key.json
   ```

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Installation in the management console using {{ marketplace-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Crossplane with {{ yandex-cloud }} support](/marketplace/products/yc/crossplane) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) for Crossplane or create a new one.
   * **Application name**: Specify the app name.
   * **Service account key**: Paste the contents of the file with the service account [authorized key](../../../iam/concepts/authorization/key.md) you [obtained earlier](#before-you-begin) or create a new one.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

{% include [crossplane-provider-info](../../../_includes/managed-kubernetes/crossplane-provider-info.md) %}

## Installation using a Helm chart from the {{ marketplace-name }} repository {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Crossplane, run the following command:


   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_crossplane.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_crossplane.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set-file providerJetYc.creds=key.json \
     crossplane ./crossplane/
   ```


   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

1. Make sure the state of all Crossplane pods changed to `Running`:

   ```bash
   kubectl get pods -A | grep -E "crossplane|provider-jet-yc"
   ```

{% include [crossplane-provider-info](../../../_includes/managed-kubernetes/crossplane-provider-info.md) %}

## Installation using a Helm chart from the Crossplane repository {#helm-repo-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
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
   helm install crossplane --namespace <namespace> crossplane-stable/crossplane
   ```

1. Make sure that Crossplane is installed and running:

   ```bash
   helm list --namespace <namespace> && \
   kubectl get all --namespace <namespace>
   ```

1. Install the Crossplane CLI:

   ```bash
   curl --silent --location https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh | sh && \
   sudo mv kubectl-crossplane $(dirname $(which kubectl))
   ```

1. Install the provider:

   ```bash
   crossplane xpkg install provider xpkg.upbound.io/yandexcloud/crossplane-provider-yc:v0.5.1
   ```
   
   The current provider version is available in the [GitHub repository](https://github.com/yandex-cloud/crossplane-provider-yc).

1. Create a secret named `yc-creds`:

   ```bash
   kubectl create secret generic yc-creds \
     --namespace "<namespace>" \
     --from-file=credentials=<path_to_key.json>
   ```

1. Make sure the [{{ yandex-cloud }} provider](https://github.com/yandex-cloud/crossplane-provider-yc/tree/main) is installed:
   
   ```bash
   kubectl get provider
   ```

1. Create the `providerconfig.yaml` Crossplane manifest with the {{ yandex-cloud }} provider settings:

   ```yaml
   apiVersion: yandex-cloud.jet.crossplane.io/v1beta1
   kind: ProviderConfig
   metadata:
     name: default
   spec:
     credentials:
       cloudId: <cloud_ID>
       folderId: <folder_ID>
       source: Secret
       secretRef:
         name: yc-creds
         namespace: <namespace>
         key: credentials
   ```

1. Apply the provider settings:

   ```bash
   kubectl apply -f providerconfig.yaml
   ```

## Configuring the provider {#change-provider-settings}

1. To change the {{ yandex-cloud }} provider settings for Crossplane, e.g., specify the default [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create resources in, run this command:

   ```bash
   kubectl edit ProviderConfig/default
   ```

1. Edit the parameters you want to update and save the changes.

## Getting information about resources {#see-resources}

1. View the list of {{ yandex-cloud }} resources you can create using Crossplane:

   ```bash
   kubectl get crd | grep yandex-cloud.jet.crossplane.io
   ```

1. View the parameters you can set with Crossplane for a specific resource:
   
   ```bash
   kubectl describe crd <resource_name>
   ```

   For example, request the parameters for creating a {{ compute-full-name }} [VM](../../../compute/concepts/vm.md):

   ```bash
   kubectl describe crd instances.compute.yandex-cloud.jet.crossplane.io
   ```

   For examples of how to configure {{ yandex-cloud }} resources, see the [provider's GitHub repo](https://github.com/yandex-cloud/crossplane-provider-yc/tree/main/examples).

## Use cases {#examples}

* [{#T}](../../tutorials/marketplace/crossplane.md)

## See also {#see-also}

* [Crossplane documentation](https://docs.crossplane.io/)
