---
title: "Viewing function monitoring charts in {{ sf-full-name }}"
description: "You can view a monitoring chart in {{ sf-full-name }} using the management console. To do this, select {{ sf-name }} and click the function to view monitoring charts for."
---

# Viewing function monitoring charts

 You can monitor functions at runtime using the monitoring tools in your management console. These tools display diagnostic information as charts. Metric values are collected and charts are displayed by [{{ monitoring-name }}](../../../monitoring/). 

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

   1. Select a function to view its monitoring charts.

   1. Go to the **{{ ui-key.yacloud.common.monitoring }}** tab.

   1. The following charts will open on the page:

      * **Requests**: Number of function calls.
      * **Request latency**: Average time it takes a trigger to process a request.
      * **Errors**: The number of runtime errors a function generated.

   You can select the time period to display information for: hour, day, week, month, or a custom interval.

{% endlist %}

## Custom metrics {#metrics}

{% include [metrics](../../../_includes/functions/metrics.md) %}
