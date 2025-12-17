# Viewing {{ MY }} cluster logs

{{ mmy-name }} allows you to [get a cluster log snippet](#get-log) for the selected period and to [view logs in real time](#get-log-stream).

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Getting a cluster log {#get-log}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
    1. Click the name of your cluster and select the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.mysql.cluster.switch_logs }}** tab.
    1. Specify a time period for the log entries you want to view by entering it manually or selecting it in the calendar using the date input field.
    1. Select the type of events to display. The default type is `MYSQL_ERROR`.
    1. Specify the hosts and logging level in the row with the date input field, if required.

    You will see a list of log entries for the time period you specified. To view detailed information about an event, click the relevant entry in the list.

    If there are too many entries and not all of them are displayed, click **{{ ui-key.yacloud.common.label_load-more }}** at the end of the list.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. See the description of the CLI command for viewing cluster logs:

        ```bash
        {{ yc-mdb-my }} cluster list-logs --help
        ```

    1. Run the following command to get cluster logs (our example only shows some of the available parameters):

        ```bash
        {{ yc-mdb-my }} cluster list-logs <cluster_name_or_ID> \
           --limit <entry_number_limit> \
           --format <output_format> \
           --service-type <service_type> \
           --columns <column_list> \
           --filter <filter_settings> \
           --since <time_range_start> \
           --until <time_range_end>
        ```

        Where:

        * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
        * {% include [logs output format](../../_includes/cli/logs/format.md) %}
        * `--service-type`: Type of the service for which you want to output entries (`mysql-error`, `mysql-general`, `mysql-slow-query`, or `mysql-audit`).
        * `--columns`: List of data columns:

            * `hostname`: [Host name](hosts.md#list-hosts).
            * `id`: Query ID.
            * `message`: Message output by the service.
            * `status`: Message status, e.g., `Note` or `Warning`.

            {% note info %}

            This example includes only the essential columns. The complete list of columns depends on the selected `--service-type`.

            {% endnote %}

            {% include [logs column format](../../_includes/cli/logs/column-format.md) %}

        * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
        * {% include [logs since time](../../_includes/cli/logs/since.md) %}
        * {% include [logs until time](../../_includes/cli/logs/until.md) %}

    You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.listLogs](../api-ref/Cluster/listLogs.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>:logs' \
            --url-query serviceType=<service_type> \
            --url-query columnFilter=<column_list> \
            --url-query fromTime=<time_range_start> \
            --url-query toTime=<time_range_end>
        ```

        Where:

        * `serviceType`: Type of the service for which you want to get logs:

            {% include [Log types](../../_includes/mdb/mmy/log-types.md) %}

        * `columnFilter`: List of data columns:

            * `hostname`: [Host name](hosts.md#list).
            * `id`: Query ID.
            * `message`: Message output by the service.
            * `status`: Message status, e.g., `Note` or `Warning`.
            * `raw`: Raw data for all columns.

            {% note info %}

            This example includes only the essential columns. The complete list of columns depends on the selected `serviceType`.

            {% endnote %}

        * `fromTime`: Start of the time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, e.g., `2024-09-18T15:04:05Z`.
        * `toTime`: End of the time range in the same format as `fromTime`.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [ClusterService/ListLogs](../api-ref/grpc/Cluster/listLogs.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
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
          yandex.cloud.mdb.mysql.v1.ClusterService.ListLogs
        ```

        Where:

        * `service_type`: Type of the service for which you want to get logs:

            {% include [Log types](../../_includes/mdb/mmy/log-types.md) %}

        * `column_filter`: List of data columns:

            * `hostname`: [Host name](hosts.md#list).
            * `id`: Query ID.
            * `message`: Message output by the service.
            * `status`: Message status, e.g., `Note` or `Warning`.
            * `raw`: Raw data for all columns.

            {% note info %}

            This example includes only the essential columns. The complete list of columns depends on the selected `service_type`.

            {% endnote %}

        * `from_time`: Start of the time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, e.g., `2024-09-18T15:04:05Z`.
        * `to_time`: End of the time range in the same format as `from_time`.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse) to make sure your request was successful.

{% endlist %}

## Getting a cluster log stream {#get-log-stream}

This method allows you to get cluster logs in real time.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view cluster logs in real time, run this command:

    ```bash
    {{ yc-mdb-my }} cluster list-logs <cluster_name_or_ID> --follow
    ```

    You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.streamLogs](../api-ref/Cluster/streamLogs.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>:stream_logs' \
            --url-query serviceType=<service_type> \
            --url-query columnFilter=<column_list>
        ```

        Where:

        * `serviceType`: Type of the service for which you want to get logs:

            {% include [Log types](../../_includes/mdb/mmy/log-types.md) %}

        * `columnFilter`: List of output data columns:

            * `hostname`: [Host name](hosts.md#list-hosts).
            * `id`: Query ID.
            * `message`: Message output by the service.
            * `status`: Message status, e.g., `Note` or `Warning`.
            * `raw`: Raw data for all columns.

            {% note info %}

            This example includes only the essential columns. The complete list of columns depends on the selected `serviceType`.

            {% endnote %}

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.mysql.v1.StreamLogRecord) to make sure your request was successful.

        The command continues running after execution, displaying new logs in its output in real time.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [ClusterService/StreamLogs](../api-ref/grpc/Cluster/streamLogs.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "service_type": "<service_type>",
                  "column_filter": [
                    "<column_1>", "<column_2>", ..., "<column_N>"
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mysql.v1.ClusterService.StreamLogs
        ```

        Where:

        * `service_type`: Type of the service for which you want to get logs:

            {% include [Log types](../../_includes/mdb/mmy/log-types.md) %}

        * `column_filter`: List of output data columns:

            * `hostname`: [Host name](hosts.md#list-hosts).
            * `id`: Query ID.
            * `message`: Message output by the service.
            * `status`: Message status, e.g., `Note` or `Warning`.
            * `raw`: Raw data for all columns.

            {% note info %}

            This example includes only the essential columns. The complete list of columns depends on the selected `service_type`.

            {% endnote %}

        * `from_time`: Start of the time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, e.g., `2024-09-18T15:04:05Z`.
        * `to_time`: End of the time range in the same format as `from_time`.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.mysql.v1.StreamLogRecord) to make sure your request was successful.

        Once you launch the command, it will continue running, displaying new logs in its output in real time.

{% endlist %}
