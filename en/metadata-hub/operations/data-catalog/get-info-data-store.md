---
title: Getting data storage info in {{ data-catalog-name }}
description: How to view information on exported data, ingestions, data sources, and data storage links in {{ data-catalog-full-name }}.
---

# Getting data storage info

{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}

You can view the following data storage info:

* [Exported data](#view-assets)
* [Ingestions](#get-ingestions)
* [Data sources](#get-sources)
* [Links](#view-lineage)

## Viewing exported data {#view-assets}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog with the data storage you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Select the data storage.
  1. Navigate to the **{{ ui-key.yacloud.data-catalog.label_source-data-tab }}** tab.

{% endlist %}

## Getting a list of ingestions {#get-ingestions}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog with the data storage you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Select the data storage.
  1. Navigate to the **{{ ui-key.yacloud.data-catalog.label_ingestions }}** tab.

{% endlist %}

## Getting a list of data sources {#get-sources}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog with the data storage you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Select the data storage.
  1. Navigate to the **{{ ui-key.yacloud.data-catalog.label_sources }}** tab.

{% endlist %}

## Viewing links between database objects {#view-lineage}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog with the data storage you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Select the data storage.
  1. Go to the **Related** tab.

{% endlist %}
