# Диагностика производительности в Managed Service for MySQL®

В Managed Service for MySQL® встроен инструмент для сбора статистики по сессиям и запросам. Эти метрики могут быть полезны при [анализе производительности и оптимизации настроек](../tutorials/profiling-mmy.md) кластера.

## Активировать сбор статистики {#activate-stats-collector}

{% list tabs group=instructions %}

* Консоль управления {#console}

    При [создании кластера](cluster-create.md) или [изменении его настроек](update.md#change-additional-settings):

    1. Включите опцию **Сбор статистики** (по умолчанию отключена).
    1. Настройте **Интервал сбора сессий** и **Интервал сбора запросов**. Допустимые значения:
        
        * для сессий — от `5` до `86400` секунд;
        * для запросов — от `60` до `86400` секунд.

* CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы включить и настроить сбор статистики, передайте параметр `--performance-diagnostics` в команде изменения кластера:

    ```bash
    yc managed-mysql cluster update <имя_или_идентификатор_кластера> \
       ...
       --performance-diagnostics enabled=true,`
                                `sessions-sampling-interval=<интервал_сбора_сессий>,`
                                `statements-sampling-interval=<интервал_сбора_запросов> \
        ...
    ```

    Допустимые значения параметров:

    * `sessions-sampling-interval` — от `5` до `86400` секунд.
    * `statements-sampling-interval` — от `60` до `86400` секунд.

* Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы включить и настроить сбор статистики, добавьте блок `performance_diagnostics` в конфигурацию кластера:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "<название_кластера>" {
          ...
          performance_diagnostics {
            enabled = true
            sessions_sampling_interval = <интервал_сбора_сессий>
            statements_sampling_interval = <интервал_сбора_запросов>
          }
          ...
        }
        ```

        Где:
        
        * `enabled` — активация сбора статистики: `true` или `false`;
        * `sessions_sampling_interval` — интервал сбора сессий: от `5` до `86400` секунд;
        * `statements_sampling_interval` — интервал сбора запросов: от `60` до `86400` секунд.

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
    
    Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for MySQL®:
    
    * создание кластера, в том числе путем восстановления из резервной копии, — 15 минут;
    * изменение кластера, в том числе обновление версии MySQL®, — 60 минут;
    * удаление кластера — 15 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
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

        1. Воспользуйтесь методом [Cluster.create](../api-ref/Cluster/create.md) и добавьте параметр `configSpec.performanceDiagnostics` в [команду cURL по созданию кластера](cluster-create.md#create-cluster):

            ```bash
            curl \
                --request POST \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters' \
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

            * `enabled` — активация сбора статистики: `true` или `false`;
            * `sessionsSamplingInterval` — интервал сбора сессий: от `5` до `86400` секунд;
            * `statementsSamplingInterval` — интервал сбора запросов: от `60` до `86400` секунд.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

    1. Чтобы включить сбор статистики при изменении существующего кластера:

        1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/<идентификатор_кластера>' \
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

            * `enabled` — активация сбора статистики: `true` или `false`;
            * `sessionsSamplingInterval` — интервал сбора сессий: от `5` до `86400` секунд;
            * `statementsSamplingInterval` — интервал сбора запросов: от `60` до `86400` секунд.

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

        1. Воспользуйтесь методом [ClusterService/Create](../api-ref/grpc/Cluster/create.md) и добавьте параметр `config_spec.performance_diagnostics` в [команду gRPCurl по созданию кластера](cluster-create.md#grpc-api):

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
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
                yandex.cloud.mdb.mysql.v1.ClusterService.Create
            ```

            Где `config_spec.performance_diagnostics` — настройки сбора статистики:

            * `enabled` — активация сбора статистики: `true` или `false`;
            * `sessions_sampling_interval` — интервал сбора сессий: от `5` до `86400` секунд;
            * `statements_sampling_interval` — интервал сбора запросов: от `60` до `86400` секунд.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

    1. Чтобы включить сбор статистики при изменении существующего кластера:

        1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
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
                yandex.cloud.mdb.mysql.v1.ClusterService.Update
            ```

            Где `config_spec.performance_diagnostics` — настройки сбора статистики:

            * `enabled` — активация сбора статистики: `true` или `false`;
            * `sessions_sampling_interval` — интервал сбора сессий: от `5` до `86400` секунд;
            * `statements_sampling_interval` — интервал сбора запросов: от `60` до `86400` секунд.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Получить статистику по сессиям {#get-sessions}

1. Перейдите в сервис **Managed Service for&nbsp;MySQL**.
1. Нажмите на имя нужного кластера и выберите вкладку **Диагностика производительности** → **Сессии**.

    Для просмотра статистики по сессиям или истории запросов в рамках сессии выберите соответствующую вкладку.

    {% list tabs %}

    * Статистика

        Для просмотра статистики по сессиям:

        1. Задайте интересующий временной интервал.
        1. (Опционально) Настройте фильтры.
        1. Выберите нужный [срез данных](https://dev.mysql.com/doc/refman/8.0/en/performance-schema-quick-start.html).

        Чтобы показать или скрыть отдельные категории, нажмите на имя категории в легенде графика.

    * История

        Для просмотра истории запросов в рамках сессии:

        1. Задайте интересующий временной интервал.
        1. (Опционально) Настройте фильтры.

    {% endlist %}

## Получить статистику по запросам {#get-queries}

1. Перейдите в сервис **Managed Service for&nbsp;MySQL**.
1. Нажмите на имя нужного кластера и выберите вкладку **Диагностика производительности** → **Запросы**.

    Для просмотра статистики по запросам или сравнения их статистических данных на двух временных интервалах выберите соответствующую вкладку.

    {% list tabs %}

    * Интервал

        Для просмотра статистики запросов:

        1. Выберите интересующий временной интервал.
        1. (Опционально) Настройте фильтры.

    * 2 интервала

        Чтобы получить сведения об относительном изменении статистических характеристик запросов:

        1. В поле **Интервал 1** выберите временной интервал, статистика за который будет основой для расчетов.
        1. В поле **Интервал 2** выберите временной интервал, статистика за который будет сравниваться со статистикой первого интервала.
        1. (Опционально) Настройте фильтры.

        Например, пусть в первом интервале было выполнено 10 запросов `SELECT * FROM cities`, а во втором — 20. Тогда при сравнении статистических данных разница по метрике <q>количество запросов</q> (столбец `Calls` в таблице) будет равняться `+100%`.

    {% endlist %}

### Доступные метрики {#metrics}

В этом разделе перечислены метрики, по которым собирается статистика запросов в [Monitoring](../../monitoring/index.md).

Метрика статистики | Единица измерения | Описание
----- | ----- | -----
**Total query latency** | миллисекунды | Время выполнения запроса, суммарно.
**Total lock latency** | миллисекунды | Время ожидания блокировок, суммарно.
**Avg query latency** | миллисекунды | Среднее время выполнения запроса.
**Avg lock latency** | миллисекунды | Среднее время ожидания блокировок.
**Rows examined** | штуки | Количество прочитанных строк.
**Calls** | штуки | Количество обращений к базе данных.
**Rows sent** | штуки | Количество возвращенных строк в ответе.
**Rows affected** | штуки | Количество измененных, удаленных, добавленных или возвращенных в ответе строк.
**Tmp tables** | штуки | Количество временных таблиц, созданных при обработке запроса.
**Tmp disk tables** | штуки | Количество временных таблиц, созданных на диске при обработке запроса.
**Select full join** | штуки | Количество джоинов, которые используют скан таблицы вместо индекса.
**Select full range join** | штуки | Количество джоинов, которые используют поиск по интервалу в референсной таблице.
**Select range** | штуки | Количество выборок по интервалам.
**Select scan** | штуки | Количество выборок с использованием скана таблицы.
**Sort merge passes** | штуки | Количество сортировок по слияниям таблиц.
**Sort range** | штуки | Количество сортировок по интервалам в единицу времени.
**Sort rows** | штуки | Количество отсортированных строк в единицу времени.
**Sort scan** | штуки | Количество сортировок с использованием скана таблицы в единицу времени.
**No index used** | 0/1 | `1`, если при сканировании таблицы не использовался индекс, `0` в ином случае.
**No good index used** | 0/1 | `1`, если для выполнения запроса не найден подходящий индекс, `0` в ином случае.
**Errors** | штуки | Количество ошибок при выполнении запроса.
**Warnings** | штуки | Количество предупреждений при выполнении запроса.

Подробнее про отображаемые сведения см. в [документации MySQL®](https://dev.mysql.com/doc/refman/8.0/en/performance-schema-events-statements-current-table.html).