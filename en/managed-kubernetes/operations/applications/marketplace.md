# Basics of working with {{ marketplace-name }}

{{ managed-k8s-name }} enables you to use applications from [{{ marketplace-full-name }}](/marketplace) in clusters.

{% note info %}

{{ marketplace-name }} access in the [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

## Retrieving a list of installed applications {#list-apps}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click the name of the desired cluster and open the **{{ marketplace-short-name }}** tab.

{% endlist %}

## Getting detailed information about an installed application {#app-info}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click the name of the desired cluster and open the **{{ marketplace-short-name }}** tab.
  1. Under **Installed applications**, click the name of the desired application.

{% endlist %}

## Installing applications {#install-apps}

{% note info %}

To deploy applications, you need at least one [active node group](../node-group/node-group-create.md#node-group-create).

{% endnote %}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click the name of the desired cluster and open the **{{ marketplace-short-name }}** tab.
  1. Under **Applications available for installation**, click the name of the desired application.
  1. In the resulting window, click **OK**.
  1. Specify application settings and click **Install**.

{% endlist %}

## Editing an application {#edit-app}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click the name of the desired cluster and open the **{{ marketplace-short-name }}** tab.
  1. Under **Installed applications**, click ![image](../../../_assets/horizontal-ellipsis.svg) next to the application to edit.
  1. In the menu that opens, click **Edit**.
  1. Make your changes and click **Save**.

{% endlist %}

## Deleting applications {#delete-apps}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ managed-k8s-name }}**.
  1. Click the name of the desired cluster and open the **{{ marketplace-short-name }}** tab.
  1. Under **Installed applications**, click ![image](../../../_assets/horizontal-ellipsis.svg) next to the application to delete.
  1. In the menu that opens, click **Delete**.

{% endlist %}