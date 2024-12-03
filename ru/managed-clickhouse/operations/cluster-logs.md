# Просмотр логов кластера {{ CH }}

{{ mch-name }} позволяет [получить фрагмент логов кластера](#get-log) за выбранный период и [просматривать логи в реальном времени](#get-log-stream).

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Получить логи кластера {#get-log}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.clickhouse.cluster.switch_logs }}**.
    1. Укажите период времени, за который нужно отобразить логи: введите его вручную или выберите в календаре, нажав на поле ввода дат.
    1. При необходимости укажите хосты и уровень логирования в строке с полем ввода дат.

    Будет отображен список записей в логе за выбранный период времени. Чтобы посмотреть подробную информацию о событии, нажмите на интересующую запись в списке.

    Если записей слишком много и отображается только часть из них, нажмите на кнопку **{{ ui-key.yacloud.common.label_load-more }}** в конце списка.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Просмотрите описание команды CLI для просмотра логов кластера:

        ```bash
        {{ yc-mdb-ch }} cluster list-logs --help
        ```

    1. Запустите команду получения логов кластера:

        ```bash
        {{ yc-mdb-ch }} cluster list-logs <имя_или_идентификатор_кластера> \
           --limit <ограничение_количества_записей> \
           --columns <список_колонок_для_вывода_информации> \
           --filter <настройки_фильтрации_записей> \
           --since <левая_граница_временного_диапазона> \
           --until <правая_граница_временного_диапазона>
        ```

        Где:

        * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
        * `--columns` — список колонок для вывода информации:
            * `hostname` — [имя хоста](hosts.md#list-hosts).
            * `component` — тип компонента, который попадет в лог. Например, `HTTP-Session`.
            * `message` — сообщение, которое выводит компонент.
            * `query_id` — идентификатор запроса.
            * `severity` — уровень логирования, например, `Debug`.
            * `thread` — идентификатор потока, участвующего в обработке запросов.
        * {% include [logs filter](../../_includes/cli/logs/filter.md) %}
        * {% include [logs since time](../../_includes/cli/logs/since.md) %}
        * {% include [logs until time](../../_includes/cli/logs/until.md) %}

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.ListLogs](../api-ref/Cluster/listLogs.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>:logs' \
            --url-query serviceType=CLICKHOUSE \
            --url-query columnFilter=<список_колонок_для_вывода_информации> \
            --url-query fromTime=<левая_граница_временного_диапазона> \
            --url-query toTime=<правая_граница_временного_диапазона>
        ```

        Где:

        * `serviceType` — тип сервиса, для которого нужно запросить логи. Допустимо только значение `CLICKHOUSE`.
        * `columnFilter` — список колонок для вывода информации:

            {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

            {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}

        {% include [from-time-rest](../../_includes/mdb/api/from-time-rest.md) %}

        * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.


        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listLogs.md#responses).

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "service_type" : "CLICKHOUSE",
                    "column_filter": [<список_колонок_для_вывода_информации>],
                    "from_time": "<левая_граница_временного_диапазона>" \
                    "to_time": "<правая_граница_временного_диапазона>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.ListLogs
        ```

        Где:

        * `service_type` — тип сервиса, для которого нужно запросить логи. Допустимо только значение `CLICKHOUSE`.
        * `column_filter` — список колонок для вывода информации:

            {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

            {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

        {% include [from-time-grpc](../../_includes/mdb/api/from-time-grpc.md) %}

        * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.


        Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsResponse).

{% endlist %}

## Получить поток логов кластера {#get-log-stream}

Этот способ позволяет получать логи кластера в реальном времени.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Для просмотра логов кластера по мере их поступления выполните команду:

    ```bash
    {{ yc-mdb-ch }} cluster list-logs <имя_или_идентификатор_кластера> --follow
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.StreamLogs](../api-ref/Cluster/streamLogs.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>:stream_logs' \
            --url-query serviceType=CLICKHOUSE \
            --url-query columnFilter=<список_колонок_для_вывода_информации> \
            --url-query fromTime=<левая_граница_временного_диапазона> \
            --url-query toTime=<правая_граница_временного_диапазона> \
            --url-query filter=<фильтр_логов>
        ```

        Где:

        * `serviceType` — тип сервиса, для которого нужно запросить логи. Допустимо только значение `CLICKHOUSE`.
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


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/streamLogs.md#responses).

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
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "service_type" : "CLICKHOUSE",
                    "column_filter": [<список_колонок_для_вывода_информации>],
                    "from_time": "<левая_граница_временного_диапазона>",
                    "to_time": "<правая_граница_временного_диапазона>",
                    "filter": "<фильтр_логов>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.StreamLogs
        ```

        Где:

        * `service_type` — тип сервиса, для которого нужно запросить логи. Допустимо только значение `CLICKHOUSE`.
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


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.clickhouse.v1.StreamLogRecord).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
