---
title: Getting a list of tags in a classification
description: Follow this guide to get a list of tags for metadata in a classification created in {{ data-catalog-full-name }}.
---

# Getting a list of tags in a classification


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog the tags were created in.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}** and select the classification the tags were created in.

{% endlist %}

## Configuring a list of tags {#setting-list-tags}

You can use the management console to find tags by ID or name, sort tags by name, and customize the columns in the list.

To find a tag, enter its ID or name in the search bar above the list of tags.

To sort tags by name, click the **{{ ui-key.yacloud.common.name }}** column header. This will sort the tags in alphabetical order. A second click on the same header reverses the sorting order. Clicking a third time clears the applied sorting.

{% include [display-columns](../../../_includes/metadata-hub/display-columns.md) %}
