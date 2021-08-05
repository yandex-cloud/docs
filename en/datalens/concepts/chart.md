---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Charts

_Charts_ are the visualization of data from a dataset in the form of a table, diagram, or map.

Charts are created in a wizard based on data from one or multiple datasets (see [multi-dataset charts](#multi-dataset-charts)).
You can create an unlimited number of charts based on a single dataset.

The workspace in the wizard interface is divided into three main panels:

1. A dataset panel where available fields are displayed: **Dimensions** and **Measures**. You can add a [calculated field](calculations/index.md) to the list.
1. A visualization setup panel where you can select the chart type. Each type has its own set of sections (such as X-axis, Y-axis, and filters) where you can drag and drop fields.
1. A preview panel where the visualization is displayed.

Charts let you quickly analyze and test hypotheses. You can also save charts and add them to dashboards as widgets.

{% note warning %}

{{ datalens-short-name }} limits the number of data rows displayed in charts. For more information, see [{#T}](limits.md).

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
   - [Table](#flat-table)
   - [Pivot table](#pivot-table)
* **Geographical map**:
   - [Map](#map-chart)
     - [Point map](#point-map-chart)
     - [Choropleth map](#choropleth-map-chart)
     - [Heat map](#heat-map-chart)
* **Other**:
   - [Indicator](#indicator)

### Line chart {#line-chart}

Displays changes to measures by dimension as a single or multiple horizontal lines.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| X | Dimension. Only one field can be specified |
| Y | Measure. You can specify multiple measures.<br/>If you add more than one measure to a section, the **Colors** section contains a dimension named `Measure Names` |
| Y2 | Measure. Use it to add a second Y-axis to a chart. You can specify multiple measures.<br/>If you add more than one measure to a section, the **Colors** section contains a dimension named `Measure Names` |
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

### Normalized area chart {#normalized-area-chart}

Normalized area chart that shows the ratio of measures as a percentage.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| X | Dimension. Only one field can be specified |
| Y | Measure. You can specify multiple measures. If you add more than one measure to a section, the **Colors** section contains a dimension named `Measure Names` |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or the `Measure Names` field. Affects the color of lines. `Measure Names` is removed by deleting measures from the Y-axis |
| Sorting | Dimension. Can only use one dimension from the X-axis. Affects the sorting of the X-axis |
| Signatures | Measure. Displays measure values on the chart |

### Column chart {#bar-chart}

Displays data as flat vertical bars.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| X | Dimensions. One or two dimensions can be specified |
| Y | Measure. You can specify multiple measures. If you add more than one measure to a section, the **Colors** section contains a dimension named `Measure Names`. `Measure Names` can be moved to the X-axis |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or the `Measure Names` field. Affects the color of lines. `Measure Names` is removed by deleting measures from the Y-axis |
| Sorting | Dimension or measure. Affects the sorting of columns |
| Signatures | Measure. Displays measure values on the chart |

### Normalized column chart {#normalized-bar-chart}

Normalized column chart that shows the ratio of measures as a percentage.

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
| Colors | Dimension or the `Measure Names` field. Affects the color of lines. `Measure Names` is removed by deleting measures from the Y-axis |
| Sorting | Dimension or measure. Affects the sorting of columns |
| Signatures | Measure. Displays measure values on the chart |

### Normalized bar chart {#normalized-horizontal-bar-chart}

Normalized bar chart that shows the ratio of measures.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Y | Dimensions. One or two dimensions can be specified |
| X | Measure. You can specify multiple measures. If you add more than one measure to a section, the **Colors** section contains a dimension named `Measure Names`. `Measure Names` can be moved to the Y-axis |
| Filters | Dimension or measure. Used as a filter |
| Colors | Dimension or the `Measure Names` field. Affects the color of lines. `Measure Names` is removed by deleting measures from the Y-axis |
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
| Strings | Dimensions |
| Measures | Measures. If you add more than one measure to a section, the **Columns** section contains the `Measure Names` dimension that defines the location of the measure headers. `Measure Names` can be moved to **Rows** |
| Filters | Dimension or measure. Used as a filter |
| Colors | Measure. Affects shading of all cells containing indicators. It may contain only one indicator |
| Sorting | Dimensions and measures specified in the **Columns** and **Rows** sections.<br/>You can use multiple dimensions and measures.<br/>The order of fields in a section affects the sorting order of table fields |

### Map {#map-chart}

Map supports three types of visualization:

* [Point map](#point-map-chart)
* [Choropleth map](#choropleth-map-chart)
* [Heat map](#heat-map-chart)

You can place no more than 5 layers with any visualization type on a map. Layers in the **Map** chart are called geolayers.

_Geolayers_ visualize indicators using points or polygons on the map.

You can do the following operations with geolayers:

* Change name.
* Set transparency level.
* Reorder the layers inside a same visualization type. However, you can't change the order of visualization types (top-to-bottom: point map, chloropleth map, heat map).

You can purchase pre-calculated geolayers from partners in {{ marketplace-name }}.

#### Point map {#point-map-chart}

Displays geographical points on the map.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Geopoints | Measure with the `Geopoint` type |
| Size | Measure. Affects the size of the point |
| Layer filters | Dimension or measure. Used as a filter for the current layer |
| General filters | Dimension or measure. Used as a filter for the whole chart |
| Colors | Dimension or measure. Affects the intensity of point fill |
| Tooltips | Dimension or measure. A tooltip that appears when you hover over a point |
| Signatures | Measure. Displayed as text on a point. When used, point size control is blocked |

#### Choropleth map {#choropleth-map-chart}

Displays shaded areas on the map.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Geopolygons | Measure with the `Geopolygon` type |
| Layer filters | Dimension or measure. Used as a filter for the current layer |
| General filters | Dimension or measure. Used as a filter for the whole chart |
| Colors | Dimension or measure. Affects the color of points |

#### Heat map {#heat-map-chart}

Displays geographical points on the map with different shading intensity.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Geopoints | Measure with the `Geopoint` type |
| Filters | Dimension or measure. Used as a filter for the current layer |
| General filters | Dimension or measure. Used as a filter for the whole chart |
| Colors | Dimension or measure. Affects the intensity of point fill |

### Indicator {#indicator}

Displays the data as one number.

| Section<br/> in the wizard | Description |
| ----- | ---- |
| Measure | Measure. One measure that determines the indicator value |
| Filters | Dimension or measure. Used as a filter |

## Multi-dataset charts {#multi-dataset-charts}

Multi-dataset charts display data from multiple datasets.

Queries for each dataset are processed independently of each other. Calculated fields can't be applied to fields from multiple datasets.
When you add a second dataset, the link is automatically created based on the first match for the field name and field data type.

In this case, you can:

* Change links.
* Add new links.
* Delete links.

{% note info %}

  Datasets used in the chart may be non-linked.

{% endnote %}

Specifics of working with linked datasets in the chart, except for geochart layers:

* One chart can use any measures from datasets, regardless of their links.
* One chart can only use linked dimensions.
* Filters by linked dimensions are applied to all datasets.
* Filters by non-linked dimensions are applied only to their own dataset.

Working with linked datasets in geovisualizations on different layers:

* A geolayer can use any measures from datasets regardless of their links
* A geolayer can only use its linked dimensions.
* Filters by linked dimensions from the **General filters** section are applied to all datasets in all layers.
* Filters from the **General filters** section that use non-linked dimensions only apply to their own dataset in all layers.
* Filters in the **Layer filters** section that use linked dimensions apply to all datasets within the current layer.
* Filters in the **Layer filters** section that use non-linked dimensions only apply to their own dataset within the current layer.
* There are no restrictions on using non-linked dimensions in different layers.

## Hierarchies {#hierarchies}

_A hierarchy_ is a set of dimensions arranged in an order that determines the sequence in which data is shown. You can [add](../operations/chart/add-hierarchy.md) a hierarchy to your chart to move to the lower levels of the hierarchy with filtering by selected or all dimension values.

Completed transitions by hierarchy level are displayed above a visualization. You can move between the hierarchy levels in the following ways:

* Click **![image](../../_assets/datalens/arrow-left.svg)** or **![image](../../_assets/datalens/arrow-right.svg)** to go to the previous or next level.
* Click on the value in the line of completed transitions to return to the selected level.
* Click on a visualization element (for example, a row or column of a simple table) to go to the next hierarchy level with filtering enabled.

Limitations when working with hierarchies:

* Hierarchies are available for all chart types except **Map**, **Indicator**, **Tree diagram**, and **Pivot table**.
* You can only add dimensions to a hierarchy.
* You can add only one hierarchy to a visualization.

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
- [{#T}](../operations/chart/create-column-chart.md)
- [{#T}](../operations/chart/create-bar-chart.md)
- [{#T}](../operations/chart/create-pie-chart.md)
- [{#T}](../operations/chart/create-map-chart.md)
- [{#T}](../operations/chart/publish.md)

