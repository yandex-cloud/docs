---
title: Справочник метрик сервиса {{ sws-full-name }} в {{ monium-full-name }}
description: На этой странице приведен справочник метрик сервиса {{ sws-name }}, поставляемых в {{ monium-full-name }}.
---

# Справочник метрик {{ sws-full-name }}

В справочнике описаны метрики HTTP-трафика, профилей безопасности и ARL, которые собирает [{{ alb-full-name }}](../application-load-balancer/), а также метрики [Network Protection](concepts/network-protection.md).

Просматривать метрики можно:

* В разделе **{{ ui-key.yacloud.common.monitoring }}** сервиса {{ sws-name }} — на дашбордах профилей безопасности и ARL.
* На вкладке **{{ ui-key.yacloud.common.monitoring }}** конкретного прокси-сервера. Чтобы открыть ее, в разделе **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}** выберите нужный прокси-сервер.
* На платформе [{{ monium-full-name }}](../monium/) — на дашбордах или с помощью [запросов к метрикам](../monium/metrics/metric-explorer.md). Здесь также доступны метрики Network Protection.

Подробнее о просмотре графиков в разделе [{#T}](operations/monitoring.md).

## Общие метки {#labels}

В запросах {{ monium-name }} укажите следующие метки:

#|
|| **Метка** | **Значение** ||
|| `project` | `folder__<идентификатор_каталога>` — проект каталога, в котором находится балансировщик или прокси-сервер. ||
|| `cluster` | `default`. ||
|| `service` | `__application-load-balancer__` — метрики профилей безопасности, ARL и HTTP-трафика; `__antiddos__` — метрики Network Protection. ||
|| `name` | Имя метрики из таблиц ниже. ||
|#

## Метрики профилей безопасности и ARL {#sws-metrics}

Для просмотра метрик профилей безопасности, ARL и общей скорости запросов в {{ monium-name }} используйте `service = __application-load-balancer__`.

{% include [alb-sws](../_includes/monitoring/metrics-ref/alb-sws.md) %}

## Общая скорость запросов {#incoming-requests}

Для графика **Inbound total RPS** используется следующая метрика:

#|
|| **Имя метрики** | **Тип, единицы измерения** | **Описание** ||
|| `load_balancer.requests_count_per_second` | `DGAUGE`, запросы/с | Общее количество запросов к балансировщику или прокси-серверу в секунду. ||
|#

Для фильтрации доступны метки `load_balancer`, `http_router`, `virtual_host`, `route`, `backend`, `backend_group` и `zone`. Дополнительная метка `code` содержит код ответа, например `200` или `503`.

Другие [метрики HTTP](../application-load-balancer/metrics.md#http-metrics) и [метрики масштабирования](../application-load-balancer/metrics.md#scaling-metrics) описаны в справочнике {{ alb-name }}.

## Метрики Network Protection {#network-protection-metrics}

Метрики Network Protection автоматически передаются в {{ monium-name }} в проект каталога, в котором находится прокси-сервер. Для их получения используйте `service = __antiddos__`. В метке `ip` укажите публичный IPv4-адрес прокси-сервера. [Как узнать адрес и построить запрос](operations/monitoring.md#network-protection).

Все метрики Network Protection — накопительные счетчики. Чтобы получить количество пакетов или байт в секунду, используйте функцию `non_negative_derivative`.

#|
|| **Имя метрики** | **Описание** ||
|| `client_packets`, `client_bytes` | Количество пакетов и байт, полученных от клиентов до очистки. ||
|| `drop_client_packets`, `drop_client_bytes` | Количество пакетов и байт от клиентов, отброшенных защитой. ||
|| `forward_client_packets`, `forward_client_bytes` | Количество пакетов и байт от клиентов, пропущенных к прокси-серверу. ||
|| `forward_service_packets`, `forward_service_bytes` | Количество пакетов и байт, пропущенных от прокси-сервера к клиентам. ||
|#

#### Полезные ссылки {#see-also}

* [{#T}](./operations/monitoring.md)
* [{#T}](./operations/alerting.md)
