---
title: Viewing function monitoring charts in {{ sf-full-name }}
description: You can view monitoring charts in {{ sf-full-name }} using the management console. To do this, select {{ sf-name }} and click the function whose monitoring charts you want to view.
---

# Viewing function monitoring charts

 You can monitor functions using the monitoring tools in the management console. These tools display diagnostic information as charts. [{{ monitoring-name }}](../../../monitoring/) collects metric values and displays charts.

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the function.

    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. Select the function whose monitoring charts you want to view.

    1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.

    1. You will see the following charts:

        * **Requests**: Number of function calls.
        * **Request latency**: Average time it takes the trigger to process a request.
        * **Errors**: Number of runtime errors that occurred while running the function.

    You can select a time period for which you want to display information: hour, day, week, month, or a custom interval.

{% endlist %}

## Custom metrics {#metrics}

{% include [metrics](../../../_includes/functions/metrics.md) %}
