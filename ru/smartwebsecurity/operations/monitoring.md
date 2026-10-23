---
title: Мониторинг в сервисе {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете настроить мониторинг {{ sws-name }}.
---

# Мониторинг в {{ sws-name }}

С помощью мониторинга вы можете следить за скоростью запросов к защищаемому ресурсу: разрешенных и заблокированных, направленных на проверки JS Challenge, Cookie Challenge или в {{ captcha-name }} и обработанных профилем ARL. Также можно [настроить уведомления](alerting.md) (алерты) о превышении каких-либо порогов скорости запросов.

Чтобы посмотреть метрики в интерфейсе {{ sws-name }}:

{% include [view-metrics](../../_includes/smartwebsecurity/view-metrics.md) %}

## Описание дашбордов для мониторинга {{ sws-name }} {#monitoring-dashboards}

Графики построены на метриках {{ alb-name }} и показывают данные за выбранный период с учетом фильтров.

На дашбордах доступны следующие графики:

* **Inbound total RPS** — общее количество входящих запросов в секунду (RPS), поступающих на балансировщик с профилем безопасности.

  Метрика — `load_balancer.requests_count_per_second`.

* **Allowed by Security Profile RPS** — количество входящих запросов в секунду, которые были проверены и разрешены профилем безопасности.

  Метрика — `load_balancer.smart_web_security.requests_per_second`, отфильтрованная при помощи метки `antirobot_verdict`=`allow`.

* **Denied by Security Profile RPS** — количество входящих запросов в секунду, которые были проверены и заблокированы профилем безопасности.

   Метрика — `load_balancer.smart_web_security.requests_per_second`, отфильтрованная при помощи метки `antirobot_verdict`=`deny`.

* **Redirected to SmartCaptcha RPS** — количество входящих запросов в секунду, направленных в {{ captcha-name }} для дополнительной верификации.

    Метрика — `load_balancer.smart_web_security.requests_per_second`, отфильтрованная при помощи метки `antirobot_verdict`=`captcha`.

* **Redirected to JS challenge RPS** — количество входящих запросов в секунду, направленных на [проверку выполнения JavaScript](../concepts/rules.md#client-checks) на стороне клиента.

    Метрика — `load_balancer.smart_web_security.requests_per_second`, отфильтрованная при помощи метки `antirobot_verdict`=`js_challenge`.

* **Redirected to Cookie challenge RPS** — количество входящих запросов в секунду, направленных на [проверку поддержки cookie](../concepts/rules.md#client-checks) у клиента.

    Метрика — `load_balancer.smart_web_security.requests_per_second`, отфильтрованная при помощи метки `antirobot_verdict`=`cookie_challenge`.

    {% note info %}

    При сопоставлении с **Inbound total RPS** учитывайте графики разрешенных, заблокированных и направленных на все виды проверок запросов. Не все разрешенные на этом этапе запросы с меткой `antirobot_verdict`=`allow` достигнут защищаемого узла. Они могут быть заблокированы профилем ARL, ограничивающим скорость входящих запросов.

    {% endnote %}

* **Allowed by ARL Profile RPS** — количество входящих запросов в секунду, которое не превышает лимит в профиле ARL.

  Метрика — `load_balancer.smart_web_security.arl_requests_per_second`, отфильтрованная при помощи метки `arl_verdict`=`allow`.

* **Denied by ARL Profile RPS** — количество входящих запросов в секунду, превысивших лимит профиля ARL и заблокированных.

  Метрика — `load_balancer.smart_web_security.arl_requests_per_second`, отфильтрованная при помощи метки `arl_verdict`=`deny`.

* **Redirected to SmartCaptcha by ARL Profile RPS** — количество входящих запросов в секунду, направленных профилем ARL в {{ captcha-name }} для дополнительной верификации.

    Метрика — `load_balancer.smart_web_security.arl_requests_per_second`, отфильтрованная при помощи метки `arl_verdict`=`captcha`.


    {% note info %}

    При сопоставлении с **Allowed by Security Profile RPS** учитывайте графики разрешенных, заблокированных и направленных на капчу запросов в профиле ARL.

    {% endnote %}

#### Полезные ссылки {#see-also}

* [{#T}](../metrics.md)
* [{#T}](../../monitoring/concepts/visualization/dashboard.md)
