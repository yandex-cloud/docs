# Просмотр логов кластера {{ KF }}

{{ mkf-name }} позволяет [получить фрагмент логов кластера](#get-log) за выбранный период и [просматривать логи в реальном времени](#get-log-stream).

{% note info %}

Здесь под логом понимается системный лог кластера и его хостов. Этот лог не имеет отношения к логу раздела для топика {{ KF }}, в который брокер записывает поступающие от производителей сообщения.

{% endnote %}

{% note info %}

Логи кластера хранятся 45 дней.

{% endnote %}

## Получить лог кластера {#get-log}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}**.
    1. Выберите **{{ ui-key.yacloud.kafka.label_filter_origin }}**, **{{ ui-key.yacloud.mdb.cluster.logs.label_hosts }}** и **{{ ui-key.yacloud.mdb.cluster.logs.label_severity }}**.
    1. Укажите период времени, за который нужно отобразить лог.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

        * `--limit` — ограничение на количество выводимых записей.
        * `--columns` — список колонок лога, из которых будет выводиться информация:
            * `hostname` — [имя хоста](cluster-hosts.md).
            * `message` — сообщение, которое выводит компонент.
            * `severity` — уровень логирования. Пример выводимого значения: `INFO`.
            * `origin` — источник сообщения. Примеры выводимых значений: `kafka_server` или `kafka_controller`.

        * `--filter` — настройки фильтрации записей, например `message.hostname='node1.{{ dns-zone }}'`.
        * `--since` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html), `HH:MM:SS` или временного промежутка относительно текущего времени. Примеры: `2006-01-02T15:04:05Z`, `15:04:05`, `2h`, `3h30m ago`.
        * `--until` — правая граница временного диапазона, формат аналогичен `--since`.

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

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

            * `hostname` — имя хоста.
            * `component` — тип компонента, который попадет в лог. Например, `HTTP-Session`.
            * `message` — сообщение, которое выводит компонент.
            * `query_id` — идентификатор запроса.
            * `severity` — уровень логирования, например, `Debug`.
            * `thread` — идентификатор потока, участвующего в обработке запросов.

            В одном параметре `columnFilter` можно указать только одну колонку. Если необходимо отфильтровать логи по нескольким колонкам, передайте перечень нужных колонок в нескольких параметрах.

        * `fromTime` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `{{ sample-rfc3339-timestamp }}`.

        * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.

        
        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.kafka.v1.ListClusterLogsResponse).

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

            * `hostname` — имя хоста.
            * `component` — тип компонента, который попадет в лог. Например, `HTTP-Session`.
            * `message` — сообщение, которое выводит компонент.
            * `query_id` — идентификатор запроса.
            * `severity` — уровень логирования, например, `Debug`.
            * `thread` — идентификатор потока, участвующего в обработке запросов.

            В параметре `column_filter` можно указать несколько колонок, если нужно отфильтровать логи по нескольким колонкам.

        * `from_time` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `{{ sample-rfc3339-timestamp }}`.

        * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

        
        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.kafka.v1.ListClusterLogsResponse).

{% endlist %}

## Получить поток записей лога {#get-log-stream}

Этот способ позволяет получать логи кластера в реальном времени.

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Для просмотра логов кластера по мере их поступления выполните команду:

    ```bash
    {{ yc-mdb-kf }} cluster list-logs <имя_или_идентификатор_кластера> --follow
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

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

            * `hostname` — имя хоста.
            * `component` — тип компонента, который попадет в лог. Например, `HTTP-Session`.
            * `message` — сообщение, которое выводит компонент.
            * `query_id` — идентификатор запроса.
            * `severity` — уровень логирования, например, `Debug`.
            * `thread` — идентификатор потока, участвующего в обработке запросов.

            В одном параметре `columnFilter` можно указать только одну колонку. Если необходимо отфильтровать логи по нескольким колонкам, передайте перечень нужных колонок в нескольких параметрах.

        * `fromTime` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `{{ sample-rfc3339-timestamp }}`.

        * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.

            Если не указывать этот параметр, то в поток логов будут отсылаться новые логи по мере их появления. Это поведение семантически эквивалентно `tail -f`.

        * `filter` — фильтр логов. Можно отфильтровать логи так, чтобы поток логов содержал только нужные логи.

            Подробнее о фильтрах и их синтаксисе в [справочнике API](../api-ref/Cluster/streamLogs.md#query_params).

            {% note tip %}
            
            Фильтр может содержать в себе кавычки и другие символы. Экранируйте их, если это необходимо.
            
            {% endnote %}
            
            Поддерживаемые фильтры:
            
            * `message.hostname` — фильтрация по имени хоста.
            * `message.severity` — фильтрация по уровню логирования.

        
        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/streamLogs.md#yandex.cloud.mdb.kafka.v1.StreamLogRecord).

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

            * `hostname` — имя хоста.
            * `component` — тип компонента, который попадет в лог. Например, `HTTP-Session`.
            * `message` — сообщение, которое выводит компонент.
            * `query_id` — идентификатор запроса.
            * `severity` — уровень логирования, например, `Debug`.
            * `thread` — идентификатор потока, участвующего в обработке запросов.

            В параметре `column_filter` можно указать несколько колонок, если нужно отфильтровать логи по нескольким колонкам.

        * `from_time` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `{{ sample-rfc3339-timestamp }}`.

        * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

            Если не указывать этот параметр, то в поток логов будут отсылаться новые логи по мере их появления. Это поведение семантически эквивалентно `tail -f`.

        * `filter` — фильтр логов. Можно отфильтровать логи так, чтобы поток логов содержал только нужные логи.

            {% note tip %}
            
            Фильтр может содержать в себе кавычки и другие символы. Экранируйте их, если это необходимо.
            
            {% endnote %}
            
            Поддерживаемые фильтры:
            
            * `message.hostname` — фильтрация по имени хоста.
            * `message.severity` — фильтрация по уровню логирования.

            Подробнее о фильтрах и их синтаксисе в [справочнике API](../api-ref/grpc/Cluster/streamLogs.md).

        
        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/streamLogs.md#yandex.cloud.mdb.kafka.v1.StreamLogRecord).

{% endlist %}