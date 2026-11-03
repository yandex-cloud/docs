# Настроить алерты

Чтобы получать уведомления о росте числа ошибок при обращении к приложению, настройте [алерт](../../monium/concepts/alerting/alert.md) в {{ monium-name }}. Алерт проверяет значения метрик и меняет статус при достижении заданных порогов. Уведомления о смене статуса можно получать по электронной почте или в мессенджере.

Чтобы настроить алертинг:

1. [Создайте канал уведомлений](#create-channel).
1. [Выберите метрики](#select-metrics) для контроля.
1. [Создайте алерт](#create-alert).

В примере алерт отслеживает долю ответов HTTP `503 Service Unavailable` от общего количества запросов.

Рост числа ответов `503` может сопровождать сбои в инфраструктуре или [DDoS-атаки](../../glossary/ddos.md). Чтобы определить причину, изучите [логи балансировщика](application-load-balancer-get-logs.md) и бэкендов.

Для расчета используются запросы:

* `A` — общее количество запросов в секунду.
* `B` — количество ответов с кодом `503` в секунду.
* `C` — доля таких ответов в процентах: `100 * B / A`.

Для одного алерта задаются два порога:

* `Warning` — доля ответов `503` составляет не менее 30%.
* `Alarm` — доля ответов `503` составляет не менее 50%.

Алерт меняет статус, если доля ошибок остается не ниже соответствующего порога в течение всего окна вычисления — 30 секунд. Подберите пороги и длительность окна с учетом требований к вашему приложению.

Для выполнения инструкции нужны роли на каталог с балансировщиком:

* [monium.metrics.reader](../../monium/security/index.md#monium-metrics-reader) — для чтения метрик.
* [monium.alerts.editor](../../monium/security/index.md#monium-alerts-editor) — для создания алерта.
* [monium.channels.editor](../../monium/security/index.md#monium-channels-editor) — для создания канала уведомлений.

## Создание канала уведомления {#create-channel}

1. [Перейдите]({{ link-monium }}) в **{{ ui-key.yacloud.iam.folder.dashboard.label_monium }}**.
1. На панели сверху выберите проект каталога с балансировщиком: `folder__<идентификатор_каталога>`. В этом проекте будут созданы канал уведомлений и алерт.
1. Слева выберите ![alt](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![alt](../../_assets/console-icons/bell.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.notification-methods.title }}**.
1. Нажмите **Создать** → **Канал уведомления**.
1. Укажите параметры канала:

    * **{{ ui-key.yacloud_monitoring.channel.field_name }}** — произвольное имя канала.
    * **{{ ui-key.yacloud_monitoring.channel.field_method }}** — метод отправки уведомлений.
    * **{{ ui-key.yacloud_monitoring.channel.field_recipients }}** — получатели уведомлений.

    {% note info %}

    {% include [notifications-requirements](../../_includes/monium/notifications-requirements.md) %}

    {% endnote %}

1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

## Выбор метрик для контроля {#select-metrics}

Используйте метрику [load_balancer.requests_count_per_second](../metrics.md#http-metrics): для запроса `A` задайте `code = total`, для `B` — `code = 503`. В обоих запросах укажите один балансировщик и одинаковые значения остальных меток. Функция `series_sum()` суммирует выбранные временные ряды, чтобы получить по одному значению `A` и `B` для каждого момента времени.

## Создание алерта {#create-alert}

1. На главной странице **{{ monium-name }}** слева выберите ![alt](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![alt](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. Вверху справа нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **Пользовательский**.
1. Укажите название алерта, например, `unavailable_service`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** опишите запрос для получения `A`:

   1. В строке запроса укажите параметры:

      * `project` = `folder__<идентификатор_каталога>`;
      * `cluster` = `default`;
      * `service` = `__application-load-balancer__`;
      * `name` = `load_balancer.requests_count_per_second`;
      * `load_balancer` = `<идентификатор_балансировщика>`;
      * `code` = `total`.

      Для меток `http_router`, `virtual_host`, `route`, `backend_group`, `backend` и `zone` укажите `*`.

   1. Задайте функцию обработки данных `series_sum()`.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.

1. Опишите запрос для получения `B`:

   1. Укажите те же метки, что в запросе `A`, но замените значение метки `code` на `503`.
   1. Последовательно примените функции `series_sum()` и `replace_nan(0)`.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.

1. Опишите запрос `C` для получения доли `B` от `A` в процентах:

   1. Переключите строку запроса в текстовый режим ![code](../../_assets/console-icons/code.svg).
   1. В строке запроса введите `100 * B / A`.

1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_conditions }}** укажите:

     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.query-to-check }}** — `C`.
     * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — **{{ ui-key.yacloud_monitoring.alert.title_aggregation-at_all_times }}**.
     * **Функция сравнения** — **{{ ui-key.yacloud_monitoring.alert.title_comparison-gte }}**.
     * **{{ ui-key.yacloud_monitoring.alert.label_warning }}** — `30` (предупреждение).
     * **{{ ui-key.yacloud_monitoring.alert.label_alarm }}** — `50` (критический уровень).
     * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — `30 секунд`.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.evaluation-delay }}** — `15 секунд`.

1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}** выберите статус `No data` для отсутствия метрик и точек данных.

   Если запросов нет (`A = 0`), доля ошибок не определена. По этому алерту нельзя делать вывод о доступности приложения в такой период.

1. (Опционально) В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.annotations }}** добавьте [информацию](../../monium/concepts/alerting/annotation.md), которую следует записывать при срабатывании алерта.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте канал для отправки уведомления.
1. [Проверьте вычисление алерта](../../monium/operations/alert/create-alert.md) на периоде, в котором есть запросы к балансировщику. Убедитесь, что запрос `C` возвращает один временной ряд со значениями от 0 до 100.
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.
