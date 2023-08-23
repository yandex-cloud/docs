---
title: "Viewing Elasticsearch cluster logs"
description: "Yandex Managed Service for Elasticsearch lets you get cluster logs for viewing and analysis."
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

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
   1. Click the name of the desired cluster and select the ![image](../../_assets/managed-elasticsearch/logs.svg) **{{ ui-key.yacloud.common.logs }}** tab.
   1. Specify the time period for which you want to display logs: enter it manually or select it in the calendar by clicking on the date field.
   1. Select the `ELASTICSEARCH` component from the drop-down list next to the date field.

   A list of log entries for the selected time period will be displayed. To view detailed information about an event, click on the respective entry in the list.

   If there are too many records and only some of them are displayed, click the **{{ ui-key.yacloud.mdb.cluster.logs.button_load-more }}** link at the end of the list.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to view cluster logs:

      ```bash
      {{ yc-mdb-es }} cluster list-logs --help
      ```

   1. Run the following command to get cluster logs (our example does not contain a complete list of available parameters):

      ```bash
      {{ yc-mdb-es }} cluster list-logs <cluster name or ID> \
         --limit <record number limit> \
         --columns <list of columns to display information> \
         --filter <record filter settings> \
         --since <left boundary of time range> \
         --until <right boundary of time range>
      ```

      Where:

      * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
      * `--service-type`: Type of service to output records for (`elasticsearch` or `kibana`).
      * `--columns`: List of columns to display information:
         * `component`: Type of component to be logged. For example, `o.e.n.Node`.
         * `hostname`: [Name of the host](cluster-hosts.md#list-hosts).
         * `level`: Logging level, such as `info`.
         * `message`: Message output by the component.
         * `stacktrace`: Additional debugging information.
         * `query_id`: Query ID.
         * `type`: Record type, such as `log`.

         {% note info %}

         A list of columns to output depends on the selected `--service-type`.

         {% endnote %}

      * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
      * {% include [logs since time](../../_includes/cli/logs/since.md) %}
      * {% include [logs until time](../../_includes/cli/logs/until.md) %}

   You can request a cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a cluster log, use the [listLogs](../api-ref/Cluster/listLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListLogs](../api-ref/grpc/cluster_service.md#ListLogs) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Getting a cluster log stream {#get-log-stream}

This method allows you to get cluster logs in real time.

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To view cluster logs as they become available, run this command:

   ```bash
   {{ yc-mdb-es }} cluster list-logs <cluster name or ID> --follow
   ```

   You can request a cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a cluster's log stream, use the [streamLogs](../api-ref/Cluster/streamLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/StreamLogs](../api-ref/grpc/cluster_service.md#StreamLogs) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}
