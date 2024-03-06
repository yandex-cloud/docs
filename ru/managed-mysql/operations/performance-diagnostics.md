# Диагностика производительности в {{ mmy-name }}

В {{ mmy-name }} встроен инструмент для сбора статистики по сессиям и запросам. Эти метрики могут быть полезны при [анализе производительности и оптимизации настроек](../tutorials/profiling-mmy.md) кластера.

## Активировать сбор статистики {#activate-stats-collector}

{% list tabs group=instructions %}

* Консоль управления {#console}

    При [создании кластера](cluster-create.md) или [изменении его настроек](update.md#change-additional-settings):

    1. Включите опцию **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** (по умолчанию отключена).
    1. Настройте **{{ ui-key.yacloud.mdb.forms.field_diagnostics-sessions-interval }}** и **{{ ui-key.yacloud.mdb.forms.field_diagnostics-statements-interval }}**. Диапазон значений — от `1` до `86400` секунд.

* CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы включить и настроить сбор статистики, передайте параметр `--performance-diagnostics` в команде изменения кластера:

    ```bash
    {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
       ...
       --performance-diagnostics enabled=true,`
                                `sessions-sampling-interval=<интервал_сбора_сессий>,`
                                `statements-sampling-interval=<интервал_сбора_запросов> \
        ...
    ```

    Допустимые значения параметров `sessions-sampling-interval` и `statements-sampling-interval` — от `1` до `86400` секунд.

* {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

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

        Допустимые значения параметров `sessions_sampling_interval` и `statements_sampling_interval` — от `1` до `86400` секунд.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

* API {#api}

    Чтобы включить сбор статистики, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) или [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) или [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Идентификатор можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
    * Значение `true` в параметре `configSpec.performanceDiagnostics.enabled`.
    * Интервал сбора сессий в параметре `configSpec.performanceDiagnostics.sessionsSamplingInterval`. Допустимые значения — от `1` до `86400` секунд.
    * Интервал сбора запросов в параметре `configSpec.performanceDiagnostics.statementsSamplingInterval`. Допустимые значения — от `1` до `86400` секунд.
    * Список полей, подлежащих изменению, в параметре `updateMask`.

    {% note warning %}

    Этот метод API сбросит все настройки кластера, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, обязательно передайте название полей, подлежащих изменению, в параметре `updateMask`.

    {% endnote %}

{% endlist %}

## Получить статистику по сессиям {#get-sessions}

1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_sessions }}**.

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

1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_diagnostics }}** → **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_queries }}**.

    Для просмотра статистики по запросам или сравнения их статистических данных на двух временных интервалах выберите соответствующую вкладку.

    {% list tabs %}

    * Интервал

        Для просмотра статистики запросов:

        1. Выберите интересующий временной интервал.
        1. (Опционально) Настройте фильтры.

    * 2 интервала

        Чтобы получить сведения об относительном изменении статистических характеристик запросов:

        1. В поле **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-first }}** выберите временной интервал, статистика за который будет основой для расчетов.
        1. В поле **{{ ui-key.yacloud.mdb.cluster.diagnostics.label_interval-second }}** выберите временной интервал, статистика за который будет сравниваться со статистикой первого интервала.
        1. (Опционально) Настройте фильтры.

        Например, пусть в первом интервале было выполнено 10 запросов `SELECT * FROM cities`, а во втором — 20. Тогда при сравнении статистических данных разница по метрике <q>количество запросов</q> (столбец `Calls` в таблице) будет равняться `+100%`.

    {% endlist %}

Подробнее про отображаемые сведения см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/performance-schema-quick-start.html).
