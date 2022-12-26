---
title: "Viewing {{ OS }} cluster logs"
description: "Yandex Managed Service for {{ OS }} lets you get cluster logs for viewing and analysis."
keywords:
  - OpenSearch logs
  - OpenSearch cluster logs
  - OpenSearch
---

# Viewing {{ OS }} cluster logs

{{ mos-name }} lets you [get a cluster log snippet](#list-logs) for the selected period and [view logs in real time](#stream-logs).

## Getting a cluster log {#list-logs}

{% list tabs %}

- API

   Use the [listLogs](../api-ref/Cluster/listLogs.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting a cluster log stream {#stream-logs}

This method lets you get cluster logs in real time.

{% list tabs %}

- API

   Use the [streamLogs](../api-ref/Cluster/streamLogs.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}
