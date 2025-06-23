# Column chart ![](../../_assets/datalens/column.svg)

This chart displays the values of one or more measures by period or category. The height of a column determines the measure value: the higher the column, the larger the value.
Unlike line charts, this type of chart assumes that different periods are compared directly and an emphasis is made on a measure's individual value rather than its general trend.

![bar-chart](../../_assets/datalens/visualization-ref/bar-chart/bar-chart.png)

{% cut "Source table" %}

Year |	Sales|	
-----|---------| 
2022|	6M |	
2021|	28M|	
2020|	18M |	
2019|	9M | 
2018|	1M |

{% endcut %}

## Types of column charts {#types}

* [Grouped](#groupped)
* [Stacked](#stacked)

### Grouped {#groupped}

A chart with grouping lets you compare two or more measures: for example, the number of products delivered and the number picked up. The column height corresponds to the measure value.

![bar-chart-groupped](../../_assets/datalens/visualization-ref/bar-chart/bar-chart-groupped.png)

{% cut "Source table" %}

Year |	Delivery|	Pickup
-----|---------| ----------|
2022|	2M |	4M
2021|	8M |	19M
2020|	5M |	13M
2019|	3M | 6M
2018|	331K |	918K

{% endcut %}

### Stacked {#stacked}

This chart depicts the ratio of internal segments by period or category. The segments are stacked one on top of the other, i.e., the base of the above segment is the top side of the one below.
Since the sum of all segments is equal to the overall column length, the stacked chart is used when you need to visualize the total column values.

![bar-chart-stacked](../../_assets/datalens/visualization-ref/bar-chart/bar-chart-stacked.png)

{% cut "Source table" %}

Year |	Delivery|	Pickup
-----|---------| ----------|
2022|	2M |	4M
2021|	8M |	19M
2020|	5M |	13M
2019|	3M | 6M
2018|	331K |	918K

{% endcut %}

## Wizard sections {#wizard-sections}

Wizard<br/> section| Description
----- | ----
X | Dimensions You can specify one or two dimensions. Affects X-axis value grouping. The order of specified dimensions affects the order of value grouping on the X-axis. For the `Date` and `Date and time` types, you can set grouping by time: minutes, hours, weeks, and so on.
Y | Measure. You can specify multiple measures. If you add more than one measure to a section, the **Colors** section will contain a dimension named [Measure Names](../concepts/chart/measure-values.md). 
Colors | Dimension, measure, [Measure Names or Measure Values](../concepts/chart/measure-values.md) field. Affects the column color. To delete `Measure Names` and `Measure Values`, click the ![image](../../_assets/datalens/cross.svg) icon or remove measures from the Y axis.
Sorting | Dimension or measure. Affects the column sorting. Sorting only applies to dimensions used when building a chart. The sorting direction is marked with an icon next to the field: ![image](../../_assets/console-icons/bars-ascending-align-left.svg) for ascending or ![image](../../_assets/console-icons/bars-descending-align-left.svg) for descending. To change the sorting direction, click the icon.
Labels | Measure. Displays measure values on the chart. When using multiple measures for a signature, add [Measure Values](../concepts/chart/measure-values.md). [Markup functions](../function-ref/markup-functions.md) are supported. For `String` type fields, you can configure using basic [{#T}](../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**.
Split | Dimension. Splits a chart horizontally by the selected dimension's values. The maximum number of splits per chart is 25.
Filters | Dimension or measure. Used as a filter. A filter can be overridden by a dashboard selector if the selector is based on the same field.

## Creating a column chart {#create-diagram}

To create a column chart:


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![chart](../../_assets/console-icons/chart-column.svg) **Charts**.
1. Click **Create chart** → **Chart in Wizard**.
1. At the top left, click ![image](../../_assets/console-icons/circles-intersection.svg) **Select dataset** and specify the dataset to visualize.
1. Select **Column chart** as the chart type.
1. Drag a dimension from the dataset to the **X** section. The values will be displayed in the lower part of the chart on the X axis.
1. Drag one or more measures from the dataset to the **Y** section. The values will be displayed as columns on the Y-axis.

{% note info %}

* By default, a stacked chart is displayed if you have more than one measure.
* To make a [grouped chart](#grouped-column-chart), use the **Colors** section for grouping.

{% endnote %}

### Creating a grouped column chart {#grouped-column-chart}

To display an X-axis grouped column chart:

1. Open a bar chart or [create](#create-diagram) a new one.
1. Depending on the number of measures in the **Y** section, follow these steps:

   {% list tabs group=indicators_number %}

    - Single measure {#one}

      1. Drag a dimension that you want to group the chart columns by to the **Color** section.
      1. Duplicate this dimension in the **X** section. The sequence of dimensions affects the grouping order.

      ![one-measure](../../_assets/datalens/visualization-ref/bar-chart/one-measure.png)

    - Two or more measures {#more}

      1. Drag the `Measure Names` dimension to the **Color** section.
      1. Drag the `Measure Names` dimension to the **X** section. The sequence of dimensions affects the grouping order.

      ![two-measures](../../_assets/datalens/visualization-ref/bar-chart/two-measures.png)

   {% endlist %}

### Adding a column color based on a measure {#column-colors}

To color columns in a chart based on the value of a measure:

1. Open a column chart or create a new one.
1. Depending on the number of measures in the **Y** section, follow the steps below:

   {% list tabs group=indicators_number %}

   - Single measure {#one}

     Copy the measure from the **Y** section to the **Colors** section.

     The colors of the columns in the chart will apply based on the measure values.

     ![image](../../_assets/datalens/operations/chart/column-colors-1.png)

   - Two or more measures {#more}

     Drag the `Measure Values` measure to the **Color** section.

     The colors of the columns in the chart will apply based on the values of all the measures listed in the **Y** section.

     ![image](../../_assets/datalens/operations/chart/column-colors-2.png)

   {% endlist %}

1. Configure a color gradient for the measure as well. To do so, in the top-right corner of the **Colors** section, click ![image](../../_assets/console-icons/gear.svg) (the icon is displayed when you hover over the section).
1. In the color settings, specify:

   * **Gradient type**: Select two or three colors.
   * Gradient color: Select a color palette for the gradient from the list.
   * Gradient direction: Change the gradient direction using the ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) icon.
   * **Set threshold values**: Set numeric thresholds for each color. Works if the **Y** section contains a single value.

### Adding column sorting by aggregated value {#column-aggregate-sorting}

In the **Sorting** section, you cannot use a value with [aggregation](../dataset/data-model.md#aggregation). To sort columns by an aggregated value (e.g., sum, count, or average), first create a [calculated field](../concepts/calculations/index.md) in the dataset or chart using the [aggregation formula](../function-ref/aggregation-functions.md). Then use it to build a chart and do the sorting.

For example, to sort your sales by total amount:

1. Open a column chart or create a new one.
1. On the left side of the screen above the list of dimensions and measures, click ![image](../../_assets/console-icons/plus.svg) and select **Field**.
1. In the **Field settings** window, enter:

   * Field name: `sum_Price`
   * Formula: `SUM([Price])`

1. Click **Create**.
1. Drag the new field to the **Y** and **Sorting** sections. The columns will be sorted by sales total. To change the sorting direction, in the **Sorting** section, click ![image](../../_assets/console-icons/bars-descending-align-left.svg) or ![image](../../_assets/console-icons/bars-ascending-align-left.svg) to the right of the field name.

![image](../../_assets/datalens/operations/chart/column-sorting.png)

### Configuring display of `null` values {#null-settings}

{% include [datalens-chart-null-settings](../../_includes/datalens/datalens-chart-null-settings.md) %}

## Recommendations {#recomentations}

* If category values contain a lot of text, try to make it shorter so that chart signatures look neater. You can use string functions in calculated fields or the `CASE` conditional statements.
* If each column is a category rather than a time value, consider sorting the columns in ascending or descending order of the measure. This will make your chart look better and more informative. Sorting may also be helpful inside each column's subcategories.
* We recommend using a column chart to display changes to a measure or measures over time. In this case, be careful when sorting values on the X-axis, because the user usually expects to see changes over time on the X-axis.
* When visualizing multiple measures, select colors carefully. They should be distinguishable and contrasting. We recommend using no more than 3-5 colors per chart. If you want to emphasize one certain measure above the others, highlight it in some bright color.
* You can split a chart by dimension into a number of small charts that are convenient to compare to one another. To do this, drag a dimension from the dataset to the **Split** section.

  {% cut "Chart example" %}

  ![bar-chart-split](../../_assets/datalens/visualization-ref/bar-chart/bar-chart-split.png)

  {% endcut %}

#### See also {#see-also}

* [{#T}](../operations/dashboard/create.md)
* [{#T}](../operations/dashboard/add-chart.md)
* [{#T}](../operations/dashboard/add-selector.md)