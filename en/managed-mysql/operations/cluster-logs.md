# Viewing {{ MY }} cluster logs

{{ mmy-name }} allows you to [get a cluster log snippet](#get-log) for the selected period and [view logs in real time](#get-log-stream).

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Getting a cluster log {#get-log}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.mysql.cluster.switch_logs }}** tab.
    1. Specify the time period you want the log info for: enter it manually or select in the calendar using the date input field.
    1. Select the type of events to display. The default type is `MYSQL_ERROR`.
    1. Specify the hosts and logging level in the line with the date input field if needed.

    A list of log entries for the selected time period will be displayed. To view detailed information about an event, click the respective entry in the list.

    If there are too many records and not all of them are displayed, click **{{ ui-key.yacloud.common.label_load-more }}** at the end of the list.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View the description of the CLI command to view cluster logs:

        ```bash
        {{ yc-mdb-my }} cluster list-logs --help
        ```

    1. Run the following command to get cluster logs (our example does not contain a complete list of available parameters):

        ```bash
        {{ yc-mdb-my }} cluster list-logs <cluster_name_or_ID> \
           --limit <entry_number_limit> \
           --format <output_format> \
           --service-type <service_type> \
           --columns <column_list> \
           --filter <filter_settings> \
           --since <time_range_left_boundary> \
           --until <time_range_right_boundary>
        ```

        Where:

        * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
        * {% include [logs output format](../../_includes/cli/logs/format.md) %}
        * `--service-type`: Type of the service for which you want to output records (`mysql-error`, `mysql-general`, `mysql-slow-query`, or `mysql-audit`).
        * `--columns`: List of columns for data output:

            * `hostname`: [Host name](hosts.md#list-hosts).
            * `id`: Request ID.
            * `message`: Message output by the service.
            * `status`: Message status, e.g., `Note` or `Warning`.

            {% note info %}

            The example only contains the main columns. A list of columns to output depends on the selected `--service-type`.

            {% endnote %}

            {% include [logs column format](../../_includes/cli/logs/column-format.md) %}

        * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
        * {% include [logs since time](../../_includes/cli/logs/since.md) %}
        * {% include [logs until time](../../_includes/cli/logs/until.md) %}

    You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.listLogs](../api-ref/Cluster/listLogs.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>:logs' \
            --url-query serviceType=<service_type> \
            --url-query columnFilter=<column_list> \
            --url-query fromTime=<time_range_left_boundary> \
            --url-query toTime=<time_range_right_boundary>
        ```

        Where:

        * `serviceType`: Type of the service to get logs for:

            {% include [Log types](../../_includes/mdb/mmy/log-types.md) %}

        * `columnFilter`: List of columns for data output:

            * `hostname`: [Host name](hosts.md#list).
            * `id`: Request ID.
            * `message`: Message output by the service.
            * `status`: Message status, e.g., `Note` or `Warning`.
            * `raw`: Raw data for all columns.

            {% note info %}

            The example only contains the main columns. A list of columns to output depends on the selected `serviceType`.

            {% endnote %}

        * `fromTime`: Left boundary of a time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, Example: `2024-09-18T15:04:05Z`.
        * `toTime`: Right boundary of a time range, the format is the same as for `fromTime`.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [ClusterService/ListLogs](../api-ref/grpc/Cluster/listLogs.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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
                "from_time": "<time_range_left_boundary>",
                "to_time": "<time_range_right_boundary>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.ListLogs
        ```

        Where:

        * `service_type`: Type of the service to get logs for:

            {% include [Log types](../../_includes/mdb/mmy/log-types.md) %}

        * `column_filter`: List of columns for data output:

            * `hostname`: [Host name](hosts.md#list).
            * `id`: Request ID.
            * `message`: Message output by the service.
            * `status`: Message status, e.g., `Note` or `Warning`.
            * `raw`: Raw data for all columns.

            {% note info %}

            The example only contains the main columns. A list of columns to output depends on the selected `service_type`.

            {% endnote %}

        * `from_time`: Left boundary of a time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, e.g., `2024-09-18T15:04:05Z`.
        * `to_time`: Right boundary of a time range, the format is the same as for `from_time`.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse) to make sure the request was successful.

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

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.streamLogs](../api-ref/Cluster/streamLogs.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>:stream_logs' \
            --url-query serviceType=<service_type> \
            --url-query columnFilter=<column_list>
        ```

        Where:

        * `serviceType`: Type of the service to get logs for:

            {% include [Log types](../../_includes/mdb/mmy/log-types.md) %}

        * `columnFilter`: List of columns for data output:

            * `hostname`: [Host name](hosts.md#list-hosts).
            * `id`: Request ID.
            * `message`: Message output by the service.
            * `status`: Message status, e.g., `Note` or `Warning`.
            * `raw`: Raw data for all columns.

            {% note info %}

            The example only contains the main columns. A list of columns to output depends on the selected `serviceType`.

            {% endnote %}

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.mysql.v1.StreamLogRecord) to make sure the request was successful.

        Once you run the command, it does not terminate. The command output displays new logs in real time.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [ClusterService/StreamLogs](../api-ref/grpc/Cluster/streamLogs.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

        * `service_type`: Type of the service to get logs for:

            {% include [Log types](../../_includes/mdb/mmy/log-types.md) %}

        * `column_filter`: List of columns for data output:

            * `hostname`: [Host name](hosts.md#list-hosts).
            * `id`: Request ID.
            * `message`: Message output by the service.
            * `status`: Message status, e.g., `Note` or `Warning`.
            * `raw`: Raw data for all columns.

            {% note info %}

            The example only contains the main columns. A list of columns to output depends on the selected `service_type`.

            {% endnote %}

        * `from_time`: Left boundary of a time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, e.g., `2024-09-18T15:04:05Z`.
        * `to_time`: Right boundary of a time range, the format is the same as for `from_time`.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.mysql.v1.StreamLogRecord) to make sure the request was successful.

        Once you run the command, it does not terminate. The command output displays new logs in real time.

{% endlist %}
