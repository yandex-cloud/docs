---
title: Getting started with {{ marketplace-full-name }}
description: Follow this guide to learn how to use {{ marketplace-name }}.
---

# Getting started with {{ marketplace-name }}

{{ managed-k8s-name }} enables you to use applications from [{{ marketplace-full-name }}](/marketplace) in clusters.

## Getting a list of installed applications {#list-apps}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select your [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster).
  1. Click the **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) tab and select **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.

{% endlist %}

## Getting details about an installed application {#app-info}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster.
  1. Click the **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) tab and select **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. Under **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}**, click the name of the application in question.

{% endlist %}

## Installing applications {#install-apps}

{% note info %}

To deploy applications, you need at least one [active node group](../node-group/node-group-create.md).

{% endnote %}

{% note warning %}

Create a new [namespace](../../concepts/index.md#namespace) for installing the application unless the system namespace is explicitly specified. If you leave the default namespace, the application may work incorrectly.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster.
  1. Click the **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) tab and select **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. Under **Applications available for installation**, click the name of the application you need.
  1. In the window that opens, click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
  1. Configure the application and click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

{% endlist %}

{% note info %}

You can also install applications from {{ marketplace-name }} [using {{ TF }} manifests](../apply-helm-provider.md).

{% endnote %}

## Editing an application {#edit-app}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster.
  1. Click the **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) tab and select **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. Under **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}**, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) next to the application to edit and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the application as needed and click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Deleting applications {#delete-apps}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster.
  1. Click the **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) tab and select **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. Under **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}**, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) next to the application to delete and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.k8s.cluster.marketplace.button_release-uninstall }}**.
  1. In the window that opens, confirm the deletion.

{% endlist %}

## Collecting statistics {#statics}

To collect application usage statistics, {{ marketplace-full-name }} checks user resources in all {{ k8s }} clusters, including {{ k8s }} [secrets](../../concepts/encryption.md#k8s-secrets-encryption) labeled with `owner: helm`. To do this, the `k8s-marketplace-analytics` and `k8s-marketplace-distributor` [service accounts](../../../iam/concepts/users/service-accounts.md) are used. Statistics are collected every 15 minutes.

If you want to disable statistics collection for your {{ k8s }} cluster:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the {{ managed-k8s-name }} cluster.
  1. Click the **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) tab and select **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/ban.svg) **{{ ui-key.yacloud.marketplace-v2.button_disallow-analytics-scanning }}**.

{% endlist %}