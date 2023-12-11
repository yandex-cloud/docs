# Basics of working with {{ marketplace-name }}

{{ managed-k8s-name }} enables you to use applications from [{{ marketplace-full-name }}](/marketplace) in clusters.

{% note info %}

{{ marketplace-name }} access is at the [Preview](../../../overview/concepts/launch-stages.md) stage.

{% endnote %}

## Retrieving a list of installed applications {#list-apps}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.

{% endlist %}

## Getting detailed information about an installed application {#app-info}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
   1. Under **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}**, click the name of the desired application.

{% endlist %}

## Installing applications {#install-apps}

{% note info %}

To deploy applications, you need at least one [active node group](../node-group/node-group-create.md#node-group-create).

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
   1. Under **Applications available for installation**, click the name of the desired application.
   1. In the window that opens, click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
   1. Specify application settings and click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

{% endlist %}

## Editing an application {#edit-app}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
   1. Under **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the application you need to edit.
   1. In the menu that opens, click **{{ ui-key.yacloud.common.edit }}**.
   1. Make your changes and click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Deleting applications {#delete-apps}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
   1. Under **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the application to delete.
   1. In the menu that opens, click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_release-uninstall }}**.

{% endlist %}