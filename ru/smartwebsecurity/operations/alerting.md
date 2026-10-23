---
title: Как настроить уведомления для сервиса {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете настроить алерты {{ sws-full-name }}.
---

# Настроить алерты для сервиса

[Алерты](../../monium/concepts/alerting/alert.md) в {{ monium-name }} отслеживают значения метрик {{ sws-name }} и отправляют уведомления при достижении заданных порогов. Способ отправки и получателей задают в [канале уведомлений](../../monium/concepts/alerting/notification-channel.md).

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
* `B` — запросов, заблокированных профилем безопасности.

Настроим алерты:

* `B` составляет 30% и более от `A` — предупреждение (`Warning`);
* `B` составляет 50% и более от `A` — критический уровень (`Alarm`).

### Создание канала уведомления {#create-channel}

1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите **Алерты и SLO** → **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. Вверху справа нажмите **Создать** → **Канал уведомления**.
1. Укажите имя канала, метод отправки и получателей.

    {% note info %}

    {% include [notifications-requirements](../../_includes/monium/notifications-requirements.md) %}

    {% endnote %}

1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

### Выбор метрик для контроля {#select-metrics}

Для расчета доли заблокированных запросов используйте:

* `A` — метрика `load_balancer.smart_web_security.requests_per_second` со всеми значениями метки `antirobot_verdict`.
* `B` — та же метрика с фильтром `antirobot_verdict` = `deny`.
* `C` — доля заблокированных запросов в процентах: `100 * B / A`.

При `A = 0` доля не определена.

### Создание алерта {#create-alert}

1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите **Алерты и SLO** → **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. Вверху справа нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **Пользовательский**.
1. Введите название алерта, например, `exceeding-blocked-requests`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** опишите запрос для получения `A`:

   1. В строке запроса укажите общие метки `project`, `cluster`, `service` и добавьте:

      * `name` = `load_balancer.smart_web_security.requests_per_second`;
      * `antirobot_verdict` = `*`;
      * `load_balancer` = `<имя_балансировщика_нагрузки>`;
      * `security_profile` = `<идентификатор_профиля_безопасности>`.

   1. В строке ![function](../../_assets/monitoring/function.svg) последовательно добавьте функции:

      * `series_sum()` — суммирует значения выбранных временных рядов.
      * `replace_nan(0)` — заменяет значения `NaN` нулем.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
1. Опишите запрос для получения `B`:

   1. Укажите общие метки `project`, `cluster`, `service` и добавьте:

      * `name` = `load_balancer.smart_web_security.requests_per_second`;
      * `antirobot_verdict` = `deny`;
      * `load_balancer` = `<имя_балансировщика_нагрузки>`;
      * `security_profile` = `<идентификатор_профиля_безопасности>`.

   1. Последовательно добавьте функции `series_sum()` и `replace_nan(0)`.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
1. Опишите запрос `C` для получения доли `B` от `A` в процентах:

   1. Нажмите ![code](../../_assets/console-icons/code.svg), чтобы переключиться в текстовый режим редактирования запроса.
   1. В строке запроса введите `100 * B / A`.

1. В блоке **Условия срабатывания** укажите:

     * `Запрос для проверки` — `C`.
     * `Функция агрегации` — `Все значения`.
     * `Функция сравнения` — `Больше или равно`.
     * `Warning` — `30` (предупреждение).
     * `Alarm` — `50` (критический уровень).
     * `Окно вычисления` — `30 секунд`.
     * `Задержка вычисления` — `15 секунд`.

1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}** задайте [политики обработки отсутствия данных](../../monium/concepts/alerting/alert.md#no-data-policy) или оставьте значения по умолчанию.
1. (Опционально) Добавьте [аннотации](../../monium/concepts/alerting/annotation.md) с дополнительной информацией для уведомлений.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте канал и выберите статусы `Warning` и `Alarm` для отправки уведомлений.
1. Нажмите **{{ ui-key.yacloud_monitoring.monitoring-alerts.action.calculate-alert }}** и проверьте график, значения запросов и статус алерта.
1. Нажмите **{{ ui-key.yacloud.common.create }}**.

## Алерт о высокой скорости легитимных запросов {#exceeding-speed-requests}

Обозначим буквами количество входящих запросов в секунду:

* `A` — разрешенных профилем безопасности.
* `B` — разрешенных профилем ARL.

Если `A` близко к `B`, профиль ARL пропускает большинство запросов, разрешенных профилем безопасности.

Если `A` значительно превышает `B`, часть запросов блокируется или направляется на дополнительную проверку профилем ARL. Проверьте характер трафика и настройки ARL: разница сама по себе не означает, что приложение не справляется с нагрузкой.

Чтобы выявить такое превышение скорости, настроим алерты:

* `A` превышает `B` на 30% и более — предупреждение (`Warning`);
* `A` превышает `B` на 50% и более — критический уровень (`Alarm`).

### Создание канала уведомления {#create-channel}

Используйте существующий канал уведомлений или [создайте новый](../../monium/operations/alert/create-channel.md).

### Выбор метрик для контроля {#select-metrics}

Для сравнения запросов, разрешенных профилями безопасности и ARL, используйте:

* `A` — метрика `load_balancer.smart_web_security.requests_per_second` с фильтром `antirobot_verdict` = `allow`.
* `B` — метрика `load_balancer.smart_web_security.arl_requests_per_second` с фильтром `arl_verdict` = `allow`.
* `C` — превышение `A` над `B` в процентах: `100 * (A - B) / B`.

Пример применим при `B > 0`. Если ARL не пропускает ни одного запроса, процент превышения не определен.

### Создание алерта {#create-alert}

1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите **Алерты и SLO** → **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. Вверху справа нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **Пользовательский**.
1. Введите название алерта, например, `inbound-over-ARL`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** опишите запрос для получения `A`:

   1. В строке запроса укажите общие метки `project`, `cluster`, `service` и добавьте:

      * `name` = `load_balancer.smart_web_security.requests_per_second`;
      * `antirobot_verdict` = `allow`;
      * `load_balancer` = `<имя_балансировщика_нагрузки>`;
      * `security_profile` = `<идентификатор_профиля_безопасности>`.

   1. В строке ![function](../../_assets/monitoring/function.svg) последовательно добавьте функции:

      * `series_sum()` — суммирует значения выбранных временных рядов.
      * `replace_nan(0)` — заменяет значения `NaN` нулем.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
1. Опишите запрос для получения `B`:

   1. Укажите общие метки `project`, `cluster`, `service` и добавьте:

      * `name` = `load_balancer.smart_web_security.arl_requests_per_second`;
      * `arl_verdict` = `allow`;
      * `load_balancer` = `<имя_балансировщика_нагрузки>`;
      * `security_profile` = `<идентификатор_профиля_безопасности>`.

   1. Последовательно добавьте функции `series_sum()` и `replace_nan(0)`.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**.
1. Опишите запрос `C` для получения превышения `A` над `B` в процентах:

   1. Нажмите ![code](../../_assets/console-icons/code.svg), чтобы переключиться в текстовый режим редактирования запроса.
   1. В строке запроса введите `100 * (A - B) / B`.

1. В блоке **Условия срабатывания** укажите:

     * `Запрос для проверки` — `C`.
     * `Функция агрегации` — `Все значения`.
     * `Функция сравнения` — `Больше или равно`.
     * `Warning` — `30` (предупреждение).
     * `Alarm` — `50` (критический уровень).
     * `Окно вычисления` — `30 секунд`.
     * `Задержка вычисления` — `15 секунд`.

1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.no-data }}** задайте [политики обработки отсутствия данных](../../monium/concepts/alerting/alert.md#no-data-policy) или оставьте значения по умолчанию.
1. (Опционально) Добавьте [аннотации](../../monium/concepts/alerting/annotation.md) с дополнительной информацией для уведомлений.
1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** добавьте канал и выберите статусы `Warning` и `Alarm` для отправки уведомлений.
1. Нажмите **{{ ui-key.yacloud_monitoring.monitoring-alerts.action.calculate-alert }}** и проверьте график, значения запросов и статус алерта.
1. Нажмите **{{ ui-key.yacloud.common.create }}**.

#### Полезные ссылки {#see-also}

* [{#T}](../metrics.md)
* [{#T}](../../monium/concepts/visualization/query-string.md)
