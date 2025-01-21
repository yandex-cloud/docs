---
title: Installing the External Secrets Operator with {{ lockbox-full-name }} support
description: Follow this guide to install the External Secrets Operator with {{ lockbox-name }} support.
---

# Installing the External Secrets Operator with {{ lockbox-name }} support


[External Secrets Operator](/marketplace/products/yc/external-secrets) is a {{ k8s }} operator integrating external secret management systems, such as [{{ lockbox-name }}](../../../lockbox/), AWS Secrets Manager, Azure Key Vault, HashiCorp Vault, Google Secrets Manager, and more. The operator reads external APIs and automatically inserts values into a {{ k8s }} secret.

The External Secrets Operator with {{ lockbox-name }} support enables you to configure syncing [{{ lockbox-name }} secrets](../../../lockbox/concepts/secret.md) with [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) [secrets](../../concepts/encryption.md).

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md) for the External Secrets Operator.
1. Assign the required [role](../../../lockbox/security/index.md#service-roles) to the [service account](../../../iam/concepts/users/service-accounts.md):
   * [For a previously created secret](../../../lockbox/operations/secret-access.md).
   * [For all secrets](../../../iam/operations/sa/assign-role-for-sa.md) of a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) or [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud).
1. Create an [authorized key](../../../iam/concepts/authorization/key.md) for the service account and save it to the `sa-key.json` file:

   ```bash
   yc iam key create \
     --service-account-name <service_account_name> \
     --output sa-key.json
   ```

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Installing the External Secrets Operator through {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ managed-k8s-name }} cluster you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [External Secrets Operator with {{ lockbox-name }} support](/marketplace/products/yc/external-secrets) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
   * **Application name**: Specify the app name.
   * **Service account key**: Paste the contents of `sa-key.json`.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the External Secrets Operator, run the following command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_external-secrets.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_external-secrets.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set-file auth.json=<path_to_sa-key.json> \
     external-secrets ./external-secrets/
   ```

   This command creates a new namespace required for using the External Secrets Operator.

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Use cases {#examples}

* [{#T}](../../tutorials/kubernetes-lockbox-secrets.md)

## See also {#see-also}

* [External Secrets Operator description](https://external-secrets.io/v0.8.1/provider/yandex-lockbox/)
* [{{ lockbox-name }} documentation](../../../lockbox/)
