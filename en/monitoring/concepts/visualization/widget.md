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

* ![image](../../../_assets/console-icons/chart-line.svg) **Line chart**: Line plotted from metric values and their timestamps.
* ![image](../../../_assets/console-icons/chart-area-stacked.svg) **Area chart**: Metrics depicted as color-filled areas.
* ![image](../../../_assets/console-icons/chart-column.svg) **Column chart**: Metric values plotted as columns of equal width. Column height represents the sum of all metric values at a given point and is split in proportion to the original values.
* **Scatter chart**: Metric values visualized as individual points.
* **Pie chart**: Metrics depicted as parts of a circle (sectors), where each sector represents the aggregated value of metrics over the entire selected time interval.
* **Tile chart**: Metric values displayed as individual tiles, where each tile shows the aggregated value of metrics over the entire selected time interval.

### Color schemes {#color-schemes}

* **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-auto }}**: Applies one of the following color schemes:
  * **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-gradient }}**: In **Area** charts if all its lines have at least one numeric value.
  * **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-standard }}**: In all the other cases.
* **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-standard }}**: Color is defined by an algorithm installed in the system.
* **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-gradient }}**: Red-to-green gradient blend, where red represents high metric values, and green, low values.
* **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-hash }}**: Calculates a unique value (hash) for each line and generates the color based on the hash value. Lines with the same name will be displayed identically in most cases.
* **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-thresholds }}**: Line color is selected based on user-defined [thresholds](../../operations/dashboard/add-widget.md#thresholds) and data aggregation method. Use this setting to highlight lines which represent critical or target values.

### Time period on charts {#time-period-on-charts}

Metrics on charts are displayed for a given time interval, which you can specify using preset ranges (`1h 3h 1d 1w 1mo`). You can also set the start and end of the interval.

To set the interval more precisely, use the timeline located above the chart.

## Alert {#alert}

The widget displays the current status of the selected alert on the dashboard. If you have added [annotations](../alerting/annotation.md) for the alert, you can also display them in the widget.

## Escalation {#escalation}

{% include [escalations-preview](../../../_includes/monitoring/escalations-preview.md) %}

The widget displays running escalation instances for a selected escalation policy on the dashboard. You can use the widget to stop one or multiple escalations.

## Text {#text}
Text in [YFM](https://ydocs.tech/en/) format that allows you to display additional information on the dashboard. For example, you can post links to other dashboards.

## Title {#heading}
Text that allows you to label a dashboard or group of charts.

## Section {#group}
You can use sections to group multiple widgets.