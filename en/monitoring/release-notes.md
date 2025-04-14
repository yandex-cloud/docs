---
title: '{{ monitoring-full-name }} release notes'
description: This section contains {{ monitoring-name }} release notes.
---

# {{ monitoring-full-name }} release notes


## October – December 2024 {#oct-nov-2024}

* We **added automated phone calls** as an alert notification channel. Currently, this feature is only available for escalations.

* We added an [escalation](concepts/alerting/escalations.md) feature you can invoke when an alert gets the **Alarm** status. An escalation sends a sequence of notifications with a specified time interval between them. You can configure notification channels and recipients.

  This feature is available at the [Preview](../overview/concepts/launch-stages.md) stage.

* We Implemented [{{ sf-name }}](../functions/index.yaml) integration. You can invoke a function in any available [programming language](../functions/concepts/) in response to an alert. Currently, this feature is only available for escalations.

* We added [alerting rules](operations/prometheus/alerting-rules.md) support in {{ managed-prometheus-full-name }}. You can send {{ prometheus-name }} metric notifications via email, Telegram, SMS, and other channels.
  
  This feature is available at the [Preview](../overview/concepts/launch-stages.md) stage.

* We updated the **Metric Explorer** interface for more consistent and detailed data analysis:

  * We moved the query string to the top, making it easier to enter queries and see the results in the charts. You can work with more than one query and chart within a single screen view.
  * You can add names and descriptions to charts.
  * We added a sorting option to metric legend boxes. Also you can select a metric graph on a chart and open it in a separate window.
  * We made it easier to use the keyboard when editing queries in [token mode](concepts/visualization/query-string.md). Now you can use keyboard shortcuts for token management and navigation.
  * We moved the chart legend to the **Pivot table** tab. Next to it, we placed the **Source data** table with service metrics.
  
* We updated the [**Dashboards**](concepts/visualization/dashboard.md) interface, adding new features:
  * Now you can add elements to a dashboard without switching to editing mode.
  * You can create additional charts by selecting specific label values in the [dashboard parameter](concepts/visualization/dashboard.md#parameterization).
  * In a dashboard, you can add an [alert widget](operations/dashboard/add-widget.md#alert) to monitor its status.
  * We improved chart loading and refreshing time.
  * We improved widget loading time and their performance.
  

## April – September 2024 {#apr-sep-2024}

We updated the [decimation](concepts/decimation.md) policy for the monitoring historical data. Now in addition to the average value, we also store the maximum, minimum, total, and last value for each aggregated time interval.

This allows you to analyze local spikes in more detail using their original values. Also historical metric graphs now look smoother.

To select a decimation method for your chart, navigate to **Metric Explorer** or **Dashboards** in the chart settings.

The new policy applies to all data collected since August 7, 2024. For older downsampled data, only the average values are available.

## January – March 2024 {#jan-mar-2024}

### Updates {#updates}

* We released {{ managed-prometheus-full-name }} for [general availability](../overview/concepts/launch-stages.md).
* We added Telegram [alert notifications](concepts/alerting/notification-channel.md).

### Fixes and improvements {#fixes-improvements}

* We improved {{ prometheus-name }} [metrics export](operations/metric/prometheusExport.md) time.

{% include [trademark](../_includes/monitoring/trademark.md) %}
