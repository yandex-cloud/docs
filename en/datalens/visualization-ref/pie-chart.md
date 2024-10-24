# Pie chart ![](../../_assets/datalens/pie.svg)

This chart shows a proportional relationship of different categories to a total using circle segments (sectors). The entire circle area is 100% and corresponds to the sum of all categories. The area of each segment corresponds to the percentage of a category in the total amount. Pie charts are a good choice for demonstrating proportions of a small number of segments.

![pie-chart](../../_assets/datalens/visualization-ref/pie-chart/pie-chart.png)

{% cut "Source table" %}

Product categories | Sales |	
-----|---------| 
Home appliances | 69М |
Household goods | 57М |
Household cleaners | 44М |

{% endcut %}

## Wizard sections {#wizard-sections}

Wizard<br/> section| Description
----- | ----
Color | Dimension. You can only specify one field here.
Measures | Measure. You can only specify one field here.
Sorting | Measure or dimension from the **Color** section. Affects area sorting. The sorting direction is marked with an icon next to the field: ![image](../../_assets/console-icons/bars-ascending-align-left.svg) for ascending or ![image](../../_assets/console-icons/bars-descending-align-left.svg) for descending. To change the sorting direction, click the icon.
Labels | Measure. Displays measure values on the chart. To add callouts with category names to the chart, drag the [Measure Names](../concepts/chart/measure-values.md) dimension to this section. [Markup functions](../function-ref/markup-functions.md) are supported. For `String` type fields, you can configure using basic [{#T}](../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**.
Filters | Dimension or measure. Used as a filter.

## Creating a pie chart {#create-diagram}

To create a pie chart:


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![chart](../../_assets/console-icons/chart-column.svg) **Charts**.
1. Click **Create chart** → **Chart**.
1. At the top left, click ![image](../../_assets/console-icons/circles-intersection.svg) **Select dataset** and specify the dataset to visualize.
1. Select **Pie chart** as the chart type.
1. Drag a dimension from the dataset to the **Color** section.
1. Drag a measure from the dataset to the **Measures** section. The values will be displayed as pie chart areas.

## Recommendations {#recommendations}

* If there are more than 4-6 segments per chart, group the smallest of them as **Other**. A larger number of segments overloads a chart and makes it difficult to understand the data.
* You cannot display negative and null values on this type of chart.
* Do not use pie charts to show changes to proportions over time or for precisely comparing data by category.