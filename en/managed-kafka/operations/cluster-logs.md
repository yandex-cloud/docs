# Viewing cluster logs

{{ mkf-name }} lets you get cluster logs for viewing and analysis.

You can get:

- [A simple log snippet](#get-log).
- [A log stream](#get-log-stream) from the server in the cluster (you can use the semantics of the `tail -f` command to work with logs).

{% note info %}

Here, the log is the system log of the cluster and its hosts. This log isn't related to the partition log for the {{ KF }} topic where the broker writes messages received from message producers.

{% endnote %}

## Get cluster logs {#get-log}

{% list tabs %}

{% if api != "noshow" %}

- API

  Use the [listLogs](../api-ref/Cluster/listLogs.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  You'll get the full cluster log. The number of log entries that the cluster can return must not exceed 100,000 (100 pages of 1000 entries each).

  If the log size exceeds this value or you want to get logs for a specific period of time, use `timestamps`. To do this, set the start and end timestamps (see the timestamp format in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt)) in the `fromTime` and `toTime` request parameters, respectively.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endif %}

{% endlist %}

## Get cluster log streams {#get-log-stream}

This way of working with logs is different from [getting a simple log snippet](#get-log) by the fact that the server can send more logs as they appear. This behavior is the same as the semantics of the `tail -f` command for working with logs.

{% list tabs %}

{% if api != "noshow" %}

- API

  Use the [streamLogs](../api-ref/Cluster/streamLogs.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  You'll get the full cluster log. The number of log entries that the cluster can return must not exceed 100,000 (100 pages of 1000 entries each).

  If the log size exceeds this value or you want to get logs for a specific period of time, use `timestamps`. To do this, set the start and end timestamps (see the timestamp format in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt)) in the `fromTime` and `toTime` request parameters, respectively.

  If you don't set the `toTime` parameter value, the stream will receive new log messages as they appear.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endif %}

{% endlist %}
