# Donut chart ![](../../_assets/datalens/ring.svg)

This chart shows the proportion of different categories using ring segments. The sum of all segments is 100%. The size of each segment matches the percentage of a category in the total amount. A number in the center of a ring depends on the selected measure and indicates the overall total. Donut charts are a good choice if you need to display a small number of segments.

![ring-chart](../../_assets/datalens/visualization-ref/ring-chart/ring-chart.png)

{% cut "Source table" %}

Year |	Sales|	
-----|---------| 
2022 |	6M |	
2021 |	28M |	
2020 |	18M |	
2019 |	9M | 
2018 |	1M |

{% endcut %}

## Wizard sections {#wizard-sections}

Wizard<br/> section| Description
----- | ----
Color | Dimension. You can specify only one field here.
Measures | Affects the size of ring segments. You can specify only one field here. The total value of a measure is displayed in the center of a ring. Calculations using [LOD expressions](../concepts/lod-aggregation.md), [window functions](../function-ref/window-functions.md), and [time series functions](../function-ref/time-series-functions.md) are not presented in the total value.
Sorting | Measure or dimension from the **Color** section. Affects segment sorting. The sorting direction is marked with an icon next to the field: ![image](../../_assets/console-icons/bars-ascending-align-left.svg) for ascending or ![image](../../_assets/console-icons/bars-descending-align-left.svg) for descending. To change the sorting direction, click the icon.
Labels | Measure. Displays measure values on the chart. To add callouts with category names to the chart, drag the [Measure Names](../concepts/chart/measure-values.md) dimension to this section. [Markup functions](../function-ref/markup-functions.md) are supported. For `String` type fields, you can configure using basic [{#T}](../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**.
Filters | Dimension or measure. Used as a filter.

## Creating a donut chart {#create-diagram}

To create a donut chart:


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![chart](../../_assets/console-icons/chart-column.svg) **Charts**.
1. Click **Create chart** → **Chart**.
1. At the top left, click ![image](../../_assets/console-icons/circles-intersection.svg) **Select dataset** and specify the dataset to visualize.
1. Select **Donut chart** as the chart type.
1. Drag a dimension or measure from the dataset to the **Color** section.
1. Drag a measure from the dataset to the **Measures** section. The values will be displayed as donut chart segments.

To disable displaying a number in the center:

1. In the top-left part of the screen, click ![image](../../_assets/console-icons/gear.svg).
1. In the **Chart settings** window, disable the **Results** option.
1. Click **Apply**.

## Recommendations {#recommendations}

* If there are more than 4-6 segments per chart, group the smallest of them as **Other**. A larger number of segments overloads a chart and makes it difficult to understand the data.
* You cannot display negative and null values on this type of chart.
* Do not use donut charts to show changes to proportions over time or for precisely comparing data by category.

#### See also {#see-also}

* [{#T}](../operations/dashboard/create.md)
* [{#T}](../operations/dashboard/add-chart.md)
* [{#T}](../operations/dashboard/add-selector.md)