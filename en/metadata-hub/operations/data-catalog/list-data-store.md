---
title: Getting a list of data storages in {{ data-catalog-name }}
description: How to get a list of data storages in {{ data-catalog-full-name }}.
---

# Getting a list of data storages

{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog with the data storages you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.

{% endlist %}

## Setting up a list of data storages {#setting-list-data-store}

### Searching for data storages {#search-data-store}

To find the storage you need, use one of these tools:

* Search bar: Enter the storage name above the list of storages, then select the cluster type and cluster connection type.
* Filtering: Click **{{ ui-key.yacloud.data-catalog.label_search-button-add-filter }}** above the list of storages and select a filter:
  
  * **Domain**: Select one or more domains and click **{{ ui-key.yacloud.common.save }}**. This will return storages marked up with the selected domains.
  * **Tag**: Select one or more tags and click **{{ ui-key.yacloud.common.save }}**. This will return storages marked up with the selected tags.
  * **Term**: Select one or more terms and click **{{ ui-key.yacloud.common.save }}**. This will return storages marked up with the selected terms.

  You can specify multiple filters by clicking **{{ ui-key.yacloud.data-catalog.label_search-button-add-filter }}** again.

### Sorting data storages {#sort-data-store}

Click the relevant column header:

* **{{ ui-key.yacloud.common.name }}**: Sorting by storage name in alphabetical order.
* **{{ ui-key.yacloud.common.created-at }}**: Sorting by creation date in ascending date order.

A second click on the same header reverses the sorting order. A third click clears the sorting.

### Customizing column display {#setting-columns}

1. Click ![image](../../../_assets/console-icons/gear.svg) in the column header row. This will open the list of all columns.
1. Do one of the following in the list of columns:

    * Uncheck the columns you do not need.
    * Check the hidden columns you want displayed.
    * To reorder columns, click ![image](../../../_assets/console-icons/grip.svg) to the left of the column name and drag the column up or down to a new position in the list.

1. Click **{{ ui-key.yacloud.common.apply }}**.