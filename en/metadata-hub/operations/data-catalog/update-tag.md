---
title: Updating a tag
description: Follow this guide to update a tag for metadata in {{ data-catalog-full-name }}.
---

# Updating a tag

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog containing the tag you want to update.
  1. Go to the ![image](../../../_assets/console-icons/tag.svg) **Tags and classifications** tab and select the classification containing the tag you want to update.
  1. In the tag list, click ![image](../../../_assets/console-icons/ellipsis.svg) in the tag row and select **{{ ui-key.yacloud.common.edit }}**.
  1. Update the tag parameters:

      * In the **{{ ui-key.yacloud.common.name }}** field, specify a new unique name for the tag.
      * Optionally, update the tag description.

  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
