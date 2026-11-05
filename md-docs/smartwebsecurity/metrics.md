[Документация Yandex Cloud](../index.md) > [Yandex Smart Web Security](index.md) > Метрики

# Справочник метрик Yandex Smart Web Security

В справочнике описаны метрики HTTP-трафика, профилей безопасности и ARL, которые собирает [Yandex Application Load Balancer](../application-load-balancer/index.md), а также метрики [Network Protection](concepts/network-protection.md).

Просматривать метрики можно:

* В разделе **Мониторинг** сервиса Smart Web Security — на дашбордах профилей безопасности и ARL.
* На вкладке **Мониторинг** конкретного прокси-сервера. Чтобы открыть ее, в разделе **Защита доменов** выберите нужный прокси-сервер.
* На платформе [Yandex Monium](../monium/index.md) — на дашбордах или с помощью [запросов к метрикам](../monium/metrics/metric-explorer.md). Здесь также доступны метрики Network Protection.

Подробнее о просмотре графиков в разделе [Мониторинг в Smart Web Security](operations/monitoring.md).

## Общие метки {#labels}

В запросах Monium укажите следующие метки:

#|
|| **Метка** | **Значение** ||
|| `project` | `folder__<идентификатор_каталога>` — проект каталога, в котором находится балансировщик или прокси-сервер. ||
|| `cluster` | `default`. ||
|| `service` | `__application-load-balancer__` — метрики профилей безопасности, ARL и HTTP-трафика; `__antiddos__` — метрики Network Protection. ||
|| `name` | Имя метрики из таблиц ниже. ||
|#

## Метрики профилей безопасности и ARL {#sws-metrics}

Для просмотра метрик профилей безопасности, ARL и общей скорости запросов в Monium используйте `service = __application-load-balancer__`.

Метки для метрик профилей безопасности и ARL:

| Метка | Значение |
| --- | --- |
| **Общие метки** |
| load_balancer | Имя [L7-балансировщика](../application-load-balancer/concepts/application-load-balancer.md) или [прокси-сервера](concepts/domain-protect.md#proxy) Smart Web Security |
| http_router | Имя [HTTP-роутера](../application-load-balancer/concepts/http-router.md) |
| virtual_host | Имя [виртуального хоста](../application-load-balancer/concepts/http-router.md#virtual-host) |
| **Специальные метки** |
| security_profile | Идентификатор [профиля безопасности](concepts/profiles.md) |
| rule_name | Имя [правила безопасности](concepts/rules.md) |

| Имя<br>Тип, единицы измерения | Описание |
| --- | --- |
| `load_balancer.smart_web_security.`<br/>`requests_per_second`<br/>`DGAUGE`, запросы/с | Количество запросов к защищаемому ресурсу в секунду.<br/>Общие метки:<ul><li>`route` — имя [маршрута](../application-load-balancer/concepts/http-router.md#routes).</li><li>`zone` — [зона доступности](../overview/concepts/geo-scope.md).</li><li>`backend` — имя бэкенда.</li><li>`backend_group` — имя [группы бэкендов](../application-load-balancer/concepts/backend-group.md).</li></ul><br/>Специальная метка `antirobot_verdict` — действие с запросом по результатам проверок. Возможные значения:<ul><li>`allow` — запрос направлен к виртуальному хосту.</li><li>`captcha` — запрос направлен в сервис [Yandex SmartCaptcha](../smartcaptcha/index.md) для дополнительной верификации.</li><li>`js_challenge` — запрос направлен на [проверку JS Challenge](concepts/rules.md#client-checks).</li><li>`cookie_challenge` — запрос направлен на [проверку Cookie Challenge](concepts/rules.md#client-checks).</li><li>`deny` — запрос заблокирован.</li></ul></li></ul> |
| `load_balancer.smart_web_security.`<br/>`arl_requests_per_second`<br/>`DGAUGE`, запросы/с | Количество запросов к защищаемому ресурсу в секунду, прошедших через модуль [Advanced Rate Limiter](concepts/arl.md).<br/>Общая метка `folderId` — идентификатор [каталога](../resource-manager/concepts/resources-hierarchy.md#folder).<br/><br/>Специальные метки:<ul><li>`arl_profile` — идентификатор профиля Advanced Rate Limiter.</li><li>`arl_verdict` — действие с запросом по результатам проверок. Возможные значения:<ul><li>`allow` — запрос направлен к виртуальному хосту.</li><li>`captcha` — запрос направлен в сервис Yandex SmartCaptcha для дополнительной верификации.</li><li>`deny` — запрос заблокирован.</li></ul></li></ul> |

## Общая скорость запросов {#incoming-requests}

Для графика **Inbound total RPS** используется следующая метрика:

#|
|| **Имя метрики** | **Тип, единицы измерения** | **Описание** ||
|| `load_balancer.requests_count_per_second` | `DGAUGE`, запросы/с | Общее количество запросов к балансировщику или прокси-серверу в секунду. ||
|#

Для фильтрации доступны метки `load_balancer`, `http_router`, `virtual_host`, `route`, `backend`, `backend_group` и `zone`. Дополнительная метка `code` содержит код ответа, например `200` или `503`.

Другие [метрики HTTP](../application-load-balancer/metrics.md#http-metrics) и [метрики масштабирования](../application-load-balancer/metrics.md#scaling-metrics) описаны в справочнике Application Load Balancer.

## Метрики Network Protection {#network-protection-metrics}

Метрики Network Protection автоматически передаются в Monium в проект каталога, в котором находится прокси-сервер. Для их получения используйте `service = __antiddos__`. В метке `ip` укажите публичный IPv4-адрес прокси-сервера. [Как узнать адрес и построить запрос](operations/monitoring.md#network-protection).

Все метрики Network Protection — накопительные счетчики. Чтобы получить количество пакетов или байт в секунду, используйте функцию `non_negative_derivative`.

#|
|| **Имя метрики** | **Описание** ||
|| `client_packets`, `client_bytes` | Количество пакетов и байт, полученных от клиентов до очистки. ||
|| `drop_client_packets`, `drop_client_bytes` | Количество пакетов и байт от клиентов, отброшенных защитой. ||
|| `forward_client_packets`, `forward_client_bytes` | Количество пакетов и байт от клиентов, пропущенных к прокси-серверу. ||
|| `forward_service_packets`, `forward_service_bytes` | Количество пакетов и байт, пропущенных от прокси-сервера к клиентам. ||
|#

#### Полезные ссылки {#see-also}

* [Мониторинг в Smart Web Security](operations/monitoring.md)
* [Настроить алерты для сервиса](operations/alerting.md)