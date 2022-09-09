# Installing Crossplane with {{ yandex-cloud }} support

[Crossplane](https://crossplane.io/) is a freeware add-on to {{ k8s }}, which enables platform development teams to build infrastructure for multiple vendors and produce higher-level API services used by application development teams.

## Before you begin {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [Install kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md) with the `admin` role. It is required for Crossplane to run.

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the name of the desired [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Crossplane with {{ yandex-cloud }} support](/marketplace/products/yc/crossplane) and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) for Crossplane or create a new one.
   * **Application name**: Enter an application name.
   * **Service account key**: Paste the contents of the [service account key](../../../iam/concepts/authorization/access-key.md) file or create a new one.
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.