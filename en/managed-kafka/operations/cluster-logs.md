# Viewing {{ KF }} cluster logs

{{ mkf-name }} lets you [get a cluster log snippet](#get-log) for the selected period and [view logs in real time](#get-log-stream).

{% note info %}

Here, the log is the system log of the cluster and its hosts. This log isn't related to the partition log for the {{ KF }} topic where the broker writes messages received from message producers.

{% endnote %}

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Getting a cluster log {#get-log}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click the name of the desired cluster and select the ![image](../../_assets/logs.svg) **Logs** tab.
   1. Select the **Source**, **Host**, and **Logging level**.
   1. Specify the time period for which you want to display the log.

- API

   Use the [listLogs](../api-ref/Cluster/listLogs.md) API method and pass the cluster ID in the `clusterId` request parameter.

   {% include [log-limits](../../_includes/mdb/mkf/log-limits.md) %}

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting a log entry stream {#get-log-stream}

This method lets you get cluster logs in real time.

{% list tabs %}

- API

   Use the [streamLogs](../api-ref/Cluster/streamLogs.md) API method and pass the cluster ID in the `clusterId` request parameter.

   {% include [log-limits](../../_includes/mdb/mkf/log-limits.md) %}

   If you don't set the `toTime` parameter value, the stream will receive new log entries as they appear.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}
