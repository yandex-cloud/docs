---
title: "Yandex Monitoring. Ответы на вопросы"
description: "Как мне поставлять в Yandex Monitoring метрики своего приложения? Как мне поставлять в Yandex Monitoring метрики сторонних приложений? Ответы на эти и другие вопросы в данной статье."

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Общие вопросы

{% include [qa-logs.md](../../_includes/qa-logs.md) %}

## Вопросы связанные со сбором метрик {#data-collection}

### Как мне поставлять в {{ monitoring-full-name }} метрики своего приложения? { #1st-party-app }

{{unified-agent-full-name}} поддерживает сбор метрик в формате {{ prometheus-name }} и конвертацию метрик в формат {{ monitoring-full-name }}. Таким образом, при помощи {{unified-agent-short-name}} можно собирать метрики любых приложений, предоставляющих метрики в формате {{ prometheus-name }}.

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

В разделе [{#T}](../operations/unified-agent/pull_prometheus.md) приведен пример настройки поставки метрики python-приложения.

### Как мне поставлять в {{ monitoring-full-name }} метрики сторонних приложений? { #3rd-party-app }

Для поставки в {{ monitoring-full-name }} метрик сторонних приложений используется {{unified-agent-full-name}}, в котором сконфигурирован вход `metrics_pull`, который периодически опрашивает напрямую стороннее приложение (если оно поддерживает метрики в формате {{ prometheus-name }}) или специальное приложение-экспортер, реализующее интеграцию с {{ prometheus-name }}.

В разделе [{#T}](../operations/unified-agent/haproxy.md) приведен пример настройки поставки метрик HAProxy.
