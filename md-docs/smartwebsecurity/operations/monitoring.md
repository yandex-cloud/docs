# Мониторинг в Smart Web Security

С помощью мониторинга вы можете следить за скоростью запросов к защищаемому ресурсу: разрешенных и заблокированных, направленных на SmartCaptcha и обработанных профилем ARL. Также можно [настроить уведомления](../../monitoring/operations/alert/create-alert.md) (алерты) о превышении каких-либо порогов скорости запросов.

В Yandex Cloud уже настроены некоторые дашборды для мониторинга Smart Web Security. 

Вы можете посмотреть дашборды одним из способов:

* На странице сервиса Smart Web Security выберите раздел **Мониторинг**.
* В разделе **Мониторинг** справа вверху нажмите **Открыть в Monium**.
* На странице сервиса Application Load Balancer:
  1. Выберите балансировщик, к которому привязан профиль безопасности.
  1. Выберите раздел **Мониторинг**.
  1. Перейдите на вкладку **Smart Web Security**.

{% note info %}

В настоящий момент самый полный набор дашбордов для Smart Web Security находится на странице сервиса Monitoring. Ниже описаны дашборды с этой страницы.

{% endnote %}

## Описание дашбордов для мониторинга Smart Web Security {#monitoring-dashboards}

* **Inbound total RPS** — общее количество входящих запросов в секунду (RPS), поступающих на балансировщик с профилем безопасности.

  Метрика — `load_balancer.requests_count_per_second`.

* **Allowed by Security Profile RPS** — количество входящих запросов в секунду, которые были проверены и разрешены профилем безопасности.

  Метрика — `load_balancer.smart_web_security.requests_per_second`, отфильтрованная при помощи метки `antirobot_verdict`=`allow`.

* **Denied by Security Profile RPS** — количество входящих запросов в секунду, которые были проверены и заблокированы профилем безопасности.

   Метрика — `load_balancer.smart_web_security.requests_per_second`, отфильтрованная при помощи метки `antirobot_verdict`=`deny`.

* **Redirected to SmartCaptcha RPS** — количество входящих запросов в секунду, направленных в SmartCaptcha для дополнительной верификации.

    Метрика — `load_balancer.smart_web_security.requests_per_second`, отфильтрованная при помощи метки `antirobot_verdict`=`captcha`.

    {% note info %}

    Общее количество запросов в каждый момент времени на **Allowed by Security Profile RPS**, **Denied by Security Profile RPS** и **Redirected to SmartCaptcha RPS** совпадает со значением **Inbound total RPS**. Но не все разрешенные на этом этапе запросы с меткой `antirobot_verdict`=`allow` достигнут защищаемого узла. Они могут быть заблокированы профилем ARL, ограничивающим скорость входящих запросов.

    {% endnote %}

* **Allowed by ARL Profile RPS** — количество входящих запросов в секунду, которое не превышает лимит в профиле ARL.

  Метрика — `load_balancer.smart_web_security.arl_requests_per_second`, отфильтрованная при помощи метки `arl_verdict`=`allow`.

* **Denied by ARL Profile RPS** — количество входящих запросов в секунду, превысивших лимит профиля ARL и заблокированных.

  Метрика — `load_balancer.smart_web_security.arl_requests_per_second`, отфильтрованная при помощи метки `arl_verdict`=`deny`.

    {% note info %}

    Общее количество запросов в каждый момент времени на **Allowed by ARL Profile RPS** и **Denied by ARL Profile RPS** совпадает со значением **Allowed by Security Profile RPS**.

    {% endnote %}

* **Redirected to SmartCaptcha by ARL Profile RPS** — количество входящих запросов в секунду, направленных профилем ARL в SmartCaptcha для дополнительной верификации.

    Метрика — `load_balancer.smart_web_security.arl_requests_per_second`, отфильтрованная при помощи метки `arl_verdict`=`captcha`.

Вы можете комбинировать несколько метрик на одном графике и [настраивать свои дашборды](../../monitoring/operations/dashboard/create.md) в сервисе Monitoring.

#### Полезные ссылки {#see-also}

* [Справочник метрик Yandex Monitoring](../metrics.md)
* [Дашборд в Monitoring](../../monitoring/concepts/visualization/dashboard.md)