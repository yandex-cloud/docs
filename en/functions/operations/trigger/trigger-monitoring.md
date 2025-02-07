---
title: Viewing monitoring charts in {{ sf-full-name }}
description: You can view a monitoring chart in {{ sf-full-name }} using the management console by selecting {{ sf-name }} and clicking the trigger of interest.
---

# Viewing trigger monitoring charts in {{ sf-name }}

You can monitor triggers using the monitoring tools in your management console. These tools display diagnostic information as charts. Metric values are collected and charts are displayed by [{{ monitoring-name }}](../../../monitoring/).

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.

    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. Select a trigger to view its monitoring charts.

    1. Go to the **{{ ui-key.yacloud.component.navigation-menu.label_monitoring }}** tab.

    1. The following charts will open on the page:

        * **Request latency**: Average time it takes a trigger to process a request.
        * **Read events**: Number of events that have set off a trigger.
        * **Function access errors**: Number of access errors when invoking a function.
        * **Function call errors**: Number of errors when invoking a function.
        * **DLQ access errors**: Number of errors when accessing the [Dead Letter Queue](../../concepts/dlq.md).
        * **Send to DLQ errors**: Number of errors when sending messages to the Dead Letter Queue.

    You can select the time period to display information for: hour, day, week, month, or a custom interval.

{% endlist %}

## Custom metrics {#metrics}

{% include [metrics](../../../_includes/functions/metrics.md) %}
