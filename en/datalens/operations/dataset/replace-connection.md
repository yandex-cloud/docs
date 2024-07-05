---
title: "How to replace a connection in a dataset in {{ datalens-full-name }}"
description: "Follow this guide to replace a connection in a dataset."
---

# Replacing a connection in a dataset

To replace a connection in a dataset:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/circles-intersection.svg) **Datasets** and select the dataset you need.
1. Go to the **Sources** tab.
1. Delete all the tables from the workspace.
1. On the left side of the screen, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the connection and select **Replace connection**.
1. Select another connection.
1. Drag the tables to be used as a data source for the dataset to the workspace.
1. Edit or delete the [calculated fields](../../concepts/calculations/index.md) which use fields not present in the new table.
1. In the top-right corner, click **Save**.

{% note info %}

If the data schema in the source changed, follow the [{#T}](./update-field.md) guide.

{% endnote %}
