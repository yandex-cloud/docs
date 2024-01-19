---
title: "How to create a default filter for new charts in {{ datalens-full-name }}"
description: "Follow this guide to create a default filter for new charts."
---

# Creating a default filter for new charts

To create a default filter:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/circles-intersection.svg) **Datasets** and select the dataset you need. If you do not have a dataset, [create one](create.md).
1. In the top-left corner, select the **Filtration** tab.
1. Click **Add**.
1. Select the field to apply the filter to.
1. Set a filtering rule.
1. In the bottom-right corner, click **Apply filter**. The filter will appear in the list and will be applied to any new chart created from data in the current dataset.

{% note info %}

Default filters are not applied to data in the dataset preview area.

{% endnote %}