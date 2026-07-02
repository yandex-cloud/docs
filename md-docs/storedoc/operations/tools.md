[Документация Yandex Cloud](../../index.md) > [Yandex StoreDoc](../index.md) > [Пошаговые инструкции](index.md) > Логи и мониторинг > Инструменты для анализа производительности

# Инструменты для анализа производительности

## Встроенные утилиты диагностики {#monitoring-tools}

В Yandex StoreDoc есть утилиты получения данных о производительности:

* `mongostat` — собирает статистику утилизации ресурсов CPU и памяти процессами Yandex StoreDoc,
* `mongotop` — собирает статистику чтения/записи данных по каждой коллекции.

При вызове этих утилит используйте учетную запись пользователя БД с ролью [mdbMonitor](../concepts/users-and-roles.md#mdbMonitor).

Например, чтобы вывести набор данных о производительности с интервалом опроса (polling interval) в 5 секунд, выполните одну из следующих команд:

```bash
mongostat 5 \
  --ssl \
  --host=<FQDN_хоста_Yandex_StoreDoc> \
  --port=27018 \
  --username=<имя_пользователя> \
  --authenticationDatabase=admin
```

```bash
mongotop 5 \
  --ssl \
  --host=<FQDN_хоста_Yandex_StoreDoc> \
  --port=27018 \
  --username=<имя_пользователя> \
  --authenticationDatabase=admin
```

О том, как получить FQDN хоста, читайте в [инструкции](connect/index.md#get-fqdn).


### Профилировщик {#explore-profiler}

В Yandex StoreDoc есть встроенный профилировщик. Он собирает данные о запросах. Затем на основе этих данных формируется стратегия оптимизации запросов. Работой профилировщика управляют [настройки Yandex StoreDoc](../concepts/settings-list.md), которые вы можете задать при [создании кластера](cluster-create.md) или [изменении настроек СУБД](update.md#change-mongod-config):

* [operationProfiling.mode](../concepts/settings-list.md#setting-operation-profiling);
* [operationProfiling.slowOpThreshold](../concepts/settings-list.md#setting-slow-op-threshold).

{% note warning %}

Использование значения `all` для настройки `operationProfiling.mode` и близкого к `0` значения для настройки `operationProfiling.slowOpThreshold` значительно снижает производительность кластера.

{% endnote %}

Чтобы просмотреть данные, собранные профилировщиком, обратитесь к коллекции `system.profile` в каждой БД. Коллекции профилировщика доступны для чтения [пользователю](cluster-users.md#adduser) с ролью [`mdbMonitor`](../concepts/users-and-roles.md#mdbMonitor). По умолчанию данные дублируются в логах.


### Выполняемые в данный момент запросы {#list-running-queries}

Чтобы посмотреть не относящиеся к текущему пользователю запросы, от имени пользователя с ролью [`mdbMonitor`](../concepts/users-and-roles.md#mdbMonitor) выполните запрос db.currentOp():

```javascript
db.currentOp()
```

Чтобы посмотреть запросы текущего пользователя, выполните запрос `db.currentOp()` со значением `true` для настройки `ownOps`:

```javascript
db.currentOp({ "$ownOps": true })
```

## Логи {#explore-logs}

Наиболее подробная информация о работе Yandex StoreDoc содержится в логах.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. Перейдите в сервис **Yandex StoreDoc**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/receipt.svg) **Логи**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы посмотреть логи **Yandex StoreDoc**:

    1. Посмотрите описание команды CLI для просмотра логов:

        ```bash
        yc managed-mongodb cluster list-logs --help
        ```

    1. Для получения всех логов кластера выполните команду:

        ```bash
        yc managed-mongodb cluster list-logs --id <идентификатор_кластера>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.mongodb.v1.ListClusterLogsResponse).

{% endlist %}