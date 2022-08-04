# Диагностика производительности

{{ mpg-name }} предоставляет встроенный инструмент для диагностики производительности кластера СУБД. Этот инструмент помогает анализировать метрики производительности {{ PG }} для [сессий](#get-sessions) и [запросов](#get-queries).

## Активировать сбор статистики {#activate-stats-collector}

{% list tabs %}

* Консоль управления

    Включите опцию **Сбор статистики** при [создании кластера](cluster-create.md) или [изменении его настроек](update.md#change-additional-settings) (по умолчанию опция отключена).

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы включить сбор статистики, передайте параметр `--performance-diagnostics` в команде изменения кластера:

    ```bash
    {{ yc-mdb-pg }} cluster update <идентификатор или имя кластера> \
        ...
        --performance-diagnostics enabled=true,`
                                 `sessions-sampling-interval=<интервал сбора сессий>,`
                                 `statements-sampling-interval=<интервал сбора запросов> \
        ...
    ```

    Допустимые значения параметров:

    - `sessions-sampling-interval` — от `1` до `86400` секунд.
    - `statements-sampling-interval` — от `60` до `86400` секунд.

* Terraform

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

    Воспользуйтесь методом API [create](../api-ref/Cluster/create.md) или [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.
    * Значение `true` в параметре `config.performanceDiagnostics.enabled`.
    * Интервал сбора сессий в параметре `config.performanceDiagnostics.sessionsSamplingInterval`. Допустимые значения — от `1` до `86400` секунд.
    * Интервал сбора запросов в параметре `config.performanceDiagnostics.statementsSamplingInterval`. Допустимые значения — от `60` до `86400` секунд.
    * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    {% note warning %}

    Этот метод API сбросит все настройки кластера, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, обязательно передайте название полей, подлежащих изменению, в параметре `updateMask`.

    {% endnote %}

{% endlist %}

## Получить статистику по сессиям {#get-sessions}

1. В консоли управления перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **Диагностика производительности** → **Сессии**.

    Для просмотра статистики по сессиям или истории запросов в рамках сессии выберите соответствующую вкладку.

    {% list tabs %}

    * Статистика

        Для просмотра статистики по сессиям:

        1. Задайте интересующий временной интервал.
        1. (Опционально) Настройте фильтры.
        1. Выберите нужный срез данных.

        Чтобы показать или скрыть отдельные категории, нажмите на имя категории в легенде графика.

    * История

        Для просмотра истории запросов в рамках сессии:

        1. Задайте интересующий временной интервал.
        1. (Опционально) Настройте фильтры.

    {% endlist %}

Подробнее про отображаемые сведения см. [в документации {{ PG }}](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-ACTIVITY-VIEW).

## Получить статистику по запросам {#get-queries}

1. В консоли управления перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
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

Подробнее про отображаемые сведения см. [в документации {{ PG }}](https://www.postgresql.org/docs/current/pgstatstatements.html#id-1.11.7.38.6).

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
