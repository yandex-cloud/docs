---
title: Getting a list of glossaries in a metadata catalog
description: Follow this guide to get a list of glossaries in a metadata catalog.
---

# Getting a list of glossaries

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog where your glossaries were created.
  1. Go to the ![image](../../../_assets/console-icons/book.svg) **Terms and glossaries** tab.

{% endlist %}

## Configuring a list of glossaries {#setting-list-tags}

You can use the management console to find glossaries by ID or name, sort glossaries by name, and customize the columns in the list.

To find a glossary, enter its ID or name in the search bar above the list of glossaries.

To sort glossaries by name, click the **{{ ui-key.yacloud.common.name }}** column header. This will sort the glossaries in alphabetical order. A second click on the same header reverses the sorting order. A third click cancels the sorting.

{% include [display-columns](../../../_includes/metadata-hub/display-columns.md) %}
