---
title: Просмотр логов кластера {{ OS }}
description: Управляемый сервис {{ OS }} позволяет получить логи кластера для просмотра и изучения.
keywords:
  - логи OpenSearch
  - логи кластера OpenSearch
  - OpenSearch
---

# Просмотр логов кластера {{ OS }}

{{ mos-name }} позволяет [получить фрагмент логов кластера](#list-logs) за выбранный период и [просматривать логи в реальном времени](#stream-logs).

## Получить лог кластера {#list-logs}

{% list tabs group=instructions %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.ListLogs](../api-ref/Cluster/listLogs.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>:logs' \
            --url-query serviceType=<тип_группы_хостов> \
            --url-query columnFilter=<список_колонок> \
            --url-query fromTime=<левая_граница_временного_диапазона> \
            --url-query toTime=<правая_граница_временного_диапазона>
        ```

        Где:

        * `serviceType` — тип хостов, для которых нужно получить записи: `OPENSEARCH` или `DASHBOARDS`.
        * `columnFilter` — список колонок для вывода информации. Список выводимых колонок зависит от выбранного типа хостов `serviceType`:

            * Для хостов `{{ OS }}`:

                * `component` — компонент кластера, к которому относится запись в логах;
                * `hostname` — [имя хоста](host-groups.md#list-hosts);
                * `level` — уровень логирования;
                * `message` — сообщение, которое выводит сервис.

            * Для хостов `Dashboards`:

                * `hostname` — имя хоста;
                * `message` — сообщение, которое выводит сервис.

        * `fromTime` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2024-09-18T15:04:05Z`.
        * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.opensearch.v1.ListClusterLogsResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [ClusterService.ListLogs](../api-ref/grpc/Cluster/listLogs.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "service_type": "<тип_группы_хостов>",
                  "column_filter": [
                    "<колонка_1>", "<колонка_2>", ..., "<колонка_N>"
                  ],
                  "from_time": "<левая_граница_временного_диапазона>",
                  "to_time": "<правая_граница_временного_диапазона>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.opensearch.v1.ClusterService.ListLogs
        ```

        Где:

        * `service_type` — тип хостов, для которых нужно получить записи: `OPENSEARCH` или `DASHBOARDS`.
        * `column_filter` — список колонок для вывода информации. Список выводимых колонок зависит от выбранного типа хостов `service_type`:

            * Для хостов `{{ OS }}`:

                * `component` — компонент кластера, к которому относится запись в логах;
                * `hostname` — [имя хоста](host-groups.md#list-hosts);
                * `level` — уровень логирования;
                * `message` — сообщение, которое выводит сервис.

            * Для хостов `Dashboards`:

                * `hostname` — имя хоста;
                * `message` — сообщение, которое выводит сервис.

        * `from_time` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2024-09-18T15:04:05Z`.
        * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.opensearch.v1.ListClusterLogsResponse).

{% endlist %}

## Получить поток логов кластера {#stream-logs}

Этот способ позволяет получать логи кластера в реальном времени.

{% list tabs group=instructions %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.StreamLogs](../api-ref/Cluster/streamLogs.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>:stream_logs' \
            --url-query serviceType=<тип_группы_хостов> \
            --url-query columnFilter=<список_колонок>
        ```

        Где:

        * `serviceType` — тип хостов, для которых нужно получить записи: `OPENSEARCH` или `DASHBOARDS`.
        * `columnFilter` — список колонок для вывода информации. Список выводимых колонок зависит от выбранного типа хостов `serviceType`:

            * Для хостов `{{ OS }}`:

                * `component` — компонент кластера, к которому относится запись в логах;
                * `hostname` — [имя хоста](host-groups.md#list-hosts);
                * `level` — уровень логирования;
                * `message` — сообщение, которое выводит сервис.

            * Для хостов `Dashboards`:

                * `hostname` — имя хоста;
                * `message` — сообщение, которое выводит сервис.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.opensearch.v1.StreamLogRecord).

        Команда не завершается после отправки. Новые логи отображаются в выводе команды в режиме реального времени.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [ClusterService.StreamLogs](../api-ref/grpc/Cluster/streamLogs.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "service_type": "<тип_группы_хостов>",
                  "column_filter": [
                    "<колонка_1>", "<колонка_2>", ..., "<колонка_N>"
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.opensearch.v1.ClusterService.StreamLogs
        ```

        Где:

        * `service_type` — тип хостов, для которых нужно получить записи: `OPENSEARCH` или `DASHBOARDS`.
        * `column_filter` — список колонок для вывода информации. Список выводимых колонок зависит от выбранного типа хостов `service_type`:

            * Для хостов `{{ OS }}`:

                * `component` — компонент кластера, к которому относится запись в логах;
                * `hostname` — [имя хоста](host-groups.md#list-hosts);
                * `level` — уровень логирования;
                * `message` — сообщение, которое выводит сервис.

            * Для хостов `Dashboards`:

                * `hostname` — имя хоста;
                * `message` — сообщение, которое выводит сервис.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.opensearch.v1.StreamLogRecord).

        Команда не завершается после отправки. Новые логи отображаются в выводе команды в режиме реального времени.

{% endlist %}
