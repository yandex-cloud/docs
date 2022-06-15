# Viewing cluster logs

{{ mkf-name }} allows you to get cluster logs for viewing and analysis.

You can get:

* [Simple log snippet](#get-log).
* A [log entry stream](#get-log-stream) in the cluster (`tail -f` command semantics are supported).

{% note info %}

Here, the log is the system log of the cluster and its hosts. This log isn't related to the partition log for the {{ KF }} topic where the broker writes messages received from message producers.

{% endnote %}

## Getting a cluster log {#get-log}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to Billing.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click on the name of the cluster and select the **Logs** tab.
   1. Select the **Source**, **Host**, and **Logging level**.
   1. Specify the time period for which you want to display the log.

- API

   Use the [listLogs](../api-ref/Cluster/listLogs.md) API method and pass the cluster ID in the `clusterId` request parameter.

   {% include [log-limits](../../_includes/mdb/mkf/log-limits.md) %}

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting a log entry stream {#get-log-stream}

This method differs from [getting a simple log snippet](#get-log) because the server can send more log entries as they appear. This behavior is the same as the semantics of the `tail -f` command for working with logs.

{% list tabs %}

- API

   Use the [streamLogs](../api-ref/Cluster/streamLogs.md) API method and pass the cluster ID in the `clusterId` request parameter.

   {% include [log-limits](../../_includes/mdb/mkf/log-limits.md) %}

   If you don't set the `toTime` parameter value, the stream will receive new log entries as they appear.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}
