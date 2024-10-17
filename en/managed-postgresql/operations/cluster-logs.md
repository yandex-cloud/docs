# Viewing {{ PG }} cluster logs

{{ mpg-name }} allows you to [get a cluster log snippet](#get-log) for the selected period and [view logs in real time](#get-log-stream).

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

To identify potential issues in a cluster, [use other tools](../tutorials/performance-problems.md) to analyze the cluster state along with its logs.

## Getting a cluster log {#get-log}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click the cluster name and select the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_logs }}** tab.
   1. Specify the time period you want the log info for: enter it manually or select in the calendar using the date input field.
   1. If required, request the `POOLER` log and specify the hosts and logging level in the line with the date input field.

   A list of log entries for the selected time period will be displayed. To view detailed information about an event, click the respective entry in the list.

   If there are too many records and not all of them are displayed, click **{{ ui-key.yacloud.common.label_load-more }}** at the end of the list.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to view cluster logs:

      ```bash
      {{ yc-mdb-pg }} cluster list-logs --help
      ```

   1. Run the following command to get cluster logs (our example does not contain a complete list of available parameters):

      ```bash
      {{ yc-mdb-pg }} cluster list-logs <cluster_name_or_ID> \
         --limit <record_number_limit> \
         --format <output_format> \
         --service-type <service_type> \
         --columns <list_of_columns_with_output_data> \
         --filter <record_filter_settings> \
         --since <left_boundary_of_time_range> \
         --until <right_boundary_of_time_range>
      ```

      Where:

      * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
      * {% include [logs output format](../../_includes/cli/logs/format.md) %}
      * `--service-type`: Type of service to output records for (`postgresql` or `pooler`).
      * `--columns`: List of columns with output data:
         * `hostname`: [Host name](hosts.md#list-hosts).
         * `db`: [Database name](databases.md#list-db).
         * `level`: Logging level, such as `info`.
         * `pid`: ID of the current session's server process.
         * `text`: Message output by the component.

         {% note info %}

         The example only contains the main columns. A list of columns to output depends on the selected `--service-type`.

         {% endnote %}

         {% include [logs column format](../../_includes/cli/logs/column-format.md) %}

      * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
      * {% include [logs since time](../../_includes/cli/logs/since.md) %}
      * {% include [logs until time](../../_includes/cli/logs/until.md) %}

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To get a cluster log, use the [listLogs](../api-ref/Cluster/listLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListLogs](../api-ref/grpc/Cluster/listLogs.md) gRPC API call, and provide in the request:

   * Cluster ID in the `clusterId` parameter.

      To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

   * Type of service whose logs you are requesting, in the `serviceType` parameter.

      * `POSTGRESQL`: {{ PG }} operations logs.
      * `POOLER`: Connection pooler operations logs.

{% endlist %}

## Getting a cluster log stream {#get-log-stream}

This method allows you to get cluster logs in real time.

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To view cluster logs as they become available, run this command:

   ```bash
   {{ yc-mdb-pg }} cluster list-logs <cluster_name_or_ID> --follow
   ```

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To get a cluster log stream, use the [streamLogs](../api-ref/Cluster/streamLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/StreamLogs](../api-ref/grpc/Cluster/streamLogs.md) gRPC API call, and provide in the request:

   * Cluster ID in the `clusterId` parameter.

      To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

   * Type of service whose logs you are requesting, in the `serviceType` parameter.

      * `POSTGRESQL`: {{ PG }} operations logs.
      * `POOLER`: Connection pooler operations logs.

{% endlist %}
