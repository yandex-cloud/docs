# Stacked area chart ![](../../_assets/datalens/area.svg)

This chart shows how a measure changed over time. The area between the axis and the line is filled with colors, which shows the volume. If multiple data categories are displayed, they overlap. The top line represents all data.

It is handy to use this type of chart when it is important to see totals by category, e.g., total sales by product category.

![area-chart-groupped](../../_assets/datalens/visualization-ref/area-chart/area-chart-groupped.png)

{% cut "Source table" %}

Year |	Home appliances |	Household goods  | Household cleaners
----- | ---------| ---------- | ---------- 
January 2019|	128K |	55K | 26K
February 2019|	97K |	79K | 18K
March 2019|	187K |	105K | 41K
April 2019|	188K | 137K | 34K
May 2019|	230K |	121K | 43K
June 2019|	256K |	162K | 59K
July 2019|	284K |	206K | 67K
August 2019|	409K |	204K | 72K
September 2019|	314K |	209K | 86K
October 2019|	324K |	262K | 79K
November 2019|	385K |	238K | 101K
December 2019|	451K |	307K | 111K

{% endcut %}

Be careful selecting the measures when building your chart. For example, do not add the number of customers to the sales amount, or the purchase amount to the sales amount.

## Wizard sections {#wizard-sections}

Section<br/> section| Description
----- | ----
X | Dimension. You can specify only one field here. This dimension is usually a date. If this is the case, make sure to specify the `Date` data type for this field in the dataset. This is required for correct sorting and signature display. For better visualization, you can group dates into weeks, months, and years. For more information, see [{#T}](../concepts/chart/settings.md#field-settings).
Y | Measure. You can specify multiple measures. If you add more than one measure to a section, the **Colors** section will contain a dimension named [Measure Names](../concepts/chart/measure-values.md).
Colors | [Measure Names](../concepts/chart/measure-values.md) dimension or field. Affects the color of lines. To remove [Measure Names](../concepts/chart/measure-values.md), delete measures from the Y axis.
Sorting | Dimension or measure. You can use a dimension from the **X** and **Color** sections or a measure from the Y axis. This section affects the sorting of values on the X axis or areas along the Y axis. The sorting direction is marked with an icon next to the field: ![image](../../_assets/console-icons/bars-ascending-align-left.svg) for ascending or ![image](../../_assets/console-icons/bars-descending-align-left.svg) for descending. To change the sorting direction, click the icon.
Labels | Measure. Displays measure values on the chart. If multiple measures are added to the **Y** section, drag [Measure Values](../concepts/chart/measure-values.md) to this section. [Markup functions](../function-ref/markup-functions.md) are supported. For `String` type fields, you can configure using basic [{#T}](../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**.
Split | Dimension. Splits a chart horizontally by the selected dimension's values. The maximum number of splits per chart is 25.
Filters | Dimension or measure. Used as a filter.

## Creating an area chart {#create-diagram}

To create an area chart:


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![chart](../../_assets/console-icons/chart-column.svg) **Charts**.
1. Click **Create chart** → **Chart**.
1. At the top left, click ![image](../../_assets/console-icons/circles-intersection.svg) **Select dataset** and specify the dataset to visualize.
1. Select **Stacked area chart** as the chart type.
1. Drag a dimension from the dataset to the **X** section. The values will be displayed in the lower part of the chart on the X axis.
1. Drag one or more measures from the dataset to the **Y** section. The values will be displayed as areas along the Y axis.

### Configuring display of `null` values {#null-settings}

{% include [datalens-chart-null-settings](../../_includes/datalens/datalens-chart-null-settings.md) %}

## Recommendations {#recomendations}

* {% include [category-text](../../_includes/datalens/datalens-category-text.md) %}
* Do not display more than three to five areas on the chart.
* To make it easier to track the dynamics, place the largest or most important categories closer to the chart base. To do this, drag the measure to the **Sorting** section or set up their order in the **Y** section. For example, you can do so to track sales dynamics in the `Household cleaners` category.
  
  {% cut "Chart example" %}
  
  ![area-chart-sort](../../_assets/datalens/visualization-ref/area-chart/area-chart-sort.png)

  {% endcut %}

* You can split a chart by dimension into a number of small charts that are convenient to compare to one another. To do this, drag a dimension from the dataset to the **Split** section.

  {% cut "Chart example" %}

  ![area-chart-split](../../_assets/datalens/visualization-ref/area-chart/area-chart-split.png)

  {% endcut %}

#### See also {#see-also}

* [{#T}](../operations/dashboard/create.md)
* [{#T}](../operations/dashboard/add-chart.md)
* [{#T}](../operations/dashboard/add-selector.md)