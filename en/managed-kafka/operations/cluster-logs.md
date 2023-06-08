# Viewing {{ KF }} cluster logs

{{ mkf-name }} allows you to [get a cluster log snippet](#get-log) for the selected period and [view logs in real time](#get-log-stream).

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

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to view cluster logs:

      ```bash
      {{ yc-mdb-kf }} cluster list-logs --help
      ```

   1. Run the following command to get cluster logs (our example does not contain a complete list of available parameters):

      ```bash
      {{ yc-mdb-kf }} cluster list-logs <cluster name or ID> \
         --limit <record number limit> \
         --columns <list of columns to display information> \
         --filter <record filter settings> \
         --since <left boundary of time range> \
         --until <right boundary of time range>
      ```

      Where:

      * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
      * `--columns`: List of columns to display information:
         * `hostname`: [Name of the host](cluster-hosts.md#list-hosts).
         * `message`: Message output by the component.
         * `severity`: Logging level, such as `I` or `W` (`Info` or `Warning`, respectively).
         * `origin`: Message source, such as `kafka_server` or `kafka_controller`.

      * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
      * {% include [logs since time](../../_includes/cli/logs/since.md) %}
      * {% include [logs until time](../../_includes/cli/logs/until.md) %}

   You can request a cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [listLogs](../api-ref/Cluster/listLogs.md) API method and provide the cluster ID in the `clusterId` request parameter.

   {% include [log-limits](../../_includes/mdb/mkf/log-limits.md) %}

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting a log entry stream {#get-log-stream}

This method allows you to get cluster logs in real time.

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To view cluster logs as they become available, run this command:

   ```bash
   {{ yc-mdb-kf }} cluster list-logs <cluster name or ID> --follow
   ```

   You can request a cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [streamLogs](../api-ref/Cluster/streamLogs.md) API method and provide the cluster ID in the `clusterId` request parameter.

   {% include [log-limits](../../_includes/mdb/mkf/log-limits.md) %}

   If you don't set the `toTime` parameter value, the stream will receive new log entries as they appear.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}
