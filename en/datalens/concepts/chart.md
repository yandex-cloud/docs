# Charts

_Charts_ are the visualization of data from a dataset in the form of a table or diagram.

Charts are created in a [wizard](https://datalens.yandex.ru/wizard/) based on data from a dataset.
You can create an unlimited number of charts based on a single dataset.

The workspace in the wizard interface is divided into three main panels:

1. A selection panel where dataset fields are displayed: **Dimensions** and **Measures**.
1. A visualization setup panel where you can select a view. Each view has its own set of sections (such as X-axis, Y-axis, and filters) where you can drag dimensions and measures.
1. A preview panel where the visualization is displayed.

Charts let you quickly analyze and test hypotheses. You can also save charts and place them on dashboards as widgets.

## Chart type {#chart-types}

The following types of charts are available in {{ datalens-full-name }}:

- [Flat table](#flat-table)
- [Pivot table](#pivot-table)
- [Line chart](#line-chart)
- [Area chart](#area-chart)
- [Pie chart](#pie-chart)
- [Bar chart](#bar-chart)
- [Tree chart](#tree-chart)
- [Scatter chart](#scatter chart)

### Simple table {#flat-table}

Displays data in table format, where the first row defines the names of fields and the remaining rows define their values.

| Section | Description |
| ----- | ---- |
| Columns | Dimensions and measures to be used as columns. Field names are used as column headers |
| Filters | Dimensions and measures that are used as a filter |
| Colors | Measure. Affects cell shading. It may contain only one indicator |
| Sorting | Dimensions and measures specified in the **Columns** section.<br/>You can use multiple dimensions and measures.<br/>The order of fields in a section affects the sorting order of table fields |

### Pivot table {#pivot-table}

Displays data in table format, where rows and columns may contain dimension values and cells at their intersection may contain measures.

| Section | Description |
| ----- | ---- |
| Columns | Dimensions |
| Rows | Dimensions |
| Measures | Measures. When more than one measure is added to a section, a dimension named **Measure Names** appears in the Columns section. It determines the location of measure headers. **Measure Names** can be moved to **Rows** |
| Filters | Dimensions and measures that are used as a filter |
| Colors | Measure. Affects cell shading. It may contain only one indicator |
| Sorting | Dimensions and measures specified in the **Columns** and **Rows** sections.<br/>You can use multiple dimensions and measures.<br/>The order of fields in a section affects the sorting order of table fields |

### Line chart {#line-chart}

Displays changes to indicators by dimension as a horizontal line.

| Section | Description |
| ----- | ---- |
| X | Dimension. Only one field can be specified |
| Y | Measure.  Multiple measures can be specified. When more than one measure is added to a section, a dimension appears in the Colors section named **Measure Names** |
| Filters | Dimensions and measures that are used as a filter |
| Colors | Dimension or the **Measure Names** field. Affects the color of lines. **Measure Names** is removed by deleting measures from the Y-axis |
| Sorting | Dimension. Can only use one dimension from the X-axis. Affects the sorting of the X-axis |

### Area chart {#area-chart}

Displays changes to measures by dimensions as areas, showing the contribution of each line to the total amount.

| Section | Description |
| ----- | ---- |
| X | Dimension. Only one field can be specified |
| Y | Measure. Multiple measures can be specified. When more than one measure is added to a section, a dimension appears in the Colors section named **Measure Names** |
| Filters | Dimensions and measures that are used as a filter |
| Colors | Dimension or the **Measure Names** field. Affects the color of lines. **Measure Names** is removed by deleting measures from the Y-axis |
| Sorting | Dimension. Can only use one dimension from the X-axis. Affects the sorting of the X-axis |

### Pie chart {#pie-chart}

Displays the size of elements in a single data series relative to the sum of elements as a circle.

| Section | Description |
| ----- | ---- |
| Dimensions | Dimension. Only one field can be specified |
| Measures | Measure. Only one field can be specified |
| Filters | Dimensions and measures that are used as a filter |
| Sorting | Measure or dimension. One dimension from the X section or any Measure. Affects the sorting |

### Bar chart {#bar-chart}

Displays data as flat vertical bars.

| Section | Description |
| ----- | ---- |
| X | Dimensions. One or two dimensions can be specified |
| Y | Measure. Multiple measures can be specified. When more than one measure is added to a section, a dimension named **Measure Names** appears in the Colors section. **Measure Names** can be moved to the X-axis |
| Filters | Dimensions and measures that are used as a filter |
| Colors | Dimension or the **Measure Names** field. Affects the color of lines. **Measure Names** is removed by deleting measures from the Y-axis |
| Sorting | Dimensions and measures. Affects the sorting of columns |

### Tree chart {#tree-chart}

Displayed as a set of rectangles. Use this chart to compare proportions in a hierarchy.

Use this chart to compare proportions in a hierarchy.

| Section | Description |
| ----- | ---- |
| Dimensions | Dimensions. Determines the hierarchy tree of nested rectangles |
| Size | Measure. One indicator that determines the rectangle area |
| Filters | Dimensions and measures that are used as a filter |
| Colors | Measure or Dimension. Affects rectangle shading. |

### Scatter chart {#scatter-chart}

Displays data points for comparing pairs of values.

| Section | Description |
| ----- | ---- |
| X | X-axis dimension or measure |
| Y | Y-axis dimension or measure |
| Points | Points - Dimension. Specifies the number of points on the chart |
| Filters | Dimensions and measures that are used as a filter |
| Colors | Dimension or measure. Affects the color of points |
| Sorting | Measure. Affects the sorting of columns |

## Access management {#access-management}

You can configure chart permissions. For more information, see [{#T}](../security/index.md).

#### See also {#see-also}

- [{#T}](../operations/chart/create-pivot-table.md)
- [{#T}](../operations/chart/create-table.md)
- [{#T}](../operations/chart/create-line-chart.md)
- [{#T}](../operations/chart/create-area-chart.md)
- [{#T}](../operations/chart/create-bar-chart.md)
- [{#T}](../operations/chart/create-pie-chart.md)

