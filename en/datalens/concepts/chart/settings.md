# Chart settings

Charts are configurable. For example, you can choose to display a legend, customize a color scheme, or set your own title.

Available settings depend on the type of chart being configured.

## General settings {#common-settings}

General settings affect the overall display of charts.
To open general settings, click ![image](../../../_assets/console-icons/gear.svg) on the left side of the screen above the chart.

{% note warning %}

The settings specified below may not be available for some chart types.

{% endnote %}

#|
|| **Name** | **Description** ||
|| Header | Sets the header for the chart.<br/><br/>Possible values:

* **Hide**: Hide header.
* **Show**: Show header. You can enter the header text in the text field on the right. ||
|| Legend | Displays the legend below the chart. The legend contains chart colors with text descriptions referring to the field values in the **Colors** section.<br/><br/>Possible values:

* **Hide**: Hides the legend.
* **Auto**: Displays the legend if the field is specified in the **Colors** section. ||
|| Tooltip | Displays tooltips when hovering over a chart item.<br/><br/>Possible values:

* **On**: Shows the tooltip.
* **Off**: Hides the tooltip. ||
|| Sum in tooltips | Displays a sum in a tooltip when you hover over the chart display.<br/><br/>Possible values:

* **On**: Displays a sum in a tooltip.
* **Off**: Hides a sum in a tooltip. ||
|| Navigator | Displays an additional element below the chart, the navigator. Allows reducing a data selection displayed in the chart.<br/><br/>Possible values:

* **On**: Shows the navigator.
* **Off**: Hides the navigator.

For more information, see [this guide](../../operations/chart/config-chart-navigator.md). ||
|| Pagination | Breaks a table into pages.<br/><br/>Possible values:

* **On**: Displays the table part by part across a number of pages.
* **Off**: Displays the whole table. ||
|| Limit | Sets the number of rows to export. This is also the number of rows displayed per page. Available if **Pagination** is enabled. ||
|| Grouping | Displays unique field values.<br/><br/>Possible values:

* **On**: Displays unique values.
* **Off**: Displays all values. ||
|| Totals | Displays a row with total values for table columns. Values in the row are calculated using the same formulas as [aggregation](../../dataset/data-model.md#aggregation) in the measure.<br/><br/>Possible values:

* **On**: Shows the **Total** row.
* **Off**: Hides the **Total** row. ||
|| Stacking | Stacked or isolated data display for each category in the [area chart](../../visualization-ref/area-chart.md#stacking).<br/><br/>Possible values:

* **On**: Displays stacked data.
* **Off**: Displays unstacked data. ||
|#

## Field settings {#field-settings}

You can configure:

* Both dimensions and measures for [charts based on a dataset](./dataset-based-charts.md).
* Only measures for [QL charts](./ql-charts.md).

To open settings of a dimension or a measure, click the icon to the left of its name.

{% note info %}

If you apply an aggregation to the dimension, it will become a measure and the relevant settings will become available for it.

{% endnote %}

### Dimensions {#measure-settings}

#|
|| **Name** | **Description** ||
|| Name | Sets a dimension name. ||
|| Type | Sets the type of dimension data. ||
|| Grouping | Sets the type of grouping or rounding. The setting is only available for dimensions of the `Date` and `Date and time` type. ||
|| Format | Sets the format of how the values are displayed. ||
|| Date mode | Sets the date display mode. The setting is only available for dimensions of the `Date` and `Date and time` type.<br/><br/>Possible values:

* **Continuous**: Displays all dates continuously.
* **Discrete**: Displays dates that contain values. ||
|| Aggregation | Sets the aggregation type. Aggregation functions are available according to the [{#T}](../../dataset/data-model.md#aggregation) table. ||
|| Markdown | The field value will be formatted according to [{#T}](../../dashboard/markdown.md). Only available for `String` type fields. ||
|| Sub-totals | Shows columns and/or rows with subtotals. This setting is only available for [Pivot table](../../visualization-ref/pivot-table-chart.md) charts. ||
|#

### Measures {#indicator-settings}

#|
|| **Name** | **Description** ||
|| Name | Sets the measure name. ||
|| Type | Sets the type of measure data. Not available for [QL charts](./ql-charts.md). ||
|| Aggregation | Sets the aggregation type. Aggregation functions are available according to the [{#T}](../../dataset/data-model.md#aggregation) table. Not available for [QL charts](./ql-charts.md). ||
|| Markdown | The field value will be formatted according to [{#T}](../../dashboard/markdown.md). Only available for `String` type fields. ||
|| Format | Sets value display format. ||
|| Decimal places | Sets the number of decimal places. Not available for [QL charts](./ql-charts.md). ||
|| Display groups of thousands | Enables displaying groups of thousands for numeric values.<br/><br/>Possible values:

* **With separator**: Displays spaces between groups of thousands.
* **Merged**: Hide spaces between groups of thousands. ||
|| Prefix | Sets a text displayed before a value. ||
|| Postfix | Sets a text displayed after a value. ||
|| Dimension | Sets a rounding scale of values. ||
|#

## Section settings {#section-settings}

To open section settings, click ![image](../../../_assets/console-icons/gear.svg) in the row with the section name.

### Axes {#axis-settings}

Axis settings are only available for charts that have at least one X or Y axis:

* Line chart.
* Area chart (stacked and normalized).
* Column chart (including normalized).
* Bar chart (including normalized).
* Scatter chart.

You can configure settings for both the **X** and **Y** axes.

{% note warning %}

Some of these settings may not be available for some axes.

{% endnote %}

#|
|| **Name** | **Description** ||
|| Axis name | Sets an axis label.<br/><br/>Possible values:

* **On**: Use the field name. If the section contains multiple fields, {{ datalens-short-name }} uses the name of the field listed first.
* **Off**: No axis label displayed.
* **Manually**: Allows setting an axis name manually in a text field. ||
|| Axis type | Defines the axis type. This setting is available if fields in the axis section are of the `Fractional number` type.<br/><br/>Possible values:

* **Linear**: Use linear axis.
* **Logarithmic**: Use logarithmic axis. Suitable for charts with a large spread of values. The logarithmic axis allows you to display a fast-growing graph in a convenient form for analysis, reducing values by an order of magnitude. ||
|| Graph axis | This setting allows you to hide all axis elements: lines, labels, and grid.<br/><br/>Possible values:

* **Show**: Displays all axis elements.
* **Hide**: Hides all axis elements. ||
|| Display mode | Enables configuring continuous chart display.<br/><br/>Possible values:

* **Discrete**: Plots the chart only for non-null values.
* **Continuous**: Plots the chart for all values continuously. You can only use continuous mode for the `Integer`, `Fractional number`, `Date`, or `Date and time` data types. ||
|| Axis formatting | Sets the formatting of numerical axis labels.<br/><br/>Possible values:

* **Auto**: Default formatting.
* **By first field on the X axis**: Displays the X axis labels with the formatting specified in the **Format** setting for the first field in the **X** section. Available in the X axis settings.
* **By first field on the Y axis**: Displays the Y axis labels with the formatting specified in the **Format** setting for the first field in the **Y** section. Available in the Y axis settings. ||
|| Grid | Enables or disables grid display in a chart.<br/><br/>Possible values:

* **On**: Shows the grid.
* **Off**: Hides the grid. ||
|| Grid increments, px | Sets the grid increment in pixels. Available if **Grid** is enabled.<br/><br/>Possible values:

* **Auto**: Calculates grid size automatically.
* **Manually**: Requires manual input of grid size in pixels. ||
|| Labels | Shows or hides axis labels based on field values.<br/><br/>Possible values:

* **On**: Shows axis labels.
* **Off**: Hides axis labels. ||
|| Label appearance | Sets the way the labels are displayed. Available if the **Labels** setting is enabled.<br/><br/>Possible values:

* **Auto**: Displays axis labels.
* **Horizontal**: Displays axis labels horizontally.
* **Vertical**: Displays axis labels vertically.
* **Angled**: Displays axis labels at a 45-degree angle. ||
|| Null values | Allows you to select a method for handling null values.<br/><br/>Possible values:

* **Hide**: Hides null values in charts.
* **Connect**: Connects field values where there are null values in between.
* **Display as 0**: Displays null values in charts as zero (0) field values.
* **Use previous**: Replaces the chart's empty values with the value of the previous point on the axis. Available in the Y axis settings for the [area chart](../../visualization-ref/area-chart.md). ||
|| Scaling | Sets the chart axis scale.<br/><br/>Possible values:

* **Auto**: Enables autoscaling. You can specify how {{ datalens-short-name }} sets the scale: from 0 to the maximum field value (**Autoscale from 0 to max**) or from the minimum to the maximum field values (**Autoscale from min to max**).
* **Manually**: Requires manual input of the axis scale. You can set the maximum and minimum values along the axis. {{ datalens-short-name }} will trim the chart lines by this value. ||
|#

### Colors {#color-settings}

Generally, you can set a specific color for any graph value.

The following settings are available for a tree diagram, a table (including a pivot table), and a map:

#|
|| **Name** | **Description** ||
|| Gradient type | Sets the number of gradient colors.<br/><br/>Possible values:

* **Two-color**: Sets two colors for the gradient.
* **Tree-color**: Sets three colors for the gradient. ||
|| Color | Sets a color for a value. Available colors depend on the gradient type. ||
|| Set threshold values | Allows you to set threshold values that will refer to each color. ||
|| Borders | Sets borders for geopolygons.<br/><br/>Possible values:

* **Show**: Displays geopolygon borders.
* **Hide**: Hides geopolygon borders. ||
|#

You can [create color palettes](../../operations/chart/create-palette.md) and use them in your charts.

### Labels {#sign}

Labels display measure values on the chart. [Markup functions](../../function-ref/markup-functions.md) are supported. For `String` type fields, you can configure using basic [{#T}](../../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**.


Labels are available for the following charts types:

* Line chart.
* Area chart (stacked and normalized).
* Column chart (including normalized).
* Bar chart (including normalized).
* Pie chart.
* Map.

### Sorting {#sort}

Allows you to sort chart values by measure or dimension.

Sorting is available for the following chart types:

* Line chart.
* Area chart (stacked and normalized).
* Column chart (including normalized).
* Bar chart (including normalized).
* Pie chart.
* Table (including a Pivot table).

### Filters {#filter}

Filters allow you to make a selection of values by dimension or measure.
Filters are available for all chart types.


## Map section settings {#map-settings}

You can configure layers, point size and color, tooltips, and filters.
To open section settings, click ![image](../../../_assets/console-icons/gear.svg) in the row with the section name.

{% note warning %}

Depending on the visualization type, different settings are available.

{% endnote %}

#|
|| **Name** | **Description** ||
|| Disk | Sets point size depending on the measure value. ||
|| Colors | These set a color for geopoints and geopolygons depending on the measure value. ||
|| Tooltips | These create a tooltip displayed when you hover over a point. The tooltip contains dimension and measure values. For `String` type fields, you can configure using basic [{#T}](../../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**. ||
|| Layer filters | Create a selection by dimension or measure for the current layer. ||
|| General filters | Create a selection by dimension or measure for the whole chart. ||
|#

### Layers {#map-layer}

You can add up to five layers with any visualization types to a single map:

* Scatter chart: `Geopoints` dimension type.
* Choropleth map: `Geopolygons` dimension type.
* Heat map: `Geopoints (heat map)` dimension type.

You can delete and rename layers.

You can change the transparency of the current layer using the slider. You can also set transparency of a text field above the slider.

![slider](../../../_assets/datalens/chart-settings/01-alpha-slider.png)

Transparency can have a value from 0 to 100.

### Colors {#map-color}

You can set a color for geopoints and geopolygons, which will depend on the measure value.

#|
|| **Name** | **Description** ||
|| Gradient type | Sets the number of gradient colors.<br/><br/>Possible values:

* **Two-color**: Sets two colors for the gradient.
* **Tree-color**: Sets three colors for the gradient. ||
|| Borders | Sets borders for geopolygons.<br/><br/>Possible values:

* **Show**: Displays geopolygon borders.
* **Hide**: Hides geopolygon borders. ||
|| Color | Sets a color for geopoints and geopolygons. Available colors depend on the gradient type. ||
|| Set threshold values | It allows you to set threshold values that will refer to each color. ||
|#

You can [create color palettes](../../operations/chart/create-palette.md) and use them in your charts.


## Undoing and redoing changes in charts {#undo-redo}

When editing a chart in the wizard or a [QL chart](./ql-charts.md), you can now undo/redo any change introduced within the current version:

* To undo changes, click ![image](../../../_assets/console-icons/arrow-uturn-ccw-left.svg) in the top-right corner of the screen or press **Ctrl** (**Cmd**) + **Z**.
* To redo changes, click ![image](../../../_assets/console-icons/arrow-uturn-cw-right.svg) or press **Ctrl** (**Cmd**) + **Shift** + **Z**.

Unsaved changes in the current version are reset:

* When refreshing the page.
* When saving a chart.
* When switching to another [version](./versioning.md).