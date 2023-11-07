---
title: "How to add parameters to a dataset"
description: "Follow this guide to add a parameter to a dataset."
---

# Adding parameters to a dataset

{% note info %}

Parameters added at the dataset level are available in all charts created based on this dataset.

{% endnote %}

To add a [parameter](../../concepts/parameters.md) to a dataset:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/datalens/datasets.svg) **Datasets** and select the dataset you need. If you do not have a dataset, [create one](create.md).
1. At the top of the screen, go to the **Parameters** tab.
1. Click **Add**.
1. In the **Add parameter** window, specify:

   * **Name**: Sets the parameter name.
   * **Type**: Defines the parameter data type: **Date**, **Date and time**, **Fractional number**, **Logical**, **String**, or **Integer**.
   * **Default value**: This is a required value. It is used when no parameter value is set in the dashboard, chart URL, or chart settings.

1. Click **Add**.

You can also create parameters at the [chart level](../chart/add-parameter-chart.md).
