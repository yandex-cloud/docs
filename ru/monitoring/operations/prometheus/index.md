---
title: "{{managed-prometheus-full-name}}"
description: "{{ managed-prometheus-full-name }} — система мониторинга, совместимая с {{ prometheus-name }}. С помощью нее можно собирать, хранить и читать метрики из контейнеров, приложений и инфраструктуры. Система использует модель данных {{ prometheus-name }} и язык запросов {{ promql-name }}, что позволяет работать с уже существующими дашбордами в {{ grafana-name }}."
---

# {{managed-prometheus-full-name}}

{% include [note-preview](../../../_includes/monitoring/prometheus-preview.md) %}

{{ managed-prometheus-full-name }} — система мониторинга, совместимая с [{{ prometheus-name }}](https://prometheus.io/docs/introduction/overview/). С помощью нее можно собирать, хранить и читать метрики из контейнеров, приложений и инфраструктуры. Система использует модель данных {{ prometheus-name }} и язык запросов [{{ promql-name }}](https://prometheus.io/docs/prometheus/latest/querying/basics/), что позволяет работать с уже существующими дашбордами в [{{ grafana-name }}](https://grafana.com/grafana/).

{{ prometheus-name }} имеет много механизмов для сбора метрик, включая [библиотеки](https://prometheus.io/docs/instrumenting/clientlibs/) для популярных языков программирования и поддержку [экспорта метрик](https://prometheus.io/docs/instrumenting/exporters/) из сторонних систем, например баз данных, очередей сообщений и т.п. {{ managed-prometheus-name }} позволяет использовать наработки Open Source-сообщества {{ prometheus-name }} и при этом обеспечивает высокую масштабируемость, доступность и безопасность без необходимости самостоятельно разворачивать кластеры {{ prometheus-name }} и управлять внутренней инфраструктурой мониторинга. Чтобы начать использовать {{ managed-prometheus-name }}, достаточно установить агенты, которые поддерживают протокол записи метрик [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write).

{{ managed-prometheus-name }} построена на основе системы, которую Яндекс использует для мониторинга внутренних сервисов. Система автоматически масштабирует запись, хранение и чтение метрик в зависимости от рабочей нагрузки. Высокая доступность обеспечивается благодаря тому, что данные мониторинга реплицируются в двух зонах доступности.

## Получить доступ {#access}

Чтобы подключить {{ managed-prometheus-name }} в текущем каталоге:

1. Откройте [главную страницу сервиса]({{ link-monitoring }}) {{ monitoring-full-name }}.
1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
1. Заполните форму и нажмите **{{ ui-key.yacloud_monitoring.prometheus.form.submit-button.text }}**.
1. Дождитесь, пока {{ yandex-cloud }} обработает заявку.
1. Когда заявка будет одобрена, на странице появятся ссылки на эндпоинты, которые необходимо использовать для текущего каталога.

Чтобы подключить [запись](ingestion/index.md) и [чтение](querying/index.md) метрик в формате {{ prometheus-name }}, воспользуйтесь соответствующими инструкциями.

## Текущие возможности {#features}

{% note info %}

Функциональность системы будет расширяться в будущих релизах.

{% endnote %}


Возможность | {{ prometheus-name }} | {{ managed-prometheus-full-name }}
--- | --- | ---
Сбор метрик | [Scrape](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config), [Pushgateway](https://prometheus.io/docs/instrumenting/pushing/), [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) | Поддерживается запись метрик по протоколу [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write). Для отправки метрик в {{ managed-prometheus-full-name }} подходит любой совместимый агент сбора, в том числе сам {{ prometheus-name }}.
Долгосрочное хранение метрик | Не предназначен для долгосрочного хранения метрик. Полагается на [сторонние решения](https://prometheus.io/docs/prometheus/latest/storage/#existing-integrations). | Поддерживается долгосрочное хранение метрик. При использовании [прореживания](../../concepts/decimation.md) возможно неограниченное по времени хранение.
Чтение метрик | Поддерживается чтение данных и метаданных через [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/). | Поддерживается чтение данных и метаданных через [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/) с некоторыми [ограничениями](querying/grafana.md#restrictions).
Визуализация | [Expression browser](https://prometheus.io/docs/visualization/browser/), [Grafana](https://prometheus.io/docs/visualization/grafana/) | Поддерживается [{{ prometheus-name }} data source](https://grafana.com/docs/grafana/latest/datasources/prometheus/).
Агрегация | Поддерживается агрегация с помощью [recording rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/). | Будет реализовано в будущих версиях. В данный момент recording rules можно вычислять по краткосрочным данным на локальных экземплярах {{ prometheus-name }}.
Алертинг | Поддерживается с помощью [alerting rules](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/). | Будет реализовано в будущих версиях. В данный момент alerting rules можно вычислять по краткосрочным данным на локальных экземплярах {{ prometheus-name }}.
Интеграции | Клиентские [библиотеки](https://prometheus.io/docs/instrumenting/clientlibs/) и [экспортеры](https://prometheus.io/docs/instrumenting/exporters/). | Можно использовать существующие библиотеки и экспортеры.


## Текущие ограничения {#restrictions}

* Значение `NaN` не поддерживается и воспринимается как отсутствие точки.
* Значения `+Inf`/`-Inf` могут обрабатываться некорректно.
* Не поддерживаются `recording rules` и `alerting rules`.
* Не поддерживаются `staleness markers`, `exemplars` и `native histograms`.

## Лимиты для одного эндпоинта {#limits-per-endpoint}

Лимиты, указанные ниже, не являются техническими ограничениями системы и могут быть увеличены по запросу в [техническую поддержку]({{ link-console-support }}).

* 350 запросов/с и 5 МБ/с на запись в формате [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write).
* 10000 метрик в одном запросе на запись.
* 100 запросов в секунду на чтение через [Remote Read API](https://prometheus.io/docs/prometheus/latest/querying/remote_read_api).
* 100 запросов в секунду на чтение через [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/).
* 1 миллион уникальных метрик.
* 29 уникальных меток для одной метрики.
* [Устаревшие метрики](../../concepts/ttl.md) удаляются через 60 дней.

{% include [trademark](../../../_includes/monitoring/trademark.md) %}
