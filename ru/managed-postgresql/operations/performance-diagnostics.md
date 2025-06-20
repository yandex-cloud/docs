# Диагностика производительности в {{ mpg-name }}

{{ mpg-name }} предоставляет встроенный инструмент для диагностики производительности кластера СУБД. Этот инструмент помогает анализировать метрики производительности {{ PG }} для [сессий](#get-sessions) и [запросов](#get-queries).

О том, как выявить и устранить проблемы с производительностью кластера, см. в разделах [Анализ производительности и оптимизация](../tutorials/profiling.md) и [Поиск проблем с производительностью кластера](../tutorials/performance-problems.md).

## Активировать сбор статистики {#activate-stats-collector}

{% list tabs %}

* Консоль управления {#console}

    Включите опцию **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** при [создании кластера](cluster-create.md) или [изменении его настроек](update.md#change-additional-settings) (по умолчанию опция отключена).

* CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы включить сбор статистики, передайте параметр `--performance-diagnostics` в команде изменения кластера:

    ```bash
    {{ yc-mdb-pg }} cluster update <имя_или_идентификатор_кластера> \
        ...
        --performance-diagnostics enabled=true,`
                                 `sessions-sampling-interval=<интервал_сбора_сессий>,`
                                 `statements-sampling-interval=<интервал_сбора_запросов> \
        ...
    ```

    Допустимые значения параметров:

    - `sessions-sampling-interval` — от `1` до `86400` секунд.
    - `statements-sampling-interval` — от `60` до `86400` секунд.

* {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

    1. {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

* REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Чтобы включить сбор статистики при создании кластера:

     1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и добавьте параметр `configSpec.performanceDiagnostics` в [команду cURL по созданию кластера](cluster-create.md#create-cluster):

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters' \
          --data '{
                    "configSpec": {
                      "performanceDiagnostics": {
                        "enabled": <активация_сбора_статистики:_true_или_false>,
                        "sessionsSamplingInterval": "<интервал_сбора_сессий>",
                        "statementsSamplingInterval": "<интервала_сбора_запросов>"
                      },
                      ...
                    },
                    ...
                  }'
        ```

        Где `configSpec.performanceDiagnostics` — настройки сбора статистики:

        * `enabled` — активация сбора статистики.
        * `sessionsSamplingInterval` — интервал сбора сессий. Допустимые значения — от `1` до `86400` секунд.
        * `statementsSamplingInterval` — интервал сбора запросов. Допустимые значения — от `60` до `86400` секунд.

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

  1. Чтобы включить сбор статистики при изменении существующего кластера:

     1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "configSpec.performanceDiagnostics",
                    "configSpec": {
                      "performanceDiagnostics": {
                        "enabled": <активация_сбора_статистики:_true_или_false>,
                        "sessionsSamplingInterval": "<интервал_сбора_сессий>",
                        "statementsSamplingInterval": "<интервала_сбора_запросов>"
                      }
                    }
                  }'
        ```

        Где `configSpec.performanceDiagnostics` — настройки сбора статистики:

        * `enabled` — активация сбора статистики.
        * `sessionsSamplingInterval` — интервал сбора сессий. Допустимые значения — от `1` до `86400` секунд.
        * `statementsSamplingInterval` — интервал сбора запросов. Допустимые значения — от `60` до `86400` секунд.

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

* gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
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
                    "enabled": <активация_сбора_статистики:_true_или_false>,
                    "sessions_sampling_interval": "<интервал_сбора_сессий>",
                    "statements_sampling_interval": "<интервала_сбора_запросов>"
                  },
                  ...
                },
                ...
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.postgresql.v1.ClusterService.Create
        ```

        Где `config_spec.performance_diagnostics` — настройки сбора статистики:

        * `enabled` — активация сбора статистики.
        * `sessions_sampling_interval` — интервал сбора сессий. Допустимые значения — от `1` до `86400` секунд.
        * `statements_sampling_interval` — интервал сбора запросов. Допустимые значения — от `60` до `86400` секунд.

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

  1. Чтобы включить сбор статистики при изменении существующего кластера:

     1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

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
                    "enabled": <активация_сбора_статистики:_true_или_false>,
                    "sessions_sampling_interval": "<интервал_сбора_сессий>",
                    "statements_sampling_interval": "<интервала_сбора_запросов>"
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.postgresql.v1.ClusterService.Update
        ```

        Где `config_spec.performance_diagnostics` — настройки сбора статистики:

        * `enabled` — активация сбора статистики.
        * `sessions_sampling_interval` — интервал сбора сессий. Допустимые значения — от `1` до `86400` секунд.
        * `statements_sampling_interval` — интервал сбора запросов. Допустимые значения — от `60` до `86400` секунд.

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Получить статистику по сессиям {#get-sessions}

{% list tabs %}

* Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_sessions }}**.

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

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [PerformanceDiagnosticsService.ListRawSessionStates](../api-ref/grpc/PerformanceDiagnostics/listRawSessionStates.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.PerformanceDiagnosticsService.ListRawSessionStates
     ```

     Где:

     * `from_time` — левая граница временного диапазона в формате [RFC-3339](https://www.ietf.org/rfc/rfc3339.html). Пример: `2024-09-18T15:04:05Z`.
     * `to_time` — правая граница временного диапазона, формат аналогичен `from_time`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/PerformanceDiagnostics/listRawSessionStates.md#yandex.cloud.mdb.postgresql.v1.ListRawSessionStatesResponse).

{% endlist %}

Подробнее про отображаемые сведения см. [в документации {{ PG }}](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

## Получить статистику по запросам {#get-queries}

{% list tabs %}

* Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_queries }}**.

    Для просмотра статистики запросов за интервал:

    1. Выберите интересующий временной интервал.
    1. (Опционально) Настройте фильтры.

    Чтобы получить сведения об относительном изменении статистических характеристик запросов:

    1. В поле **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-first }}** выберите временной интервал, статистика за который будет основой для расчетов.
    1. В поле **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-second }}** выберите временной интервал, статистика за который будет сравниваться со статистикой первого интервала.
    1. (Опционально) Настройте фильтры.

    Например, пусть в первом интервале было выполнено 10 запросов `SELECT * FROM cities`, а во втором — 20. Тогда при сравнении статистических данных разница по метрике <q>количество запросов</q> (столбец `Calls` в таблице) будет равняться `+100%`.

* gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [PerformanceDiagnosticsService.ListRawStatements](../api-ref/grpc/PerformanceDiagnostics/listRawStatements.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
       {{ api-host-mdb }}:{{ port-https }} \
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

[Модуль `auto_explain`](https://www.postgresql.org/docs/current/auto-explain.html) позволяет логировать план выполнения медленных запросов автоматически, обходясь без [команды `EXPLAIN`](https://www.postgresql.org/docs/current/sql-explain.html). Это полезно для отслеживания неоптимизированных запросов. Логирование выполняется в общий лог {{ PG }}.

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
