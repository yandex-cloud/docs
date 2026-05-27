# Просмотр логов кластера Yandex StoreDoc

Yandex StoreDoc позволяет [получить фрагмент логов кластера](#get-log) за выбранный период и [просматривать логи в реальном времени](#get-log-stream).

{% note info %}

Логи операций кластера хранятся 45 дней, аудитные логи — 90 дней.

{% endnote %}

## Получить лог кластера {#get-log}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud), в котором находится кластер.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex StoreDoc**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/receipt.svg) **Логи**.
    1. Укажите период времени, за который нужно отобразить логи: введите его вручную или выберите в календаре, нажав на поле ввода дат.
    1. При необходимости укажите хосты и уровень логирования в строке с полем ввода дат.

    Будет отображен список записей в логе за выбранный период времени. Чтобы посмотреть подробную информацию о событии, нажмите на интересующую запись в списке.

    Если записей слишком много и отображается только часть из них, нажмите на кнопку **Загрузить еще** в конце списка.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Просмотрите описание команды CLI для просмотра логов кластера:

        ```bash
        yc managed-mongodb cluster list-logs --help
        ```

    1. Запустите команду получения логов кластера (в примере приведены не все доступные параметры):

        ```bash
        yc managed-mongodb cluster list-logs <имя_или_идентификатор_кластера> \
           --limit <ограничение_количества_записей> \
           --service-type <тип_сервиса> \
           --columns <список_колонок_для_вывода_информации> \
           --filter <настройки_фильтрации_записей> \
           --since <левая_граница_временного_диапазона> \
           --until <правая_граница_временного_диапазона>
        ```

        Где:

        * `--limit` — ограничение на количество выводимых записей.
        * `--service-type` — тип сервиса, для которого требуется вывести записи (`mongod`, `mongos`, `mongocfg` или `audit`).
        * `--columns` — список колонок для вывода информации:
            * `component` — тип компонента, который попадет в лог. Например, `CONTROL`.
            * `context` — имя исполняемого модуля, например, `signalProcessingThread`.
            * `hostname` — [имя хоста](hosts.md#list-hosts).
            * `message` — сообщение, которое выводит компонент.
            * `severity` — уровень логирования, например, `I` или `W` (`Info` и `Warning` соответственно).

            {% note info %}

            Список выводимых колонок зависит от выбранного типа сервиса `--service-type`.

            {% endnote %}

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
            --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>:logs' \
            --url-query serviceType=<тип_сервиса> \
            --url-query columnFilter=<список_колонок> \
            --url-query fromTime=<левая_граница_временного_диапазона> \
            --url-query toTime=<правая_граница_временного_диапазона>
        ```

        Где:

        * `serviceType` — тип сервиса, логи которого нужно получить:

          * `MONGOD` — лог операций Yandex StoreDoc.
          * `AUDIT` — лог аудита.

        * `columnFilter` — список колонок для вывода информации:
          
          * `hostname` — имя хоста.
          * `component` — тип компонента, который попадет в лог. Например, `HTTP-Session`.
          * `message` — сообщение, которое выводит компонент.
          * `query_id` — идентификатор запроса.
          * `severity` — уровень логирования, например, `Debug`.
          * `thread` — идентификатор потока, участвующего в обработке запросов.

          В одном параметре `columnFilter` можно указать только одну колонку. Если необходимо отфильтровать логи по нескольким колонкам, передайте перечень нужных колонок в нескольких параметрах.

            * `fromTime` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2006-01-02T15:04:05Z`.

            * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.mongodb.v1.ListClusterLogsResponse).

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
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
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
          yandex.cloud.mdb.mongodb.v1.ClusterService.ListLogs
        ```

        Где:

        * `service_type` — тип сервиса, логи которого нужно получить:
        
          * `MONGOD` — лог операций Yandex StoreDoc.
          * `AUDIT` — лог аудита.

        * `column_filter` — список колонок для вывода информации:

          * `hostname` — имя хоста.
          * `component` — тип компонента, который попадет в лог. Например, `HTTP-Session`.
          * `message` — сообщение, которое выводит компонент.
          * `query_id` — идентификатор запроса.
          * `severity` — уровень логирования, например, `Debug`.
          * `thread` — идентификатор потока, участвующего в обработке запросов.

          В параметре `column_filter` можно указать несколько колонок, если нужно отфильтровать логи по нескольким колонкам.

            * `from_time` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2006-01-02T15:04:05Z`.

            * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.mongodb.v1.ListClusterLogsResponse).

{% endlist %}

## Получить поток логов кластера {#get-log-stream}

Этот способ позволяет получать логи кластера в реальном времени.

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Для просмотра логов кластера по мере их поступления выполните команду:

    ```bash
    yc managed-mongodb cluster list-logs <имя_или_идентификатор_кластера> --follow
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
            --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>:stream_logs' \
            --url-query serviceType=<тип_сервиса> \
            --url-query columnFilter=<список_колонок> \
            --url-query fromTime=<левая_граница_временного_диапазона> \
            --url-query toTime=<правая_граница_временного_диапазона> \
            --url-query filter=<фильтр_логов>
        ```

        Где:

        * `serviceType` — тип сервиса, логи которого нужно получить:

          * `MONGOD` — лог операций Yandex StoreDoc.
          * `AUDIT` — лог аудита.

        * `columnFilter` — список колонок для вывода информации:

          * `hostname` — имя хоста.
          * `component` — тип компонента, который попадет в лог. Например, `HTTP-Session`.
          * `message` — сообщение, которое выводит компонент.
          * `query_id` — идентификатор запроса.
          * `severity` — уровень логирования, например, `Debug`.
          * `thread` — идентификатор потока, участвующего в обработке запросов.

          В одном параметре `columnFilter` можно указать только одну колонку. Если необходимо отфильтровать логи по нескольким колонкам, передайте перечень нужных колонок в нескольких параметрах.
        
            * `fromTime` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2006-01-02T15:04:05Z`.

            * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.

        * `filter` — фильтр логов. Можно отфильтровать логи так, чтобы поток логов содержал только нужные логи.

            Подробнее о фильтрах и их синтаксисе см. в [справочнике API](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.mongodb.v1.StreamClusterLogsRequest).

            {% note tip %}
            
            Фильтр может содержать в себе кавычки и другие символы. Экранируйте их, если это необходимо.
            
            {% endnote %}
            
            Поддерживаемые фильтры:
            
            * `message.hostname` — фильтрация по имени хоста.
            * `message.severity` — фильтрация по уровню логирования.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.mongodb.v1.StreamLogRecord).

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
    1. Воспользуйтесь вызовом [ClusterService.StreamLogs](../api-ref/grpc/Cluster/listLogs.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "service_type": "<тип_сервиса>",
                "column_filter": [
                  "<колонка_1>", "<колонка_2>", ..., "<колонка_N>"
                ],
                "from_time": "<левая_граница_временного_диапазона>",
                "to_time": "<правая_граница_временного_диапазона>",
                "filter": "<фильтр_логов>"
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.mongodb.v1.ClusterService.StreamLogs
        ```

        Где:

        * `service_type` — тип сервиса, логи которого нужно получить:

          * `MONGOD` — лог операций Yandex StoreDoc.
          * `AUDIT` — лог аудита.

        * `column_filter`  — список колонок для вывода информации:

          * `hostname` — имя хоста.
          * `component` — тип компонента, который попадет в лог. Например, `HTTP-Session`.
          * `message` — сообщение, которое выводит компонент.
          * `query_id` — идентификатор запроса.
          * `severity` — уровень логирования, например, `Debug`.
          * `thread` — идентификатор потока, участвующего в обработке запросов.

          В параметре `column_filter` можно указать несколько колонок, если нужно отфильтровать логи по нескольким колонкам.

            * `from_time` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2006-01-02T15:04:05Z`.
        
            * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

        * `filter` — фильтр логов. Можно отфильтровать логи так, чтобы поток логов содержал только нужные логи.

          Подробнее о фильтрах и их синтаксисе см. в [справочнике API](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.mongodb.v1.StreamClusterLogsRequest).

          {% note tip %}
          
          Фильтр может содержать в себе кавычки и другие символы. Экранируйте их, если это необходимо.
          
          {% endnote %}
          
          Поддерживаемые фильтры:
          
          * `message.hostname` — фильтрация по имени хоста.
          * `message.severity` — фильтрация по уровню логирования.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.mongodb.v1.StreamLogRecord).    

{% endlist %}