---
title: Combined chart in {{ datalens-full-name }}
description: In this tutorial, you will learn how to create and customize the combined chart visualization type in {{ datalens-full-name }}.
---

# Combined chart ![](../../_assets/datalens/combined.svg) in {{ datalens-full-name }}

Combined chart is a separate type of visualization consisting of layers. Each layer is a separate type of diagram. You can combine [line charts](line-chart.md), [column charts](column-chart.md), and [area charts](area-chart.md).

### Features

* The **X**, **Sort**, and **Filters** sections are the same for all layers.
* You can add, delete, reorder and rename layers.
* Each layer is executed with a separate query in the database.
* The maximum number of layers is 5.

{% note info %}

* There is no color fill by measure in column charts.
* In a combined chart, sorting only applies to the layers it is supported for.

{% endnote %}

## What is important to know

* A combined chart is often used for plan/actual comparison. You can show the plan as a dashed line on the line chart layer, while presenting the actual values broken down into categories on the column chart layer.

   {% cut "Example" %}

   {% list tabs %}

   - Visualization

      ![combo-line-column](../../_assets/datalens/visualization-ref/combined-chart/combo-line-column.png =800x)

   - Source table

      |Year|Category|Plan|Sales|
      |-----|-----|-----|-----|
      |2018|Household cleaners|435.53|449|
      |2018|Household goods|null|null|
      |2018|Home appliances|null|null|
      |2019|Household cleaners|503,255|512,282|
      |2019|Household goods|1,457,502|1,483,733|
      |2019|Home appliances|2,237,228.4|2,331,805|
      |2020|Household cleaners|1,623,124|1,644,668|
      |2020|Household goods|4,495,448|4,535,567|
      |2020|Home appliances|6,711,462.8|7,046,605|
      |2021|Household cleaners|2,686,134|2,737,436|
      |2021|Household goods|7,794,310|7,836,228|
      |2021|Home appliances|11,329,663.6|11,910,983|
      |2022|Household cleaners|2,512,031|2,652,918|
      |2022|Household goods|7,013,145|7,382,385|
      |2022|Home appliances|11,327,092|11,461,881|

   {% endlist %}

   {% endcut %}

* It is sometimes convenient to use a combined chart for same-type layers. For example, when one layer represents sales by category and another one shows the plan constant.

   {% cut "Example" %}

   ![combo-constant](../../_assets/datalens/visualization-ref/combined-chart/combo-constant.png =800x)

   {% endcut %}

* You can display additional lines calculated using [window functions](../../datalens/function-ref/window-functions.md) or [LOD functions](../../datalens/function-ref/aggregation-functions.md#syntax-lod). For example, to calculate an average by category, use this formula: `avg(SUM([Sales] INCLUDE [Category]))`.

   {% cut "Example" %}

   ![combo-avg](../../_assets/datalens/visualization-ref/combined-chart/combo-avg.png =800x)

   {% endcut %}

## Wizard sections {#wizard-sections}

Wizard<br/> section| Description
----- | ----
X | Dimension. You can specify only one field here. This dimension is usually a date. If this is the case, make sure to specify the `Date` data type for this field in the dataset. This is required for correct sorting and signature display. For better visualization, you can group dates into weeks, months, and years. For more information, see [{#T}](../concepts/chart/settings.md#field-settings). The **X** section is common for all layers.
Layer section | Allows you to add, delete, reorder, and rename layers. You can select a chart type for a layer: [line chart](line-chart.md), [column chart](column-chart.md), or [area chart](area-chart.md). The list of other sections depends on the layer chart type you select.<br/><br/> You can manage data display in the chart layers using the legend. To do this, click individual legend elements or select multiple elements by pressing and holding `Ctrl`/`Cmd`. You can enable or disable the legend in the chart settings. For more information, see [{#T}](../concepts/chart/settings.md#common-settings).

## Creating a combined chart {#create-diagram}

To create a combined chart:


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. {% include [create-1](../../_includes/datalens/visualization-ref/create-1.md) %}
1. {% include [create-2](../../_includes/datalens/visualization-ref/create-2.md) %}
1. {% include [create-3](../../_includes/datalens/visualization-ref/create-3.md) %}
1. {% include [create-4](../../_includes/datalens/visualization-ref/create-4.md) %}
1. Select **Combined chart** as your chart type.
1. Drag a dimension from the dataset to the **X** section. The values will be displayed in the lower part of the chart on the X axis.
1. Select a layer chart type: line chart ![](../../_assets/datalens/line.svg), column chart ![](../../_assets/datalens/column.svg), or area chart ![](../../_assets/datalens/area.svg). Rename the layer, if required.
1. Create a chart of the appropriate type:

   * [{#T}](line-chart.md#create-diagram)
   * [{#T}](column-chart.md#create-diagram)
   * [{#T}](area-chart.md#create-diagram)

1. Add a new layer. To do this, click ![](../../_assets/console-icons/plus.svg) to the right of the layer name.

{% include [see-also](../../_includes/datalens/visualization-ref/see-also-sub.md) %}