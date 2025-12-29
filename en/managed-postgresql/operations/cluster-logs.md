# Viewing {{ PG }} cluster logs

{{ mpg-name }} allows you to [get a cluster log snippet](#get-log) for the selected period and [view logs in real time](#get-log-stream).

{% include [log-duration](../../_includes/mdb/log-duration.md) %}


To identify potential cluster problems, [use other health analysis tools](../tutorials/performance-problems.md) alongside the cluster logs.


## Getting a cluster log {#get-log}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Click the name of your cluster and select the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_logs }}** tab.
    1. Specify a time period for the log entries you want to view: enter it manually or select in the calendar using the date input field.
    
        
    1. If needed, you can request the log `POOLER` and specify particular hosts and logging level in the row with the date input field.
    

    You will see a list of log entries for the time period you specified. To view detailed information about an event, click the relevant entry in the list.

    If there are too many entries and not all of them are displayed, click **{{ ui-key.yacloud.common.label_load-more }}** at the end of the list.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View the description of the CLI command for viewing cluster logs:

        ```bash
        {{ yc-mdb-pg }} cluster list-logs --help
        ```

    1. Run the following command to get cluster logs. Note that our example does not include all available options:

        ```bash
        {{ yc-mdb-pg }} cluster list-logs <cluster_name_or_ID> \
           --limit <entry_number_limit> \
           --format <output_format> \
           --service-type <service_type> \
           --columns <list_of_data_columns> \
           --filter <entry_filtration_settings> \
           --since <time_range_start> \
           --until <time_range_end>
        ```

        Where:

        * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
        * {% include [logs output format](../../_includes/cli/logs/format.md) %}
        * `--service-type`: Source service type to output (`postgresql` or `pooler`).
        * `--columns`: List of data columns:
            * `hostname`: [Host name](hosts.md#list-hosts).
            * `db`: [Database name](databases.md#list-db).
            * `level`: Logging level, e.g., `info`.
            * `pid`: ID of the current session's server process
            * `text`: Message output by the component.

            {% note info %}

            This example includes only the essential columns. The complete list of columns depends on the selected `--service-type`.

            {% endnote %}

            {% include [logs column format](../../_includes/cli/logs/column-format.md) %}

        * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
        * {% include [logs since time](../../_includes/cli/logs/since.md) %}
        * {% include [logs until time](../../_includes/cli/logs/until.md) %}

    You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListLogs](../api-ref/Cluster/listLogs.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>:logs' \
       --url-query serviceType=<service_type> \
       --url-query columnFilter=<column_list> \
       --url-query fromTime=<time_range_start> \
       --url-query toTime=<time_range_end>
     ```

     Where:

     * `serviceType`: Source service type for logs:

       * `POSTGRESQL`: {{ PG }} operations.
       * `POOLER`: Connection manager operations.

     * `columnFilter`: Output column name:

       * `hostname`: [Host name](hosts.md#list-hosts).
       * `db`: [Database name](databases.md#list-db).
       * `level`: Logging level, e.g., `info`.
       * `pid`: ID of the current session's server process
       * `text`: Message output by the component.

       {% note info %}

       The complete list of columns depends on the selected `serviceType`. The example only shows the main columns for the `POOLER` type.

       {% endnote %}

       {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}

     * `fromTime`: Start of the time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, e.g., `2024-09-18T15:04:05Z`.
     * `toTime`: End of the time range in the same format as `fromTime`.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.postgresql.v1.ListClusterLogsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.ListLogs](../api-ref/grpc/Cluster/listLogs.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "service_type": "<service_type>",
             "column_filter": [
               "<column_1>", "<column_2>", ..., "<column_N>"
             ],
             "from_time": "<time_range_start>",
             "to_time": "<time_range_end>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.ListLogs
     ```

     Where:

     * `service_type`: Source service type for logs:

       * `POSTGRESQL`: {{ PG }} operations.
       * `POOLER`: Connection manager operations.

     * `column_filter`: List of output data columns:

       * `hostname`: [Host name](hosts.md#list-hosts).
       * `db`: [Database name](databases.md#list-db).
       * `level`: Logging level, e.g., `info`.
       * `pid`: ID of the current session's server process
       * `text`: Message output by the component.

       {% note info %}

       The complete list of columns depends on the selected `service_type`. The example only shows the main columns for the `POOLER` type.

       {% endnote %}

       {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

     * `from_time`: Start of the time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, e.g., `2024-09-18T15:04:05Z`.
     * `to_time`: End of the time range in the same format as `from_time`.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.postgresql.v1.ListClusterLogsResponse) to make sure your request was successful.

{% endlist %}

## Getting a cluster log stream {#get-log-stream}

This method allows you to get cluster logs in real time.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view cluster logs in real time, run this command:

    ```bash
    {{ yc-mdb-pg }} cluster list-logs <cluster_name_or_ID> --follow
    ```

    You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.StreamLogs](../api-ref/Cluster/streamLogs.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>:stream_logs' \
       --url-query serviceType=<service_type> \
       --url-query columnFilter=<column_list>
     ```

     Where:

     * `serviceType`: Type of the service to get logs for:

       * `POSTGRESQL`: {{ PG }} operation logs.
       * `POOLER`: Connection pooler operation logs.

     * `columnFilter`: Name of the data column:

       * `hostname`: [Host name](hosts.md#list-hosts).
       * `db`: [Database name](databases.md#list-db).
       * `level`: Logging level, e.g., `info`.
       * `pid`: ID of the current session's server process
       * `text`: Message output by the component.

       {% note info %}

       The complete list of columns depends on the selected `serviceType`. The example only shows the main columns for the `POOLER` type.

       {% endnote %}

       {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.postgresql.v1.StreamLogRecord) to make sure your request was successful.

     Once you launch the command, it will continue running, displaying new logs in its output in real time.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.StreamLogs](../api-ref/grpc/Cluster/streamLogs.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "service_type": "<service_type>",
             "column_filter": [
               "<column_1>", "<column_2>", ..., "<column_N>"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.StreamLogs
     ```

     Where:

     * `service_type`: Type of the service to get logs for:

       * `POSTGRESQL`: {{ PG }} operation logs.
       * `POOLER`: Connection pooler operation logs.

     * `column_filter`: List of output data columns:

       * `hostname`: [Host name](hosts.md#list-hosts).
       * `db`: [Database name](databases.md#list-db).
       * `level`: Logging level, e.g., `info`.
       * `pid`: ID of the current session's server process
       * `text`: Message output by the component.

       {% note info %}

       The complete list of columns depends on the selected `service_type`. The example only shows the main columns for the `POOLER` type.

       {% endnote %}

       {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.postgresql.v1.StreamLogRecord) to make sure your request was successful.

     Once you launch the command, it will continue running, displaying new logs in its output in real time.

{% endlist %}
