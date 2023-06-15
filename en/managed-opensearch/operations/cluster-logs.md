---
title: "Viewing {{ OS }} cluster logs"
description: "Yandex Managed Service for {{ OS }} lets you get cluster logs for viewing and analysis."
keywords:
  - OpenSearch logs
  - OpenSearch cluster logs
  - OpenSearch
---

# Viewing {{ OS }} cluster logs

{{ mos-name }} allows you to [get a cluster log snippet](#list-logs) for the selected period and [view logs in real time](#stream-logs).

## Getting a cluster log {#list-logs}

{% list tabs %}

- API

   To get a cluster log, use the [listLogs](../api-ref/Cluster/listLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListLogs](../api-ref/grpc/cluster_service.md#ListLogs) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

## Getting a cluster log stream {#stream-logs}

This method allows you to get cluster logs in real time.

{% list tabs %}

- API

   To get a cluster's log stream, use the [streamLogs](../api-ref/Cluster/streamLogs.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/StreamLogs](../api-ref/grpc/cluster_service.md#StreamLogs) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}
