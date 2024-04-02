# Filtering charts by charts

{{ datalens-short-name }} allows you to [set up](../operations/dashboard/add-filtration.md) filtering of charts by other charts on the dashboard. A chart with filtering configured can thus be used as a selector for other charts.

To apply filtering, click an individual item in the filtering chart, e.g., a point on a graph, a column, or a pie chart segment. The linked charts will then be filtered by the selected dimensions.

{% note info %}

Clicking a cell in the **Table** chart applies filtering by all the dimensions of the selected row.

{% endnote %}

You can reset chart filtering in two ways:

* Click the selected item once again.
* Click ![image](../../_assets/datalens/clear-filters.svg) in the top-right corner of the chart.

You can choose multiple filtering values on the same chart (other than the **Table** chart):

1. Click the first dimension value for filtering.
1. Hold down the `Ctrl` (`Cmd`) key on your keyboard and select the other values.

Filtering is available for the following types of charts created using the [wizard](../concepts/chart/dataset-based-charts.md):

* [Line chart](../visualization-ref/line-chart.md)
* [Stacked area chart](../visualization-ref/area-chart.md)
* [Column chart](../visualization-ref/column-chart.md)
* [Bar chart](../visualization-ref/bar-chart.md)
* [Scatter chart](../visualization-ref/scatter-chart.md)
* [Pie chart](../visualization-ref/pie-chart.md)
* [Donut chart](../visualization-ref/ring-chart.md)
* [Table](../visualization-ref/table-chart.md)
* [Pivot table](../visualization-ref/pivot-table-chart.md)


## Recommendations and limitations {#using}

When filtering charts by other charts, keep in mind the following:

* Charts created in the wizard are filtered using all dimensions except for fields of the [tree of strings](../concepts/data-types.md#tree-hierarchy) type, [hierarchies](../operations/chart/add-hierarchy.md), and fields containing [markup language](../function-ref/markup-functions.md).
* The state of filtered charts is saved in the dashboard's `state` parameter. You can share a link to such a dashboard.
