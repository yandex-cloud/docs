# Просмотр логов кластера {{ KF }}

{{ mkf-name }} позволяет [получить фрагмент логов кластера](#get-log) за выбранный период и [просматривать логи в реальном времени](#get-log-stream).

{% note info %}

Здесь под логом понимается системный лог кластера и его хостов. Этот лог не имеет отношения к логу раздела для топика {{ KF }}, в который брокер записывает поступающие от производителей сообщения.

{% endnote %}

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Получить лог кластера {#get-log}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}**.
    1. Выберите **{{ ui-key.yacloud.kafka.label_filter_origin }}**, **{{ ui-key.yacloud.mdb.cluster.logs.label_hosts }}** и **{{ ui-key.yacloud.mdb.cluster.logs.label_severity }}**.
    1. Укажите период времени, за который нужно отобразить лог.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Просмотрите описание команды CLI для просмотра логов кластера:

        ```bash
        {{ yc-mdb-kf }} cluster list-logs --help
        ```

    1. Запустите команду получения логов кластера (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-mdb-kf }} cluster list-logs <имя_или_идентификатор_кластера> \
           --limit <ограничение_количества_записей> \
           --columns <список_колонок_лога> \
           --filter <настройки_фильтрации_записей> \
           --since <левая_граница_временного_диапазона> \
           --until <правая_граница_временного_диапазона>
        ```

        Где:

        * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
        * `--columns` — список колонок лога, из которых будет выводиться информация:
            * `hostname` — [имя хоста](cluster-hosts.md).
            * `message` — сообщение, которое выводит компонент.
            * `severity` — уровень логирования. Пример выводимого значения: `INFO`.
            * `origin` — источник сообщения. Примеры выводимых значений: `kafka_server` или `kafka_controller`.

        * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
        * {% include [logs since time](../../_includes/cli/logs/since.md) %}
        * {% include [logs until time](../../_includes/cli/logs/until.md) %}

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.listLogs](../api-ref/Cluster/listLogs.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>:logs' \
            --url-query columnFilter=<список_колонок_для_вывода_информации> \
            --url-query fromTime=<левая_граница_временного_диапазона> \
            --url-query toTime=<правая_граница_временного_диапазона>
        ```

        Где:

        * `columnFilter` — список колонок для вывода информации:

            {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

            {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}

        {% include [from-time-rest](../../_includes/mdb/api/from-time-rest.md) %}

        * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.


        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.kafka.v1.ListClusterLogsResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/ListLogs](../api-ref/grpc/Cluster/listLogs.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "column_filter": [<список_колонок_для_вывода_информации>],
                    "from_time": "<левая_граница_временного_диапазона>" \
                    "to_time": "<правая_граница_временного_диапазона>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.ListLogs
        ```

        Где:

        * `service_type` — тип сервиса, для которого нужно запросить логи. Допустимо только значение `CLICKHOUSE`.
        * `column_filter` — список колонок для вывода информации:

            {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

            {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

        {% include [from-time-grpc](../../_includes/mdb/api/from-time-grpc.md) %}

        * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.


        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.kafka.v1.ListClusterLogsResponse).

{% endlist %}

## Получить поток записей лога {#get-log-stream}

Этот способ позволяет получать логи кластера в реальном времени.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Для просмотра логов кластера по мере их поступления выполните команду:

    ```bash
    {{ yc-mdb-kf }} cluster list-logs <имя_или_идентификатор_кластера> --follow
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.streamLogs](../api-ref/Cluster/streamLogs.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>:stream_logs' \
            --url-query columnFilter=<список_колонок_для_вывода_информации> \
            --url-query fromTime=<левая_граница_временного_диапазона> \
            --url-query toTime=<правая_граница_временного_диапазона> \
            --url-query filter=<фильтр_логов>
        ```

        Где:

        * `columnFilter` — список колонок для вывода информации:

            {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

            {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}

        {% include [from-time-rest](../../_includes/mdb/api/from-time-rest.md) %}

        * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.

            {% include [tail-f-semantics](../../_includes/mdb/api/tail-f-semantics.md) %}

        * `filter` — фильтр логов. Можно отфильтровать логи так, чтобы поток логов содержал только нужные логи.

            Подробнее о фильтрах и их синтаксисе см. в [справочнике API](../api-ref/Cluster/streamLogs.md#query_params).

            {% include [stream-logs-filter](../../_includes/mdb/api/stream-logs-filter.md) %}


        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.kafka.v1.StreamLogRecord).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/StreamLogs](../api-ref/grpc/Cluster/streamLogs.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "column_filter": [<список_колонок_для_вывода_информации>],
                    "from_time": "<левая_граница_временного_диапазона>",
                    "to_time": "<правая_граница_временного_диапазона>",
                    "filter": "<фильтр_логов>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.StreamLogs
        ```

        Где:

        * `column_filter` — список колонок для вывода информации:

            {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

            {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

        {% include [from-time-grpc](../../_includes/mdb/api/from-time-grpc.md) %}

        * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

            {% include [tail-f-semantics](../../_includes/mdb/api/tail-f-semantics.md) %}

        * `filter` — фильтр логов. Можно отфильтровать логи так, чтобы поток логов содержал только нужные логи.

            {% include [stream-logs-filter](../../_includes/mdb/api/stream-logs-filter.md) %}

            Подробнее о фильтрах и их синтаксисе см. в [справочнике API](../api-ref/grpc/Cluster/streamLogs.md).


        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.kafka.v1.StreamLogRecord).

{% endlist %}
