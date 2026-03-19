# Viewing {{ SPQR }} cluster logs

{{ mspqr-name }} allows you to [get a cluster log snippet](#get-log) for the selected time period and [view logs in real time](#get-log-stream).

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Getting a cluster log {#get-log}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
    1. Click the name of your cluster and select the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_logs }}** tab.
    1. Specify a time period for the log entries you want to view: enter it manually or select in the calendar using the date input field.
    1. Optionally, add log filters in the row with the date input field:
       1. Select the `INFRA`, `ROUTER`, or `COORDINATOR` service type.
       1. Specify the hosts.
       1. Select the logging level.

    You will see a list of log entries for the chosen time period. To see details of a specific event, click its entry in the list.

    If the list is too long to display all entries at once, click **{{ ui-key.yacloud.common.label_load-more }}** at the end of the list.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. See the description of the CLI command for viewing cluster logs:

        ```bash
        yc managed-sharded-postgresql cluster list-logs --help
        ```

    1. Run the command below to get cluster logs. Note that this example does not show all available command options:

        ```bash
        yc managed-sharded-postgresql cluster list-logs <cluster_name_or_ID> \
           --limit <entry_number_limit> \
           --service-type <service_type> \
           --columns <list_of_data_columns> \
           --filter <entry_filtration_settings> \
           --since <time_range_start> \
           --until <time_range_end>
        ```

        Where:

        * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
        * `--service-type`: Target service type for log retrieval (`infra`, `router`, or `coordinator`).
        * `--columns`: List of output columns:
            * `hostname`: Host name.
            * `severity`: Logging level, e.g., `info`.
            * `message`: Component’s log message.
            * `contextual_data`: Additional information.

        * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
        * {% include [logs since time](../../_includes/cli/logs/since.md) %}
        * {% include [logs until time](../../_includes/cli/logs/until.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListLogs](../api-ref/Cluster/listLogs.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>:logs' \
       --url-query serviceType=<service_type> \
       --url-query columnFilter=<column_1> \
       --url-query columnFilter=<column_2> \
       ... \
       --url-query columnFilter=<column_N> \
       --url-query fromTime=<time_range_start> \
       --url-query toTime=<time_range_end>
     ```

     Where:

     * `serviceType`: Target service type for log retrieval:

       * `INFRA`: `INFRA` host operations, which acts as both the router and coordinator.
       * `ROUTER`: Router operations.
       * `COORDINATOR`: Coordinator operations.

     * `columnFilter`: Name of the data column:

       * `hostname`: Host name.
       * `severity`: Logging level, e.g., `info`.
       * `message`: Component’s log message.
       * `contextual_data`: Additional information.

       {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}

     * `fromTime`: Start of the time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, e.g., `2024-09-18T15:04:05Z`.
     * `toTime`: End of the time range in the same format as `fromTime`.

  1. Check the [server response](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.spqr.v1.ListClusterLogsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.ListLogs](../api-ref/grpc/Cluster/listLogs.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
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
       yandex.cloud.mdb.spqr.v1.ClusterService.ListLogs
     ```

     Where:

     * `service_type`: Target service type for log retrieval:

       * `INFRA`: `INFRA` host operations, which acts as both the router and coordinator.
       * `ROUTER`: Router operations.
       * `COORDINATOR`: Coordinator operations.

     * `column_filter`: List of output columns:

       * `hostname`: Host name.
       * `severity`: Logging level, e.g., `info`.
       * `message`: Component’s log message.
       * `contextual_data`: Additional information.

       {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

     * `from_time`: Start of the time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, e.g., `2024-09-18T15:04:05Z`.
     * `to_time`: End of the time range in the same format as `from_time`.

  1. Check the [server response](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.spqr.v1.ListClusterLogsResponse) to make sure your request was successful.

{% endlist %}

## Streaming cluster logs {#get-log-stream}

This method allows you to stream cluster logs in real time.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view cluster logs in real time, run this command:

    ```bash
    yc managed-sharded-postgresql cluster list-logs <cluster_name_or_ID> \
       --service-type <service_type> \
       --follow
    ```

    Where `--service-type` is the target service type for log retrieval (`infra`, `router`, or `coordinator`).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.StreamLogs](../api-ref/Cluster/streamLogs.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>:stream_logs' \
       --url-query serviceType=<service_type> \
       --url-query columnFilter=<column_1> \
       --url-query columnFilter=<column_2> \
       ... \
       --url-query columnFilter=<column_N> \
     ```

     Where:

     * `serviceType`: Target service type for log retrieval:

       * `INFRA`: `INFRA` host operations, which acts as both the router and coordinator.
       * `ROUTER`: Router operations.
       * `COORDINATOR`: Coordinator operations.

     * `columnFilter`: Name of the data column:

       * `hostname`: Host name.
       * `severity`: Logging level, e.g., `info`.
       * `message`: Component’s log message.
       * `contextual_data`: Additional information.

       {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}

  1. Check the [server response](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.spqr.v1.StreamLogRecord) to make sure your request was successful.

     Once you launch the command, it will continue running, displaying new logs in its output in real time.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.StreamLogs](../api-ref/grpc/Cluster/streamLogs.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "service_type": "<service_type>",
             "column_filter": [
               "<column_1>", "<column_2>", ..., "<column_N>"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.StreamLogs
     ```

     Where:

     * `service_type`: Target service type for log retrieval:

       * `INFRA`: `INFRA` host operations, which acts as both the router and coordinator.
       * `ROUTER`: Router operations.
       * `COORDINATOR`: Coordinator operations.

     * `column_filter`: List of output columns:

       * `hostname`: Host name.
       * `severity`: Logging level, e.g., `info`.
       * `message`: Component’s log message.
       * `contextual_data`: Additional information.

       {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

  1. Check the [server response](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.spqr.v1.StreamLogRecord) to make sure your request was successful.

     Once you launch the command, it will continue running, displaying new logs in its output in real time.

{% endlist %}
