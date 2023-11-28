# Resolving the "RESOURCE_EXHAUSTED" error



## Issue description {#issue-description}

While working with Managed Service for YDB, you see the `RESOURCE_EXHAUSTED` error.

## Solution {#case-resolution}

Check the cluster monitoring charts for exceeding [quotas and limits of Managed Service for YDB](../../../ydb/concepts/limits.md).
For the database state monitoring charts of Managed Service for YDB:

1. Go to the page of your cloud folder and select **Managed Service for YDB**.
2. Click on the name of the required database and select the **Monitoring** tab.
3. To start working with metrics, dashboards, or alerts in Yandex Monitoring, click the **Open in Monitoring** button on the top panel.

On the page that opens, you will see the DB status charts.
If the `Requests per second` and `Request units per second` metrics on database monitoring charts often approach service limits, [increase the throughput](../../../ydb/operations/manage-databases#update-db-serverless) in the YDB cluster parameters.

{% note info %}

Increasing the throughput in the database settings might increase its operating expenses.

{% endnote %}

You can also create a [request to increase the quotas](https://console.cloud.yandex.com/cloud?section=quotas) of Managed Service for YDB from the management console.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. YDB cluster ID.
2. Date and time when the issue occurred.
3. Link to the database status chart in Yandex Monitoring.
4. Error messages arising when connecting to the database from client applications or via the YDB CLI tools.
