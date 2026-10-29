---
title: Как настроить уведомления для сервиса {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете настроить алерты {{ sws-full-name }}.
---

# Настроить алерты для сервиса

[Алертинг](../../monium/concepts/alerting/alert.md) позволяет следить за изменениями в метриках и отправлять уведомления, когда показатели достигают критических значений. Изменения в метриках отслеживаются с помощью периодически отправляемых запросов — _алертов_. Когда они достигают пороговых значений, система отправляет уведомление через указанный канал связи. Например, по электронной почте или в мессенджер.

В сервисе {{ sws-name }} доступны метрики скорости входящих запросов:

* `load_balancer.smart_web_security.requests_per_second` — количество запросов к защищаемому ресурсу в секунду. Это значение соответствует количеству запросов, обработанных профилем безопасности.
* `load_balancer.smart_web_security.arl_requests_per_second` — количество запросов к защищаемому ресурсу в секунду, которые обработаны модулем Advanced Rate Limiter.

С помощью меток можно отслеживать запросы к отдельному ресурсу или запросы с определенным результатом проверки, например заблокированные.

Чтобы настроить алертинг:

1. [Создайте канал уведомлений](../../monium/operations/alert/create-channel.md).
1. Выберите [метрики и метки](../metrics.md) для контроля.
1. [Создайте алерт](../../monium/operations/alert/create-alert.md).

Во всех запросах на получение метрик укажите общие метки:

* `project` = `folder__<идентификатор_каталога>`.
* `cluster` = `default`.
* `service` = `__application-load-balancer__`.

В метке `load_balancer` укажите имя балансировщика или прокси-сервера, если защищаете домен. В запросах `A` и `B` одного алерта используйте одинаковые значения меток ресурса: балансировщика, профиля безопасности и при необходимости HTTP-роутера и виртуального хоста.

Примеры алертов для выявления аномалий:

* [Алерт об увеличении доли заблокированных запросов](#increased-deny-requests).
* [Алерт о высокой скорости легитимных запросов](#exceeding-speed-requests).

Пороги, окно и задержку вычисления из примеров подберите под нагрузку приложения и частоту поступления метрик.

## Алерт об увеличении доли заблокированных запросов {#increased-deny-requests}

Алерт будет срабатывать, когда количество заблокированных запросов составляет 50% и более от общего количества запросов. Такой алерт поможет выявить различные типы атак, например, [DDoS-атаки](../../glossary/ddos.md) или попытку взлома с использованием ботов.

Обозначим буквами количество входящих запросов в секунду:

* `A` — общее количество запросов.
* `B` — количество запросов, заблокированных профилем безопасности.

Настроим алерты:

* `B` составляет 30% от `A` — предупреждение (`{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}`);
* `B` составляет 50% от `A` — критический уровень (`{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}`).

### Создание канала уведомления {#create-channel}

{% include [alerting-create-channel](../../_includes/smartwebsecurity/alerting-create-channel.md) %}

### Выбор метрик для контроля {#select-metrics}

Для расчета доли заблокированных запросов используйте:

* `A` — метрика `load_balancer.smart_web_security.requests_per_second` со всеми значениями метки `antirobot_verdict`.
* `B` — та же метрика с фильтром `antirobot_verdict` = `deny`.
* `C` — доля заблокированных запросов в процентах: `100 * B / A`.

При `A = 0` доля не определена.

### Создание алерта {#create-alert}

1. [Перейдите]({{ link-monium }}) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monium }}**.
1. На панели слева выберите ![shield-exclamation](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![megaphone](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите `{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}`.
1. Введите название алерта, например, `exceeding-blocked-requests`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** опишите запрос для получения `A`:

    1. Установите курсор в свободном пространстве в поле правее значка ![request-icon](../../_assets/monium/request-icon.svg) и добавьте параметры:

        * `service` = `Application Load Balancer`;
        * `name` = `load_balancer.smart_web_security.requests_per_second`;
        * `antirobot_verdict` = `allow`;
        * `load_balancer` = `<имя_балансировщика_нагрузки>`.
    1. Установите курсор в свободном пространстве в поле правее значка ![function](../../_assets/monitoring/function.svg), выберите `{{ ui-key.yacloud_monitoring.querystring.functions.label.category-TRANSFORMATION }}`, затем выберите и задайте функцию для обработки данных `replace_nan(0)` — замена пропусков данных на значение `0`, чтобы график был непрерывным.
1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
1. Опишите запрос для получения `B`:

    1. Укажите данные для сбора:

        * `service` = `application-load-balancer`;
        * `name` = `load_balancer.smart_web_security.requests_per_second`;
        * `antirobot_verdict` = `deny`;
        * `load_balancer` = `<имя_балансировщика_нагрузки>`.
    1. Задайте функцию `replace_nan(0)`.
1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
1. Опишите запрос `C` для получения доли `B` от `A` в процентах:

    1. Нажмите ![raw](../../_assets/monitoring/raw.svg), чтобы переключиться в текстовый режим редактирования запроса.
    1. В строке запроса введите `100 * B / A`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}** укажите:

    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.query-to-check }}** — `C`.
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}** — `{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.at-all-times }}`.
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** — `30` (предупреждение).
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** — `50` (критический уровень).
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}** — `30s`.
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.evaluation-delay }}** — `15s`.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}** оставьте значения по умолчанию.
1. (опционально) В блоке [**{{ ui-key.yacloud_monitoring.monitoring-alerts.title.annotations }}**](../../monium/concepts/alerting/annotation.md) добавьте информацию, которую следует записывать при срабатывании алерта.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте канал для отправки уведомления.
1. Нажмите **{{ ui-key.yacloud.common.create }}**.

## Алерт о высокой скорости легитимных запросов {#exceeding-speed-requests}

Обозначим буквами количество входящих запросов в секунду:

* `A` — разрешенных профилем безопасности.
* `B` — разрешенных профилем ARL.

Если `A` близко к `B`, профиль ARL пропускает большинство запросов, разрешенных профилем безопасности.

Если `A` значительно превышает `B`, часть запросов блокируется или направляется на дополнительную проверку профилем ARL. Проверьте характер трафика и настройки ARL: разница сама по себе не означает, что приложение не справляется с нагрузкой.

Чтобы выявить такое превышение скорости, настроим алерты:

* `A` превышает `B` на 30% — предупреждение (`{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}`);
* `A` превышает `B` на 50% — критический уровень (`{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}`).

### Создание канала уведомления {#create-channel2}

{% include [alerting-create-channel](../../_includes/smartwebsecurity/alerting-create-channel.md) %}

### Выбор метрик для контроля {#select-metrics2}

Для сравнения запросов, разрешенных профилями безопасности и ARL, используйте:

* `A` — метрика `load_balancer.smart_web_security.requests_per_second` с фильтром `antirobot_verdict` = `allow`.
* `B` — метрика `load_balancer.smart_web_security.arl_requests_per_second` с фильтром `arl_verdict` = `allow`.
* `C` — превышение `A` над `B` в процентах: `100 * (A - B) / B`.

Пример применим при `B > 0`. Если ARL не пропускает ни одного запроса, процент превышения не определен.

### Создание алерта {#create-alert2}

1. [Перейдите]({{ link-monium }}) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monium }}**.
1. На панели слева выберите ![shield-exclamation](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![megaphone](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите `{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}`.
1. Введите название алерта, например, `inbound-over-ARL`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** опишите запрос для получения `A`:

    1. Установите курсор в свободном пространстве в поле правее значка ![request-icon](../../_assets/monium/request-icon.svg) и добавьте параметры:

        * `service` = `Application Load Balancer`;
        * `name` = `load_balancer.smart_web_security.requests_per_second`;
        * `antirobot_verdict` = `allow`;
        * `load_balancer` = `<имя_балансировщика_нагрузки>`.
    1. Установите курсор в свободном пространстве в поле правее значка ![function](../../_assets/monitoring/function.svg) и задайте функции для обработки данных:

        * `{{ ui-key.yacloud_monitoring.querystring.functions.label.category-COMBINE }}` → `series_sum()` — сумма значений метрик с разными метками для конкретной точки. В нашем примере метка одна — `antirobot_verdict`, но для других метрик эта функция будет полезна.
        * `{{ ui-key.yacloud_monitoring.querystring.functions.label.category-TRANSFORMATION }}` → `replace_nan(0)` — замена пропусков данных на значение `0`, чтобы график был непрерывным.
1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
1. Опишите запрос для получения `B`:

    1. Укажите данные для сбора:

        * `service` = `application-load-balancer`;
        * `name` = `load_balancer.smart_web_security.arl_requests_per_second`;
        * `arl_verdict` = `allow`;
        * `load_balancer` = `<имя_балансировщика_нагрузки>`.
    1. Задайте функции `series_sum()` и `replace_nan(0)`.
1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
1. Опишите запрос `C` для получения разницы между `A` и `B` в процентах:

    1. Нажмите ![raw](../../_assets/monitoring/raw.svg), чтобы переключиться в текстовый режим редактирования запроса.
    1. В строке запроса введите `100 * abs(A - B) / B`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}** укажите:

     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.query-to-check }}** — `C`.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}** — `{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.at-all-times }}`.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** — `30` (предупреждение).
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** — `50` (критический уровень).
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}** — `30s`.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.evaluation-delay }}** — `15s`.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}** оставьте значения по умолчанию.
1. (опционально) В блоке [**{{ ui-key.yacloud_monitoring.monitoring-alerts.title.annotations }}**](../../monium/concepts/alerting/annotation.md) добавьте информацию, которую следует записывать при срабатывании алерта.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте канал для отправки уведомления.
1. Нажмите **{{ ui-key.yacloud.common.create }}**.

#### Полезные ссылки {#see-also}

* [{#T}](../metrics.md)
* [{#T}](../../monium/concepts/visualization/query-string.md)
