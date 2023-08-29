# Мониторинг состояния трансфера

Данные о состоянии трансфера доступны в консоли управления. Их можно посмотреть на вкладке **{{ ui-key.yacloud.data-transfer.label_monitoring }}** страницы управления трансфером или в сервисе [{{ monitoring-full-name }}](../../monitoring/concepts/index.md).

Диагностическая информация о состоянии трансфера представлена в виде графиков.


Вы можете [настроить алерты](#monitoring-integration) в сервисе {{ monitoring-full-name }} для получения уведомлений о сбоях в работе трансфера. В {{ monitoring-full-name }} используются два порога срабатывания алерта: `Warning` и `Alarm`. При превышении заданного порога вы получите оповещения через настроенные [каналы уведомлений](../../monitoring/concepts/alerting.md#notification-channel).


Отслеживать состояние трансферов и получать логи их работы можно и в [мобильном приложении](/mobile-app) {{ yandex-cloud }}.



## Мониторинг состояния трансфера {#monitoring}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
  1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
  1. Нажмите на имя нужного трансфера и выберите вкладку ![image](../../_assets/monitoring.svg) **{{ ui-key.yacloud.data-transfer.label_monitoring }}**.
  1. Чтобы перейти к работе с метриками, дашбордами или алертами в сервисе {{ monitoring-full-name }}, нажмите кнопку **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}** на панели сверху.

{% endlist %}

На странице появятся графики:

### Number of source events {#publisher.data.changeitems}
`publisher.data.changeitems`

Число событий на источнике, сгенерированных для переноса (события помимо переносимых данных могут содержать технические операции).

### Number of target events {#sinker.pusher.data.changeitems}
`sinker.pusher.data.changeitems`

Число событий, записанных в приемник (события помимо переносимых данных могут содержать технические операции).

### Maximum data transfer delay {#sinker.pusher.time.row_max_lag_sec}
`sinker.pusher.time.row_max_lag_sec`

Максимальное отставание данных (в секундах).

### Reads {#publisher.data.bytes}
`publisher.data.bytes`

Объем считанных из источника данных (в байтах).

### Data transfer delay {#sinker.pusher.time.row_lag_sec}
`sinker.pusher.time.row_lag_sec`

Разница между временем появления записей на приемнике и временем их появлением на источнике (в секундах). Гистограмма разбита на диапазоны (`bin`). Допустим, в выбранный момент времени на гистограмме представлены два диапазона `bin` 45 и 60, со значением 50% каждый. Это означает, что половина переносимых в этот момент записей имела задержку передачи от 30 до 45 секунд, а половина — от 45 до 60 секунд.

### Source buffer size {#publisher.consumer.log_usage_bytes}
`publisher.consumer.log_usage_bytes`

Объем буфера или журнала опережающей записи (там, где он поддерживается) в источнике (в байтах).

### Rows written to target, by table {#sinker.table.rows}
`sinker.table.rows`

50 таблиц с максимальным количеством записанных в приемник строк.

### Target response time {#sinker.pusher.time.batch_push_distribution_sec}
`sinker.pusher.time.batch_push_distribution_sec`

Полное время записи в приемник батча данных с учетом предварительной обработки (в секундах).

### Rows awaiting transfer, by table {#task.snapshot.remainder.table}
`task.snapshot.remainder.table`

Количество строк, ожидающих переноса.

### Operation status {#task.status}
`task.status`

Тип выполняющейся операции: `1` — задача активна.


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с трансфером, для которого нужно настроить алерты.
  1. В списке сервисов выберите ![image](../../_assets/monitoring.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_data-transfer }}**.
  1. На нужном графике нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов см. в [документации {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` и `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` для срабатывания алерта.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

## Рекомендованные алерты

### Число событий источника {#source-change-items}

Срабатывание алерта означает, что на протяжении окна вычисления база-источник не генерировала реплицируемых {{ data-transfer-name }} событий (отдельных элементов данных).

Возможные причины срабатывания:

* База-источник недоступна по сети для {{ data-transfer-name }}. Например, из-за отзыва доступов или из-за отказа базы-источника.
* На базе-источнике отсутствуют данные для репликации.

Параметры алерта:

* Метрики:

    ![image](../../_assets/monitoring/chart-lines2.svg) `<имя облака> > <имя каталога>` `service = data-transfer` `name = publisher.data.changeitems`

    ![image](../../_assets/monitoring/function.svg) `derivative()` (в разделе **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformation.transformers.array_item_label }}**)

* Настройки алерта:

    * {{ ui-key.yacloud_monitoring.alert.label_trigger-condition }} — `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`.
    * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }} — `0`.
    * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }} — `-`.

    Можно дополнительно задать условие срабатывания `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` для ситуаций, когда число реплицируемых операций ниже ожидаемого значения.

    Дополнительные настройки:

    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.max }}`.
    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-period }}** — `5 минут`. Если в базе-источнике изменения происходят реже одного раза в 5 минут, увеличьте окно вычисления до максимально допустимого интервала между двумя DML-операциями с данными в источнике.

### Число событий приемника {#target-change-items}

Срабатывание алерта означает, что на протяжении окна вычисления в базу-приемник не записывались реплицируемые события {{ data-transfer-name }}.

Возможные причины срабатывания:

* База-источник или база-приемник недоступны по сети для {{ data-transfer-name }}. Например, из-за отзыва доступов или из-за отказа базы-источника или базы-приемника.
* На базе-источнике отсутствуют данные для репликации.
* Данные из базы-источника не могут быть реплицированы в базу-приемник. Например, из-за ограничений целевого типа данных в базе-приемнике.

Параметры алерта:

* Метрики:

    ![image](../../_assets/monitoring/chart-lines2.svg) `<имя облака> > <имя каталога>` `service = data-transfer` `name = sinker.pusher.data.changeitems`
    ![image](../../_assets/monitoring/function.svg) `derivative()` (в разделе **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformation.transformers.array_item_label }}**)

* Настройки алерта:

    * {{ ui-key.yacloud_monitoring.alert.label_trigger-condition }} — `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`.
    * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }} — `0`.
    * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }} — `-`.

    Можно дополнительно задать условие срабатывания `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` для ситуаций, когда число реплицируемых операций ниже ожидаемого значения.

    Дополнительные настройки:

    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.max }}`.
    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-period }}** — `5 минут`. Если в базе-источнике изменения происходят реже одного раза в 5 минут, увеличьте окно вычисления до максимально допустимого интервала между двумя DML-операциями с данными в источнике.

### Максимальная задержка передачи данных {#row-max-lag}

Срабатывание алерта означает, что на протяжении окна вычисления разница во времени между моментом исполнения операции со строками в источнике и в приемнике превысила заданный порог.

Возможные причины срабатывания:

* База-приемник недоступна по сети для {{ data-transfer-name }}. Например, из-за отзыва доступов или из-за отказа базы-приемника.
* Нехватка ресурсов для репликации. Например, нагрузка на базу-источник превышает возможности [виртуальной машины](../../glossary/vm.md), на которой запущена репликация {{ data-transfer-name }}.
* Данные из базы-источника не могут быть реплицированы в базу-приемник. Например, из-за ограничений целевого типа данных в базе-приемнике.

Параметры алерта:

* Метрики:

    ![image](../../_assets/monitoring/chart-lines2.svg) `<имя облака> > <имя каталога>` `service = data-transfer` `name = sinker.pusher.time.row_max_lag_sec`

* Настройки алерта:

    * {{ ui-key.yacloud_monitoring.alert.label_trigger-condition }} — `{{ ui-key.yacloud_monitoring.alert.title_comparison-gte }}`.
    *  {{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }} — `15`. Если база-приемник медленная, или реплицируются сразу большие блоки данных, задайте максимально возможное значение.
    * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }} — `-`.

    Дополнительные настройки:

    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}`.
    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-period }}** — `1 минута`.

### Чтение {#reading}

Срабатывание алерта означает, что на протяжении окна вычисления из источника не было прочитано ни одного байта данных.

Возможные причины срабатывания:

* База-источник недоступна по сети для {{ data-transfer-name }}. Например, из-за отзыва доступов или из-за отказа базы-источника.
* На базе-источнике отсутствуют данные для репликации.

Параметры алерта:

* Метрики:

    ![image](../../_assets/monitoring/chart-lines2.svg) `<имя облака> > <имя каталога>` `service = data-transfer` `name = publisher.data.bytes`
    ![image](../../_assets/monitoring/function.svg) `derivative()` (в разделе **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformation.transformers.array_item_label }}**)

* Настройки алерта:

    * {{ ui-key.yacloud_monitoring.alert.label_trigger-condition }} — `{{ ui-key.yacloud_monitoring.alert.title_comparison-eq }}`.
    * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }} — `0`.
    * {{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }} — `-`.

    Дополнительные настройки:

    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.max }}`.
    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-period }}** — `15 минут`. Если в базе-источнике изменения происходят реже одного раза в 15 минут, увеличьте окно вычисления до максимально допустимого интервала между двумя DML-операциями с данными в источнике.

## Особенности работы с алертами {#alert-specifics}

* Чтобы определить причины сбоя трансфера, проверьте все имеющиеся алерты. Информация о том, какие алерты сработали, а какие — нет, позволит определить причину более точно. Например, если алерт [{#T}](#source-change-items) сработал, а алерт [{#T}](#target-change-items) не сработал, вероятнее всего проблема не на источнике.
