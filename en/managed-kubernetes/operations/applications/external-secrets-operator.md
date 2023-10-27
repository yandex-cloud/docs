# Installing External Secrets Operator with {{ lockbox-name }} support

[External Secrets Operator](/marketplace/products/yc/external-secrets) is a {{ k8s }} operator integrating external secret management systems, such as [{{ lockbox-name }}](../../../lockbox/), AWS Secrets Manager, Azure Key Vault, HashiCorp Vault, Google Secrets Manager, and more. The operator reads external APIs and automatically inserts values into a {{ k8s }} secret.

External Secrets Operator with {{ lockbox-name }} support enables you to configure syncing [{{ lockbox-name }} secrets](../../../lockbox/concepts/secret.md) with the [secrets](../../concepts/encryption.md) in a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster).

## Creating a service account {#create-sa-key}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md) for the External Secrets Operator.
1. Assign the required [role](../../../lockbox/security/index.md#service-roles) to the [service account](../../../iam/concepts/users/service-accounts.md):
   * [For a previously created secret](../../../lockbox/operations/secret-access.md).
   * [For all secrets](../../../iam/operations/sa/assign-role-for-sa.md) of a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) or [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud).
1. Create an [authorized key](../../../iam/concepts/authorization/key.md) and save it to a file named `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <service_account_name> \
     --output sa-key.json
   ```

## Installing the External Secrets Operator through {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the {{ managed-k8s-name }} cluster name and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [External Secrets Operator with {{ lockbox-name }} support](/marketplace/products/yc/external-secrets) and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter an application name.
   * **Folder ID**: Specify a [folder ID](../../../resource-manager/operations/folder/get-id.md).
   * **Cluster ID**: Specify a [{{ managed-k8s-name }} cluster ID](../kubernetes-cluster/kubernetes-cluster-list.md).
   * **Service account key**: Paste the contents of `sa-key.json`.
1. Click **Install**.

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the External Secrets Operator, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_external-secrets.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_external-secrets.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set-file auth.json=sa-key.json \
     external-secrets ./external-secrets/
   ```

   This command creates a new namespace required for using the External Secrets Operator.

#### See also {#see-also}

* [External Secrets Operator description](https://external-secrets.io/v0.8.1/provider/yandex-lockbox/).
* [{{ lockbox-name }} documentation](../../../lockbox/).