# Подключение Remote API

Чтобы подключить {{ monitoring-name }} в качестве [удаленного хранилища](https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations) для {{ prometheus-name }}, необходимо настроить в {{ prometheus-name }} [запись](remote-write.md) и [чтение](remote-read.md) метрик через Remote API.

{% include [note-preview](../../../_includes/note-preview.md) %}

## Лимиты для одного эндпоинта {#limits-per-endpoint}

* 200 запросов/c и 3 МБ/с на запись.
* 10000 метрик в одном запросе на запись.
* 25 запросов в секунду на чтение.
* 1 миллион уникальных метрик.
* 29 уникальных меток для одной метрики.
* [Устаревшие метрики](../../concepts/ttl.md) удаляются через 60 дней.

## Ограничения {#restrictions}

* Значение `NaN` не поддерживается и воспринимается как отсутствие точки.
* Значения `+Inf`/`-Inf` могут обрабатываться некорректно.
* Не поддерживаются `staleness markers` и `exemplars`.
