---
title: "Просмотр логов кластера {{ OS }}"
description: "Управляемый сервис {{ OS }} позволяет получить логи кластера для просмотра и изучения."
keywords:
  - логи OpenSearch
  - логи кластера OpenSearch
  - OpenSearch
---

# Просмотр логов кластера {{ OS }}

{{ mos-name }} позволяет [получить фрагмент логов кластера](#list-logs) за выбранный период и [просматривать логи в реальном времени](#stream-logs).

## Получить лог кластера {#list-logs}

{% list tabs group=instructions %}

- API {#api}

    Чтобы получить лог кластера, воспользуйтесь методом REST API [listLogs](../api-ref/Cluster/listLogs.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/ListLogs](../api-ref/grpc/cluster_service.md#ListLogs) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

        {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

    * Тип хостов, для которых требуется получить записи, в параметре `serviceType`:

        * `OPENSEARCH`.
        * `DASHBOARDS`.

{% endlist %}

## Получить поток логов кластера {#stream-logs}

Этот способ позволяет получать логи кластера в реальном времени.

{% list tabs group=instructions %}

- API {#api}

    Чтобы получить поток логов кластера, воспользуйтесь методом REST API [streamLogs](../api-ref/Cluster/streamLogs.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/StreamLogs](../api-ref/grpc/cluster_service.md#StreamLogs) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

        {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

    * Тип хостов, для которых требуется получить записи, в параметре `serviceType`:

        * `OPENSEARCH`.
        * `DASHBOARDS`.

{% endlist %}
