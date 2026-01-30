---
title: Viewing {{ OS }} cluster logs
description: In the managed service for {{ OS }}, you can view and analyze cluster logs.
keywords:
  - OpenSearch logs
  - OpenSearch cluster logs
  - OpenSearch
---

# Viewing {{ OS }} cluster logs

{{ mos-name }} allows you to [get a cluster log snippet](#list-logs) for the selected time period and [view logs in real time](#stream-logs).

## Getting a cluster log {#list-logs}

{% list tabs group=instructions %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.ListLogs](../api-ref/Cluster/listLogs.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>:logs' \
            --url-query serviceType=<host_group_type> \
            --url-query columnFilter=<column_list> \
            --url-query fromTime=<time_range_start> \
            --url-query toTime=<time_range_end>
        ```

        Where:

        * `serviceType`: Type of hosts you need the records for, `OPENSEARCH` or `DASHBOARDS`.
        * `columnFilter`: List of output data columns: The list of data columns depends on the selected type of hosts, `serviceType`:

            * For `{{ OS }}` hosts:

                * `component`: Cluster component the log entry refers to.
                * `hostname`: [Host name](host-groups.md#list-hosts).
                * `level`: Logging level.
                * `message`: Message output by the service.

            * For `Dashboards` hosts:

                * `hostname`: Host name.
                * `message`: Message output by the service.

        * `fromTime`: Start of the time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, e.g., `2024-09-18T15:04:05Z`.
        * `toTime`: End of the time range in the same format as `fromTime`.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.opensearch.v1.ListClusterLogsResponse) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "service_type": "<host_group_type>",
                  "column_filter": [
                    "<column_1>", "<column_2>", ..., "<column_N>"
                  ],
                  "from_time": "<time_range_start>",
                  "to_time": "<time_range_end>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.opensearch.v1.ClusterService.ListLogs
        ```

        Where:

        * `service_type`: Type of hosts you need the records for, `OPENSEARCH` or `DASHBOARDS`.
        * `column_filter`: List of output data columns: The list of data columns depends on the selected type of hosts, `service_type`:

            * For `{{ OS }}` hosts:

                * `component`: Cluster component the log entry refers to.
                * `hostname`: [Host name](host-groups.md#list-hosts).
                * `level`: Logging level.
                * `message`: Message output by the service.

            * For `Dashboards` hosts:

                * `hostname`: Host name.
                * `message`: Message output by the service.

        * `from_time`: Start of the time range in [RFC-3339](https://www.ietf.org/rfc/rfc3339.html) format, e.g., `2024-09-18T15:04:05Z`.
        * `to_time`: End of the time range in the same format as `from_time`.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.opensearch.v1.ListClusterLogsResponse) to make sure your request was successful.

{% endlist %}

## Getting a cluster log stream {#stream-logs}

This method allows you to get cluster logs in real time.

{% list tabs group=instructions %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.StreamLogs](../api-ref/Cluster/streamLogs.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>:stream_logs' \
            --url-query serviceType=<host_group_type> \
            --url-query columnFilter=<column_list>
        ```

        Where:

        * `serviceType`: Type of hosts you need the records for, `OPENSEARCH` or `DASHBOARDS`.
        * `columnFilter`: List of output data columns: The list of data columns depends on the selected type of hosts, `serviceType`:

            * For `{{ OS }}` hosts:

                * `component`: Cluster component the log entry refers to.
                * `hostname`: [Host name](host-groups.md#list-hosts).
                * `level`: Logging level.
                * `message`: Message output by the service.

            * For `Dashboards` hosts:

                * `hostname`: Host name.
                * `message`: Message output by the service.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.opensearch.v1.StreamLogRecord) to make sure your request was successful.

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
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "service_type": "<host_group_type>",
                  "column_filter": [
                    "<column_1>", "<column_2>", ..., "<column_N>"
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.opensearch.v1.ClusterService.StreamLogs
        ```

        Where:

        * `service_type`: Type of hosts you need the records for, `OPENSEARCH` or `DASHBOARDS`.
        * `column_filter`: List of output data columns: The list of data columns depends on the selected type of hosts, `service_type`:

            * For `{{ OS }}` hosts:

                * `component`: Cluster component the log entry refers to.
                * `hostname`: [Host name](host-groups.md#list-hosts).
                * `level`: Logging level.
                * `message`: Message output by the service.

            * For `Dashboards` hosts:

                * `hostname`: Host name.
                * `message`: Message output by the service.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.opensearch.v1.StreamLogRecord) to make sure your request was successful.

        Once you launch the command, it will continue running, displaying new logs in its output in real time.

{% endlist %}
