---
title: Viewing {{ OS }} cluster logs
description: The {{ OS }} managed service allows you to get cluster logs for viewing and analyzing.
keywords:
  - OpenSearch logs
  - OpenSearch cluster logs
  - OpenSearch
---

# Viewing {{ OS }} cluster logs

{{ mos-name }} allows you to [get a cluster log snippet](#list-logs) for the selected period and [view logs in real time](#stream-logs).

## Getting a cluster log {#list-logs}

{% list tabs group=instructions %}

- API {#api}

    To get a cluster log, use the [listLogs](../api-ref/Cluster/listLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListLogs](../api-ref/grpc/Cluster/listLogs.md) gRPC API call, and provide in the request:

    * Cluster ID in the `clusterId` parameter.

        {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

    * Type of hosts to output records for in the `serviceType` parameter:

        * `OPENSEARCH`.
        * `DASHBOARDS`.

{% endlist %}

## Getting a cluster log stream {#stream-logs}

This method allows you to get cluster logs in real time.

{% list tabs group=instructions %}

- API {#api}

    To get a cluster log stream, use the [streamLogs](../api-ref/Cluster/streamLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/StreamLogs](../api-ref/grpc/Cluster/streamLogs.md) gRPC API call, and provide in the request:

    * Cluster ID in the `clusterId` parameter.

        {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

    * Type of hosts to output records for in the `serviceType` parameter:

        * `OPENSEARCH`.
        * `DASHBOARDS`.

{% endlist %}
