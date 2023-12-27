# Viewing {{ CH }} cluster logs

{{ mch-name }} allows you to [get a cluster log snippet](#get-log) for the selected period and [view logs in real time](#get-log-stream).

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Getting cluster logs {#get-log}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and select the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.clickhouse.cluster.switch_logs }}** tab.
   1. Specify the time period for logs to be displayed: enter it manually or select in the calendar by clicking the date input field.
   1. Select the hosts and logging level in the drop-down lists next to the date input field, if required.

   A list of log entries for the selected time period will be displayed. To view detailed information about an event, click the respective entry in the list.

   If there are too many records and not all of them are displayed, click the **{{ ui-key.yacloud.mdb.cluster.logs.button_load-more }}** link at the end of the list.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to view cluster logs:

      ```bash
      {{ yc-mdb-ch }} cluster list-logs --help
      ```

   1. Run this command to get cluster logs:

      ```bash
      {{ yc-mdb-ch }} cluster list-logs <cluster_name_or_ID> \
         --limit <record_number_limit> \
         --columns <list_of_columns_with_output_data> \
         --filter <record_filter_settings> \
         --since <left_boundary_of_time_range> \
         --until <right_boundary_of_time_range>
      ```

      Where:

      * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
      * `--columns`: List of columns with output data:
         * `hostname`: [Host name](hosts.md#list-hosts).
         * `component`: Type of component to be logged. For example, `HTTP-Session`.
         * `message`: Message output by the component.
         * `query_id`: Query ID.
         * `severity`: Logging level, such as `Debug`.
         * `thread`: ID of the thread involved in query handling.
      * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
      * {% include [logs since time](../../_includes/cli/logs/since.md) %}
      * {% include [logs until time](../../_includes/cli/logs/until.md) %}

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get cluster logs, use the [listLogs](../api-ref/Cluster/listLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListLogs](../api-ref/grpc/cluster_service.md#ListLogs) gRPC API call, and provide the following in the request:

   * Cluster ID in the `clusterId` parameter.

      To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

   * `CLICKHOUSE`, in the `serviceType` parameter.

{% endlist %}

## Getting a cluster log stream {#get-log-stream}

This method allows you to get cluster logs in real time.

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To view cluster logs as they become available, run this command:

   ```bash
   {{ yc-mdb-ch }} cluster list-logs <cluster_name_or_ID> --follow
   ```

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a cluster log stream, use the [streamLogs](../api-ref/Cluster/streamLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/StreamLogs](../api-ref/grpc/cluster_service.md#StreamLogs) gRPC API call, and provide in the request:

   * Cluster ID in the `clusterId` parameter.

      To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

   * `CLICKHOUSE`, in the `serviceType` parameter.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
