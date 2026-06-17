# Просмотр логов кластера Yandex MPP Analytics for PostgreSQL

Yandex MPP Analytics for PostgreSQL позволяет [получить фрагмент логов кластера](#get-log) за выбранный период и [просматривать логи в реальном времени](#get-log-stream).

{% note info %}

Логи кластера хранятся 45 дней.

{% endnote %}

## Получить лог кластера {#get-log}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/receipt.svg) **Логи**.
    1. Укажите период времени, за который нужно отобразить логи: введите его вручную или выберите в календаре, нажав на поле ввода дат.
    1. Выберите тип сервиса, для которого требуется вывести логи:

        * `GREENPLUM` — лог операций СУБД.
        * `GREENPLUM_POOLER` — лог операций менеджера подключений.
        * `GREENPLUM_PXF` — лог протокола [PXF](../concepts/external-tables.md).
    
    1. При необходимости выберите хосты и уровень логирования.

    Будет отображен список записей в логе за выбранный период времени. Чтобы посмотреть подробную информацию о событии, нажмите на интересующую запись в списке.

    Если записей слишком много и отображается только часть из них, нажмите на кнопку **Загрузить еще** в конце списка.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Просмотрите описание команды CLI для просмотра логов кластера:

        ```bash
        yc managed-greenplum cluster list-logs --help
        ```

    1. Запустите команду получения логов кластера (в примере приведены не все доступные параметры):

        ```bash
        yc managed-greenplum cluster list-logs <имя_или_идентификатор_кластера> \
           --limit <ограничение_количества_записей> \
           --format <формат_вывода> \
           --service-type <тип_сервиса> \
           --columns <список_колонок_для_вывода_информации> \
           --filter <настройки_фильтрации_записей> \
           --since <левая_граница_временного_диапазона> \
           --until <правая_граница_временного_диапазона>
        ```

        Где:

        * `--limit` — ограничение на количество выводимых записей.
        * `--format` — формат, в котором будут представлены записи логов (`text`, `yaml`, `json` или `json-rest`).
        * `--service-type` — тип сервиса, для которого требуется вывести записи:
            * `greenplum` — лог операций СУБД.
            * `greenplum-pooler`— лог операций менеджера подключений.
            * `greenplum-pxf` — лог протокола [PXF](../concepts/external-tables.md).
        * `--columns` — список колонок для вывода информации:
            * `hostname` — [имя хоста](cluster-list.md#get-hosts).
            * `level` — уровень логирования, например, `info`.
            * `pid` — идентификатор серверного процесса текущей сессии.
            * `text` — сообщение, которое выводит компонент.

            {% note info %}

            Список выводимых колонок зависит от выбранного типа сервиса `--service-type`. В примере приведены только основные колонки для типа `greenplum-pooler`.

            {% endnote %}

            Для вывода отдельных колонок передайте параметр `--format` с указанием формата вывода (`yaml`, `json` или `json-rest`). Колонки не поддерживаются для формата вывода `text` (установлен по умолчанию).

        * `--filter` — настройки фильтрации записей, например `message.hostname='node1.mdb.yandexcloud.net'`.
        * `--since` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html), `HH:MM:SS` или временного промежутка относительно текущего времени. Примеры: `2006-01-02T15:04:05Z`, `15:04:05`, `2h`, `3h30m ago`.
        * `--until` — правая граница временного диапазона, формат аналогичен `--since`.

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.ListLogs](../api-ref/Cluster/listLogs.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>:logs' \
            --url-query serviceType=<тип_сервиса> \
            --url-query columnFilter=<название_колонки> \
            --url-query fromTime=<левая_граница_временного_диапазона> \
            --url-query toTime=<правая_граница_временного_диапазона>
        ```

        Где:

        * `serviceType` — тип сервиса, для которого нужно запросить логи:

            * `GREENPLUM` — операции СУБД;
            * `GREENPLUM_POOLER` — операции [менеджера подключений](../concepts/pooling.md);
            * `GREENPLUM_PXF` — протокол [PXF](../concepts/external-tables.md).

        * `columnFilter` — название колонки для вывода информации:

            * `hostname` — [имя хоста](cluster-list.md#get-hosts).
            * `level` — уровень логирования, например `info`.
            * `pid` — идентификатор серверного процесса текущей сессии.
            * `text` — сообщение, которое выводит компонент.

            {% note info %}

            Список выводимых колонок зависит от выбранного типа сервиса `serviceType`. В примере приведены только основные колонки для типа `GREENPLUM_POOLER`.

            {% endnote %}

            В одном параметре `columnFilter` можно указать только одну колонку. Если необходимо отфильтровать логи по нескольким колонкам, передайте перечень нужных колонок в нескольких параметрах.

        * `fromTime` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2006-01-02T15:04:05Z`.

        * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.greenplum.v1.ListClusterLogsResponse).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.ListLogs](../api-ref/grpc/Cluster/listLogs.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.ClusterService.ListLogs
        ```

        Где:

        * `service_type` — тип сервиса, для которого нужно запросить логи:

            * `GREENPLUM` — операции СУБД;
            * `GREENPLUM_POOLER` — операции [менеджера подключений](../concepts/pooling.md);
            * `GREENPLUM_PXF` — протокол [PXF](../concepts/external-tables.md).

        * `column_filter` — список колонок для вывода информации:

            * `hostname` — [имя хоста](cluster-list.md#get-hosts).
            * `level` — уровень логирования, например `info`.
            * `pid` — идентификатор серверного процесса текущей сессии.
            * `text` — сообщение, которое выводит компонент.

            {% note info %}

            Список выводимых колонок зависит от выбранного типа сервиса `serviceType`. В примере приведены только основные колонки для типа `GREENPLUM_POOLER`.

            {% endnote %}

            В параметре `column_filter` можно указать несколько колонок, если нужно отфильтровать логи по нескольким колонкам.

        * `from_time` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2006-01-02T15:04:05Z`.

        * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.greenplum.v1.ListClusterLogsResponse).

{% endlist %}

## Получить поток логов кластера {#get-log-stream}

Этот способ позволяет получать логи кластера в реальном времени.

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Для просмотра логов кластера по мере их поступления выполните команду:

    ```bash
    yc managed-greenplum cluster list-logs <имя_или_идентификатор_кластера> --follow
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.StreamLogs](../api-ref/Cluster/streamLogs.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/<идентификатор_кластера>:stream_logs' \
            --url-query serviceType=<тип_сервиса> \
            --url-query columnFilter=<название_колонки> \
            --url-query fromTime=<левая_граница_временного_диапазона> \
            --url-query toTime=<правая_граница_временного_диапазона> \
            --url-query filter=<фильтр_логов>
        ```

        Где:

        * `serviceType` — тип сервиса, для которого нужно запросить логи:

            * `GREENPLUM` — операции СУБД;
            * `GREENPLUM_POOLER` — операции [менеджера подключений](../concepts/pooling.md);
            * `GREENPLUM_PXF` — протокол [PXF](../concepts/external-tables.md).

        * `columnFilter` — название колонки для вывода информации:

            * `hostname` — [имя хоста](cluster-list.md#get-hosts).
            * `level` — уровень логирования, например `info`.
            * `pid` — идентификатор серверного процесса текущей сессии.
            * `text` — сообщение, которое выводит компонент.

            {% note info %}

            Список выводимых колонок зависит от выбранного типа сервиса `serviceType`. В примере приведены только основные колонки для типа `GREENPLUM_POOLER`.

            {% endnote %}

            В одном параметре `columnFilter` можно указать только одну колонку. Если необходимо отфильтровать логи по нескольким колонкам, передайте перечень нужных колонок в нескольких параметрах.

        * `fromTime` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2006-01-02T15:04:05Z`.

        * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.

            Если не указывать этот параметр, то в поток логов будут отсылаться новые логи по мере их появления. Это поведение семантически эквивалентно `tail -f`.

        * `filter` — фильтр логов, например `message.hostname='node1.mdb.yandexcloud.net'`.

            Информация о фильтрах и их синтаксисе находится в [справочнике API](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.greenplum.v1.StreamClusterLogsRequest).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.greenplum.v1.StreamLogRecord).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.StreamLogs](../api-ref/grpc/Cluster/streamLogs.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.greenplum.v1.ClusterService.StreamLogs
        ```

        Где:

        * `service_type` — тип сервиса, для которого нужно запросить логи:

            * `GREENPLUM` — операции СУБД;
            * `GREENPLUM_POOLER` — операции [менеджера подключений](../concepts/pooling.md);
            * `GREENPLUM_PXF` — протокол [PXF](../concepts/external-tables.md).

        * `column_filter` — список колонок для вывода информации:

            * `hostname` — [имя хоста](cluster-list.md#get-hosts).
            * `level` — уровень логирования, например `info`.
            * `pid` — идентификатор серверного процесса текущей сессии.
            * `text` — сообщение, которое выводит компонент.

            {% note info %}

            Список выводимых колонок зависит от выбранного типа сервиса `service_type`. В примере приведены только основные колонки для типа `GREENPLUM_POOLER`.

            {% endnote %}

            В параметре `column_filter` можно указать несколько колонок, если нужно отфильтровать логи по нескольким колонкам.

        * `from_time` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2006-01-02T15:04:05Z`.

        * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

            Если не указывать этот параметр, то в поток логов будут отсылаться новые логи по мере их появления. Это поведение семантически эквивалентно `tail -f`.

        * `filter` — фильтр логов, например `message.hostname='node1.mdb.yandexcloud.net'`.

            Информация о фильтрах и их синтаксисе находится в [справочнике API](../api-ref/grpc/Cluster/streamLogs.md).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.greenplum.v1.StreamLogRecord).

{% endlist %}