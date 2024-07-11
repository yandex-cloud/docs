# Viewing {{ MY }} cluster logs

{{ mmy-name }} allows you to [get a cluster log snippet](#get-log) for the selected period and [view logs in real time](#get-log-stream).

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Getting a cluster log {#get-log}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and select the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.mysql.cluster.switch_logs }}** tab.
   1. Specify the time period you want the log info for: enter it manually or select in the calendar using the date input field.
   1. Select the type of events to display. By default, the `MYSQL_ERROR` type is used.
   1. Specify the hosts and logging level in the line with the date input field if needed.

   A list of log entries for the selected time period will be displayed. To view detailed information about an event, click the respective entry in the list.

   If there are too many records and not all of them are displayed, click **{{ ui-key.yacloud.common.label_load-more }}** at the end of the list.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to view cluster logs:

      ```bash
      {{ yc-mdb-my }} cluster list-logs --help
      ```

   1. Run the following command to get cluster logs (our example does not contain a complete list of available parameters):

      ```bash
      {{ yc-mdb-my }} cluster list-logs <cluster_name_or_ID> \
         --limit <record_number_limit> \
         --format <output_format> \
         --service-type <service_type> \
         --columns <list_of_columns> \
         --filter <filter_settings> \
         --since <left_boundary_of_time_range> \
         --until <right_boundary_of_time_range>
      ```

      Where:

      * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
      * {% include [logs output format](../../_includes/cli/logs/format.md) %}
      * `--service-type`: Service type to display records for (`mysql-error`, `mysql-general`, `mysql-slow-query`, or `mysql-audit`).
      * `--columns`: List of columns with output data:
         * `hostname`: [Host name](hosts.md#list-hosts).
         * `id`: Query ID.
         * `message`: Message output by the service.
         * `status`: Message status, such as `Note` or `Warning`.

         {% note info %}

         The example only contains the main columns. A list of columns to output depends on the selected `--service-type`.

         {% endnote %}

         {% include [logs column format](../../_includes/cli/logs/column-format.md) %}

      * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
      * {% include [logs since time](../../_includes/cli/logs/since.md) %}
      * {% include [logs until time](../../_includes/cli/logs/until.md) %}

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To get a cluster log, use the [listLogs](../api-ref/Cluster/listLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListLogs](../api-ref/grpc/cluster_service.md#ListLogs) gRPC API call, and provide in the request:

   * Cluster ID in the `clusterId` parameter.

      To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

   * Log type, in the `serviceType` parameter:

      {% include [Log types](../../_includes/mdb/mmy/log-types.md) %}

{% endlist %}

## Getting a cluster log stream {#get-log-stream}

This method allows you to get cluster logs in real time.

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To view cluster logs as they become available, run this command:

   ```bash
   {{ yc-mdb-my }} cluster list-logs <cluster_name_or_ID> --follow
   ```

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To get a cluster log stream, use the [streamLogs](../api-ref/Cluster/streamLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/StreamLogs](../api-ref/grpc/cluster_service.md#StreamLogs) gRPC API call, and provide in the request:

   * Cluster ID in the `clusterId` parameter.

      To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

   * Log type, in the `serviceType` parameter:

      {% include [Log types](../../_includes/mdb/mmy/log-types.md) %}

{% endlist %}
