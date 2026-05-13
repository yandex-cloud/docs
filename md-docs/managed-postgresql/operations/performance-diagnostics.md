# Диагностика производительности в Managed Service for PostgreSQL

Managed Service for PostgreSQL предоставляет встроенный инструмент для диагностики производительности кластера СУБД. Этот инструмент помогает анализировать метрики производительности PostgreSQL для [сессий](#get-sessions) и [запросов](#get-queries).

О том, как выявить и устранить проблемы с производительностью кластера, см. в разделах [Анализ производительности и оптимизация](../tutorials/profiling.md) и [Поиск проблем с производительностью кластера](../tutorials/performance-problems.md).

## Активировать сбор статистики {#activate-stats-collector}

{% list tabs %}

* Консоль управления {#console}

    При [создании кластера](cluster-create.md) или [изменении его настроек](update.md#change-additional-settings):
    
    1. Включите опцию **Сбор статистики** (по умолчанию отключена).
    1. Настройте **Интервал сбора сессий** и **Интервал сбора запросов**. Допустимые значения:
        
        * для сессий — от `5` до `86400` секунд;
        * для запросов — от `60` до `86400` секунд.

* CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы включить сбор статистики, передайте параметр `--performance-diagnostics` в команде изменения кластера:

    ```bash
    yc managed-postgresql cluster update <имя_или_идентификатор_кластера> \
        ...
        --performance-diagnostics enabled=true,`
                                 `sessions-sampling-interval=<интервал_сбора_сессий>,`
                                 `statements-sampling-interval=<интервал_сбора_запросов> \
        ...
    ```

    Допустимые значения параметров:

    - `sessions-sampling-interval` — от `5` до `86400` секунд.
    - `statements-sampling-interval` — от `60` до `86400` секунд.

* Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера Managed Service for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).

    1. Чтобы настроить сбор статистики, добавьте в блок `config` блок `performance_diagnostics`:
       
       ```hcl
       resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
         ...
         config {
           ...
           performance_diagnostics {
             enabled                      = <активация_сбора_статистики>
             sessions_sampling_interval   = <интервал_сбора_сессий>
             statements_sampling_interval = <интервал_сбора_запросов>
           }
           ...
         }
         ...
       }
       ```
       
       Где:
       
       * `enabled` — активация сбора статистики: `true` или `false`.
       * `sessions_sampling_interval` — интервал сбора сессий от `5` до `86400` секунд.
       * `statements_sampling_interval` — интервал сбора запросов от `60` до `86400` секунд.

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        {% note warning "Ограничения по времени" %}
        
        Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
        
        * создание, в том числе путем восстановления из резервной копии, — 30 минут;
        * изменение — 60 минут;
        * удаление — 15 минут.
        
        Операции, длящиеся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
          ...
          timeouts {
            create = "1h30m" # Полтора часа
            update = "2h"    # 2 часа
            delete = "30m"   # 30 минут
          }
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

* REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Чтобы включить сбор статистики при создании кластера:

     1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и добавьте параметр `configSpec.performanceDiagnostics` в [команду cURL по созданию кластера](cluster-create.md#create-cluster):

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters' \
          --data '{
                    "configSpec": {
                      "performanceDiagnostics": {
                        "enabled": <активировать_сбор_статистики>,
                        "sessionsSamplingInterval": "<интервал_сбора_сессий>",
                        "statementsSamplingInterval": "<интервал_сбора_запросов>"
                      },
                      ...
                    },
                    ...
                  }'
        ```

        Где `configSpec.performanceDiagnostics` — настройки сбора статистики:

        * `enabled` — активация сбора статистики: `true` или `false`.
        * `sessionsSamplingInterval` — интервал сбора сессий. Допустимые значения — от `5` до `86400` секунд.
        * `statementsSamplingInterval` — интервал сбора запросов. Допустимые значения — от `60` до `86400` секунд.

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

  1. Чтобы включить сбор статистики при изменении существующего кластера:

     1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "configSpec.performanceDiagnostics",
                    "configSpec": {
                      "performanceDiagnostics": {
                        "enabled": <активировать_сбор_статистики>,
                        "sessionsSamplingInterval": "<интервал_сбора_сессий>",
                        "statementsSamplingInterval": "<интервал_сбора_запросов>"
                      }
                    }
                  }'
        ```

        Где `configSpec.performanceDiagnostics` — настройки сбора статистики:

        * `enabled` — активация сбора статистики: `true` или `false`.
        * `sessionsSamplingInterval` — интервал сбора сессий. Допустимые значения — от `5` до `86400` секунд.
        * `statementsSamplingInterval` — интервал сбора запросов. Допустимые значения — от `60` до `86400` секунд.

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

* gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Чтобы включить сбор статистики при создании кластера:

     1. Воспользуйтесь методом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и добавьте параметр `config_spec.performance_diagnostics` в [команду grpcurl по созданию кластера](cluster-create.md#grpc-api):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "config_spec": {
                  "performance_diagnostics": {
                    "enabled": <активировать_сбор_статистики>,
                    "sessions_sampling_interval": "<интервал_сбора_сессий>",
                    "statements_sampling_interval": "<интервал_сбора_запросов>"
                  },
                  ...
                },
                ...
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.postgresql.v1.ClusterService.Create
        ```

        Где `config_spec.performance_diagnostics` — настройки сбора статистики:

        * `enabled` — активация сбора статистики: `true` или `false`.
        * `sessions_sampling_interval` — интервал сбора сессий. Допустимые значения — от `5` до `86400` секунд.
        * `statements_sampling_interval` — интервал сбора запросов. Допустимые значения — от `60` до `86400` секунд.

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

  1. Чтобы включить сбор статистики при изменении существующего кластера:

     1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
        {% cut "Формат перечисления настроек" %}
        
        ```yaml
        "update_mask": {
            "paths": [
                "<настройка_1>",
                "<настройка_2>",
                ...
                "<настройка_N>"
            ]
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config_spec.performance_diagnostics"
                  ]
                },
                "config_spec": {
                  "performance_diagnostics": {
                    "enabled": <активировать_сбор_статистики>,
                    "sessions_sampling_interval": "<интервал_сбора_сессий>",
                    "statements_sampling_interval": "<интервал_сбора_запросов>"
                  }
                }
              }' \
          mdb.api.cloud.yandex.net:443 \
          yandex.cloud.mdb.postgresql.v1.ClusterService.Update
        ```

        Где `config_spec.performance_diagnostics` — настройки сбора статистики:

        * `enabled` — активация сбора статистики: `true` или `false`.
        * `sessions_sampling_interval` — интервал сбора сессий. Допустимые значения — от `5` до `86400` секунд.
        * `statements_sampling_interval` — интервал сбора запросов. Допустимые значения — от `60` до `86400` секунд.

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Получить статистику по сессиям {#get-sessions}

{% list tabs %}

* Консоль управления {#console}

    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Диагностика производительности** → **Сессии**.

    Для просмотра статистики по сессиям:

    1. Задайте интересующий временной интервал.
    1. (Опционально) Настройте фильтры.
    1. Выберите нужный срез данных.

    Чтобы показать или скрыть отдельные категории, нажмите на имя категории в легенде графика.

    Для просмотра истории запросов в рамках сессии:

    1. Задайте интересующий временной интервал.
    1. (Опционально) Настройте фильтры.

* gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Воспользуйтесь вызовом [PerformanceDiagnosticsService.ListRawSessionStates](../api-ref/grpc/PerformanceDiagnostics/listRawSessionStates.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/perf_diag_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "from_time": "<левая_граница_временного_диапазона>",
             "to_time": "<правая_граница_временного_диапазона>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.PerformanceDiagnosticsService.ListRawSessionStates
     ```

     Где:

     * `from_time` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2024-09-18T15:04:05Z`.
     * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/PerformanceDiagnostics/listRawSessionStates.md#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesResponse).

{% endlist %}

Подробнее про отображаемые сведения см. [в документации PostgreSQL](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

## Получить статистику по запросам {#get-queries}

{% list tabs %}

* Консоль управления {#console}

    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Диагностика производительности** → **Запросы**.

    Для просмотра статистики запросов за интервал:

    1. Выберите интересующий временной интервал.
    1. (Опционально) Настройте фильтры.

    Чтобы получить сведения об относительном изменении статистических характеристик запросов:

    1. В поле **Интервал 1** выберите временной интервал, статистика за который будет основой для расчетов.
    1. В поле **Интервал 2** выберите временной интервал, статистика за который будет сравниваться со статистикой первого интервала.
    1. (Опционально) Настройте фильтры.

    Например, пусть в первом интервале было выполнено 10 запросов `SELECT * FROM cities`, а во втором — 20. Тогда при сравнении статистических данных разница по метрике <q>количество запросов</q> (столбец `Calls` в таблице) будет равняться `+100%`.

* gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Воспользуйтесь вызовом [PerformanceDiagnosticsService.ListRawStatements](../api-ref/grpc/PerformanceDiagnostics/listRawStatements.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/perf_diag_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "from_time": "<левая_граница_временного_диапазона>",
             "to_time": "<правая_граница_временного_диапазона>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.PerformanceDiagnosticsService.ListRawStatements
     ```

     Где:

     * `from_time` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2024-09-18T15:04:05Z`.
     * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/PerformanceDiagnostics/listRawStatements.md#yandex.cloud.mdb.postgresql.v1.ListRawStatementsResponse).

{% endlist %}

Подробнее про отображаемые сведения см. в документации расширений [pg_stat_statements](https://www.postgresql.org/docs/current/pgstatstatements.html) и [pg_stat_kcache](https://github.com/powa-team/pg_stat_kcache/blob/master/README.rst).

## Получить информацию о плане выполнения запроса {#auto-explain-enable}

[Модуль `auto_explain`](https://www.postgresql.org/docs/current/auto-explain.html) позволяет логировать план выполнения медленных запросов автоматически, обходясь без [команды `EXPLAIN`](https://www.postgresql.org/docs/current/sql-explain.html). Это полезно для отслеживания неоптимизированных запросов. Логирование выполняется в общий лог PostgreSQL.

Чтобы включить логирование запросов, [измените настройки СУБД](update.md#change-postgresql-config):

1. В поле **Shared preload libraries** выберите значение `auto_explain`.
1. Включите настройку **Auto explain log analyze**.
1. Задайте настройки модуля `auto_explain`:

    {% note warning %}

    Установка значения `0` для настройки **Auto explain log min duration** или включение настройки **Auto explain log timing** могут существенно снизить производительность кластера.

    {% endnote %}

    * [**Auto explain log buffers**](../concepts/settings-list.md#setting-auto-explain-log-buffers)
    * [**Auto explain log min duration**](../concepts/settings-list.md#setting-auto-explain-log-min-duration)
    * [**Auto explain log nested statements**](../concepts/settings-list.md#setting-auto-explain-log-nested-statements)
    * [**Auto explain log timing**](../concepts/settings-list.md#setting-auto-explain-log-timing)
    * [**Auto explain log triggers**](../concepts/settings-list.md#setting-auto-explain-log-triggers)
    * [**Auto explain log verbose**](../concepts/settings-list.md#setting-auto-explain-log-verbose)
    * [**Auto explain sample rate**](../concepts/settings-list.md#setting-auto-explain-sample-rate)