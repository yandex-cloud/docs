# Просмотр логов кластера MySQL®

Managed Service for MySQL® позволяет [получить фрагмент логов кластера](#get-log) за выбранный период и [просматривать логи в реальном времени](#get-log-stream).

{% note info %}

Логи кластера хранятся 45 дней.

{% endnote %}

## Получить лог кластера {#get-log}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите в сервис **Managed Service for&nbsp;MySQL**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/receipt.svg) **Логи**.
    1. Укажите период времени, за который нужно отобразить логи: введите его вручную или выберите в календаре, нажав на поле ввода дат.
    1. Выберите тип отображаемых событий. По умолчанию используется тип `MYSQL_ERROR`.
    1. При необходимости укажите хосты и уровень логирования в строке с полем ввода дат.

    Будет отображен список записей в логе за выбранный период времени. Чтобы посмотреть подробную информацию о событии, нажмите на интересующую запись в списке.

    Если записей слишком много и отображается только часть из них, нажмите на кнопку **Загрузить еще** в конце списка.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Просмотрите описание команды CLI для просмотра логов кластера:

        ```bash
        yc managed-mysql cluster list-logs --help
        ```

    1. Запустите команду получения логов кластера (в примере приведены не все доступные параметры):

        ```bash
        yc managed-mysql cluster list-logs <имя_или_идентификатор_кластера> \
           --limit <ограничение_количества_записей> \
           --format <формат_вывода> \
           --service-type <тип_сервиса> \
           --columns <список_колонок> \
           --filter <настройки_фильтрации> \
           --since <левая_граница_временного_диапазона> \
           --until <правая_граница_временного_диапазона>
        ```

        Где:

        * `--limit` — ограничение на количество выводимых записей.
        * `--format` — формат, в котором будут представлены записи логов (`text`, `yaml`, `json` или `json-rest`).
        * `--service-type` — тип сервиса, для которого требуется вывести записи (`mysql-error`, `mysql-general`, `mysql-slow-query` или `mysql-audit`).
        * `--columns` — список колонок для вывода информации:

            * `hostname` — [имя хоста](hosts.md#list-hosts).
            * `id` — идентификатор запроса.
            * `message` — сообщение, которое выводит сервис.
            * `status` — статус сообщения, например `Note` или `Warning`.

            {% note info %}

            В примере приведены только основные колонки. Список выводимых колонок зависит от выбранного типа сервиса `--service-type`.

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

    1. Воспользуйтесь методом [Cluster.listLogs](../api-ref/Cluster/listLogs.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/<идентификатор_кластера>:logs' \
            --url-query serviceType=<тип_сервиса> \
            --url-query columnFilter=<список_колонок> \
            --url-query fromTime=<левая_граница_временного_диапазона> \
            --url-query toTime=<правая_граница_временного_диапазона>
        ```

        Где:

        * `serviceType` — тип сервиса, логи которого нужно получить:

            * `MYSQL_ERROR` — лог ошибок, связанных с запуском, работой и остановкой инстансов MySQL®.
            * `MYSQL_GENERAL` — лог клиентских соединений и запросов.
            
                По умолчанию лог не ведется. Чтобы включить его, измените значение настройки [General log](../concepts/settings-list.md#setting-general-log) при [изменении настроек MySQL®](update.md#change-mysql-config).
            
            * `MYSQL_SLOW_QUERY` — лог медленных запросов.
            
                По умолчанию лог не ведется. Чтобы включить его, измените значение настройки [Slow query log](../concepts/settings-list.md#setting-slow-query-log) при [изменении настроек MySQL®](update.md#change-mysql-config). Смотрите также настройки [Log slow filter](../concepts/settings-list.md#setting-log-slow-filter), [Log slow rate limit](../concepts/settings-list.md#setting-log-slow-rate-limit), [Log slow rate type](../concepts/settings-list.md#setting-log-slow-rate-type), [Log slow sp statements](../concepts/settings-list.md#setting-log-slow-sp-statements) и [Slow query log always write time](../concepts/settings-list.md#setting-slow-query-log-always-write-time).
            
            * `MYSQL_AUDIT` — лог аудита.
            
                По умолчанию лог не ведется. Чтобы включить его, измените значение настройки [Audit log](../concepts/settings-list.md#setting-audit-log) при [изменении настроек MySQL®](update.md#change-mysql-config).

        * `columnFilter` — список колонок для вывода информации:

            * `hostname` — [имя хоста](hosts.md#list);
            * `id` — идентификатор запроса;
            * `message` — сообщение, которое выводит сервис;
            * `status` — статус сообщения, например `Note` или `Warning`;
            * `raw` — информация по всем колонкам в необработанном виде.

            {% note info %}

            В примере приведены только основные колонки. Список выводимых колонок зависит от выбранного типа сервиса `serviceType`.

            {% endnote %}

        * `fromTime` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2024-09-18T15:04:05Z`.
        * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse).

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
    1. Воспользуйтесь вызовом [ClusterService/ListLogs](../api-ref/grpc/Cluster/listLogs.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "service_type": "<тип_сервиса>",
                "column_filter": [
                  "<колонка_1>", "<колонка_2>", ..., "<колонка_N>"
                ],
                "from_time": "<левая_граница_временного_диапазона>",
                "to_time": "<правая_граница_временного_диапазона>"
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mysql.v1.ClusterService.ListLogs
        ```

        Где:

        * `service_type` — тип сервиса, логи которого нужно получить:

            * `MYSQL_ERROR` — лог ошибок, связанных с запуском, работой и остановкой инстансов MySQL®.
            * `MYSQL_GENERAL` — лог клиентских соединений и запросов.
            
                По умолчанию лог не ведется. Чтобы включить его, измените значение настройки [General log](../concepts/settings-list.md#setting-general-log) при [изменении настроек MySQL®](update.md#change-mysql-config).
            
            * `MYSQL_SLOW_QUERY` — лог медленных запросов.
            
                По умолчанию лог не ведется. Чтобы включить его, измените значение настройки [Slow query log](../concepts/settings-list.md#setting-slow-query-log) при [изменении настроек MySQL®](update.md#change-mysql-config). Смотрите также настройки [Log slow filter](../concepts/settings-list.md#setting-log-slow-filter), [Log slow rate limit](../concepts/settings-list.md#setting-log-slow-rate-limit), [Log slow rate type](../concepts/settings-list.md#setting-log-slow-rate-type), [Log slow sp statements](../concepts/settings-list.md#setting-log-slow-sp-statements) и [Slow query log always write time](../concepts/settings-list.md#setting-slow-query-log-always-write-time).
            
            * `MYSQL_AUDIT` — лог аудита.
            
                По умолчанию лог не ведется. Чтобы включить его, измените значение настройки [Audit log](../concepts/settings-list.md#setting-audit-log) при [изменении настроек MySQL®](update.md#change-mysql-config).

        * `column_filter` — список колонок для вывода информации:

            * `hostname` — [имя хоста](hosts.md#list);
            * `id` — идентификатор запроса;
            * `message` — сообщение, которое выводит сервис;
            * `status` — статус сообщения, например `Note` или `Warning`;
            * `raw` — информация по всем колонкам в необработанном виде.

            {% note info %}

            В примере приведены только основные колонки. Список выводимых колонок зависит от выбранного типа сервиса `service_type`.

            {% endnote %}

        * `from_time` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2024-09-18T15:04:05Z`.
        * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse).

{% endlist %}

## Получить поток логов кластера {#get-log-stream}

Этот способ позволяет получать логи кластера в реальном времени.

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Для просмотра логов кластера по мере их поступления выполните команду:

    ```bash
    yc managed-mysql cluster list-logs <имя_или_идентификатор_кластера> --follow
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.streamLogs](../api-ref/Cluster/streamLogs.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/<идентификатор_кластера>:stream_logs' \
            --url-query serviceType=<тип_сервиса> \
            --url-query columnFilter=<список_колонок>
        ```

        Где:

        * `serviceType` — тип сервиса, логи которого нужно получить:

            * `MYSQL_ERROR` — лог ошибок, связанных с запуском, работой и остановкой инстансов MySQL®.
            * `MYSQL_GENERAL` — лог клиентских соединений и запросов.
            
                По умолчанию лог не ведется. Чтобы включить его, измените значение настройки [General log](../concepts/settings-list.md#setting-general-log) при [изменении настроек MySQL®](update.md#change-mysql-config).
            
            * `MYSQL_SLOW_QUERY` — лог медленных запросов.
            
                По умолчанию лог не ведется. Чтобы включить его, измените значение настройки [Slow query log](../concepts/settings-list.md#setting-slow-query-log) при [изменении настроек MySQL®](update.md#change-mysql-config). Смотрите также настройки [Log slow filter](../concepts/settings-list.md#setting-log-slow-filter), [Log slow rate limit](../concepts/settings-list.md#setting-log-slow-rate-limit), [Log slow rate type](../concepts/settings-list.md#setting-log-slow-rate-type), [Log slow sp statements](../concepts/settings-list.md#setting-log-slow-sp-statements) и [Slow query log always write time](../concepts/settings-list.md#setting-slow-query-log-always-write-time).
            
            * `MYSQL_AUDIT` — лог аудита.
            
                По умолчанию лог не ведется. Чтобы включить его, измените значение настройки [Audit log](../concepts/settings-list.md#setting-audit-log) при [изменении настроек MySQL®](update.md#change-mysql-config).

        * `columnFilter` — список колонок для вывода информации:

            * `hostname` — [имя хоста](hosts.md#list-hosts).
            * `id` — идентификатор запроса.
            * `message` — сообщение, которое выводит сервис.
            * `status` — статус сообщения, например `Note` или `Warning`.
            * `raw` — информация по всем колонкам в необработанном виде.

            {% note info %}

            В примере приведены только основные колонки. Список выводимых колонок зависит от выбранного типа сервиса `serviceType`.

            {% endnote %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.mysql.v1.StreamLogRecord).

        Команда не завершается после отправки. Новые логи отображаются в выводе команды в режиме реального времени.

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
    1. Воспользуйтесь вызовом [ClusterService/StreamLogs](../api-ref/grpc/Cluster/streamLogs.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "service_type": "<тип_сервиса>",
                  "column_filter": [
                    "<колонка_1>", "<колонка_2>", ..., "<колонка_N>"
                  ]
                }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.mysql.v1.ClusterService.StreamLogs
        ```

        Где:

        * `service_type` — тип сервиса, логи которого нужно получить:

            * `MYSQL_ERROR` — лог ошибок, связанных с запуском, работой и остановкой инстансов MySQL®.
            * `MYSQL_GENERAL` — лог клиентских соединений и запросов.
            
                По умолчанию лог не ведется. Чтобы включить его, измените значение настройки [General log](../concepts/settings-list.md#setting-general-log) при [изменении настроек MySQL®](update.md#change-mysql-config).
            
            * `MYSQL_SLOW_QUERY` — лог медленных запросов.
            
                По умолчанию лог не ведется. Чтобы включить его, измените значение настройки [Slow query log](../concepts/settings-list.md#setting-slow-query-log) при [изменении настроек MySQL®](update.md#change-mysql-config). Смотрите также настройки [Log slow filter](../concepts/settings-list.md#setting-log-slow-filter), [Log slow rate limit](../concepts/settings-list.md#setting-log-slow-rate-limit), [Log slow rate type](../concepts/settings-list.md#setting-log-slow-rate-type), [Log slow sp statements](../concepts/settings-list.md#setting-log-slow-sp-statements) и [Slow query log always write time](../concepts/settings-list.md#setting-slow-query-log-always-write-time).
            
            * `MYSQL_AUDIT` — лог аудита.
            
                По умолчанию лог не ведется. Чтобы включить его, измените значение настройки [Audit log](../concepts/settings-list.md#setting-audit-log) при [изменении настроек MySQL®](update.md#change-mysql-config).

        * `column_filter` — список колонок для вывода информации:

            * `hostname` — [имя хоста](hosts.md#list-hosts).
            * `id` — идентификатор запроса.
            * `message` — сообщение, которое выводит сервис.
            * `status` — статус сообщения, например `Note` или `Warning`.
            * `raw` — информация по всем колонкам в необработанном виде.

            {% note info %}

            В примере приведены только основные колонки. Список выводимых колонок зависит от выбранного типа сервиса `service_type`.

            {% endnote %}

        * `from_time` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2024-09-18T15:04:05Z`.
        * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.mysql.v1.StreamLogRecord).

        Команда не завершается после отправки. Новые логи отображаются в выводе команды в режиме реального времени.

{% endlist %}