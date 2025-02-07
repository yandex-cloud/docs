---
title: Как настроить уведомления для сервиса {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете настроить алерты {{ sws-full-name }}.
---

# Настроить алерты для сервиса

[Алертинг](../../monitoring/concepts/alerting/alert.md) позволяет следить за изменениями в метриках и отправлять уведомления, когда показатели достигают критических значений. Изменения в метриках отслеживаются с помощью периодически отправляемых запросов — _алертов_. Когда они достигают пороговых значений, система отправляет уведомление через указанный канал связи. Например, по электронной почте или в мессенджер.

В сервисе {{ sws-name }} доступны метрики скорости входящих запросов:

* `load_balancer.smart_web_security.requests_per_second` — количество запросов к защищаемому ресурсу в секунду. Это значение соответствует количеству запросов, обработанных профилем безопасности.
* `load_balancer.smart_web_security.arl_requests_per_second` — количество запросов к защищаемому ресурсу в секунду, которые обработаны модулем Advanced Rate Limiter.

Можно настроить алерты при достижении метриками определенных порогов скорости. А также использовать метки для расчета метрик по отдельным событиям.

Чтобы настроить алертинг:

1. [Создайте канал уведомлений](../../monitoring/operations/alert/create-channel.md).
1. Выберите [метрики и метки](../../monitoring/metrics-ref/smartwebsecurity-ref.md) для контроля.
1. [Создайте алерт](../../monitoring/operations/alert/create-alert.md).

Рассмотрим примеры создания алертов, которые могут быть полезны для выявления аномалий:

* [Алерт об увеличении доли заблокированных запросов](#increased-deny-requests).
* [Алерт о высокой скорости легитимных запросов](#exceeding-speed-requests).

## Алерт об увеличении доли заблокированных запросов {#increased-deny-requests}

Алерт будет срабатывать, когда количество заблокированных запросов составляет 50% и более от общего количества запросов. Такой алерт поможет выявить различные типы атак, например, [DDoS](../../glossary/ddos.md) или попытку взлома с использованием ботов.

Обозначим буквами количество входящих запросов в секунду:

* `A` — общее количество запросов.
* `B` — запросов, заблокированных профилем безопасности.

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

* Величину `A` будем получать с помощью метрики `load_balancer.smart_web_security.requests_per_second`.
* Величину `B` будем получать с помощью метрики `load_balancer.smart_web_security.requests_per_second`, отфильтровав по метке `antirobot_verdict` = `deny`.
* Долю `B` от `A` будем вычислять как `100 * B / A` и сохранять в значении `C`.

### Создание алерта {#create-alert}

1. На странице сервиса **{{ monitoring-short-name }}** нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
1. Введите название алерта, например, `exceeding-blocked-requests`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** опишите запрос для получения `A`:
   1. Напротив значка ![image](../../_assets/monitoring/chart-lines2.svg) нажмите ![image](../../_assets/monitoring/plus.svg) и добавьте параметры:
     * `service` = `Application Load Balancer`;
     * `name` = `load_balancer.smart_web_security.requests_per_second`;
     * `antirobot_verdict` = `allow`;
     * `load_balancer` = `<имя_балансировщика_нагрузки>`.
   1. Напротив значка ![image](../../_assets/monitoring/function.svg) нажмите ![image](../../_assets/monitoring/plus.svg).
   1. Задайте функцию для обработки данных `replace_nan(0)` — замена пропусков данных на значение `0`, чтобы график был непрерывным.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.

1. Опишите запрос для получения `B`:
   1. Укажите данные для сбора:
     * `service` = `Application Load Balancer`;
     * `name` = `load_balancer.smart_web_security.requests_per_second`;
     * `antirobot_verdict` = `deny`;
     * `load_balancer` = `<имя_балансировщика_нагрузки>`.
   1. Задайте функцию `replace_nan(0)`.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
   
1. Опишите запрос `C` для получения доли `B` от `A` в процентах:
   1. Нажмите ![image](../../_assets/monitoring/raw.svg), чтобы переключиться в текстовый режим редактирования запроса.
   1. В строке запроса введите `100 * B / A`.

1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}** укажите:
     * `Запрос для проверки` — `C`.
     * `Функция агрегации` — `Все значения`.
     * `Warning` — `30` (предупреждение).
     * `Alarm` — `50` (критический уровень).
     * `Окно вычисления` — `30 секунд`.
     * `Задержка вычисления` — `15 секунд`.

1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}** оставьте значения по умолчанию.
1. (опционально) В блоке [**{{ ui-key.yacloud_monitoring.monitoring-alerts.title.annotations }}**](../../monitoring/concepts/alerting/annotation.md) добавьте информацию, которую следуют записывать при срабатывании алерта.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте канал для отправки уведомления.
1. Нажмите **{{ ui-key.yacloud.common.create }}**.

## Алерт о высокой скорости легитимных запросов {#exceeding-speed-requests}

Обозначим буквами количество входящих запросов в секунду:

* `A` — разрешенных профилем безопасности.
* `B` — разрешенных профилем ARL.

В норме величина `A` должна быть равна или немного больше `B`. То есть количество запросов, разрешенных профилем безопасности, незначительно превышает установленный лимит в ARL. А значит большинство запросов, разрешенных профилем безопасности, достигает вирутального хоста. В этом случае нагрузка на систему находится в пределах нормы.

Значительная разница в количестве запросов означает, что система не справляется с нагрузкой и блокирует потенциально легитимные запросы. Это возможно при недостаточной производительности или атаке. Если такая ситуация наблюдается постоянно, стоит пересмотреть настройки профиля безопасности или лимиты скорости.

Чтобы выявить такое превышение скорости, настроим алерты:

* `A` превышает `B` на 30% — предупреждение (`Warning`);
* `A` превышает `B` на 50% — критический уровень (`Alarm`).

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

* Величину `A` будем получать с помощью метрики `load_balancer.smart_web_security.requests_per_second`, отфильтровав по метке `antirobot_verdict` = `allow`.
* Величину `B` будем получать с помощью метрики `load_balancer.smart_web_security.arl_requests_per_second`, отфильтровав по метке `arl_verdict` = `allow`.
* Превышение `A` над `B` в процентах будем вычислять как `100 * abs(A - B) / B` и сохранять в значении `C`.

### Создание алерта {#create-alert}

1. На странице сервиса **{{ monitoring-short-name }}** нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
1. Введите название алерта, например, `inbound-over-ARL`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** опишите запрос для получения `A`:
   * Напротив значка ![image](../../_assets/monitoring/chart-lines2.svg) нажмите ![image](../../_assets/monitoring/plus.svg) и добавьте параметры:
     * `service` = `Application Load Balancer`;
     * `name` = `load_balancer.smart_web_security.requests_per_second`;
     * `antirobot_verdict` = `allow`;
     * `load_balancer` = `<имя_балансировщика_нагрузки>`.
   * Напротив значка ![image](../../_assets/monitoring/function.svg) нажмите ![image](../../_assets/monitoring/plus.svg) и задайте функции для обработки данных:
     * `series_sum()` — сумма значений метрик с разными метками для конкретной точки. В нашем примере метка одна — `antirobot_verdict`, но для других метрик эта функция будет полезна.
     * `replace_nan(0)` — замена пропусков данных на значение `0`, чтобы график был непрерывным.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.

1. Опишите запрос для получения `B`:
   * Укажите данные для сбора:
     * `service` = `Application Load Balancer`;
     * `name` = `load_balancer.smart_web_security.arl_requests_per_second`;
     * `arl_verdict` = `allow`;
     * `load_balancer` = `<имя_балансировщика_нагрузки>`.
   * Задайте функции `series_sum()` и `replace_nan(0)`.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
   
1. Опишите запрос `C` для получения разницы между  `A` и `B` в процентах:
   1. Нажмите ![image](../../_assets/monitoring/raw.svg), чтобы переключиться в текстовый режим редактирования запроса.
   1. В строке запроса введите `100 * abs(A - B) / B`.

1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}** укажите:
     * `Запрос для проверки` — `C`.
     * `Функция агрегации` — `Все значения`.
     * `Warning` — `30` (предупреждение).
     * `Alarm` — `50` (критический уровень).
     * `Окно вычисления` — `30 секунд`.
     * `Задержка вычисления` — `15 секунд`.

1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}** оставьте значения по умолчанию.
1. (опционально) В блоке [**{{ ui-key.yacloud_monitoring.monitoring-alerts.title.annotations }}**](../../monitoring/concepts/alerting/annotation.md) добавьте информацию, которую следуют записывать при срабатывании алерта.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте канал для отправки уведомления.
1. Нажмите **{{ ui-key.yacloud.common.create }}**.

#### См. также {#see-also}

* [{#T}](../metrics.md)
* [{#T}](../../monitoring/concepts/visualization/query-string.md)
