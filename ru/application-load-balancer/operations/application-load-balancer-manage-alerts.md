# Настроить алерты

[Алертинг](../../monitoring/concepts/alerting/alert.md) позволяет следить за изменениями в метриках и отправлять уведомления, когда показатели достигают критических значений. Изменения в метриках отслеживаются с помощью периодически отправляемых запросов — _алертов_. Когда они достигают пороговых значений, система отправляет уведомление через указанный канал связи. Например, по электронной почте или в мессенджер.

Чтобы настроить алертинг:

1. [Создайте канал уведомлений](../../monitoring/operations/alert/create-channel.md).
1. Выберите [метрики и метки](../../monitoring/metrics-ref/smartwebsecurity-ref.md) для контроля.
1. [Создайте алерт](../../monitoring/operations/alert/create-alert.md).

Рассмотрим пример создания алерта о недоступности сервиса.

Алерт будет срабатывать, когда количество неуспешных запросов составляет 50% и более от общего количества запросов. Такой алерт поможет выявить [DDoS-атаки](../../glossary/ddos.md) или сбои в работе инфраструктуры.

Обозначим буквами количество входящих запросов в секунду:

* `A` — общее количество запросов.
* `B` — количество неуспешных запросов.

Настроим алерты:

* `B` составляет 30% от `A` — предупреждение (`Warning`);
* `B` составляет 50% от `A` — критический уровень (`Alarm`).

### Создание канала уведомления {#create-channel}

1. В [консоли управления]({{ link-console-main }}) слева выберите каталог.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. Выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.channels.title }}**.
1. Нажмите **{{ ui-key.yacloud_monitoring.channel.button_new-channel }}**.
1. Укажите имя канала, метод отправки и получателей.

    {% note info %}

    {% include [notifications-requirements](../../_includes/monitoring/notifications-requirements.md) %}

    {% endnote %}

1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

### Выбор метрик для контроля {#select-metrics}

* Величину `A` будем получать с помощью метрики `load_balancer.requests_count_per_second`.
* Величину `B` будем получать с помощью метрики `load_balancer.requests_count_per_second`, отфильтровав по метке `code` = `503`.
* Долю `B` от `A` будем вычислять как `100 * B / A` и сохранять в значении `C`.

### Создание алерта {#create-alert}

1. На странице сервиса **{{ monitoring-short-name }}** нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
1. Введите название алерта, например, `unavailable_service`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** опишите запрос для получения `A`:
   1. Напротив значка ![image](../../_assets/monitoring/chart.svg) добавьте параметры:
      * `service` = `Application Load Balancer`;
      * `name` = `load_balancer.requests_count_per_second`;
      * `load_balancer` = `<имя_балансировщика_нагрузки>`.
   1. Напротив значка ![image](../../_assets/monitoring/function.svg) задайте функцию для обработки данных `replace_nan(0)` — замена пропусков данных на значение `0`, чтобы график был непрерывным.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.

1. Опишите запрос для получения `B`:
   1. Укажите данные для сбора:
      * `service` = `Application Load Balancer`;
      * `name` = `load_balancer.requests_count_per_second`;
      * `code` = `503`;
      * `load_balancer` = `<имя_балансировщика_нагрузки>`.
   1. Задайте функцию `replace_nan(0)`.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
   
1. Опишите запрос `C` для получения доли `B` от `A` в процентах:
   1. Нажмите ![image](../../_assets/monitoring/raw.svg), чтобы переключиться в текстовый режим редактирования запроса.
   1. В строке запроса введите `100 * B / A`.

1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_conditions }}** укажите:
     * `Запрос для проверки` — `C`.
     * `Функция агрегации` — `Все значения`.
     * `Warning` — `30` (предупреждение).
     * `Alarm` — `50` (критический уровень).
     * `Окно вычисления` — `30 секунд`.
     * `Задержка вычисления` — `15 секунд`.

1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}** оставьте значения по умолчанию.
1. (опционально) В блоке [**{{ ui-key.yacloud_monitoring.monitoring-alerts.title.annotations }}**](../../monitoring/concepts/alerting/annotation.md) добавьте информацию, которую следует записывать при срабатывании алерта.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте канал для отправки уведомления.
1. Нажмите **{{ ui-key.yacloud.common.create }}**.