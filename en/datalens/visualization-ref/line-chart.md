---
title: Line chart in {{ datalens-full-name }}
description: In this tutorial, you will learn how to create and customize the line chart visualization type in {{ datalens-full-name }}.
---

# Line chart ![](../../_assets/datalens/line.svg) in {{ datalens-full-name }}

The chart shows how one or more measures change over a period of time. The chart line connects points with coordinates (X, Y).

### What you can observe

The chart depicts trends, seasonal patterns, dynamics, and relationships between multiple measures at a the same point in time.

Multiple measures can be drawn using different lines on the same chart. For example, the basic sales targets, optimistic sales targets, and actual sales can be represented as a dotted, dashed, and solid line, respectively.

{% list tabs %}

- Line chart 

  ![line-chart-plan](../../_assets/datalens/visualization-ref/line-chart/line-chart-plan.png =800x)

- Source table

  Year |	Sales |	Basic targets |	Optimistic targets
  ----- | --------- | --------- | --------- 
  January 2019|	209K |	200K |	210K
  February 2019|	194K |	205K |	220K
  March 2019|	333K |	250K |	280K
  April 2019|	359K | 260K |	290K
  May 2019|	394K |	270K |	300K
  June 2019|	477K |	300K |	350K
  July 2019|	557K |	350K |	400K
  August 2019|	685K |	400K |	450K
  September 2019|	609K |	500K |	550K
  October 2019|	665K |	530K |	570K
  November 2019|	724K |	600K |	670K
  December 2019|	869K |	700K |	800K

{% endlist %}

### Extra options

* **Additional axes**

  When measure values vary greatly, you can use separate Y-axes for each measure.

  {% cut "Example" %}

  {% list tabs %}

  - Sales and customer count chart

    ![line-chart-2measures-2y](../../_assets/datalens/visualization-ref/line-chart/line-chart-2measures-2y.png =800x)

  - Source table

    | Year | Sales | Number of customers |
    | ----- | ----- | ----- |
    | January 2019 | 298,450 | 64 |
    | February 2019 |498,052 | 84 |
    | March 2019 | 629,201 | 99 |
    | April 2019 | 895,075 | 147 |
    | May 2019 | 998,557 | 166 |
    | June 2019 | 1,050,330 | 161 |
    | July 2019 | 1,350,246 | 244 |
    | August 2019 | 1,452,550 | 255 |
    | September 2019 | 1,716,182 | 273 |
    | October 2019 | 1,670,980 | 300 |
    | November 2019 | 1,743,450 | 326 |
    | December 2019 | 1,935,377 | 345 |

  {% endlist %}

  {% endcut %}


* **Additional categories**

  The chart allows you to compare several categories based on the same measure. Each category has a line of a different color or shape.

  {% cut "Example" %}

  {% list tabs %}

  - Total sales for different product categories

    ![line-chart-groupped](../../_assets/datalens/visualization-ref/line-chart/line-chart-groupped.png =800x)

  - Source table

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

  {% endlist %}

  {% endcut %}

* **Points instead of lines**

  If using single values on the X-axis, you will see nothing but points on the chart. This may happen due to [filtering](../dashboard/chart-chart-filtration.md).

  {% cut "Example" %}

  {% list tabs %}

  - Individual points

    ![line-chart-single-values](../../_assets/datalens/visualization-ref/line-chart/line-chart-single-values.png =800x)

  - Source table

    Year | Home appliances | Household goods | Household cleaners
    ----- | ---------| ---------- | ---------- 
    2018 | 25K | 21K | 16K

  {% endlist %}

  {% endcut %}


## Wizard sections {#wizard-sections}

Wizard<br/> section| Description
----- | ----
X | Dimension. You can specify only one field here. This dimension is usually a date. If this is the case, make sure to specify the `Date` data type for this field in the dataset. This is required for correct sorting and signature display. For better visualization, you can group dates into weeks, months, and years. For more information, see [{#T}](../concepts/chart/settings.md#field-settings).
Y | Measure. You can specify multiple measures.<br/>If you add more than one measure to a section, the **Colors** section will contain a dimension named [Measure Names](../concepts/chart/measure-values.md).
Y2 | Measure. Use it to add a second Y axis to a chart. You can specify multiple measures.<br/>If you add more than one measure to a section, the **Colors** section will contain a dimension named [Measure Names](../concepts/chart/measure-values.md).
Colors | [Measure Names](../concepts/chart/measure-values.md) dimension or field. Affects the color of lines. To delete [Measure Names](../concepts/chart/measure-values.md), click the cross icon or remove measures from the Y axis.
Forms | [Measure Names](../concepts/chart/measure-values.md) dimension or field. Affects the shape of lines.
Sorting | Dimension or measure. Affects the sorting of the X axis. Sorting only applies to dimensions used when building a chart. The sorting direction is marked with an icon next to the field: ![image](../../_assets/console-icons/bars-ascending-align-left.svg) for ascending or ![image](../../_assets/console-icons/bars-descending-align-left.svg) for descending. To change the sorting direction, click the icon.
Labels | Measure. Displays measure values on the chart. If multiple measures are added to the **Y** or **Y2** section, drag [Measure Values](../concepts/chart/measure-values.md) to this section. [Markup functions](../function-ref/markup-functions.md) are supported. For `String` type fields, you can configure using basic [{#T}](../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**.
Split | Dimension. Splits a chart horizontally by the selected dimension's values. The maximum number of splits per chart is 25.
Filters | Dimension or measure. Used as a filter.

## Creating a line chart {#create-diagram}

To create a line chart:


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. {% include [create-1](../../_includes/datalens/visualization-ref/create-1.md) %}
1. {% include [create-2](../../_includes/datalens/visualization-ref/create-2.md) %}
1. {% include [create-3](../../_includes/datalens/visualization-ref/create-3.md) %}
1. {% include [create-4](../../_includes/datalens/visualization-ref/create-4.md) %}
1. Select **Line chart** as your chart type.
1. Drag a dimension from the dataset to the **X** section. The values will be displayed in the lower part of the chart on the X axis.
1. Drag one or more measures from the dataset to the **Y** section. The values will be displayed as a chart on the Y axis.
1. Drag one or more measures from the dataset to the **Y2** section. The values will be displayed as a chart on the second Y axis.
1. Drag a dimension to the **Color** section. The measure value is divided by color depending on the selected dimension.
1. Drag a dimension or measure from the dataset to the **Filters** section. The field can be empty. In this case, no filters are applied.

### Configuring display of `null` values {#null-settings}

{% include [datalens-chart-null-settings](../../_includes/datalens/datalens-chart-null-settings.md) %}

## Recommendations {#recomendations}

* **Scale.** The line chart data perception depends on its proportions.

  The lines may look steeper (rising or falling sharply) if the chart is compressed over a small segment. If the chart covers a longer segment, the lines appear smoother because the chart is stretched out. 

  {% cut "Example" %}

  {% list tabs %}

  - Steep

    ![line-chart-proportions](../../_assets/datalens/visualization-ref/line-chart/line-chart-proportions-1.png =400x)

  - Smoother

    ![line-chart-proportions](../../_assets/datalens/visualization-ref/line-chart/line-chart-proportions-2.png =400x)

  {% endlist %}

  {% endcut %}
  
  For a closer look at the chart, make the axis longer.

* **Labels.** Use labels to display measure values on the chart. To display values on the chart, drag a measure from the dataset to the **Labels** section.

  {% cut "Chart example" %}

  ![line-chart-signatures-1](../../_assets/datalens/visualization-ref/line-chart/line-chart-signatures-1.png =800x)

  {% endcut %}

  If multiple measures are added to the **Y** or **Y2** section, drag [Measure Values](../concepts/chart/measure-values.md) to this section.

  {% cut "Chart example" %}

  ![line-chart-signatures-2](../../_assets/datalens/visualization-ref/line-chart/line-chart-signatures-2.png =800x)

  {% endcut %}

  You can also sign only the last value on the chart by adding a calculated field with the `MAX` function. For more information, see [Demo dashboard](https://datalens.yandex/9fms9uae7ip02?tab=Are).

* {% include [category-text](../../_includes/datalens/datalens-category-text.md) %}

* **Colors.** For multiple measures, choose distinguishable and contrasting colors. Using more than 3-5 colors can make the chart harder to read.
  To highlight one measure, select the brightest color for it.

* Disable the **Sum in tooltips** option in the [chart settings](../concepts/chart/settings.md#common-settings) if the chart lines represent different entities. For example, the sales amount and the number of customers.
  
* {% include [split](../../_includes/datalens/visualization-ref/split.md) %}

  {% cut "Chart example" %}

  ![line-chart-split](../../_assets/datalens/visualization-ref/line-chart/line-chart-split.png =800x)

  {% endcut %}

* For better visualization, use formatting in the [dimension](../concepts/chart/settings.md#measure-settings) and [measure](../concepts/chart/settings.md#indicator-settings) setup window.
  Check the data type for correct sorting and comparison of values. Specify additional parameters. 

  For example, the format and units for numeric data and the number of decimal places for fractions.
  
  {% cut "Example of measure settings" %}
  
  ![line-chart-measure-settings](../../_assets/datalens/visualization-ref/line-chart/line-chart-measure-settings.png =800x)

  {% endcut %}



## Use cases {#examples}

* [{#T}](../tutorials/datalens.md)


{% include [see-also](../../_includes/datalens/visualization-ref/see-also-sub.md) %}