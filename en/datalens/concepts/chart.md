# Charts

_Charts_ are the visualization of data from a dataset in the form of a table, diagram, or map.

Charts are created in a [wizard](https://datalens.yandex.com/wizard/) based on data from a dataset.
You can create an unlimited number of charts based on a single dataset.

The workspace in the wizard interface is divided into three main panels:

1. A dataset panel where available fields are displayed: **Dimensions** and **Measures**. You can add a [calculated field](calculations.md) to the list.
1. A visualization setup panel where you can select the chart type. Each type has its own set of sections (such as X-axis, Y-axis, and filters) where you can drag and drop fields.
1. A preview panel where the visualization is displayed.

Charts let you quickly analyze and test hypotheses. You can also save charts and add them to dashboards as widgets.

{% note warning %}

{{ datalens-short-name }} limits the number of data rows displayed in charts. Read about them in the section [{#T}](limits.md).

{% endnote %}

## Chart type {#chart-types}

The following types of charts are available in {{ datalens-full-name }}:

* **Diagrams**:
   - [Line chart](#line-chart)
   - [Area chart](#area-chart)
   - [Normalized area chart](#normalized-area-chart)
   - [Column chart](#bar-chart)
   - [Normalized column chart](#normalized-bar-chart)
   - [Bar chart](#horizontal-bar-chart)
   - [Normalized bar chart](#normalized-horizontal-bar-chart)
   - [Scatter chart](#scatter-chart)
   - [Pie chart](#pie-chart)
   - [Tree chart](#tree-chart)
* **Tables**:
   - [Flat table](#flat-table)
   - [Pivot table](#pivot-table)
* **Geographical maps**:
   - [Point map](#point-map-chart)
   - [Choropleth map](#vchoropleth-map-chart)
   - [Heat map](#heat-map-chart)

### Line chart {#line-chart}

Displays changes to measures by dimension as a single or multiple horizontal lines.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| X | Dimension. Only one field can be specified |
| Y | Measure.  You can specify multiple measures.<br/>If you add more than one measure to a section, the **Colors** section contains a dimension named`Measure Names` |
| Y2 | Measure.  Use it to add a second Y-axis to a chart. You can specify multiple measures.<br/>If you add more than one measure to a section, the **Colors** section contains a dimension named`Measure Names` |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or the `Measure Names` field. Affects the color of lines. `Measure Names` is removed by deleting measures from the Y-axis |
| Sorting | Dimension. Can only use one dimension from the X-axis. Affects the sorting of the X-axis |
| Signatures | Measure. Displays measure values on the chart |

### Area chart {#area-chart}

Displays changes to measures by dimensions as areas, showing the contribution of each line to the total amount.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| X | Dimension. Only one field can be specified |
| Y | Measure. You can specify multiple measures. If you add more than one measure to a section, the **Colors** section contains a dimension named `Measure Names` |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or the `Measure Names` field. Affects the color of lines. `Measure Names` is removed by deleting measures from the Y-axis |
| Sorting | Dimension. Can only use one dimension from the X-axis. Affects the sorting of the X-axis |
| Signatures | Measure. Displays measure values on the chart |

### Stacked area chart {#normalized-area-chart}

Stacked area chart that shows the ratio of measures as a percentage.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| X | Dimension. Only one field can be specified |
| Y | Measure. You can specify multiple measures. If you add more than one measure to a section, the **Colors** section contains a dimension named `Measure Names` |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or the `Measure Names` field. Affects the color of lines. `Measure Names` is removed by deleting measures from the Y-axis |
| Sorting | Dimension. Can only use one dimension from the X-axis. Affects the sorting of the X-axis |
| Signatures | Measure. Displays measure values on the chart |

### Bar chart {#bar-chart}

Displays data as flat vertical bars.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| X | Dimensions. One or two dimensions can be specified |
| Y | Measure. You can specify multiple measures. If you add more than one measure to a section, the **Colors** section contains a dimension named `Measure Names`. `Measure Names` can be moved to the X-axis |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or the `Measure Names` field. Affects the color of lines. `Measure Names` is removed by deleting measures from the Y-axis |
| Sorting | Dimension or measure. Affects the sorting of columns |
| Signatures | Measure. Displays measure values on the chart |

### Stacked bar chart {#normalized-bar-chart}

Stacked bar chart that shows the ratio of measures as a percentage.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| X | Dimensions. One or two dimensions can be specified |
| Y | Measure. You can specify multiple measures. If you add more than one measure to a section, the **Colors** section contains a dimension named `Measure Names`. `Measure Names` can be moved to the X-axis |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or the `Measure Names` field. Affects the color of lines. `Measure Names` is removed by deleting measures from the Y-axis |
| Sorting | Dimension or measure. Affects the sorting of columns |
| Signatures | Measure. Displays measure values on the chart |

### Bar chart {#horizontal-bar-chart}

Displays data as flat horizontal bars.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Y | Dimensions. One or two dimensions can be specified |
| X | Measure. You can specify multiple measures. If you add more than one measure to a section, the **Colors** section contains a dimension named `Measure Names`. `Measure Names` can be moved to the Y-axis |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or the `Measure Names` field. Affects the color of lines. `Measure Names` can be removed by deleting measures from the X-axis |
| Sorting | Dimension or measure. Affects the sorting of columns |
| Signatures | Measure. Displays measure values on the chart |

### Normalized bar chart {#normalized-horizontal-bar-chart}

Normalized bar chart that shows the ratio of measures.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Y | Dimensions. One or two dimensions can be specified |
| X | Measure. You can specify multiple measures. If you add more than one measure to a section, the **Colors** section contains a dimension named `Measure Names`. `Measure Names` can be moved to the Y-axis |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or the `Measure Names` field. Affects the color of lines. `Measure Names` can be removed by deleting measures from the X-axis |
| Sorting | Dimension or measure. Affects the sorting of columns |
| Signatures | Measure. Displays measure values on the chart |

### Scatter chart {#scatter-chart}

Displays data points for comparing pairs of values.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| X | Dimension or measure. Sets the X-axis value |
| Y | Dimension or measure. Sets the Y-axis value |
| Points | Dimension. Specifies the number of points on the chart |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or measure. Affects the color of points |
| Sorting | Measure. Affects the sorting of columns |

### Pie chart {#pie-chart}

Displays the size of elements in a single data series relative to the sum of elements as a circle.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Colors | Dimension. Only one field can be specified |
| Measures | Measure. Only one field can be specified |
| Filters | Dimension or measure. Used as a filter |
| Sorting | Dimension or measure from the **Colors** section. Affects the sorting |
| Signatures | Measure. Displays measure values on the chart |

### Tree chart {#tree-chart}

Displayed as a set of rectangles. Use this chart to compare proportions in a hierarchy.

Use this chart to compare proportions in a hierarchy.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Dimensions | Dimensions. Determines the hierarchy tree of nested rectangles |
| Size | Measure. One measure that determines the area of a rectangle |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or measure. Affects the shading of rectangles in a chart |

### Simple table {#flat-table}

Displays data in table format, where the first row defines the names of fields and the remaining rows define their values.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Columns | Dimensions and measures to be used as columns. Field names are used as column headers |
| Filters | Dimension or measure. Used as a filter |
| Colors | Measure. Affects shading of all cells within a row. It may contain only one indicator |
| Sorting | Dimensions and measures specified in the **Columns** section.<br/>You can use multiple dimensions and measures.<br/>The order of fields in a section affects the sorting order of table fields |

### Pivot table {#pivot-table}

Displays data in table format, where rows and columns may contain dimension values and cells at their intersection may contain measures.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Columns | Dimensions |
| Rows | Dimensions |
| Measures | Measures. If you add more than one measure to a section, the **Columns** section contains the `Measure Names` dimension that defines the location of the measure headers. `Measure Names` can be moved to **Rows** |
| Filters | Dimension or measure. Used as a filter |
| Colors | Measure. Affects shading of all cells containing indicators. It may contain only one indicator |
| Sorting | Dimensions and measures specified in the **Columns** and **Rows** sections.<br/>You can use multiple dimensions and measures.<br/>The order of fields in a section affects the sorting order of table fields |

### Point map {#point-map-chart}

Displays geographical points on the map.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Geopoints | Measure with the type `Geopoint` |
| Size | The size of a point on the map |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or measure. Affects the intensity of point fill |
| Tooltips | Dimension or measure. A tooltip that appears when you hover over a point |

### Choropleth map {#choropleth-map-chart}

Displays shaded areas on the map.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Geopolygons | Measure with the type `Geopolygon` |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or measure. Affects the color of points |

### Heat map {#heat-map-chart}

Displays geographical points on the map with different shading intensity.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Geopoints | Measure with the type `Geopoint` |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or measure. Affects the intensity of point fill |

## Publishing a chart {#public-access}

You can grant any internet user access to a chart using [{{ datalens-public }}](datalens-public.md). This chart becomes public and any user can view it without authorization.

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

## Access management {#access-management}

You can configure chart permissions. For more information, see [{#T}](../security/index.md).

#### See also {#see-also}

- [{#T}](../operations/chart/create-line-chart.md)
- [{#T}](../operations/chart/create-pivot-table.md)
- [{#T}](../operations/chart/create-table.md)
- [{#T}](../operations/chart/create-area-chart.md)
- [{#T}](../operations/chart/create-bar-chart.md)
- [{#T}](../operations/chart/create-pie-chart.md)
- [{#T}](../operations/chart/create-point-map-chart.md)
- [{#T}](../operations/chart/create-choropleth-map-chart.md)
- [{#T}](../operations/chart/create-heat-map-chart.md)
- [{#T}](../operations/chart/publish.md)

