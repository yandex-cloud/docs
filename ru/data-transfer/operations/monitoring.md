# Мониторинг состояния трансфера

Данные о состоянии трансфера доступны в консоли управления:

* Краткая информация представлена на временной шкале в разделе **{{ ui-key.yacloud.common.overview }}** для выбранного трансфера в сервисе [{{ data-transfer-name }}]({{ link-console-main }}/link/data-transfer/). В правой верхней части шкалы вы можете выбрать интервал для просмотра — час, день или неделю. Интервал разбит на сегменты. Наведите курсор на сегмент, чтобы узнать сколько байт и строк перенес трансфер за соответствующий период времени или просмотреть сообщения об ошибках.
* Подробная диагностическая информация представлена в виде графиков. Их можно посмотреть на вкладке **{{ ui-key.yacloud.common.monitoring }}** страницы управления трансфером или в [{{ metrics-name }}](../../monium/metrics/overview.md).

Вы можете [настроить алерты](#monitoring-integration) в сервисе {{ monium-full-name }} для получения уведомлений о сбоях в работе трансфера. В {{ monium-full-name }} используются два порога срабатывания алерта: `Warning` и `Alarm`. При превышении заданного порога вы получите оповещения через настроенные [каналы уведомлений](../../monium/concepts/alerting/notification-channel.md).

Отслеживать состояние трансферов и получать логи их работы можно и в [мобильном приложении](/mobile-app) {{ yandex-cloud }}.


## Ошибки, отображаемые на временной шкале трансфера {#errors-timeline}

Некоторые ошибки, информацию о которых можно увидеть на временной шкале для выбранного трансфера:

  * Трансфер записывает не все прочитанные данные. Количество событий, записанных в приемник, меньше, чем количество прочитанных из источника. Это может говорить о недостаточной пропускной способности приемника.
  * Время переноса данных выросло или слишком велико. Если трансфер обрабатывает данные слишком долго, возможно, дело в росте потока данных из источника или в низкой пропускной способности приемника.
  * Лаг репликации растет. Рост лага может быть вызван ростом количества событий из источника, проблемами в приемнике данных, нехваткой ресурсов или ошибками при работе.
  * Репликация часто перезапускается. Частые перезапуски репликации могут указывать на неполадки с источником или приемником данных, а также на нехватку памяти.

[Подробнее об ошибках, которые отображаются на временной шкале](../troubleshooting/index.md#timeline).

### AI-расшифровка ошибок {#ai-error-explanation}

Для упрощения диагностики проблем в {{ data-transfer-name }} доступна функция **{{ ui-key.yacloud.data-transfer.EntityAdviserSection.label_analyze-with-ai_ektYP }}**. Она помогает быстро понять причину возникшей ошибки и получить рекомендации по ее устранению.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
  1. Нажмите на имя нужного трансфера и выберите вкладку **{{ ui-key.yacloud.common.overview }}**.
  1. Под временной шкалой трансфера наведите курсор на сегмент с кратким описанием ошибки.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-transfer.EntityAdviserSection.label_analyze-with-ai_ektYP }}**.

{% endlist %}

Система проанализирует ошибку и предоставит понятное объяснение с возможными причинами и рекомендациями по устранению. AI-расшифровка особенно полезна при первичной диагностике проблем, когда нужно быстро определить направление для дальнейшего исследования.

## Мониторинг состояния трансфера {#monitoring}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}).
  1. [Перейдите]({{ link-console-main }}/link/data-transfer) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
  1. Нажмите на имя нужного трансфера и выберите вкладку **{{ ui-key.yacloud.data-transfer.label_monitoring }}**.
  1. Чтобы начать работу с метриками, дашбордами или алертами в сервисе {{ monium-full-name }}, нажмите кнопку **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}** на панели сверху.

{% endlist %}

На странице появятся графики:

### Maximum data transfer delay {#sinker.pusher.time.row_max_lag_sec}
`sinker.pusher.time.row_max_lag_sec`

Максимальное отставание данных (в секундах).

### Reads {#publisher.data.bytes}
`publisher.data.bytes`

Объем считанных из источника данных (в байтах).

### Number of source events {#publisher.data.changeitems}
`publisher.data.changeitems`

Число событий на источнике, сгенерированных для переноса (события помимо переносимых данных могут содержать технические операции).

### Number of target events {#sinker.pusher.data.changeitems}
`sinker.pusher.data.changeitems`

Число событий, записанных в приемник (события помимо переносимых данных могут содержать технические операции).

### Data transfer delay {#sinker.pusher.time.row_lag_sec}
`sinker.pusher.time.row_lag_sec`

Разница между временем появления записей на приемнике и временем их появления на источнике (в секундах). Гистограмма разбита на диапазоны (`bin`). Допустим, в выбранный момент времени на гистограмме представлены два диапазона `bin` 45 и 60, со значением 50% каждый. Это означает, что половина переносимых в этот момент записей имела задержку передачи от 30 до 45 секунд, а половина — от 45 до 60 секунд.

### Rows written to target, by table {#sinker.table.rows}
`sinker.table.rows`

50 таблиц с максимальным количеством записанных в приемник строк.

### Source buffer size {#publisher.consumer.log_usage_bytes}
`publisher.consumer.log_usage_bytes`

Объем буфера или журнала опережающей записи (там, где он поддерживается) в источнике (в байтах).

### Target response time {#sinker.pusher.time.batch_push_distribution_sec}
`sinker.pusher.time.batch_push_distribution_sec`

Полное время записи в приемник батча данных с учетом предварительной обработки (в секундах).

### Rows awaiting transfer, by table {#task.snapshot.remainder.table}
`task.snapshot.remainder.table`

Количество строк, ожидающих переноса.

### Operation status {#task.status}
`task.status`

Тип выполняющейся операции: `1` — задача активна.


## Настройка алертов в {{ monium-full-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Откройте главную страницу [{{ monium-name }}]({{ link-monium }}).
  1. Вверху выберите проект каталога с нужным трансфером.
  1. На панели слева выберите ![image](../../_assets/console-icons/layout-cells-large.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** и перейдите на вкладку **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**.
  1. Откройте дашборд **{{ ui-key.yacloud.iam.folder.dashboard.value_data-transfer }}** и в его параметрах выберите нужный трансфер.
  1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики. Подробнее о языке запросов в [документации {{ monium-full-name }}](../../monium/concepts/querying.md).
  1. Укажите **{{ ui-key.yacloud_monitoring.alert.title_name }}** алерта.
  1. Выберите функцию сравнения, функцию агрегации и окно вычисления. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}` и `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` для срабатывания алерта.
  1. Добавьте [канал уведомлений](../../monium/concepts/alerting/notification-channel.md). Если канала нет, [создайте его](../../monium/operations/alert/create-channel.md).
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

  Подробнее о создании алерта в [документации {{ monium-full-name }}](../../monium/operations/alert/create-alert.md).

{% endlist %}

## Рекомендованные алерты

В примерах ниже используются запросы с сервисного дашборда {{ data-transfer-name }}. При создании алерта на основе такого запроса используется `service=data-transfer`. Проверьте, что метка `resource_id` содержит идентификатор нужного трансфера.

Если вы создаете запрос с нуля в {{ monium-name }}, укажите `project=folder__<идентификатор_каталога>`, `cluster=default` и `service=__data-transfer__`.

### Число событий источника {#source-change-items}

Срабатывание алерта означает, что на протяжении окна вычисления база-источник не генерировала реплицируемых {{ data-transfer-name }} событий (отдельных элементов данных).

Возможные причины срабатывания:

* База-источник недоступна по сети для {{ data-transfer-name }}. Например, из-за отзыва доступов или из-за отказа базы-источника.
* На базе-источнике отсутствуют данные для репликации.

Параметры алерта:

* Метрики:

    ![image](../../_assets/console-icons/chart-line.svg) `service=data-transfer` `resource_id=<идентификатор_трансфера>` `name = publisher.data.changeitems`

    ![image](../../_assets/console-icons/function.svg) `derivative()` (в разделе **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformation.transformers.array_item_label }}**)

* Настройки алерта:

    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`.
    * **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}** — `0`.
    * **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}** — `-`.

      Можно дополнительно задать условие срабатывания `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` для ситуаций, когда число реплицируемых операций ниже ожидаемого значения.

    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-period }}** — `5 минут`. Если в базе-источнике изменения происходят реже одного раза в 5 минут, увеличьте окно вычисления до максимально допустимого интервала между двумя DML-операциями с данными в источнике.
    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.max }}`.

### Число событий приемника {#target-change-items}

Срабатывание алерта означает, что на протяжении окна вычисления в базу-приемник не записывались реплицируемые события {{ data-transfer-name }}.

Возможные причины срабатывания:

* База-источник или база-приемник недоступны по сети для {{ data-transfer-name }}. Например, из-за отзыва доступов или из-за отказа базы-источника или базы-приемника.
* На базе-источнике отсутствуют данные для репликации.
* Данные из базы-источника не могут быть реплицированы в базу-приемник. Например, из-за ограничений целевого типа данных в базе-приемнике.

Параметры алерта:

* Метрики:

    ![image](../../_assets/console-icons/chart-line.svg) `service=data-transfer` `resource_id=<идентификатор_трансфера>` `name = sinker.pusher.data.changeitems`
    ![image](../../_assets/console-icons/function.svg) `derivative()` (в разделе **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformation.transformers.array_item_label }}**)

* Настройки алерта:

    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`.
    * **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}** — `0`.
    * **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}** — `-`.

      Можно дополнительно задать условие срабатывания `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` для ситуаций, когда число реплицируемых операций ниже ожидаемого значения.

    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-period }}** — `5 минут`. Если в базе-источнике изменения происходят реже одного раза в 5 минут, увеличьте окно вычисления до максимально допустимого интервала между двумя DML-операциями с данными в источнике.
    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.max }}`.

### Максимальная задержка передачи данных {#row-max-lag}

Срабатывание алерта означает, что на протяжении окна вычисления разница во времени между моментом исполнения операции со строками в источнике и в приемнике превысила заданный порог.

Возможные причины срабатывания:

* База-приемник недоступна по сети для {{ data-transfer-name }}. Например, из-за отзыва доступов или из-за отказа базы-приемника.
* Нехватка ресурсов для репликации. Например, нагрузка на базу-источник превышает возможности [виртуальной машины](../../glossary/vm.md), на которой запущена репликация {{ data-transfer-name }}.
* Данные из базы-источника не могут быть реплицированы в базу-приемник. Например, из-за ограничений целевого типа данных в базе-приемнике.

Параметры алерта:

* Метрики:

    ![image](../../_assets/console-icons/chart-line.svg) `service=data-transfer` `resource_id=<идентификатор_трансфера>` `name = sinker.pusher.time.row_max_lag_sec`

* Настройки алерта:

    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-gte }}`.
    *  **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}** — `15`. Если база-приемник медленная, или реплицируются сразу большие блоки данных, задайте максимально возможное значение.
    * **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}** — `-`.
    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-period }}** — `1 минута`.
    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}`.

### Чтение {#reading}

Срабатывание алерта означает, что на протяжении окна вычисления из источника не было прочитано ни одного байта данных.

Возможные причины срабатывания:

* База-источник недоступна по сети для {{ data-transfer-name }}. Например, из-за отзыва доступов или из-за отказа базы-источника.
* На базе-источнике отсутствуют данные для репликации.

Параметры алерта:

* Метрики:

    ![image](../../_assets/console-icons/chart-line.svg) `service=data-transfer` `resource_id=<идентификатор_трансфера>` `name = publisher.data.bytes`
    ![image](../../_assets/console-icons/function.svg) `derivative()` (в разделе **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformation.transformers.array_item_label }}**)

* Настройки алерта:

    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-eq }}`.
    * **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}** — `0`.
    * **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}** — `-`.
    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-period }}** — `15 минут`. Если в базе-источнике изменения происходят реже одного раза в 15 минут, увеличьте окно вычисления до максимально допустимого интервала между двумя DML-операциями с данными в источнике.
    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.max }}`.

## Особенности работы с алертами {#alert-specifics}

* Чтобы определить причины сбоя трансфера, проверьте все имеющиеся алерты. Информация о том, какие алерты сработали, а какие — нет, позволит определить причину более точно. Например, если алерт [Число событий источника](#source-change-items) сработал, а алерт [Число событий приемника](#target-change-items) не сработал, вероятнее всего проблема не на источнике.
