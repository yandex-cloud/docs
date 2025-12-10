# Viewing {{ CH }} cluster logs

{{ mch-name }} allows you to [get a cluster log snippet](#get-log) for the selected period and [view logs in real time](#get-log-stream).

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Getting cluster logs {#get-log}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.clickhouse.cluster.switch_logs }}** tab.
    1. Specify a time period for the log entries you want to view: enter it manually or select in the calendar using the date input field.
    1. Specify the hosts and logging level in the row with the date input field, if required.

    You will see a list of log entries for the time period you specified. To view detailed information about an event, click the relevant entry in the list.

    If there are too many entries and not all of them are displayed, click **{{ ui-key.yacloud.common.label_load-more }}** at the end of the list.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View the description of the CLI command for viewing cluster logs:

        ```bash
        {{ yc-mdb-ch }} cluster list-logs --help
        ```

    1. Run this command to get cluster logs:

        ```bash
        {{ yc-mdb-ch }} cluster list-logs <cluster_name_or_ID> \
           --limit <entry_number_limit> \
           --columns <list_of_data_columns> \
           --filter <entry_filtration_settings> \
           --since <time_range_start> \
           --until <time_range_end>
        ```

        Where:

        * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
        * `--columns`: List of output data columns:
            * `hostname`: [Host name](hosts.md#list-hosts).
            * `component`: Type of component to log, e.g., `HTTP-Session`.
            * `message`: Message output by the component.
            * `query_id`: Query ID.
            * `severity`: Logging level, e.g., `Debug`.
            * `thread`: ID of the thread involved in query handling.
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
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>:logs' \
            --url-query serviceType=CLICKHOUSE \
            --url-query columnFilter=<list_of_data_columns> \
            --url-query fromTime=<time_range_start> \
            --url-query toTime=<time_range_end>
        ```

        Where:

        * `serviceType`: Type of service to request logs for. The only valid value is `CLICKHOUSE`.
        * `columnFilter`: List of output data columns:

            {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

            {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}

        {% include [from-time-rest](../../_includes/mdb/api/from-time-rest.md) %}

        * `toTime`: End of the time range in the same format as `fromTime`.

        
        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).


    1. View the [server response](../api-ref/Cluster/listLogs.md#responses) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "service_type" : "CLICKHOUSE",
                    "column_filter": [<list_of_data_columns>],
                    "from_time": "<time_range_start>" \
                    "to_time": "<time_range_end>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.ListLogs
        ```

        Where:

        * `service_type`: Type of service to request logs for. The only valid value is `CLICKHOUSE`.
        * `column_filter`: List of output data columns:

            {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

            {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

        {% include [from-time-grpc](../../_includes/mdb/api/from-time-grpc.md) %}

        * `to_time`: End of the time range in the same format as `from_time`.

        
        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).


    1. View the [server response](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsResponse) to make sure your request was successful.

{% endlist %}

## Getting a cluster log stream {#get-log-stream}

This method allows you to get cluster logs in real time.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view cluster logs in real time, run this command:

    ```bash
    {{ yc-mdb-ch }} cluster list-logs <cluster_name_or_ID> --follow
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
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>:stream_logs' \
            --url-query serviceType=CLICKHOUSE \
            --url-query columnFilter=<list_of_data_columns> \
            --url-query fromTime=<time_range_start> \
            --url-query toTime=<time_range_end> \
            --url-query filter=<log_filter>
        ```

        Where:

        * `serviceType`: Type of service to request logs for. The only valid value is `CLICKHOUSE`.
        * `columnFilter`: List of output data columns:

            {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

            {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}

        {% include [from-time-rest](../../_includes/mdb/api/from-time-rest.md) %}

        * `toTime`: End of the time range in the same format as `fromTime`.

            {% include [tail-f-semantics](../../_includes/mdb/api/tail-f-semantics.md) %}

        * `filter`: Log filter. You can filter logs so that the stream contains only the logs you need.

            For more information about filters and their syntax, see the [API reference](../api-ref/Cluster/streamLogs.md#query_params).

            {% include [stream-logs-filter](../../_includes/mdb/api/stream-logs-filter.md) %}

        
        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).


    1. View the [server response](../api-ref/Cluster/streamLogs.md#responses) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "service_type" : "CLICKHOUSE",
                    "column_filter": [<list_of_data_columns>],
                    "from_time": "<time_range_start>",
                    "to_time": "<time_range_end>",
                    "filter": "<log_filter>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.StreamLogs
        ```

        Where:

        * `service_type`: Type of service to request logs for. The only valid value is `CLICKHOUSE`.
        * `column_filter`: List of output data columns:

            {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

            {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

        {% include [from-time-grpc](../../_includes/mdb/api/from-time-grpc.md) %}

        * `to_time`: End of the time range in the same format as `from_time`.

            {% include [tail-f-semantics](../../_includes/mdb/api/tail-f-semantics.md) %}

        * `filter`: Log filter. You can filter logs so that the stream contains only the logs you need.

            {% include [stream-logs-filter](../../_includes/mdb/api/stream-logs-filter.md) %}

            For more information about filters and their syntax, see the [API reference](../api-ref/grpc/Cluster/streamLogs.md).

        
        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).


    1. View the [server response](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.clickhouse.v1.StreamLogRecord) to make sure your request was successful.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
