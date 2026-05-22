---
title: Viewing your services' or applications' metrics in {{ metrics-name }}
description: Follow this guide to view detailed metric charts for your services or applications.
---

# Viewing metrics in {{ metrics-name }}

In **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**, you can customize metric visualization and analyze the metrics of your infrastructure and applications in real time.

The charts you create in this section are not saved and lend themselves well for real-time monitoring. If you need repeated access to a specific chart, save it to your [dashboard](#add-to-dashboard).

## Building charts based on metrics {#add-graph}

For charts based on {{ prometheus-name }} metrics, see [{#T}](../operations/prometheus/querying/monitoring.md).

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** on the left.
  1. At the top, set the data search period on the timeline.
  1. To search for application metrics, enter the following in the query string:
       
      {% include [application-labels](../../_includes/monium/application-labels.md) %}
  
  1. To search for {{ yandex-cloud }} resource metrics, enter the following in the query string:
  
      {% include [yc-resource-labels](../../_includes/monium/yc-resource-labels-metrics.md) %}
  
  1. To view all available labels for a query you have already entered, click ![view](../../_assets/console-icons/folder-open.svg) in the query bar controls on the right. If you do not see the label in the list, it means that its values were not transferred to the system or have already been deleted due to [TTL](../concepts/common-ttl.md) expiration. You can enter a label manually, but the chart will not be displayed.

     You can select [metrics and labels](../concepts/data-model.md) with your cursor from the drop-down lists in the query string or by typing the first letters of the label name.
   
     To view query string hotkey tooltips, click ![view](../../_assets/console-icons/keyboard.svg) **Cmd/Ctrl + Enter**.

  1. Click **{{ ui-key.yacloud_monitoring.querystring.button.apply-and-parse }}**.

  1. To visualize a modified metric on the chart, select [functions](../concepts/querying.md#functions) in ![image](../../_assets/monitoring/function.svg).
  
  1. To display another metric on the chart, click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}** and enter the metric and label values.
   
     Hide any intermediate queries used for calculating another query on the chart. To do this, click ![image](../../_assets/monitoring/concepts/visualization/chart-query-hide.svg) next to the query.

     If you want to render a dedicated chart for each query, enable the **{{ ui-key.yacloud_monitoring.wizard.one-graph-per-query.label }}** setting and select the number of charts per row.
  
  1. To temporarily hide charts for specific labels, select **{{ ui-key.yacloud_monitoring.wizard.tab.pivot-table }}** at the bottom and disable the charts you do not need.
  1. To view metric values in a table, select **{{ ui-key.yacloud_monitoring.wizard.tab.table }}** at the bottom.

{% endlist %}

## Selecting a time interval {#set-time}

You can set the time interval for displaying metrics in one of the following ways:

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  * At the top of the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** section, click:
    * **Last hour** to set the date and time in the drop-down list.
    * **<** or **>** to move one hour forward or backward on the timescale.
    * **1h**, **1d**, **1w**, or **1M** to show metrics for the last hour, day, week, or month, respectively, on the chart. In the field next to it, you can specify your own time interval, e.g., `15m`.
  * At the top right of the chart panel, click **+** or **–**.
  * Select an area on the chart and click **{{ ui-key.yacloud_monitoring.tooltip.actions.go-to-window }}**.

{% endlist %}

## Customizing chart visualization {#set-graph}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. At the top right of the chart panel, click ![image](../../_assets/console-icons/gear.svg).
  1. Under **{{ ui-key.yacloud_monitoring.wizard.tab.general }}**, set the chart title and description.
  1. Under **{{ ui-key.yacloud_monitoring.wizard.tab.visualization }}**, configure the following:
     1. **{{ ui-key.yacloud_monitoring.wizard.vis.chart-type }}**: Select one of the metric display options: line chart, shaded areas, bar chart, scatter chart, pie chart, or tile chart.
     1. **{{ ui-key.yacloud_monitoring.wizard.vis.color-scheme }}**: Chart [line colors](../concepts/visualization/widget.md#color-schemes).

        To maintain consistent colors for lines with the same names across various charts, select **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-hash }}**.

        To highlight lines exceeding a threshold value with that threshold's color, select **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-thresholds }}** and configure thresholds.

     1. **{{ ui-key.yacloud_monitoring.wizard.vis.normalize }}**: To normalize all data to a range from `0%` to `100%`.
     1. **{{ ui-key.yacloud_monitoring.wizard.vis.interpolate-key-value }}**: To set a method of filling the data gap between two points, such as linear interpolation, forward fill, or backward fill.
  1. Under **{{ ui-key.yacloud_monitoring.wizard.axes.primary-y }}** and **{{ ui-key.yacloud_monitoring.wizard.axes.secondary-y }}**, set the title, scale, minimum and maximum values, units, and the number of decimal places.
  1. Under **{{ ui-key.yacloud_monitoring.wizard.tab.downsampling }}**, configure the [read data aggregation](../concepts/decimation.md#reading-decimation) option.
  1. Under **{{ ui-key.yacloud_monitoring.wizard.tab.thresholds }}**, specify one or more values. Based on these, straight lines will be drawn on your chart to help you easily detect any metrics with values above or below thresholds. You can customize the color for each line or leave the defaults.
  1. When you are done configuring the chart, close the settings panel. The chart displays all changes as soon as you make them.

{% endlist %}

## Reviewing the chart data {#graph-exploring}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  To view the chart legend:

  1. At the top right of the chart panel, click ![image](../../_assets/console-icons/ellipsis.svg).
  1. Select **{{ ui-key.yacloud_monitoring.wizard.settings-select.show-legend }}**.
  1. To highlight a specific chart, hover your cursor over its title in the legend.

  To view the legend and statistics for a particular time point:

  1. Hover the cursor over, or click, the point of interest on the chart.
  1. In the information window, check values for different labels at that time point.
  1. To sort values based on a specific column, click the column header.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.tooltip.actions.go-to-line }}** to open a separate chart for a specific value.
  1. To keep the information window open when you select another point, press **Cmd + Click** or **Ctrl + Click**.

     This way, you can open multiple windows for a single chart, comparing metric values at different points in time. To arrange windows in the desired order, hover over ![image](../../_assets/console-icons/grip.svg) and drag the window.

  To view the legend and statistics for a time interval:

  1. Select an area on the chart.
  1. In the information window, view the statistics for the metrics within the selected interval.
  1. If needed, sort by minimum value, maximum value, average value, or other parameters.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.tooltip.actions.go-to-line }}** to open a separate chart for a specific value.

{% endlist %}

## Viewing metrics in numeric format {#view-source}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. To view the numeric values of the metrics, click **{{ ui-key.yacloud_monitoring.wizard.tab.table }}** under the chart.

     It will give you a list of data for all the time points with collected metrics. To change the period, select the time interval you need at the top.

  1. To view statistics for the metrics (minimum and maximum values, sum, etc.), click **{{ ui-key.yacloud_monitoring.wizard.tab.pivot-table }}**.

  1. To save the pivot table data, click **{{ ui-key.yacloud_monitoring.wizard.legend.copy-as-csv }}** on the right.

{% endlist %}
   
## Splitting a chart by a parameter {#repeated-graphs}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. Select the metrics and [build a chart](#add-graph).
  1. Under the chart, click **{{ ui-key.yacloud_monitoring.wizard.button.top-by }}**.
  1. Select the parameters you want plotted:
     * **{{ ui-key.yacloud_monitoring.wizard.group-by.label-field-title }}**: Parameter for additional charts. These can be charts for different services, hosts, or processors, i.e., tokens selected in the query.
     * **{{ ui-key.yacloud_monitoring.wizard.group-by.limit-field-title }}**: Number of highest and lowest values on the chart.
     * **{{ ui-key.yacloud_monitoring.wizard.group-by.sort-by }}**: Sorting by minimum, maximum, or average value of the selected parameter.
     * **{{ ui-key.yacloud_monitoring.wizard.select.charts-count.label }}**: Number of charts per row.
  1. Click **{{ ui-key.yacloud_monitoring.wizard.group-by.execute }}**.

Select different parameter values and you will see the charts updated to reflect your selection.

{% endlist %}

## Adding a chart to a dashboard and sharing a chart{#add-to-dashboard}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  To add a chart to a dashboard:

  1. Select the metrics and [build a chart](#add-graph).
  1. At the top right, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_monitoring.wizard.wizard.mx.save-as }}**.
  1. Select the project where the dashboard is located or will be created.
  1. Select an existing dashboard or click **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.dash-picker.new-dashboard }}**.
  1. Enter a name for the chart-based widget.
  1. Select a chart adding option:
     * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add }}**: Stay in **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
     * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add-and-go }}**: Go to **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**. The chart will not be saved in **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.

  The widget on the dashboard will not be linked to the original chart. The changes you make to any of them will not affect the other.

  To share a chart:

  1. Select the metrics and [build a chart](#add-graph).
  1. At the top right, click ![image](../../_assets/monitoring/concepts/visualization/share.svg).
  1. Specify a time interval for your chart.
  1. Click **Copy** to copy the chart link to the clipboard.

{% endlist %}

## Creating an alert from a query {#create-alert}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. Select the metrics and [build a chart](#add-graph).
  1. In the query panel at the top right, click ![image](../../_assets/console-icons/ellipsis.svg) and select **Create alert from query** or **{{ ui-key.yacloud_monitoring.querystring.action.create-alert-from-all-queries }}**.
  1. Specify the [alert parameters](../operations/alert/create-alert.md).
  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}
