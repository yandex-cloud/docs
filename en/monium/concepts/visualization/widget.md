# Widgets

_Widgets_ are dashboard elements that display information as a chart or text.

In {{ monitoring-full-name }}, you can add the following widgets:

* [Chart](#chart)
* [Text](#text)
* [Title](#heading)
* [Escalation](#escalation)
* [Alert](#alert)
* [Section](#group)

## Chart {#chart}

The visual representation of one or more metrics over a specific period of time. Each metric has a different [color on the chart](#color-schemes).

{{ monitoring-full-name }} lets you display {{ yandex-cloud }} service metrics on charts and custom metrics uploaded via the API.

### Chart types {#chart-types}

There are two groups of charts: **Timeseries** show how metrics change over time, while **aggregations** represent summary values ​​for a selected period.

#### Timeseries {#time-series}

The X axis displays time, and the Y axis shows the metric value.

* ![image](../../../_assets/console-icons/chart-line.svg) **{{ ui-key.yacloud_monitoring.wizard.chart.line }}**: Metric values ​​are connected by lines.
* ![image](../../../_assets/console-icons/chart-area-stacked.svg) **{{ ui-key.yacloud_monitoring.wizard.chart.area }}**: Metric values ​​are shown as color-filled areas.
* ![image](../../../_assets/console-icons/chart-column.svg) **{{ ui-key.yacloud_monitoring.wizard.chart.column }}**: Metric values ​​are shown as columns of equal width. The height of a column is equal to the sum of the metric values ​​at a given point in time, while the height of each segment matches the value of the appropriate metric.
* ![image](../../../_assets/console-icons/grip-horizontal.svg) **{{ ui-key.yacloud_monitoring.wizard.chart.points }}**: Metric values ​​are shown as individual points.

#### Aggregations {#aggregations}

For each element of the chart, a single value is calculated for the selected period. In the **{{ ui-key.yacloud_monitoring.wizard.vis.aggregation-key-value }}** setting, you can select the average, minimum, maximum, last value, sum, or number of points.

* ![image](../../../_assets/console-icons/chart-pie.svg) **{{ ui-key.yacloud_monitoring.wizard.chart.pie }}**: Aggregated values ​​are shown as sectors of a circle.
* ![image](../../../_assets/console-icons/rectangles-4.svg) **{{ ui-key.yacloud_monitoring.wizard.chart.tiles }}**: Aggregated values ​​are shown on separate tiles.
* ![image](../../../_assets/console-icons/chart-bar.svg) **Bars**: Metrics are grouped into categories and subgroups based on label values. The aggregated value determines the height of a vertical column or the length of a horizontal column. For this chart, options are available for sorting, selecting orientation, and arranging the columns within each category. For more details, see [Configuring the _Bars_ chart](../../metrics/metric-explorer.md#bar-chart).

### Color schemes {#color-schemes}

* **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-auto }}**: Applies one of the following color schemes:
  * **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-gradient }}**: For a chart of the **{{ ui-key.yacloud_monitoring.wizard.chart.area }}** type, provided that all lines have at least one numerical value.
  * **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-standard }}**: In all the other cases.
* **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-standard }}**: Color is defined by an algorithm installed in the system.
* **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-gradient }}**: Red-to-green gradient blend, where red represents high metric values, and green, low values.
* **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-hash }}**: For each line, a unique value (hash) will be calculated, based on which the color will be generated. Lines with the same name will be displayed identically in most cases.
* **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-thresholds }}**: Line color is selected based on user-defined [thresholds](../../operations/dashboard/add-widget.md#thresholds) and data aggregation method. Use this setting to highlight lines which represent critical or target values.

### Time period on charts {#time-period-on-charts}

Metrics on charts are displayed for a given time interval, which you can specify using preset ranges (`1h 3h 1d 1w 1mo`). You can also set the start and end of the interval.

To set the interval more precisely, use the timeline located above the chart.

## Alert {#alert}

The widget displays the current status of the selected alert on the dashboard. If you have added [annotations](../alerting/annotation.md) for the alert, you can also display them in the widget.

## List of alerts {#alert-list}

The widget displays the current status of alerts or multialert sub-alerts matching the selector as colored dashboard tiles. You can aggregate alerts from any project you have access to.

## SLO {#slo}

This widget displays a list of [SLOs](../../slo/index.md) with current SLI values and the remaining error budget. Clicking an SLO name opens the respective view page.

Changing the dashboard time range does not affect the SLO widget. It always shows the current values.

## Escalation {#escalation}

The widget displays running escalation instances for a selected escalation policy on the dashboard. You can use the widget to stop one or multiple escalations.

## Text {#text}
Text in [YFM](https://ydocs.tech/en/) format that allows you to display additional information on the dashboard. For example, you can post links to other dashboards.

## Title {#heading}
Text that allows you to label a dashboard or group of charts.

## Section {#group}
You can use sections to group multiple widgets.
