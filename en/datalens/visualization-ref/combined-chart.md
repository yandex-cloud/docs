# Combined chart ![](../../_assets/datalens/combined.svg)

A combined chart is a visualization type that consists of layers. Each layer is represented with its own chart type. You can combine [linear charts](line-chart.md), [column charts](column-chart.md), and [area charts](area-chart.md).

Specifics:

* The **X** axis is common for all layers.
* You can add, delete, and rename layers, as well as change their order.
* Each layer is executed with a separate query in the database.
* The number of layers is unlimited.

{% note info %}

There is no color fill by measure in column charts.

{% endnote %}

A combined chart is often used for plan/actual comparison. You can represent the plan as a dashed line on the layer with a linear chart, while categorizing columns with actual values on the layer with a column chart.

![combo-line-column](../../_assets/datalens/visualization-ref/combined-chart/combo-line-column.png)

{% cut "Source table" %}

| Year | Category | Plan | Sales |
|-----|-----|-----|-----|
| 2018 | Household cleaners | 435.53 | 449 |
| 2018 | Household goods | null | null |
| 2018 | Home appliances | null | null |
| 2019 | Household cleaners | 503255 | 512282 |
| 2019 | Household goods | 1457502 | 1483733 |
| 2019 | Home appliances | 2237228.4 | 2331805 |
| 2020 | Household cleaners | 1623124 | 1644668 |
| 2020 | Household goods | 4495448 | 4535567 |
| 2020 | Home appliances | 6711462.8 | 7046605 |
| 2021 | Household cleaners | 2686134 | 2737436 |
| 2021 | Household goods | 7794310 | 7836228 |
| 2021 | Home appliances | 11329663.6 | 11910983 |
| 2022 | Household cleaners | 2512031 | 2652918 |
| 2022 | Household goods | 7013145 | 7382385 |
| 2022 | Home appliances | 11327092 | 11461881 |

{% endcut %}

It's sometimes convenient to use a combined chart for same-type layers. For example, when one layer represents sales by category and another one shows the plan constant.

![combo-constant](../../_assets/datalens/visualization-ref/combined-chart/combo-constant.png)

You can display additional lines calculated using [window functions](../../datalens/function-ref/window-functions.md) or [LOD functions](../../datalens/function-ref/aggregation-functions.md#syntax-lod). For example, to calculate an average by category, use this formula: `avg(SUM([Sales] INCLUDE [Category]))`.

![combo-avg](../../_assets/datalens/visualization-ref/combined-chart/combo-avg.png)

## Sections in the wizard {#wizard-sections}

| Section<br/> in the wizard | Description |
----- | ----
| X | Dimension. Only one field can be specified. This dimension is usually a date. In this case, make sure that the `Date` data type is specified for this field in the dataset. This is required for correct sorting and signature display. For better visualization, you can group dates into weeks, months, and years (to learn more, see [{#T}](../concepts/chart/settings.md#field-settings)). The **X** section is common for all layers. |
| Layer section | Lets you add, delete, and rename layers, as well as change their order. You can select a chart type for a layer: [linear chart](line-chart.md), [column chart](column-chart.md), or [area chart](area-chart.md). A list of other sections depends on the layer chart type you selected. |

## Creating a combined chart {#create-diagram}

To create a combined chart:

1. On the {{ datalens-full-name }} [home page]({{ link-datalens-main }}), click **Create chart**.
1. Under **Dataset**, select a dataset for visualization.
1. Select **Combined chart** as your chart type.
1. Drag a dimension from the dataset to the **X** section. The values are displayed in the lower part of the chart on the X-axis.
1. Select a layer chart type: linear chart ![](../../_assets/datalens/line.svg), column chart ![](../../_assets/datalens/column.svg), or area chart ![](../../_assets/datalens/area.svg). Rename the layer if needed.
1. Create a chart of the appropriate type:

   * [{#T}](line-chart.md#create-diagram)
   * [{#T}](column-chart.md#create-diagram)
   * [{#T}](area-chart.md#create-diagram)

1. Add a new layer. To do this, click ![](../../_assets/datalens/plus.svg) to the right of the layer name.
