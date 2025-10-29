---
title: '{{ managed-prometheus-full-name }}'
description: '{{ managed-prometheus-full-name }} — система мониторинга, совместимая с {{ prometheus-name }}. С помощью нее можно собирать, хранить и читать метрики из контейнеров, приложений и инфраструктуры. Система использует модель данных {{ prometheus-name }} и язык запросов {{ promql-name }}, что позволяет работать с уже существующими дашбордами в {{ grafana-name }}.'
sourcePath: ru/monitoring_includes/operations/prometheus/index.md
---

# Обзор {{ managed-prometheus-full-name }}


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvgrffiwvx5522amjv?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://youtu.be/EEI4LseR0tw).



{{ managed-prometheus-full-name }} — система мониторинга, совместимая с [{{ prometheus-name }}](https://prometheus.io/docs/introduction/overview/). С помощью нее можно собирать, хранить и читать метрики из контейнеров, приложений и инфраструктуры. Система использует модель данных {{ prometheus-name }} и язык запросов [{{ promql-name }}](https://prometheus.io/docs/prometheus/latest/querying/basics/), что позволяет работать с уже существующими дашбордами в [{{ grafana-name }}](https://grafana.com/grafana/).

{{ prometheus-name }} имеет много механизмов для сбора метрик, включая [библиотеки](https://prometheus.io/docs/instrumenting/clientlibs/) для популярных языков программирования и поддержку [экспорта метрик](https://prometheus.io/docs/instrumenting/exporters/) из сторонних систем, например баз данных, очередей сообщений и т.п. {{ managed-prometheus-name }} позволяет использовать наработки Open Source-сообщества {{ prometheus-name }} и при этом обеспечивает высокую масштабируемость, доступность и безопасность без необходимости самостоятельно разворачивать кластеры {{ prometheus-name }} и управлять внутренней инфраструктурой мониторинга. Чтобы начать использовать {{ managed-prometheus-name }}, достаточно установить агенты, которые поддерживают протокол записи метрик [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write).

{{ managed-prometheus-name }} построена на основе системы, которую Яндекс использует для мониторинга внутренних сервисов. Система автоматически масштабирует запись, хранение и чтение метрик в зависимости от рабочей нагрузки. Высокая доступность обеспечивается благодаря тому, что данные мониторинга реплицируются в двух зонах доступности.

## Начало работы {#access}

1. Откройте [главную страницу сервиса]({{ link-monitoring }}) {{ monitoring-full-name }} и выберите каталог.
1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.prometheus.action_create }}**.
1. На открывшейся странице появятся ссылки на эндпоинты.
   
   Используйте эти эндпоинты, чтобы настроить [запись](ingestion/index.md) и [чтение](querying/index.md) метрик из воркспейса в формате {{ prometheus-name }}.

## Сравнение возможностей {#features}

{% note info %}

Функциональность системы будет расширяться в будущих релизах.

{% endnote %}


Возможность | {{ prometheus-name }} | {{ managed-prometheus-full-name }}
--- | --- | ---
Сбор метрик | [Scrape](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config), [Pushgateway](https://prometheus.io/docs/instrumenting/pushing/), [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) | Поддерживается запись метрик по протоколу [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write). Для отправки метрик с виртуальной машины в {{ managed-prometheus-full-name }} можно использовать [{{ unified-agent-short-name }} от {{ yandex-cloud }}](ingestion/prometheus-agent.md). Также подходит любой совместимый агент сбора, в том числе сам {{ prometheus-name }}.
Долгосрочное хранение метрик | Не предназначен для долгосрочного хранения метрик. Полагается на [сторонние решения](https://prometheus.io/docs/prometheus/latest/storage/#existing-integrations). | Поддерживается долгосрочное хранение метрик. При использовании [прореживания](../../concepts/decimation.md) возможно неограниченное по времени хранение.
Чтение метрик | Поддерживается чтение данных и метаданных через [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/). | Поддерживается чтение данных и метаданных через [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/) с некоторыми [ограничениями](querying/grafana.md#restrictions).
Визуализация | [Expression browser](https://prometheus.io/docs/visualization/browser/), [Grafana](https://prometheus.io/docs/visualization/grafana/) | Графики и дашборды в [{{ monitoring-name }}](querying/monitoring.md). Поддерживается [{{ prometheus-name }} data source](https://grafana.com/docs/grafana/latest/datasources/prometheus/).
Агрегация | Поддерживается агрегация с помощью правил записи ([recording rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/)). | Поддерживаются существующие файлы с [правилами записи](recording-rules.md) (`recording rules`) в формате YAML. Загрузка файлов и управление ими доступны через пользовательский интерфейс {{ monitoring-name }} и API.
Алертинг | Поддерживается с помощью правил алертинга ([alerting rules](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/)). | Поддерживаются существующие файлы с [правилами алертинга](alerting-rules.md) (`alerting rules`) в формате YAML. Загрузка файлов и управление ими доступны через пользовательский интерфейс {{ monitoring-name }} и API.
Интеграции | Клиентские [библиотеки](https://prometheus.io/docs/instrumenting/clientlibs/) и [экспортеры](https://prometheus.io/docs/instrumenting/exporters/). | Можно использовать существующие библиотеки и экспортеры.

## Текущие ограничения {#restrictions}

* Значение `NaN` не поддерживается и воспринимается как отсутствие точки.
* Значения `+Inf`/`-Inf` могут обрабатываться некорректно.
* Для правил алертинга (`alerting rules`) поддерживаются только каналы [email](https://prometheus.io/docs/alerting/latest/configuration/#email_config) и [Telegram](https://prometheus.io/docs/alerting/latest/configuration/#telegram_config), не поддерживается [динамическая маршрутизация](https://prometheus.io/docs/alerting/latest/configuration/#route).
* Не поддерживаются `staleness markers`, `exemplars` и `native histograms`.

## Квоты и лимиты {#limits}

В {{ managed-prometheus-full-name }} действуют следующие ограничения:

{% include [quotes-limits-def.md](../../../_includes/quotes-limits-def.md) %}

Если вам необходимо больше ресурсов, напишите в службу технической поддержки по электронной почте [{{ link-support-mail }}](mailto:{{ link-support-mail }}) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

### Квоты для одного эндпоинта {#quotas-per-endpoint}

Вид ограничения | Значение
----- | -----
Максимальная скорость записи в формате [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write) | 1000 запросов/с и 80 МБ/с
Количество метрик в одном запросе на запись | 10000
Количество запросов в секунду на чтение через [Remote Read API](https://prometheus.io/docs/prometheus/latest/querying/remote_read_api) | 200
Количество запросов в секунду на чтение через [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/) | 200
Количество уникальных метрик | 20 000 000
Максимальное время хранения [устаревших метрик](../../concepts/ttl.md) ^1^ | 60 дней

^1^ Если новые значения не поступают для метрики в течение 60 дней, она считается устаревшей и удаляется. Если новые значения поступают, время хранения метрики не ограничено.

На вкладке **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** > Воркспейс > **Общая информация** вы можете:

* посмотреть количество записанных метрик;
* перейти на страницу с сервисными [дашбордами](../../concepts/visualization/dashboard) и посмотреть количество запросов, ошибок и HTTP-статусов в секунду для разных эндпоинтов.

### Лимиты для одного эндпоинта {#limits-per-endpoint}

Вид ограничения | Значение
----- | -----
Количество уникальных меток для одной метрики | 29

Данные передаются в виде временного ряда, который определяется метрикой и набором меток. В {{ managed-prometheus-name }} одна метрика может содержать до 29 уникальных меток (включая `name`), то есть до 28 дополнительных. 

Ограничения на количество значений меток нет, оно определяется общей [квотой](../../concepts/limits.md) {{ monitoring-name }} — количеством метрик одного сервиса в каталоге. Каждая новая комбинация значений — это одна новая метрика. Например, `http_server_requests_seconds_count{uri="…"}` может иметь много значений `uri`, каждое значение создает новый ряд и расходует квоту.

При исчерпании квоты попытка записи в новый ряд завершается ошибкой. Записанные данные при этом не удаляются. Квота действует на количество временных рядов, но не на количество данных в них. Данные удаляются только при отсутствии записей в течение [TTL](../../concepts/ttl.md), поэтому новые временные ряды можно будет создавать после освобождения или увеличения квоты.

{% include [trademark](../../../_includes/monitoring/trademark.md) %}
