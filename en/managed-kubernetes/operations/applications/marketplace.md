---
title: Getting started with {{ marketplace-full-name }}
description: Follow this guide to learn how to interact with {{ marketplace-name }}.
---

# Getting started with {{ marketplace-name }}

{{ managed-k8s-name }} enables you to use applications from [{{ marketplace-full-name }}](/marketplace) in clusters.

## Retrieving a list of installed applications {#list-apps}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.

{% endlist %}

## Getting detailed information about an installed application {#app-info}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
  1. Under **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}**, click the name of the desired application.

{% endlist %}

## Installing applications {#install-apps}

{% note info %}

To deploy applications, you need at least one [active node group](../node-group/node-group-create.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
  1. Under **Applications available for installation**, click the name of the desired application.
  1. In the window that opens, click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. Specify application settings and click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

{% endlist %}

## Editing an application {#edit-app}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
  1. Under **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the app to edit.
  1. In the menu that opens, click **{{ ui-key.yacloud.common.edit }}**.
  1. Make your changes and click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Deleting applications {#delete-apps}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
  1. Under **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the app to delete.
  1. In the menu that opens, click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_release-uninstall }}**.

{% endlist %}

## Statistics collection {#statics}

To collect app usage statistics, {{ marketplace-full-name }} reviews user resources in all {{ k8s }} clusters, including {{ k8s }} [secrets](../../concepts/encryption.md#k8s-secrets-encryption) labeled with `owner: helm`. To do this, the `k8s-marketplace-analytics` and `k8s-marketplace-distributor` [service accounts](../../../iam/concepts/users/service-accounts.md) are used. Statistics are collected every 15 minutes.

If you want to disable statistics collection for your {{ k8s }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
  1. In the top-right corner, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/ban.svg) **{{ ui-key.yacloud.marketplace-v2.button_disallow-analytics-scanning }}**.

{% endlist %}
