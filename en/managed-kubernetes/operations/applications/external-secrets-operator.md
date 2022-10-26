# Installing External Secrets Operator with {{ lockbox-name }} support

[External Secrets Operator](/marketplace/products/yc/external-secrets) is a {{ k8s }} operator integrating external secret management systems, such as [{{ lockbox-name }}](../../../lockbox/), AWS Secrets Manager, Azure Key Vault, HashiCorp Vault, Google Secrets Manager, and more. The operator reads external APIs and automatically inserts values into {{ k8s }} Secret.

External Secrets Operator with {{ lockbox-name }} support enables you to configure syncing {{ lockbox-name }} secrets with the secrets in a [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster).

## Creating a service account {#create-sa-key}.

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md) for External Secrets Operator.
1. Create an [authorized key](../../../iam/concepts/authorization/key.md) and save it to the file `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <service account name> \
     --output sa-key.json
   ```

## Installing External Secrets Operator through {{ marketplace-full-name }} {#install-eso-marketplace}

1. Go to the folder page and select **{{ managed-k8s-name }}**.
1. Click the name of the desired cluster and open the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select **External Secrets Operator with {{ lockbox-name }} support** and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter an application name.
   * **Service account key**: Paste in the contents of `sa-key.json`.
1. Click **Install**.

## Installation using a Helm chart {#install-eso-helm}

1. {% include [Установка Helm](../../../_includes/application-load-balancer/k8s-ingress-controller-install-helm.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with External Secrets Operator, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/external-secrets/chart/external-secrets \
     --version 0.3.8-2 \
     --untar && \
   helm install \
     --namespace external-secrets \
     --create-namespace \
     --set-file auth.json=sa-key.json \
     external-secrets ./external-secrets
   ```

   This command creates a new `external-secrets` namespace required for using the External Secrets Operator.

#### See also {#see-also}

* [External Secrets Operator description](https://external-secrets.io/provider-yandex-lockbox/).
* [{{ lockbox-name }} documentation](../../../lockbox/).