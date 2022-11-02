# Line chart ![](../../_assets/datalens/line.svg)

This chart displays a change to one or more measures over a time interval. It indicates trends, seasonality, dynamics, and a ratio of multiple measures in a single point in time. A chart is built using points with (X, Y) coordinates that are then connected by a line.

It can show multiple measures with different lines. For example, the basic sales targets, optimistic sales targets, and actual sales can be represented as a dotted, dashed, and solid line, respectively.

![line-chart-plan](../../_assets/datalens/visualization-ref/line-chart/line-chart-plan.png)

{% cut "Source table" %}

| Year | Sales | Basic targets | Optimistic targets |
----- | --------- | --------- | --------- 
| January 2019 | 209K | 200K | 210К |
| February 2019 | 194К | 205К | 220К |
| March 2019 | 333К | 250К | 280К |
| April 2019 | 359К | 260К | 290К |
| May 2019 | 394К | 270К | 300K |
| June 2019 | 477К | 300K | 350K |
| July 2019 | 557K | 350K | 400K |
| August 2019 | 685K | 400K | 450K |
| September 2019 | 609K | 500K | 550K |
| October 2019 | 665K | 530K | 570К |
| November 2019 | 724К | 600K | 670К |
| December 2019 | 869К | 700К | 800К |

{% endcut %}

If measure values differ significantly, you can place them on different Y axes. In this case, the values of each measure will be plotted on their own axis. For example, a chart for sales and customer count.

![line-chart-2measures-2y](../../_assets/datalens/visualization-ref/line-chart/line-chart-2measures-2y.png)

{% cut "Source table" %}

| Year | Sales | Number of customers |
| ----- | ----- | ----- |
| January 2019 | 298450 | 64 |
| February 2019 | 498052 | 84 |
| March 2019 | 629201 | 99 |
| April 2019 | 895075 | 147 |
| May 2019 | 998557 | 166 |
| June 2019 | 1050330 | 161 |
| July 2019 | 1350246 | 244 |
| August 2019 | 1452550 | 255 |
| September 2019 | 1716182 | 273 |
| October 2019 | 1670980 | 300 |
| November 2019 | 1743450 | 326 |
| December 2019 | 1935377 | 345 |

{% endcut %}

This chart lets you compare multiple categories by a single measure. Each category's line has its own color and form. For example, the sales amount for different product categories.

![line-chart-groupped](../../_assets/datalens/visualization-ref/line-chart/line-chart-groupped.png)

{% cut "Source table" %}

| Year | Home appliances | Household goods | Household cleaners |
----- | ---------| ---------- | ---------- 
| January 2019 | 128К | 55К | 26К |
| February 2019 | 97К | 79К | 18К |
| March 2019 | 187К | 105К | 41К |
| April 2019 | 188К | 137К | 34К |
| May 2019 | 230K | 121К | 43K |
| June 2019 | 256K | 162K | 59K |
| July 2019 | 284K | 206K | 67K |
| August 2019 | 409K | 204K | 72K |
| September 2019 | 314K | 209K | 86K |
| October 2019 | 324K | 262К | 79К |
| November 2019 | 385К | 238К | 101К |
| December 2019 | 451К | 307К | 111К |

{% endcut %}

## Sections in the wizard {#wizard-sections}

| Section<br/> in the wizard | Description |
----- | ----
| X | Dimension. Only one field can be specified. This dimension is usually a date. In this case, make sure that the `Date` data type is specified for this field in the dataset. This is required for correct sorting and signature display. For better visualization, you can group dates into weeks, months, and years (to learn more, see [{#T}](../concepts/chart/settings.md#field-settings)). |
| Y | Measure. You can specify multiple measures.<br/>If you add more than one measure to a section, the **Colors** section contains a dimension named [Measure Names](../concepts/chart/measure-values.md). |
| Y2 | Measure. Use it to add a second Y-axis to a chart. You can specify multiple measures.<br/>If you add more than one measure to a section, the **Colors** section contains a dimension named [Measure Names](../concepts/chart/measure-values.md). |
| Colors | Dimension or the [Measure Names](../concepts/chart/measure-values.md) field. Affects the color of lines. [Measure Names](../concepts/chart/measure-values.md) is deleted by clicking the cross icon or removing measures from the Y-axis. |
| Shapes | Dimension or the [Measure Names](../concepts/chart/measure-values.md) field. Affects the shape of lines. |
| Sorting | Dimension. Can only use one dimension from the X-axis. Affects the sorting of the X-axis. |
| Signatures | Measure. Displays measure values on the chart. If multiple measures are added to the **Y** or **Y2** section, drag [Measure Values](../concepts/chart/measure-values.md) to this section. |
| Chart filters | Dimension or measure. Used as a filter. |

## Creating a line chart {#create-diagram}

To create a line chart:

1. On the {{ datalens-full-name }} [home page]({{ link-datalens-main }}), click **Create chart**.
1. Under **Dataset**, select a dataset for visualization.
1. Select **Line chart** as your chart type.
1. Drag a dimension from the dataset to the **X** section. The values are displayed in the lower part of the chart on the X-axis.
1. Drag one or more measures from the dataset to the **Y** section. The values are displayed as a chart on the Y-axis.
1. Drag one or more measures from the dataset to the **Y2** section. The values are displayed as a chart on the second Y-axis.
1. Drag a dimension to the **Colors** section. The measure value is divided by color depending on the selected dimension.
1. Drag a dimension or measure from the dataset to the **Filters** section. The field can be empty. In this case, no filters are applied.

### Configuring the display of `null` values {#null-settings}

{% include [datalens-chart-null-settings](../../_includes/datalens/datalens-chart-null-settings.md) %}

## Recommendations {#recomendations}

* The perception of data on a line chart depends on its proportions. An upward or downward trend may intensify if the chart is contracted and be less evident if it's spread.

  {% cut "Chart examples" %}

  ![line-chart-proportions](../../_assets/datalens/visualization-ref/line-chart/line-chart-proportions.png)

  {% endcut %}

* {% include [category-text](../../_includes/datalens/datalens-category-text.md) %}
* When visualizing multiple measures, select colors carefully. They should be distinguishable and contrasting. We recommend using no more than 3-5 colors per chart. If you want to emphasize one certain measure above the others, highlight it in some bright color.
* Disable the **Sum in tooltips** option in the [chart settings](../concepts/chart/settings.md#common-settings) if the chart lines represent different entities. For example, the sales amount and the number of customers.
* Sign measure values on the chart. To do this, drag a measure from the dataset to the **Signatures** section. The chart will display its values.

  {% cut "Chart example" %}

  ![line-chart-signatures-1](../../_assets/datalens/visualization-ref/line-chart/line-chart-signatures-1.png)

  {% endcut %}

  If multiple measures are added to the **Y** or **Y2** section, drag [Measure Values](../concepts/chart/measure-values.md) to this section.

  {% cut "Chart example" %}

  ![line-chart-signatures-2](../../_assets/datalens/visualization-ref/line-chart/line-chart-signatures-2.png)

  {% endcut %}

  You can also sign the last value on the chart only. To do this, add a calculated field with the `MAX` function. For more information, see [Demo dashboard](https://datalens.yandex/9fms9uae7ip02?tab=Are).

* For better visualization, use formatting in the [dimension](../concepts/chart/settings.md#measure-settings) and [measure](../concepts/chart/settings.md#indicator-settings) setup window. Check the data type for correct sorting and comparison of values. Specify additional parameters. For example, the format and units for numeric data and the number of decimal places for fractions.

  {% cut "Sample measure settings" %}

  ![line-chart-measure-settings](../../_assets/datalens/visualization-ref/line-chart/line-chart-measure-settings.png)

  {% endcut %}
