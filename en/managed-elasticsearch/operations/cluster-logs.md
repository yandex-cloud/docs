---
title: Viewing Elasticsearch cluster logs
description: Yandex Managed Service for Elasticsearch allows you to get cluster logs for viewing and analyzing.
keywords:
  - Elasticsearch logs
  - Elasticsearch cluster logs
  - Elasticsearch
---

# Viewing {{ ES }} cluster logs

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

{{ mes-name }} allows you to [get a cluster log snippet](#get-log) for the selected period and [view logs in real time](#get-log-stream).

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Getting a cluster log {#get-log}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}** tab.
    1. Specify the time period you want the log info for: enter it manually or select in the calendar using the date input field.
    1. Select `ELASTICSEARCH` from the drop-down list next to the date input field.

    A list of log entries for the selected time period will be displayed. To view detailed information about an event, click the respective entry in the list.

    If there are too many entries and not all of them are displayed, click **{{ ui-key.yacloud.common.label_load-more }}** at the end of the list.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View the description of the CLI command to view cluster logs:

        ```bash
        {{ yc-mdb-es }} cluster list-logs --help
        ```

    1. Run the following command to get cluster logs (our example does not contain a complete list of available parameters):

        ```bash
        {{ yc-mdb-es }} cluster list-logs <cluster_name_or_ID> \
           --limit <entry_number_limit> \
           --service-type <service_type> \
           --columns <list_of_columns_for_data_output> \
           --filter <entry_filtration_settings> \
           --since <time_range_left_boundary> \
           --until <time_range_right_boundary>
        ```

        Where:

        * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
        * `--service-type`: Type of the service for which you want to output entries (`elasticsearch` or `kibana`).
        * `--columns`: List of columns for data output:
            * `component`: Type of component to log, e.g., `o.e.n.Node`.
            * `hostname`: [Host name](cluster-hosts.md#list-hosts).
            * `level`: Logging level, e.g., `INFO`.
            * `message`: Message output by the component.
            * `stacktrace`: Additional debugging information.
            * `query_id`: Request ID.
            * `type`: Entry type, such as `log`.

            {% note info %}

            A list of columns to output depends on the selected `--service-type`.

            {% endnote %}

        * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
        * {% include [logs since time](../../_includes/cli/logs/since.md) %}
        * {% include [logs until time](../../_includes/cli/logs/until.md) %}

    You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

    To get a cluster log, use the [listLogs](../api-ref/Cluster/listLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListLogs](../api-ref/grpc/Cluster/listLogs.md) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Getting a cluster log stream {#get-log-stream}

This method allows you to get cluster logs in real time.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view cluster logs as they become available, run this command:

    ```bash
    {{ yc-mdb-es }} cluster list-logs <cluster_name_or_ID> --follow
    ```

    You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

    To get a cluster's log stream, use the [streamLogs](../api-ref/Cluster/streamLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/StreamLogs](../api-ref/grpc/Cluster/streamLogs.md) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}
