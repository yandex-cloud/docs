---
title: How to replace a dataset in a chart in {{ datalens-full-name }}
description: Follow this guide to replace a dataset in a chart.
---

# Replacing a dataset in a chart

To replace a dataset in a chart:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/chart-column.svg) **Charts** and select the chart you need.
1. On the left side of the screen, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the dataset and select **Replace dataset**.
1. Select another dataset.

   {% note info %}

   Make sure the new dataset contains fields with the same names as the old one. If, after you replace the dataset, the chart shows the `ERR.DS_API.DB.COLUMN_DOES_NOT_EXIST` error, follow the instructions in [{#T}](../../dataset/create-dataset.md#update-fields).

   {% endnote %}

1. In the top-right corner, click **Save**.
