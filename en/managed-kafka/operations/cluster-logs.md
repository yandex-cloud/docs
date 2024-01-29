# Viewing {{ KF }} cluster logs

{{ mkf-name }} allows you to [get a cluster log snippet](#get-log) for the selected period and [view logs in real time](#get-log-stream).

{% note info %}

Here, the log is the system log of the cluster and its hosts. This log is not related to the partition log for the {{ KF }} topic where the broker writes messages received from message producers.

{% endnote %}

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Getting a cluster log {#get-log}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Click the cluster name and select the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}** tab.
   1. Select **{{ ui-key.yacloud.kafka.label_filter_origin }}**, **{{ ui-key.yacloud.mdb.cluster.logs.label_hosts }}**, and **{{ ui-key.yacloud.mdb.cluster.logs.label_severity }}**.
   1. Specify the time period for which you want to display the log.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to view cluster logs:

      ```bash
      {{ yc-mdb-kf }} cluster list-logs --help
      ```

   1. Run the following command to get cluster logs (our example does not contain a complete list of available parameters):

      ```bash
      {{ yc-mdb-kf }} cluster list-logs <cluster_name_or_ID> \
         --limit <record_number_limit> \
         --columns <list_of_columns_with_output_data> \
         --filter <record_filter_settings> \
         --since <left_boundary_of_time_range> \
         --until <right_boundary_of_time_range>
      ```

      Where:

      * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
      * `--columns`: List of columns with output data:
         * `hostname`: [Host name](cluster-hosts.md#list-hosts).
         * `message`: Message output by the component.
         * `severity`: Logging level, such as `I` or `W` (`Info` or `Warning`, respectively).
         * `origin`: Message source, such as `kafka_server` or `kafka_controller`.

      * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
      * {% include [logs since time](../../_includes/cli/logs/since.md) %}
      * {% include [logs until time](../../_includes/cli/logs/until.md) %}

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To get a cluster log, use the [listLogs](../api-ref/Cluster/listLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListLogs](../api-ref/grpc/cluster_service.md#ListLogs) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [log-limits](../../_includes/mdb/mkf/log-limits.md) %}

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting a log entry stream {#get-log-stream}

This method allows you to get cluster logs in real time.

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To view cluster logs as they become available, run this command:

   ```bash
   {{ yc-mdb-kf }} cluster list-logs <cluster_name_or_ID> --follow
   ```

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To get a cluster's log stream, use the [streamLogs](../api-ref/Cluster/streamLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/StreamLogs](../api-ref/grpc/cluster_service.md#StreamLogs) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [log-limits](../../_includes/mdb/mkf/log-limits.md) %}

   If you do not set the `toTime` parameter value, the stream will receive new log entries as they appear.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}
