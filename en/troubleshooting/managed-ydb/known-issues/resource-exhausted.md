# Fixing the `RESOURCE_EXHAUSTED` error



## Issue description {#issue-description}

When using {{ ydb-name }}, you get the `RESOURCE_EXHAUSTED` error.

## Solution {#issue-resolution}

Check the cluster monitoring charts for exceeding [{{ ydb-name }} quotas and limits](../../../ydb/concepts/limits.md).
To view the {{ ydb-name }} database monitoring charts, follow these steps:

1. Navigate to your folder dashboard and select {{ ydb-name }}.
1. Click the database name and open the **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** tab.
1. To get started with {{ monitoring-full-name }} metrics, dashboards, or alerts, click **{{ ui-key.yacloud_monitoring.dashboard.dash.open-in-monitoring }}** in the top panel.

On the page that opens, you will see the database status charts. If the `Requsts per second` and `Request units per second` metrics on database monitoring charts often touch the limits, [increase the throughput](../../../ydb/operations/manage-databases.md#update-db-serverless) in the {{ ydb-name }} cluster settings.

{% note warning %}

Increasing the throughput in the database settings might increase its operating expenses.

{% endnote %}

You can also [request a {{ ydb-name }} quota increase]({{ link-console-quotas }}) from the [management console]({{ link-console-main }}).

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ ydb-short-name }} cluster ID.
1. Date and time when the issue occurred.
1. Link to the database status chart in {{ monitoring-full-name }}.
1. Error messages appearing when connecting to the database from client applications or via the {{ ydb-short-name }} CLI.