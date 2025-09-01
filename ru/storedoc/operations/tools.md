---
title: Какие инструменты для анализа производительности есть в {{ SD }}
description: Из статьи вы узнаете, какие инструменты для анализа производительности есть в {{ SD }}.
---

# Инструменты для анализа производительности

## Встроенные утилиты диагностики {#monitoring-tools}

В {{ SD }} есть утилиты получения данных о производительности:

* [mongostat](https://docs.mongodb.com/database-tools/mongostat/#bin.mongostat) — собирает статистику утилизации ресурсов CPU и памяти процессами {{ SD }},
* [mongotop](https://docs.mongodb.com/database-tools/mongotop/#bin.mongotop) — собирает статистику чтения/записи данных по каждой коллекции.

При вызове этих утилит используйте строку подключения с логином и паролем пользователя с ролью `mdbMonitor`, например:

```bash
mongostat 5 --uri="mongodb://{<имя_пользователя_с_ролью_mdbMonitor>}:{<пароль>}@{<хост>}:27018/?authSource=admin"
mongotop 5 --uri="mongodb://{<имя_пользователя_с_ролью_mdbMonitor>}:{<пароль>}@{<хост>}:27018/?authSource=admin"
```

Здесь обе утилиты выводят набор данных о производительности с интервалом опроса (polling interval) в 5 секунд.

Подробнее об использовании утилит `monostat` и `mongotop` см. в [документации {{ MG }}](https://docs.mongodb.com/manual/administration/monitoring/).

### Профилировщик {#explore-profiler}

В {{ SD }} есть [встроенный профилировщик](https://docs.mongodb.com/manual/reference/database-profiler/). Он собирает данные о запросах. Затем на основе этих данных формируется стратегия оптимизации запросов. Работой профилировщика управляют [настройки {{ SD }}](../concepts/settings-list.md), которые вы можете задать при [создании кластера](./cluster-create.md) или [изменении настроек СУБД](./update.md#change-mongod-config):

* [operationProfiling.mode](../concepts/settings-list.md#setting-operation-profiling);
* [operationProfiling.slowOpThreshold](../concepts/settings-list.md#setting-slow-op-threshold).

{% note warning %}

Использование значения `all` для настройки `operationProfiling.mode` и близкого к `0` значения для настройки `operationProfiling.slowOpThreshold` значительно снижает производительность кластера.

{% endnote %}

Чтобы просмотреть данные, собранные профилировщиком, обратитесь к коллекции `system.profile` в каждой БД. Коллекции профилировщика доступны для чтения [пользователю](./cluster-users.md#adduser) с ролью [`mdbMonitor`](../concepts/users-and-roles.md#mdbMonitor). По умолчанию данные дублируются в логах.

Подробнее о настройке профилировщика и о том, как интерпретировать его результаты, читайте в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/database-profiler/).

### Выполняемые в данный момент запросы {#list-running-queries}

Чтобы посмотреть не относящиеся к текущему пользователю запросы, от имени пользователя с ролью [`mdbMonitor`](../concepts/users-and-roles.md#mdbMonitor) выполните [запрос db.currentOp()](https://docs.mongodb.com/manual/reference/method/db.currentOp/):

```javascript
db.currentOp()
```

Чтобы посмотреть запросы текущего пользователя, выполните запрос `db.currentOp()` со значением `true` для [настройки](https://docs.mongodb.com/manual/reference/method/db.currentOp/#behavior) `ownOps`:

```javascript
db.currentOp({ "$ownOps": true })
```

## Логи {#explore-logs}

Наиболее подробная информация о работе {{ SD }} содержится в логах.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **Yandex StoreDoc**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_logs }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы посмотреть логи **Yandex StoreDoc**:

    1. Посмотрите описание команды CLI для просмотра логов:

        ```bash
        {{ yc-mdb-mg }} cluster list-logs --help
        ```

    1. Для получения всех логов кластера выполните команду:

        ```bash
        {{ yc-mdb-mg }} cluster list-logs --id <идентификатор_кластера>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.ListLogs](../api-ref/Cluster/listLogs.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>:logs' \
            --url-query serviceType=<тип_сервиса> \
            --url-query columnFilter=<список_колонок> \
            --url-query fromTime=<левая_граница_временного_диапазона> \
            --url-query toTime=<правая_граница_временного_диапазона>
        ```

        Где:

        * `serviceType` — тип сервиса, логи которого нужно получить:
        
          * `MONGOD` — лог операций {{ SD }}.
          * `AUDIT` — лог аудита.

        * `columnFilter` — список колонок для вывода информации:

          {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

          {% include [column-filter-rest](../../_includes/mdb/api/column-filter-rest.md) %}
        
            {% include [from-time-rest](../../_includes/mdb/api/from-time-rest.md) %}

            * `toTime` — правая граница временного диапазона, формат аналогичен `fromTime`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/listLogs.md#yandex.cloud.mdb.mongodb.v1.ListClusterLogsResponse).

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
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.ListLogs
        ```

        Где:

        * `service_type` — тип сервиса, логи которого нужно получить:

          * `MONGOD` — лог операций {{ SD }}.
          * `AUDIT` — лог аудита.

        * `column_filter`  — список колонок для вывода информации:

          {% include [column-filter-list](../../_includes/mdb/api/column-filter-list.md) %}

          {% include [column-filter-grpc](../../_includes/mdb/api/column-filter-grpc.md) %}

            {% include [from-time-grpc](../../_includes/mdb/api/from-time-grpc.md) %}

            * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/listLogs.md#yandex.cloud.mdb.mongodb.v1.ListClusterLogsResponse).

{% endlist %}
