---
title: '{{ monitoring-full-name }} release notes'
description: This section contains {{ monitoring-name }} release notes.
---

# {{ monitoring-full-name }} release notes


## October – December 2024 {#oct-nov-2024}

* **Added phone calls** as a notification channel to make an automated call to the user when an alert triggers (currently available for escalations only).

* Added the [escalation](concepts/alerting/escalations.md) feature you can invoke when an alert gets the **Alarm** status. An escalation starts a sequence of notifications with a preset interval. You can configure sending notifications to different channels for one or more cloud users.

  This feature is available at the [Preview](../overview/concepts/launch-stages.md) stage.

* Implemented integration with [{{ sf-name }}](../functions/index.yaml). You can now invoke a function using any of the available [programming languages](../functions/concepts/) when an alert triggers (currently available for escalations only).

* Added support for [alerting rules](operations/prometheus/alerting-rules.md) in {{ managed-prometheus-full-name }}. You can send notifications for {{ prometheus-name }} metrics via email, Telegram, text messages (SMS), and other channels.
  
  This feature is available at the [Preview](../overview/concepts/launch-stages.md) stage.

* Updated the **Metric Explorer** interface to allow a more consistent and detailed data analysis:

  * Query string is now located at the top so you can type in queries and view results in charts with more ease. You can add and edit multiple queries: all the queries and charts are available from a single screen.
  * You can add a name and description for charts.
  * Added sorting for each chart metric to the legend window. Also now you can highlight a chart line with a specific metric and open the chart in a separate window.
  * Optimized query editing in [token mode](concepts/visualization/query-string.md) for the use of a keyboard. Added keyboard shortcuts for managing and navigating tokens.
  * Placed the chart legend on the **Pivot table** tab. Next to it, you can find the **Source data** table with service metrics.
  
* Updated the [**Dashboards**](concepts/visualization/dashboard.md) interface with new features:
  * Now you do not need to switch to editing mode to add an element to a dashboard: you can begin the setup right away.
  * You can create duplicate charts for each of the selected metric value in a [dashboard parameter](concepts/visualization/dashboard.md#parameterization).
  * You can add an [alert widget](operations/dashboard/add-widget.md#alert) to a dashboard and monitor its status.
  * Improved the speed of loading and updating charts.
  * Improved the widget loading speed and performance.
  

## April – September 2024 {#apr-sep-2024}

Updated the [decimation](concepts/decimation.md) policy for historical data in monitoring. Now the data stores not only the average value, but also the maximum, minimum, total, and last value in each time interval subject to aggregation.

The new policy is more accurate in reflecting local spikes in charts and allows you to see the original data, which helps you analyze changes in more detail. Historical metrics charts now have smoother lines.

To select one of the decimation types for your chart, go to **Metric Explorer** and **Dashboards** in the chart settings.

The new policy applies to all data obtained since August 7, 2024. For older data, only the average value is available.

## January – March 2024 {#jan-mar-2024}

### Updates {#updates}

* Released {{ managed-prometheus-full-name }} for [general availability](../overview/concepts/launch-stages.md).
* Added support for [sending alert notifications](concepts/alerting/notification-channel.md) in Telegram.

### Fixes and improvements {#fixes-improvements}

* Enabled faster [export of metrics in {{ prometheus-name }} format](operations/metric/prometheusExport.md).

{% include [trademark](../_includes/monitoring/trademark.md) %}
