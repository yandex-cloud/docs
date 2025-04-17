---
title: '{{ monitoring-full-name }} release notes'
description: This section contains {{ monitoring-name }} release notes.
---

# {{ monitoring-full-name }} release notes

## January – March 2025 {#jan-mar-2025}

* Added **chart decomposition** based on a given parameter for [drill-down](https://en.wikipedia.org/wiki/Data_drilling) analysis. Decompose charts to switch from an overview to a detailed look into the metrics of specific system elements to diagnose the causes of anomalies or incidents faster.

   Learn more about metrics in [{#T}](operations/metric/metric-explorer.md).

* You can now set the number of minimum, maximum, or average values when decomposing charts. For example, when analyzing CPU usage, you can display 10 CPU load surges in the last 24 hours.

* Added the option to invoke a [{{ sf-name }}](../functions/index.yaml) function to notification channels for alerts. This will allow you to create a webhook for automatic processing of incidents and other events in your cloud.

   For more information, see sections [{#T}](operations/alert/create-channel-function.md) and [{#T}](operations/alert/alert-call-function.md).

* When creating a VM, you can [install an agent](operations/prometheus/ingestion/prometheus-agent.md) for collecting metrics in {{ prometheus-name }} format. By default, Linux system metrics are sent to {{ managed-prometheus-full-name }}. You can also configure delivering your application metrics when creating a VM or at a later time.

* The [Dashboards](concepts/visualization/dashboard.md) section updates:
  
  * Added sharing a chart screenshot: you can now copy the screenshot itself or a link to it.
  * Added expandable sections in which you can group any number of widgets. This allows you to pack more information into your dashboard, hide the charts you do not currently need, group them by purpose, service, or metric type.

* Updated the [Metric Explorer](concepts/visualization/metric-explorer.md) section:
  
  * Added the request history that saves 100 recent requests. You can select any of your earlier requests, find a requests using text search, or add requests to favorites. The history always saves your favorite requests and displays them at the top.
  * In the chart’s color scheme settings, you can automatically [assign one color](operations/metric/metric-explorer.md#set-graph) to lines of the same name on different charts.
  * When you create a chart screenshot, a legend is now added to it.

* Updated the [Alerts](concepts/alerting/alert.md) section: now you can use any units to specify the alert calculation time. For example, you can specify the `one week` interval as `1w` or `7d`.

* General UI updates: you can now view the full name of the label in the information window.

* Documentation update: added the [{#T}](operations/prometheus/ingestion/troubleshooting.md) guide for {{ managed-prometheus-full-name }}.

## October – December 2024 {#oct-nov-2024}

* We **added automated phone calls** as an alert notification channel. Currently, this feature is only available for escalations.

* We added an [escalation](concepts/alerting/escalations.md) feature you can invoke when an alert gets the **Alarm** status. An escalation sends a sequence of notifications with a specified time interval between them. You can configure notification channels and recipients.

  This feature is available at the [Preview](../overview/concepts/launch-stages.md) stage.

* [{{ sf-name }}](../functions/index.yaml) integration has been implemented. Now you can invoke a function in any available [programming language](../functions/concepts/) in escalations.

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

The new policy is more accurate in reflecting local spikes in charts and allows you to see the original data, which helps you analyze changes in more detail. Historical metrics charts now have smoother lines.

To select a decimation method for your chart, navigate to **Metric Explorer** or **Dashboards** in the chart settings.

The new policy applies to all data collected since August 7, 2024. For older downsampled data, only the average values are available.

## January – March 2024 {#jan-mar-2024}

### Updates {#updates}

* {{ managed-prometheus-full-name }} has entered the [General Availability](../overview/concepts/launch-stages.md) stage.
* We added Telegram [alert notifications](concepts/alerting/notification-channel.md).

### Fixes and improvements {#fixes-improvements}

* We improved {{ prometheus-name }} [metrics export](operations/metric/prometheusExport.md) time.

{% include [trademark](../_includes/monitoring/trademark.md) %}
