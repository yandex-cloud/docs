---
title: Viewing container monitoring charts
description: Follow this guide to view container monitoring charts.
---

# Viewing container monitoring charts

You can monitor containers at runtime using the monitoring tools in your management console. These tools display diagnostic information as charts. Metric values are collected and charts are displayed by [{{ monitoring-name }}](../../monitoring/).

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your container.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Select the container to view its monitoring charts.
  1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.
  1. The following charts will appear on the page:
      * **Requests**: Number of container calls
      * **Requests latency**: Average time for a container to process a call.
      * **Errors**: Number of errors generated while a container was processing a call.

      You can select a time period for which you want to display information on the graph. It can be an hour, three hours, a day, a week, a month, or a custom interval.

{% endlist %}

## Custom metrics {#metrics}

{% include [metrics](../../_includes/serverless-containers/metrics.md) %}