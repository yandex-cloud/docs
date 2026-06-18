---
title: Viewing monitoring charts in {{ serverless-containers-full-name }}
description: You can view monitoring charts in {{ serverless-containers-full-name }} using the management console. To do this, navigate to {{ serverless-containers-name }} and click the trigger whose monitoring charts you want to view.
---

# Viewing trigger monitoring charts in {{ serverless-containers-name }}

You can monitor triggers using the monitoring tools in the management console. These tools display diagnostic information as charts. [{{ monitoring-name }}](../../monitoring/) collects metric values and displays charts. 

The chart refresh interval is 15 seconds.

## Viewing monitoring charts {#charts}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the trigger.

    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

    1. Select a trigger for which you want to view monitoring charts.

    1. Navigate to the **{{ ui-key.yacloud.common.monitoring }}** tab.

    1. You will see the following charts:

        * **Request latency**: Average time it takes the trigger to process a request.
        * **Read events**: Number of events that have set off the trigger.
        * **Function access errors**: Number of access errors when invoking the container.
        * **Function call errors**: Number of errors when invoking the container.
        * **DLQ access errors**: Number of errors when accessing the [dead-letter queue](../../serverless-containers/concepts/dlq.md).
        * **Send to DLQ errors**: Number of errors when sending messages to the dead-letter queue.

    You can select a time period for which you want to display information: hour, day, week, month, or a custom interval.

{% endlist %}

## Custom metrics {#metrics}

{% include [metrics](../../_includes/serverless-containers/metrics.md) %}
