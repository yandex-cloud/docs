---
title: Creating a tag
description: Follow this guide to create a tag for metadata in {{ data-catalog-full-name }}.
---

# Creating a tag


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog where you want to create a tag.
  1. Navigate to the ![image](../../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}** tab.
  1. Select the classification you want to create a tag in or create a new classification.
  1. Click **{{ ui-key.yacloud.data-catalog.label_create-tag-action }}**.
  1. Set the tag parameters:

     * In the **{{ ui-key.yacloud.common.name }}** field, specify a unique name for the tag.
     * Optionally, describe the tag.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
