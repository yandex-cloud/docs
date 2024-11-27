# Просмотр логов кластера {{ GP }}

{{ mgp-name }} позволяет [получить фрагмент логов кластера](#get-log) за выбранный период и [просматривать логи в реальном времени](#get-log-stream).

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Получить лог кластера {#get-log}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}**.
    1. Укажите период времени, за который нужно отобразить логи: введите его вручную или выберите в календаре, нажав на поле ввода дат.
    1. Выберите тип сервиса, для которого требуется вывести логи:

        * `GREENPLUM` — лог операций {{ GP }}.
        * `GREENPLUM_POOLER` — лог операций менеджера подключений.
        * `GREENPLUM_PXF` — лог протокола [PXF](../concepts/external-tables.md).
    
    1. При необходимости выберите хосты и уровень логирования.

    Будет отображен список записей в логе за выбранный период времени. Чтобы посмотреть подробную информацию о событии, нажмите на интересующую запись в списке.

    Если записей слишком много и отображается только часть из них, нажмите на кнопку **{{ ui-key.yacloud.common.label_load-more }}** в конце списка.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Просмотрите описание команды CLI для просмотра логов кластера:

        ```bash
        {{ yc-mdb-gp }} cluster list-logs --help
        ```

    1. Запустите команду получения логов кластера (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-mdb-gp }} cluster list-logs <имя_или_идентификатор_кластера> \
           --limit <ограничение_количества_записей> \
           --format <формат_вывода> \
           --service-type <тип_сервиса> \
           --columns <список_колонок_для_вывода_информации> \
           --filter <настройки_фильтрации_записей> \
           --since <левая_граница_временного_диапазона> \
           --until <правая_граница_временного_диапазона>
        ```

        Где:

        * {% include [logs output limit](../../_includes/cli/logs/limit.md) %}
        * {% include [logs output format](../../_includes/cli/logs/format.md) %}
        * `--service-type` — тип сервиса, для которого требуется вывести записи:
            * `greenplum` — лог операций {{ GP }}.
            * `greenplum-pooler`— лог операций менеджера подключений.
            * `greenplum-pxf` — лог протокола [PXF](../concepts/external-tables.md).
        * `--columns` — список колонок для вывода информации:
            * `hostname` — [имя хоста](./hosts/cluster-hosts.md).
            * `level` — уровень логирования, например, `info`.
            * `pid` — идентификатор серверного процесса текущей сессии.
            * `text` — сообщение, которое выводит компонент.

            {% note info %}

            Список выводимых колонок зависит от выбранного типа сервиса `--service-type`. В примере приведены только основные колонки для типа `greenplum-pooler`.

            {% endnote %}

            {% include [logs column format](../../_includes/cli/logs/column-format.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>:logs' \
            --url-query serviceType=<тип_сервиса> \
            --url-query columnFilter=<название_колонки> \
            --url-query fromTime=<левая_граница_временного_диапазона> \
            --url-query toTime=<правая_граница_временного_диапазона>
        ```

        Где:

        * `serviceType` — тип сервиса, для которого нужно запросить логи:

            * `GREENPLUM` — операции {{ GP }};
            * `GREENPLUM_POOLER` — операции [менеджера подключений](../concepts/pooling.md);
            * `GREENPLUM_PXF` — протокол [PXF](../concepts/external-tables.md).

        * `columnFilter` — название колонки для вывода информации:

            * `hostname` — [имя хоста](./hosts/cluster-hosts.md).
            * `level` — уровень логирования, например `info`.
            * `pid` — идентификатор серверного процесса текущей сессии.
            * `text` — сообщение, которое выводит компонент.

            {% note info %}

            Список выводимых колонок зависит от выбранного типа сервиса `serviceType`. В примере приведены только основные колонки для типа `GREENPLUM_POOLER`.

            {% endnote %}

            {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}

        {% include [from-time-rest](../../_includes/mdb/api/from-time-rest.md) %}

        * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.greenplum.v1.ListClusterLogsResponse).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "column_filter": [
                    "<колонка_1>", "<колонка_2>", ..., "<колонка_N>"
                  ],
                  "service_type": "<тип_сервиса>",
                  "from_time": "<левая_граница_временного_диапазона>",
                  "to_time": "<правая_граница_временного_диапазона>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.ListLogs
        ```

        Где:

        * `service_type` — тип сервиса, для которого нужно запросить логи:

            * `GREENPLUM` — операции {{ GP }};
            * `GREENPLUM_POOLER` — операции [менеджера подключений](../concepts/pooling.md);
            * `GREENPLUM_PXF` — протокол [PXF](../concepts/external-tables.md).

        * `column_filter` — список колонок для вывода информации:

            * `hostname` — [имя хоста](./hosts/cluster-hosts.md).
            * `level` — уровень логирования, например `info`.
            * `pid` — идентификатор серверного процесса текущей сессии.
            * `text` — сообщение, которое выводит компонент.

            {% note info %}

            Список выводимых колонок зависит от выбранного типа сервиса `serviceType`. В примере приведены только основные колонки для типа `GREENPLUM_POOLER`.

            {% endnote %}

            {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

        {% include [from-time-grpc](../../_includes/mdb/api/from-time-grpc.md) %}

        * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.greenplum.v1.ListClusterLogsResponse).

{% endlist %}

## Получить поток логов кластера {#get-log-stream}

Этот способ позволяет получать логи кластера в реальном времени.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Для просмотра логов кластера по мере их поступления выполните команду:

    ```bash
    {{ yc-mdb-gp }} cluster list-logs <имя_или_идентификатор_кластера> --follow
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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>:stream_logs' \
            --url-query serviceType=<тип_сервиса> \
            --url-query columnFilter=<название_колонки> \
            --url-query fromTime=<левая_граница_временного_диапазона> \
            --url-query toTime=<правая_граница_временного_диапазона> \
            --url-query filter=<фильтр_логов>
        ```

        Где:

        * `serviceType` — тип сервиса, для которого нужно запросить логи:

            * `GREENPLUM` — операции {{ GP }};
            * `GREENPLUM_POOLER` — операции [менеджера подключений](../concepts/pooling.md);
            * `GREENPLUM_PXF` — протокол [PXF](../concepts/external-tables.md).

        * `columnFilter` — название колонки для вывода информации:

            * `hostname` — [имя хоста](./hosts/cluster-hosts.md).
            * `level` — уровень логирования, например `info`.
            * `pid` — идентификатор серверного процесса текущей сессии.
            * `text` — сообщение, которое выводит компонент.

            {% note info %}

            Список выводимых колонок зависит от выбранного типа сервиса `serviceType`. В примере приведены только основные колонки для типа `GREENPLUM_POOLER`.

            {% endnote %}

            {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}

        {% include [from-time-rest](../../_includes/mdb/api/from-time-rest.md) %}

        * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.

            {% include [tail-f-semantics](../../_includes/mdb/api/tail-f-semantics.md) %}

        * `filter` — фильтр логов, например `message.hostname='node1.{{ dns-zone }}'`.

            Подробнее о фильтрах и их синтаксисе см. в [справочнике API](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.greenplum.v1.StreamClusterLogsRequest).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.greenplum.v1.StreamLogRecord).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "column_filter": [
                    "<колонка_1>", "<колонка_2>", ..., "<колонка_N>"
                  ],
                  "service_type": "<тип_сервиса>",
                  "from_time": "<левая_граница_временного_диапазона>",
                  "to_time": "<правая_граница_временного_диапазона>",
                  "filter": "<фильтр_логов>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.StreamLogs
        ```

        Где:

        * `service_type` — тип сервиса, для которого нужно запросить логи:

            * `GREENPLUM` — операции {{ GP }};
            * `GREENPLUM_POOLER` — операции [менеджера подключений](../concepts/pooling.md);
            * `GREENPLUM_PXF` — протокол [PXF](../concepts/external-tables.md).

        * `column_filter` — список колонок для вывода информации:

            * `hostname` — [имя хоста](./hosts/cluster-hosts.md).
            * `level` — уровень логирования, например `info`.
            * `pid` — идентификатор серверного процесса текущей сессии.
            * `text` — сообщение, которое выводит компонент.

            {% note info %}

            Список выводимых колонок зависит от выбранного типа сервиса `service_type`. В примере приведены только основные колонки для типа `GREENPLUM_POOLER`.

            {% endnote %}

            {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

        {% include [from-time-grpc](../../_includes/mdb/api/from-time-grpc.md) %}

        * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

            {% include [tail-f-semantics](../../_includes/mdb/api/tail-f-semantics.md) %}

        * `filter` — фильтр логов, например `message.hostname='node1.{{ dns-zone }}'`.

            Подробнее о фильтрах и их синтаксисе см. в [справочнике API](../api-ref/grpc/Cluster/streamLogs.md).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.greenplum.v1.StreamLogRecord).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
