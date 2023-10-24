# Диагностика производительности в {{ mpg-name }}

{{ mpg-name }} предоставляет встроенный инструмент для диагностики производительности кластера СУБД. Этот инструмент помогает анализировать метрики производительности {{ PG }} для [сессий](#get-sessions) и [запросов](#get-queries).

## Активировать сбор статистики {#activate-stats-collector}

{% list tabs %}

* Консоль управления

    Включите опцию **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** при [создании кластера](cluster-create.md) или [изменении его настроек](update.md#change-additional-settings) (по умолчанию опция отключена).

* CLI

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

* {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

    1. {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

* API

    Чтобы включить сбор статистики, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) или [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) или [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

        Идентификатор можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    * Значение `true` в параметре `config.performanceDiagnostics.enabled`.
    * Интервал сбора сессий в параметре `config.performanceDiagnostics.sessionsSamplingInterval`. Допустимые значения — от `1` до `86400` секунд.
    * Интервал сбора запросов в параметре `config.performanceDiagnostics.statementsSamplingInterval`. Допустимые значения — от `60` до `86400` секунд.
    * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

    {% note warning %}

    Этот метод API сбросит все настройки кластера, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, обязательно передайте название полей, подлежащих изменению, в параметре `updateMask`.

    {% endnote %}

{% endlist %}

## Получить статистику по сессиям {#get-sessions}

{% list tabs %}

* Консоль управления

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

* API

    Чтобы получить статистику по сессиям, воспользуйтесь вызовом gRPC API [PerformanceDiagnosticsService/ListRawSessionStates](../api-ref/grpc/perf_diag_service#ListRawSessionStates) и передайте в запросе:

    * Идентификатор кластера в параметре `cluster_id`.

        Идентификатор можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    * Период, за который надо запросить данные:

        * начало периода в параметре `from_time`;
        * конец периода в параметре `to_time`.

    * Параметры [пагинации](../../api-design-guide/concepts/pagination.md):

        * максимально допустимое количество результатов на одной странице в параметре `page_size`;
        * токен предыдущей страницы с результатами для получения следующей страницы в параметре `page_token`.

{% endlist %}

Подробнее про отображаемые сведения см. [в документации {{ PG }}](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

## Получить статистику по запросам {#get-queries}

{% list tabs %}

* Консоль управления

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

* API

    Чтобы получить статистику по запросам, воспользуйтесь вызовом gRPC API [PerformanceDiagnosticsService/ListRawStatements](../api-ref/grpc/perf_diag_service#ListRawStatements) и передайте в запросе:

    * Идентификатор кластера в параметре `cluster_id`.

        Идентификатор можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    * Период, за который надо запросить данные:

        * начало периода в параметре `from_time`;
        * конец периода в параметре `to_time`.

    * Параметры [пагинации](../../api-design-guide/concepts/pagination.md):

        * максимально допустимое количество результатов на одной странице в параметре `page_size`;
        * токен предыдущей страницы с результатами для получения следующей страницы в параметре `page_token`.

{% endlist %}

Подробнее про отображаемые сведения см. в документации расширений [pg_stat_statements](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.38.6) и [pg_stat_kcache](https://pgstats.dev/pg_stat_kcache).

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
