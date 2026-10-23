[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Настроить мониторинг

# Мониторинг в Smart Web Security

С помощью мониторинга вы можете следить за скоростью запросов к защищаемому ресурсу: разрешенных и заблокированных, направленных на проверки JS Challenge, Cookie Challenge или в SmartCaptcha и обработанных профилем ARL. Также можно [настроить уведомления](alerting.md) (алерты) о превышении каких-либо порогов скорости запросов.

Чтобы посмотреть метрики в интерфейсе Smart Web Security:

1. В [консоли управления](https://console.yandex.cloud) выберите каталог с профилем безопасности.
1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
1. На панели слева выберите ![display-pulse](../../_assets/console-icons/display-pulse.svg) **Мониторинг**.
1. Задайте период просмотра метрик.
1. При необходимости отфильтруйте графики с помощью полей **Балансировщик**, **Профиль безопасности** и **Профиль ARL**.

## Описание дашбордов для мониторинга Smart Web Security {#monitoring-dashboards}

Графики построены на метриках Application Load Balancer и показывают данные за выбранный период с учетом фильтров.

На дашбордах доступны следующие графики:

* **Inbound total RPS** — общее количество входящих запросов в секунду (RPS), поступающих на балансировщик с профилем безопасности.

  Метрика — `load_balancer.requests_count_per_second`.

* **Allowed by Security Profile RPS** — количество входящих запросов в секунду, которые были проверены и разрешены профилем безопасности.

  Метрика — `load_balancer.smart_web_security.requests_per_second`, отфильтрованная при помощи метки `antirobot_verdict`=`allow`.

* **Denied by Security Profile RPS** — количество входящих запросов в секунду, которые были проверены и заблокированы профилем безопасности.

   Метрика — `load_balancer.smart_web_security.requests_per_second`, отфильтрованная при помощи метки `antirobot_verdict`=`deny`.

* **Redirected to SmartCaptcha RPS** — количество входящих запросов в секунду, направленных в SmartCaptcha для дополнительной верификации.

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

* **Redirected to SmartCaptcha by ARL Profile RPS** — количество входящих запросов в секунду, направленных профилем ARL в SmartCaptcha для дополнительной верификации.

    Метрика — `load_balancer.smart_web_security.arl_requests_per_second`, отфильтрованная при помощи метки `arl_verdict`=`captcha`.


    {% note info %}

    При сопоставлении с **Allowed by Security Profile RPS** учитывайте графики разрешенных, заблокированных и направленных на капчу запросов в профиле ARL.

    {% endnote %}

#### Полезные ссылки {#see-also}

* [Справочник метрик Smart Web Security](../metrics.md)
* [Дашборд в Monitoring](../../monitoring/concepts/visualization/dashboard.md)