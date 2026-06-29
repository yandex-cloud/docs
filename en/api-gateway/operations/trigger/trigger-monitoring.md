---
title: Viewing trigger monitoring charts in {{ api-gw-full-name }}
description: You can view monitoring charts in {{ api-gw-full-name }} using the management console. To do this, select {{ api-gw-full-name }} and click the trigger whose monitoring charts you want to view.
---

# Viewing trigger monitoring charts in {{ api-gw-full-name }}

 You can monitor triggers using the monitoring tools in the management console. These tools display diagnostic information as charts. [{{ monitoring-name }}](../../../monitoring/) collects metric values and displays charts.

The chart update period is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the trigger.

    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.

    1. Select a trigger for which you want to view monitoring charts.

    1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.

    1. You will see the following charts:

        * **Request latency**: Average time it takes the trigger to process a request.
        * **Read events**: Number of events that have set off a trigger.
        * **Function access errors**: Number of access errors when sending messages to WebSocket connections.
        * **Function call errors**: Number of errors when sending messages to WebSocket connections.

    You can select the time period to display information for: hour, day, week, month, or a custom interval.

{% endlist %}

## Custom metrics {#metrics}

{% include [users-metrics](../../../_includes/api-gateway/users-metrics.md) %}
