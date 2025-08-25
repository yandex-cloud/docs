---
title: Getting a list of metadata sources
description: Follow this guide to get a list of metadata sources in {{ data-catalog-full-name }}.
---

# Getting a list of sources


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to get a list of metadata catalogs.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. In the list that opens, select the metadata catalog where your sources were created.
    1. Navigate to the ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.data-catalog.label_sources }}** tab.

{% endlist %}

## Configuring a list of sources {#setting-list-sources}

### Finding sources by ID, name, or type {#search-sources}

In the search bar above the list of sources, enter the ID, name, or type of source.

### Displaying your sources only {#filter_sources}

* Click **{{ ui-key.yacloud.data-transfer.switch_my }}** to display only your own sources.
* Click **{{ ui-key.yacloud.data-transfer.switch_all }}** to display all sources.

### Sorting sources {#sort-sources}

Click the relevant column header:

* **{{ ui-key.yacloud.common.name }}**: Sorting by source name in alphabetical order.
* **{{ ui-key.yacloud.data-catalog.label_ingestion-count }}**: Sorting by number of ingestions in ascending order.
* **{{ ui-key.yacloud.common.created-at }}**: Sorting by creation date in ascending date order.
* **{{ ui-key.yacloud.common.label_author }}**: Sorting by author name in alphabetical order.

Clicking the same header a second time reverses the sorting order. Clicking a third time clears the applied sorting.

### Customizing column display {#setting-columns}

To customize the columns:

1. Click ![image](../../../_assets/console-icons/gear.svg) in the column header row. This will open the list of all columns.
1. Do one of the following in the list of columns:

    * Uncheck the columns you do not need.
    * Check the hidden columns you want displayed.
    * To reorder columns, click ![image](../../../_assets/console-icons/grip.svg) to the left of the column name and drag the column up or down to a new position in the list.

1. Click **{{ ui-key.yacloud.common.apply }}**.
