---
title: Мониторинг в сервисе {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете настроить мониторинг {{ sws-name }}.
---

# Мониторинг в {{ sws-name }}

С помощью мониторинга вы можете следить за скоростью запросов к защищаемому ресурсу: разрешенных и заблокированных, направленных на проверки JS Challenge, Cookie Challenge или в {{ captcha-name }} и обработанных профилем ARL. Также можно [настроить уведомления](alerting.md) (алерты) о превышении каких-либо порогов скорости запросов.

Для мониторинга защиты на уровнях L3–L4 [посмотрите метрики Network Protection](#network-protection) в {{ monium-name }}. Они показывают объем входящего, отброшенного и пропущенного трафика.

Вы можете посмотреть дашборды одним из способов:

* На [странице]({{ link-console-main }}/link/smartwebsecurity) сервиса {{ sws-name }} выберите раздел ![display-pulse](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** и вкладку:
  * **Anti-DDoS** — графики профилей безопасности и ARL.
  * **SolidWall WAF** — графики профиля [SolidWall WAF](../concepts/solidwall-waf.md).
* Для просмотра метрик конкретного прокси-сервера в разделе **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}** выберите прокси-сервер и откройте вкладку **{{ ui-key.yacloud.common.monitoring }}**. На ней доступны вкладки **{{ sws-name }}**, **HTTP статистика** и **Статистика масштабирования**.
* Для просмотра дашборда на платформе {{ monium-name }} нажмите **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}** справа вверху раздела или вкладки **{{ ui-key.yacloud.common.monitoring }}**. В {{ monium-name }} также можно [строить графики по выбранным метрикам](../../monium/metrics/metric-explorer.md).
* На [странице]({{ link-console-main }}/link/application-load-balancer) сервиса {{ alb-name }}:
  1. Выберите балансировщик, к которому привязан профиль безопасности.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}**, затем на вкладку **Smart Web Security**.

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

Вы можете комбинировать несколько метрик на одном графике и [настраивать свои дашборды](../../monium/operations/dashboard/create.md) в сервисе {{ monium-name }}.

## Посмотреть метрики Network Protection {#network-protection}

Для просмотра метрик нужны роли:

* [smart-web-security.auditor](../security/index.md#smart-web-security-auditor) — на прокси-сервер.
* [monium.metrics.reader](../../monium/security/index.md#monium-metrics-reader) — на каталог, в котором находится прокси-сервер.

Чтобы построить график отброшенного трафика:

1. Узнайте публичный IPv4-адрес прокси-сервера. В [консоли управления]({{ link-console-main }}/link/smartwebsecurity) выберите каталог с прокси-сервером, откройте раздел **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}** и выберите прокси-сервер. На вкладке **{{ ui-key.yacloud.common.overview }}** скопируйте значение поля **{{ ui-key.yacloud.smart-web-security.proxy-servers.publicIpColumn_dPwQF }}**.
1. Откройте [{{ monium-name }}]({{ link-monium }}) и на панели сверху выберите проект `folder__<идентификатор_каталога>` каталога с прокси-сервером.
1. На панели слева выберите ![compass](../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → ![rectangle-pulse](../../_assets/console-icons/rectangle-pulse.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
1. Вверху на шкале времени задайте период просмотра.
1. В строке запроса нажмите ![code](../../_assets/console-icons/code.svg), чтобы переключиться в текстовый режим, и введите:

    ```text
    non_negative_derivative({project = "folder__<идентификатор_каталога>", service = "__antiddos__", cluster = "default", ip = "<ip_адрес_прокси_сервера>", name = "drop_client_bytes"})
    ```

    Замените `<идентификатор_каталога>` на [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) с прокси-сервером, а `<ip_адрес_прокси_сервера>` — на адрес из первого шага.
1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.button.apply-and-parse }}**.

График покажет, сколько байт клиентского трафика отбрасывается в секунду. Функция `non_negative_derivative` рассчитывает, на сколько увеличивается накопительный счетчик за секунду.

Чтобы посмотреть входящий или пропущенный трафик, замените `drop_client_bytes` в метке `name` на `client_bytes` или `forward_client_bytes` соответственно. Для сравнения на одном графике добавьте отдельные запросы кнопкой **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**. Полный список метрик приведен в [справочнике](../metrics.md#network-protection-metrics).

#### Полезные ссылки {#see-also}

* [{#T}](../metrics.md)
* [{#T}](../../monium/concepts/visualization/dashboard.md)
