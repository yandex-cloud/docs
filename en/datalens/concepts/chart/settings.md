# Chart settings

Charts can be configured. For example, you can choose to display a legend, customize a color scheme, or set your own title.

Available settings depend on the type of chart being configured.

## General settings {#common-settings}

General settings affect the overall display of charts.
To open general settings, click ![image](../../../_assets/datalens/gear.svg) to the left of the screen above the chart.

{% note warning %}

The availability of individual settings depends on the chart type.

{% endnote %}

| Name | Description |
----- | -----
| Header | Sets a chart header.<br/><br/>Possible values:<br/>**Hide**: Hides a header.<br/>**Show**: Displays a header. In the text field on the right, you can enter the header text. |
| Legend | Displays a legend below the chart. A legend contains chart colors with text descriptions that correspond to field values in the **Colors** section.<br/><br/>Possible values:<br/>**Hide**: Hides a legend.<br/>**Auto**: Displays a legend if the field is specified in the **Colors** section. |
| Sum in tooltips | Displays a sum in a tooltip when you hover over the chart display.<br/><br/>Possible values:<br/>**On**: Displays a sum in a tooltip.<br/>**Off**: Hides a sum in a tooltip. |
|  |
| Navigator | Displays the navigator as an additional element below the chart. It helps reduce a selection of data displayed in the chart.<br/><br/>Possible values:<br/>**On**: Displays the navigator.<br/>**Off**: Hides the navigator.<br/>To learn more, see the [instructions](../../operations/chart/config-chart-navigator.md). |
| Pagination | Splits a table into pages.<br/><br/>Possible values:<br/>**On**: Breaks a table in parts across pages.<br/>**Off**: Displays an entire table. |
| Limit | Sets the number of rows to export. Also, this is the number of rows displayed per page. The setting is available if the **Pagination** setting is enabled. |
| Grouping | Displays unique field values.<br/><br/>Possible values:<br/>**On**: Display unique values.<br/>**Off**: Display all values. |
| Totals | Displays a row with total values for table columns. Values in a row are calculated using the same formulas as [aggregation](../dataset/data-model.md#aggregation) in a measure.<br/><br/>Possible values:<br/>**On**: Display the **Total** row.<br/>**Off**: Hide the **Total** row. |

## Field settings {#field-settings}

You can configure dimensions and measures.
To open settings of a dimension or a measure, click the icon to the left of its name.

{% note info %}

If you apply aggregation to a dimension, it acts as a measure and the measure settings become available.

{% endnote %}

### Dimensions {#measure-settings}

| Name | Description |
----- | -----
| Name | Sets a dimension name. |
| Type | Sets the type of dimension data. |
| Grouping | Sets the type of grouping or rounding. The setting is only available for dimensions of the **Date** and **Date and time** type. |
| Format | Sets the format of the value display. |
| Date mode | Sets the date display mode. The setting is only available for dimensions of the **Date** and **Date and time** type.<br/><br/>Possible values:<br/>**Continuous**: Display all dates continuously.<br/>**Discrete**: Display dates that contain values. |
| Aggregation | Sets the aggregation type. Aggregation functions are available according to the table [{#T}](../dataset/data-model.md#aggregation). |

### Measures {#indicator-settings}

| Name | Description |
----- | -----
| Name | Sets the measure name. |
| Type | Sets the type of measure data. |
| Aggregation | Sets the aggregation type. Aggregation functions are available according to the table [{#T}](../dataset/data-model.md#aggregation). |
| Format | Sets the format of the value display. |
| Decimal places | Sets the number of characters displayed after the decimal point in a value. |
| Display groups of thousands | Allows you to display groups of thousands for numeric values.<br/><br/>Possible values:<br/>**With separator**: Display spaces between groups of thousands.<br/>**Merged**: Hide spaces between groups of thousands. |
| Prefix | Sets a text displayed before a value. |
| Postfix | Sets a text displayed after a value. |
| Data type | Sets a rounding scale of values. |

## Section settings {#section-settings}

To open section settings, click ![image](../../../_assets/datalens/gear.svg) in a row with the section name.

### Axes {#axis-settings}

Axis settings are only available for charts that have at least one X or Y axis:
- Line chart
- Area chart (Stacked and Normalized)
- Column chart (including a Normalized column chart)
- Bar chart (including a Normalized bar chart)
- Scatter chart

You can configure settings for both the **X** and **Y** axes.

{% note warning %}

Not all of these settings are available for all axes.

{% endnote %}

| Name | Description |
----- | -----
| Axis name | Sets an axis label.<br/><br/>Possible values:<br/>**Auto**: Uses a field name. If the section contains several fields, {{ datalens-short-name }} uses the name of the field specified first in the list.<br/>**Manually**: Allows you to set an axis name manually in a text field.<br/>**Off**: No axis label. |
| Grid | Displays a grid on the chart.<br/><br/>Possible values:<br/>**On**: Displays a grid.<br/>**Off**: Hides a grid. |
| Grid increments, px | Sets the grid increment in pixels.<br/>The setting is available if the **Grid** setting is enabled.<br/><br/>Possible values:<br/>**Auto**: Calculates the grid size automatically.<br/>**Manually**: Allows you to set the grid size in pixels. |
| Hide labels | Hides axis labels that correspond to the field values.<br/><br/>Possible values:<br/>**Yes**: Hides axis labels.<br/>**No**: Displays axis labels. |
| Label appearance | Sets the appearance of the label display. The setting is available if the **Hide labels** setting is set to **No**.<br/><br/>Possible values:<br/>**Auto**: Displays label values.<br/>**Horizontal**: Displays label values horizontally.<br/>**Vertical**: Displays label values vertically.<br/>**At angle**: Displays label values at a 45-degree angle. |
| Empty displays (null) | Sets the method of processing empty values.<br/><br/>Possible values:<br/>**Do not display**: Does not display empty values in a chart.<br/>**Join**: Joins values of fields that have empty values between them.<br/>**Display as 0**: Displays empty values in charts as zero (0) field values. |
| Scaling | Sets the scale of chart axes.<br/><br/>Possible values:<br/>**Auto**: Sets the scale automatically. You can specify how {{ datalens-short-name }} sets the scale: from 0 to the maximum field value (**Autoscale from 0 to max**) or from the minimum to the maximum field values (**Autoscale from min to max**). <br/>**Manually**: Allows you to set the axis scale manually. You can set the maximum and minimum values along the axis. {{ datalens-short-name }} trims the chart lines by this value. |
| Axis type | Sets the axis type. The setting is available if fields in the axis section are of the **Fractional number** type.<br/><br/>Possible values:<br/>**Linear**: Sets a linear axis.<br/>**Logarithmic**: Sets a logarithmic axis. Use it for charts with a large range of values. A logarithmic axis allows you to display a fast-growing graph in a convenient form for analysis, reducing values by an order of magnitude. |

### Color {#color-settings}

Generally, you can set a specific color for any graph value.

The following settings are available for a tree diagram, a table (including a pivot table), and a map:

| Name | Description |
----- | -----
| Gradient type | Sets the number of colors used in a gradient.<br/><br/>Possible values:<br/>**Two-color**: Sets two colors for a gradient.<br/>**Tri-color**: Sets three colors for a gradient. |
| Color | Sets a color for a value. Available colors depend on the gradient type. |
| Set threshold values | Allows you to set threshold values that will correspond to each color. |
| Borders | Sets borders for geopolygons.<br/><br/>Possible values:<br/>**Show**: Display geopolygon borders.<br/>**Hide**: Hide geopolygon borders. |

### Labels {#sign}

Display a measure value on the chart.

Labels are available for the following charts types:
- Line chart
- Area chart (Stacked and Normalized)
- Column chart (including a Normalized column chart)
- Bar chart (including a Normalized bar chart)
- Pie chart
- Map

### Sorting {#sort}

Allows you to sort chart values by measure or dimension.

Sorting is available for the following chart types:
- Line chart
- Area chart (Stacked and Normalized)
- Column chart (including a Normalized column chart)
- Bar chart (including a Normalized bar chart)
- Pie chart
- Table (including a Pivot table)

### Filters {#filter}

They allow making a selection of values by dimension or measure.
Filters are available for all chart types.

## Map section settings {#map-settings}

You can configure layers, point size and color, tooltips, and filters.
To open section settings, click ![image](../../../_assets/datalens/gear.svg) in a row with the section name.

{% note warning %}

Depending on the visualization type, different settings are available.

{% endnote %}

| Name | Description |
----- | -----
| Size | Sets a point size depending on the measure value. |
| Colors | Sets a color for geopoints and geopolygons depending on the measure value. |
| Tooltips | Show a small hint that will be displayed when you hover over a point. The hint contains dimension and measure values. |
| Layer filters | They allow making a selection for the current layer by dimension or measure. |
| General filters | They allow making a selection of values for the entire chart by dimension or measure. |

### Layers {#map-layer}

You can add up to 5 layers with any visualization types to a single map:
- Scatter chart: **Geopoints** dimension type.
- Choropleth map: **Geopolygons** dimension type.
- Heat map: **Geopoints (heat map)** dimension type.

Layers can be deleted and renamed.

You can change the transparency of the current layer using the slider. You can also set transparency of a text field above the slider.

![slider](../../../_assets/datalens/chart-settings/01-alpha-slider.png)

Transparency can have a value from 0 to 100.

### Colors {#map-color}

You can set a color for geopoints and geopolygons, which will depend on the measure value.

| Name | Description |
----- | -----
| Gradient type | Sets the number of colors used in a gradient.<br/><br/>Possible values:<br/>**Two-color**: Sets two colors for a gradient.<br/>**Tri-color**: Sets three colors for a gradient. |
| Borders | Sets borders for geopolygons.<br/><br/>Possible values:<br/>**Show**: Display geopolygon borders.<br/>**Hide**: Hide geopolygon borders. |
| Color | Sets a color for geopoints and geopolygons. Available colors depend on the gradient type. |
| Set threshold values | Allows you to set threshold values that will correspond to each color. |