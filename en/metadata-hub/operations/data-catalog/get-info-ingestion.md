---
title: Getting ingestion info
description: Follow this guide to get information about an ingestion in {{ data-catalog-full-name }}.
---

# Getting ingestion info

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

## Getting ingestion info {#ingestion-info}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog where your ingestion was created.
  1. Navigate to the ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}** tab and select the ingestion.
 
     In the **{{ ui-key.yacloud.data-catalog.label_ingestion-tab-overview }}** tab that opens, you will see general information about the ingestion and the configuration specified when the ingestion was [created](create-ingestion.md).

{% endlist %}

## Getting information about operations with an ingestion {#ingestion-operations}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog where your ingestion was created.
  1. Navigate to the ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}** tab and select the ingestion.
  1. Navigate to the **{{ ui-key.yacloud.data-catalog.label_ingestion-tab-operations }}** tab.

     On this tab, you can view the list of all operations and filter them by status or type using the drop-down lists.

{% endlist %}

## Getting ingestion logs {#ingestion-logs}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog where your ingestion was created.
  1. Navigate to the ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}** tab and select the ingestion.
  1. Navigate to the **{{ ui-key.yacloud.data-catalog.label_ingestion-tab-logs }}** tab.
  1. In the drop-down list, select an operation to view the logs associated with it. You can [find](#ingestion-operations) the ID and status of the operation on the **{{ ui-key.yacloud.data-catalog.label_ingestion-tab-operations }}** tab.

{% endlist %}

