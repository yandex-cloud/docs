---
title: Viewing your services' metrics in {{ monitoring-full-name }}
description: Follow this guide to view detailed metric charts for your services.
---

# Viewing your services' metrics in {{ monitoring-full-name }}

In **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**, you can flexibly manage metric visualization and analyze various metrics of your infrastructure and applications in real time.

The charts you create in this section are not saved. They are used for real-time monitoring. If you need to access specific charts from time to time, save them to your [dashboard](#add-to-dashboard).

## Building charts based on metrics {#add-graph}

1. Open the [service home page]({{ link-monitoring }}).
1. Select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** on the left.
1. In the query string, select the service for which you want to view metrics.
1. Specify the [metrics and labels](../../concepts/data-model.md) of the service (tokens) to plot on the chart.

   You can select tokens with your cursor from the drop-down lists in the query string or by typing the first letters of the token name.
   
   To view query string hotkey hints, click **{{ ui-key.yacloud_monitoring.querystring.hint.search-hotkey }}**.

1. To visualize a modified metric on the chart, select [functions](../../concepts/querying.md#functions) in ![image](../../../_assets/monitoring/function.svg).
1. To display another metric on the chart, click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}** and enter the metric and label values.
   
   Hide any intermediate queries used for calculating another query on the chart. To do this, click ![image](../../../_assets/monitoring/concepts/visualization/chart-query-hide.svg) next to the query.
1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}** or press **Cmd/Ctrl + Enter**.

## Selecting a time interval

You can set the time interval for displaying metrics in one of the following ways:

* At the top of the page, click:
  * **Last hour** to flexibly set the date and time in the drop-down list.
  * **<** or **>** to move one hour forward or backward on the timescale.
  * **1h**, **1d**, **1w**, or **1M** to show metrics for the last hour, day, week, or month, respectively, on the chart. In the field next to it, you can specify your own time interval, e.g., `15m`.
* At the top right of the chart panel, click **+** or **–**.
* Select an area on the chart and click **{{ ui-key.yacloud_monitoring.tooltip.actions.go-to-window }}**.

## Customizing chart visualization {#set-graph}

1. At the top right of the chart panel, click ![image](../../../_assets/console-icons/gear.svg).
1. Under **{{ ui-key.yacloud_monitoring.wizard.tab.general }}**, set the chart title and description.
1. Under **{{ ui-key.yacloud_monitoring.wizard.tab.visualization }}**, configure the following:
   1. **{{ ui-key.yacloud_monitoring.wizard.vis.chart-type }}**: Select one of the metric display options: line chart, shaded areas, bar chart, scatter chart, pie chart, or tile chart.
   1. **{{ ui-key.yacloud_monitoring.wizard.vis.color-scheme }}**: Chart line colors. 
   
      To maintain consistent colors for lines with the same names across various charts, select **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-hash }}**.

   1. **{{ ui-key.yacloud_monitoring.wizard.vis.normalize }}**: Normalizing all data to a range of 0 to 100%.
   1. **{{ ui-key.yacloud_monitoring.wizard.vis.interpolate-key-value }}**: Method of filling the data gap between two points, such as linear interpolation, forward fill, or backward fill.
1. Under **{{ ui-key.yacloud_monitoring.wizard.axes.primary-y }}** and **{{ ui-key.yacloud_monitoring.wizard.axes.secondary-y }}**, set the title, scale, minimum and maximum values, units, and number of decimal places.
1. Under **{{ ui-key.yacloud_monitoring.wizard.tab.downsampling }}**, configure how to display [historical data](../../concepts/decimation.md) on the chart.
1. When you are done configuring the chart, close the settings panel. The chart displays all changes as soon as you make them.

## Reviewing the chart data {#graph-exploring}

To view the chart legend:

1. At the top right of the chart panel, click ![image](../../../_assets/console-icons/ellipsis.svg).
1. Select **{{ ui-key.yacloud_monitoring.wizard.settings-select.show-legend }}**.
1. To highlight the chart for a specific value, hover over its name in the legend.

To view the legend and statistics for a particular time point:

1. Select the point on the chart.
1. In the information window, check the values for different labels at that time point.
1. To sort the values, click the **Name** or **Value** column.
1. Click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.tooltip.actions.go-to-line }}** to open a separate chart for a specific value.

To view the legend and statistics for a time interval:

1. Select an area on the chart.
1. In the information window, view the statistics for the metrics within the selected interval.
1. If needed, sort by minimum value, maximum value, average value, or other parameters.
1. Click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.tooltip.actions.go-to-line }}** to open a separate chart for a specific value.

## Viewing metrics in numeric format {#view-source}

1. To view the numeric values of the metrics, click **{{ ui-key.yacloud_monitoring.wizard.tab.table }}** under the chart.
  
   It will give you a list of data for all the time points with collected metrics. To change the period, select the time interval you need at the top.

1. To view statistics for the metrics (minimum and maximum values, sum, etc.), click **{{ ui-key.yacloud_monitoring.wizard.tab.pivot-table }}**.

1. To save the pivot table data, click **{{ ui-key.yacloud_monitoring.wizard.legend.copy-as-csv }}** on the right.
   
## Splitting a chart by a parameter {#repeated-graphs}

1. Select the metrics and [build a chart](#add-graph).
1. Under the chart, click **{{ ui-key.yacloud_monitoring.wizard.button.top-by }}**.
1. Select the parameters you want plotted:
   * **{{ ui-key.yacloud_monitoring.wizard.group-by.label-field-title }}**: Parameter for additional charts. These can be charts for different services, hosts, or processors, i.e., tokens selected in the query.
   * **{{ ui-key.yacloud_monitoring.wizard.group-by.limit-field-title }}**: Number of highest values and lowest values on the chart.
   * **{{ ui-key.yacloud_monitoring.wizard.group-by.sort-by }}**: Sorting by minimum, maximum, or average value of the selected parameter.
   * **{{ ui-key.yacloud_monitoring.wizard.group-by.charts-count }}**: Number of charts on a single line.
1. Click **{{ ui-key.yacloud_monitoring.wizard.group-by.execute }}**.

Select different parameter values and you will see the charts updated to reflect your selection.

## Adding a chart to a dashboard and sharing a chart {#add-to-dashboard}

To add a chart to a dashboard:

1. Select the metrics and [build a chart](#add-graph).
1. At the top right, click **{{ ui-key.yacloud_monitoring.wizard.wizard.mx.save-as }}**.
1. Enter a name for your chart.
1. Select a cloud and folder.
1. Select an existing dashboard or create a new one.
1. Select a chart adding option:
   * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add }}**: Stay in **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
   * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add-and-go }}**: Go to **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**. The chart will not be saved in **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

The widget on the dashboard will not be linked to the original chart. The changes you make to one will not affect the other.

To share a chart:

1. Select the metrics and [build a chart](#add-graph).
1. At the top right, click ![image](../../../_assets/monitoring/concepts/visualization/share.svg).
1. Specify a time interval for your chart.
1. Click **Copy** to copy the chart link to the clipboard.

## Creating an alert from a query {#create-alert}

1. Select the metrics and [build a chart](#add-graph).
1. In the query panel at the top right, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **Create alert from query** or **{{ ui-key.yacloud_monitoring.querystring.action.create-alert-from-all-queries }}**.
1. Specify the [alert parameters](../alert/create-alert.md).
1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

#### See also {#see-also}

[{#T}](../../concepts/visualization/metric-explorer.md)
[{#T}](../dashboard/create.md)
[{#T}](../alert/create-alert.md)