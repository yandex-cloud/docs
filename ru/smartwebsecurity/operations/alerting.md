---
title: Как настроить уведомления для сервиса {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете настроить алерты {{ sws-full-name }}.
---

# Настроить алерты для сервиса

[Алерт](../../monium/concepts/alerting/alert.md) в {{ monium-name }} проверяет значения метрик и меняет статус при достижении заданных порогов. Уведомления о смене статуса можно получать по электронной почте или в мессенджере.

Для контроля скорости входящих запросов {{ sws-name }} доступны метрики в {{ metrics-name }}:

* `load_balancer.smart_web_security.requests_per_second` — количество запросов к защищаемому ресурсу в секунду. Это значение соответствует количеству запросов, обработанных профилем безопасности.
* `load_balancer.smart_web_security.arl_requests_per_second` — количество запросов к защищаемому ресурсу в секунду, которые обработаны модулем Advanced Rate Limiter.

С помощью меток можно отслеживать запросы к отдельному ресурсу или запросы с определенным результатом проверки, например заблокированные.

Чтобы настроить алертинг:

1. [Создайте канал уведомлений](../../monium/operations/alert/create-channel.md).
1. Выберите [метрики и метки](../metrics.md) для контроля.
1. [Создайте алерт](../../monium/operations/alert/create-alert.md).

Во всех запросах на получение метрик укажите общие метки:

* `project` — [проект каталога](*monium-folder-project) с балансировщиком или прокси-сервером.
* `cluster` = `default`.
* `service` = `__application-load-balancer__`.

В метке `load_balancer` укажите идентификатор балансировщика, а в метке `security_profile` — идентификатор профиля безопасности. Для прокси-сервера скопируйте идентификатор его балансировщика на странице прокси-сервера: вкладка **{{ ui-key.yacloud.common.overview }}**, блок **Балансировщик нагрузки**, поле **Идентификатор**.

В запросах `A` и `B` одного алерта используйте одинаковые значения меток ресурса. Если не нужно ограничивать запросы HTTP-роутером, виртуальным хостом или другими ресурсами, выберите для соответствующих меток `*`.

Примеры алертов для выявления аномалий:

* [Алерт об увеличении доли заблокированных запросов](#increased-deny-requests).
* [Алерт об ограничении запросов профилем ARL](#exceeding-speed-requests).

Пороги, окно и задержку вычисления из примеров подберите под нагрузку приложения и частоту поступления метрик.

Для выполнения инструкций нужны роли на каталог с балансировщиком или прокси-сервером:

* [monium.metrics.reader](../../monium/security/index.md#monium-metrics-reader) — для чтения метрик.
* [monium.alerts.editor](../../monium/security/index.md#monium-alerts-editor) — для создания алертов.
* [monium.channels.editor](../../monium/security/index.md#monium-channels-editor) — для создания канала уведомлений.

## Алерт об увеличении доли заблокированных запросов {#increased-deny-requests}

Алерт отслеживает долю запросов, заблокированных профилем безопасности. Ее рост может указывать на [DDoS-атаку](../../glossary/ddos.md), активность ботов или ложные срабатывания правил. Чтобы определить причину, изучите [логи профиля](configure-logging.md#view-logs).

Обозначим буквами количество входящих запросов в секунду:

* `A` — общее количество запросов.
* `B` — количество запросов, заблокированных профилем безопасности.

Для одного алерта задайте два порога:

* `B` составляет не менее 30% от `A` — предупреждение (`{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}`);
* `B` составляет не менее 50% от `A` — критический уровень (`{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}`).

### Создание канала уведомления {#create-channel}

{% include [alerting-create-channel](../../_includes/smartwebsecurity/alerting-create-channel.md) %}

### Выбор метрик для контроля {#select-metrics}

Для расчета доли заблокированных запросов используйте:

* `A` — метрика `load_balancer.smart_web_security.requests_per_second` со всеми значениями метки `antirobot_verdict`.
* `B` — та же метрика с фильтром `antirobot_verdict` = `deny`.
* `C` — доля заблокированных запросов в процентах: `100 * B / A`.

При `A = 0` доля не определена.

Функция [series_sum()](../../monium/concepts/querying-functions.md#series_sum) суммирует выбранные временные ряды, чтобы в каждый момент времени запросы `A` и `B` возвращали по одному значению.

### Создание алерта {#create-alert}

1. Откройте [{{ monium-name }}]({{ link-monium }}) и выберите проект, в котором создан канал уведомлений.
1. На панели слева выберите ![shield-exclamation](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![megaphone](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. Вверху справа нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **Пользовательский**.
1. Введите название алерта, например, `exceeding-blocked-requests`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** опишите запрос для получения `A`:

    1. В строке запроса укажите общие метки, перечисленные выше, и добавьте:

        * `name` = `load_balancer.smart_web_security.requests_per_second`;
        * `antirobot_verdict` = `*` — все результаты проверки;
        * `load_balancer` — идентификатор балансировщика;
        * `security_profile` — идентификатор профиля безопасности.
    1. Задайте функцию обработки данных `series_sum()`.
1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
1. Опишите запрос для получения `B`:

    1. Укажите те же метки, что в запросе `A`, но замените значение метки `antirobot_verdict` на `deny`.
    1. Последовательно примените функции `series_sum()` и `replace_nan(0)`.
1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
1. Опишите запрос `C` для получения доли `B` от `A` в процентах:

    1. Переключите строку запроса в текстовый режим ![code](../../_assets/console-icons/code.svg).
    1. В строке запроса введите `100 * B / A`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_conditions }}** укажите:

    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.query-to-check }}** — `C`.
    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert.title_aggregation-at_all_times }}`.
    * **Функция сравнения** — **{{ ui-key.yacloud_monitoring.alert.title_comparison-gte }}**.
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** — `30` (предупреждение).
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** — `50` (критический уровень).
    * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — `30 секунд`.
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.evaluation-delay }}** — `15 секунд`.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}** выберите статус `No data` для отсутствия метрик и точек данных.
1. (Опционально) В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.annotations }}** добавьте [информацию](../../monium/concepts/alerting/annotation.md), которую следует записывать при срабатывании алерта.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте канал для отправки уведомления.
1. [Проверьте вычисление алерта](../../monium/operations/alert/create-alert.md) на периоде, в котором есть запросы. Убедитесь, что запрос `C` возвращает один временной ряд.
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

## Алерт об ограничении запросов профилем ARL {#exceeding-speed-requests}

Обозначим буквами количество входящих запросов в секунду:

* `A` — разрешенных профилем безопасности.
* `B` — разрешенных профилем ARL.

Если `A` близко к `B`, профиль ARL пропускает большинство запросов, разрешенных профилем безопасности.

Если `A` значительно превышает `B`, часть запросов блокируется или направляется на дополнительную проверку профилем ARL. Проверьте характер трафика и настройки ARL: разница сама по себе не означает, что приложение не справляется с нагрузкой.

Для одного алерта задайте два порога:

* `A` превышает `B` не менее чем на 30% — предупреждение (`{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}`);
* `A` превышает `B` не менее чем на 50% — критический уровень (`{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}`).

### Создание канала уведомления {#create-channel2}

Используйте канал, созданный для первого алерта, или [создайте новый](#create-channel).

### Выбор метрик для контроля {#select-metrics2}

Для сравнения запросов, разрешенных профилями безопасности и ARL, используйте:

* `A` — метрика `load_balancer.smart_web_security.requests_per_second` с фильтром `antirobot_verdict` = `allow`.
* `B` — метрика `load_balancer.smart_web_security.arl_requests_per_second` с фильтром `arl_verdict` = `allow`.
* `C` — превышение `A` над `B` в процентах: `100 * (A - B) / B`.

Пример применим при `B > 0`. Если ARL не пропускает ни одного запроса, процент превышения не определен.

### Создание алерта {#create-alert2}

1. Откройте [{{ monium-name }}]({{ link-monium }}) и выберите проект, в котором создан канал уведомлений.
1. На панели слева выберите ![shield-exclamation](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![megaphone](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. Вверху справа нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **Пользовательский**.
1. Введите название алерта, например, `inbound-over-ARL`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** опишите запрос для получения `A`:

    1. В строке запроса укажите общие метки, перечисленные выше, и добавьте:

        * `name` = `load_balancer.smart_web_security.requests_per_second`;
        * `antirobot_verdict` = `allow`;
        * `load_balancer` — идентификатор балансировщика;
        * `security_profile` — идентификатор профиля безопасности.
    1. Задайте функцию обработки данных `series_sum()`.
1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
1. Опишите запрос для получения `B`:

    1. Укажите те же метки ресурса и общие метки, что в запросе `A`. Для метки `name` выберите `load_balancer.smart_web_security.arl_requests_per_second`, а вместо `antirobot_verdict` укажите `arl_verdict = allow`.
    1. Задайте функцию обработки данных `series_sum()`.
1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
1. Опишите запрос `C` для получения разницы между `A` и `B` в процентах:

    1. Переключите строку запроса в текстовый режим ![code](../../_assets/console-icons/code.svg).
    1. В строке запроса введите `100 * (A - B) / B`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_conditions }}** укажите:

     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.query-to-check }}** — `C`.
     * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert.title_aggregation-at_all_times }}`.
     * **Функция сравнения** — **{{ ui-key.yacloud_monitoring.alert.title_comparison-gte }}**.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** — `30` (предупреждение).
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** — `50` (критический уровень).
     * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — `30 секунд`.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.evaluation-delay }}** — `15 секунд`.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}** выберите статус `No data` для отсутствия метрик и точек данных.
1. (Опционально) В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.annotations }}** добавьте [информацию](../../monium/concepts/alerting/annotation.md), которую следует записывать при срабатывании алерта.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте канал для отправки уведомления.
1. [Проверьте вычисление алерта](../../monium/operations/alert/create-alert.md) на периоде, в котором есть запросы. Убедитесь, что запрос `C` возвращает один временной ряд.
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

#### Полезные ссылки {#see-also}

* [{#T}](../metrics.md)
* [{#T}](../../monium/concepts/visualization/query-string.md)

[*monium-folder-project]: {% include notitle [folder-project](../../_popups/monium/folder-project.md) %}
