## Часто задаваемые вопросы

В данном разделе приведены ответы на часто задаваемые вопросы, возникающие при использовании {{unified-agent-full-name}}.

## Как мне поставлять в {{ monitoring-full-name }} метрики своего приложения? { #1st-party-app }

{{unified-agent-full-name}} поддерживает сбор метрик в формате Prometheus и конвертацию метрик в формат {{ monitoring-full-name }}. Таким образом, при помощи {{unified-agent-short-name}} можно собирать метрики любых приложений, предоставляющих метрики в формате Prometheus.

Для поставки метрик своего приложения воспользуйтесь [клиентской библиотекой Prometheus](https://prometheus.io/docs/instrumenting/clientlibs/) для языка программирования, на котором написано ваше приложение.

{% list tabs %}

- Go

    [Клиентская библиотека Prometheus для Go](https://github.com/prometheus/client_golang)

- Python

    [Клиентская библиотека Prometheus для Python](https://github.com/prometheus/client_python)

- PHP

    [Клиентская библиотека Prometheus для PHP](https://github.com/promphp/prometheus_client_php)

- Java

    [Клиентская библиотека Prometheus для Java](https://github.com/prometheus/client_java)

- Node.js

    [Клиентская библиотека Prometheus для Node.js](https://github.com/siimon/prom-client)

- C++

    [Клиентская библиотека Prometheus для C++](https://github.com/jupp0r/prometheus-cpp)

{% endlist %}

В разделе [{#T}](./quickstart/pull_prometheus.md) приведен пример настройки поставки метрики python-приложения.

## Как мне поставлять в {{ monitoring-full-name }} метрики сторонних приложений? { #3rd-party-app }

Для поставки в {{ monitoring-full-name }} метрик сторонних приложений используется вход `prometheus_pull`, который периодически опрашивает напрямую стороннее приложение (если оно поддерживает метрики в формате Prometheus) или специальное приложение-экспортер, реализующее интеграцию с Prometheus.

В разделе [{#T}](quickstart/haproxy.md) приведен пример настройки поставки метрик HAProxy.

## Как исправить ошибку DERIV_AND_TS? { #DERIV_AND_TS }

Пример сообщения об ошибке:

```
response code [400], description [400 Bad request], headers [Server=nginx/1.17.7;Date=Fri, 18 Dec 2020 11:44:07 GMT;Content-Type=application/json;charset=UTF-8;Content-Length=55;Connection=keep-alive;X-Solomon-Version=9;X-Solomon-Host=solomon-gateway-00.svc.cloud.yandex.net;Vary=Origin;Vary=Access-Control-Request-Method;Vary=Access-Control-Request-Headers], response data [{"writtenMetricsCount":0,"errorMessage":"DERIV_AND_TS"}]
```

## Как исправить ошибку meta key [_metric_name_label] not found? { #name-not-found }

Пример сообщения об ошибке:

```
yaml-cpp, line 5, column 9: can't start session, status [Error], error [(yexception) logbroker/unified_agent/interface/core.cpp:99: meta key [_metric_name_label] not found]
```
