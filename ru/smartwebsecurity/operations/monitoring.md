---
title: Мониторинг в сервисе {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете настроить мониторинг {{ sws-name }}.
---

# Мониторинг в {{ sws-name }}

С помощью мониторинга вы можете следить за скоростью запросов к защищаемому ресурсу: разрешенных и заблокированных, направленных на проверки JS Challenge, Cookie Challenge или в {{ captcha-name }} и обработанных профилем ARL. Также можно [настроить уведомления](../../monitoring/operations/alert/create-alert.md) (алерты) о превышении каких-либо порогов скорости запросов.

В {{ yandex-cloud }} уже настроены некоторые дашборды для мониторинга {{ sws-name }}.

Вы можете посмотреть дашборды одним из способов:

* На странице сервиса {{ sws-name }} выберите раздел ![display-pulse](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.
* В разделе **{{ ui-key.yacloud.common.monitoring }}** справа вверху нажмите **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}**.
* На странице сервиса {{ alb-name }}:
  1. Выберите балансировщик, к которому привязан профиль безопасности.
  1. Выберите раздел **{{ ui-key.yacloud.common.monitoring }}**.
  1. Перейдите на вкладку **Smart Web Security**.

{% note info %}

В настоящий момент самый полный набор дашбордов для {{ sws-name }} находится на странице сервиса {{ monitoring-name }}. Ниже описаны дашборды с этой страницы.

{% endnote %}

## Описание дашбордов для мониторинга {{ sws-name }} {#monitoring-dashboards}

Графики запросов, направленных на проверки, используют метрики с меткой `service=application-load-balancer`. Имя метрики задается в метке `name`. Трафик отбирается по каталогу (`folderId`), балансировщику (`load_balancer`), профилю безопасности (`security_profile`) и правилу (`rule_name`). Для графиков профиля безопасности также используются метки HTTP-роутера (`http_router`) и виртуального хоста (`virtual_host`), для графиков ARL — идентификатор профиля ARL (`arl_profile`).

Значения отобранных временных рядов суммируются функцией `series_sum()`, а значения `NaN` заменяются нулем с помощью `replace_nan(0)`.

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

Вы можете комбинировать несколько метрик на одном графике и [настраивать свои дашборды](../../monitoring/operations/dashboard/create.md) в сервисе {{ monitoring-short-name }}.

#### Полезные ссылки {#see-also}

* [{#T}](../metrics.md)
* [{#T}](../../monitoring/concepts/visualization/dashboard.md)
