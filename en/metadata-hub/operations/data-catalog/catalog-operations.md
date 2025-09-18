---
title: Getting a list of operations with a metadata catalog
description: Follow this guide to get a list of operations in {{ data-catalog-full-name }}.
---

# Getting a list of operations


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. In the list that opens, select the metadata catalog for which you want to get a list of operations.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.data-catalog.label_ingestion-tab-operations }}**.

{% endlist %}

## Setting up a list of operations {#setting-list-operations}

### Searching operations by status or type {#search-operations}

In the fields above the list of sources, select the operation status or type.

### Sorting operations {#sort-operations}

Click the relevant column header:

* **{{ ui-key.yacloud.common.started-at }}**: Sorting by operation start date and time in ascending order.
* **{{ ui-key.yacloud.common.updated-at }}**: Sorting by catalog update date and time in ascending order.

A second click on the same header reverses the sorting order. Clicking a third time clears the applied sorting.

### Customizing column display {#setting-columns}

To customize the columns:

1. Click ![image](../../../_assets/console-icons/gear.svg) in the column header row. This will open the list of all columns.
1. Do one of the following in the list of columns:

    * Uncheck the columns you do not need.
    * Check the hidden columns you want displayed.
    * To reorder columns, click ![image](../../../_assets/console-icons/grip.svg) to the left of the column name and drag the column up or down to a new position in the list.

1. Click **{{ ui-key.yacloud.common.apply }}**.
