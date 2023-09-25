---
title: "Как записать метрики через Remote API"
description: "Следуя данной инструкции, вы сможете записать метрики через Remote API."
---

# Запись метрик через Remote API

{% include [note-preview](../../../../_includes/monitoring/prometheus-preview.md) %}

Чтобы настроить запись метрик через Remote API, используя Prometheus в качестве агента для сбора метрик:

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите хранить данные.
1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) с ролью `{{ roles-monitoring-editor }}` на выбранный каталог.
1. [Создайте API-ключ](../../../../iam/operations/api-key/create.md) для сервисного аккаунта.
1. В [конфигурацию Prometheus](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write), в секцию `remote_write`, добавьте эндпоинт (`url`):
   ```yaml
   ...
   remote_write:
     ...
     - url: '<url>' # предоставляется по запросу
       bearer_token: '<api_key>'
       # Или через файл (рекомендуется):
       # bearer_token_file: '<имя файла с api_key>'
       queue_config:
           max_samples_per_send: 1000
           min_backoff: 100ms
           max_backoff: 15s
           # для Prometheus 2.26 и новее
           # retry_on_http_429: true
       metadata_config:
           send: false
   ```
1. Перезапустите {{ prometheus-name }} или перезагрузите конфигурацию.
1. Проверьте, что в логах {{ prometheus-name }} нет ошибок, которые связаны с заданным эндпоинтом.

## Примеры ошибок {#errors}

* Не найден эндпоинт
  >```ts=2022-11-09T20:55:43.329Z caller=dedupe.go:112 component=remote level=error remote_name=1d1b77 url=https://monitoring.{{ api-host }}/workspaces/monb1piptmdo916sceer/prometheus/api/v1/write msg="non-recoverable error" count=499 exemplarCount=0 err="server returned HTTP status 404 Not Found: {\"type\":\"NOT_FOUND\",\"message\":\"workspace not found: monb1piptmdo916sceer\",\"code\":404}"```
* Превышен лимит запросов на запись
  >```ts=2022-10-27T20:11:26.806Z caller=dedupe.go:112 component=remote level=error remote_name=f0fd14 url=https://monitoring.{{ api-host }}/workspaces/monb1piptmdo916sceer/prometheus/api/v1/write msg="non-recoverable error" count=500 exemplarCount=0 err="server returned HTTP status 429 Too Many Requests: {\"type\":\"RESOURCE_EXHAUSTED\",\"message\":\"too many write requests (bytes/sec): monb1piptmdo916sceer\",\"code\":429}"```
* Сервис не доступен
  >```ts=2022-11-07T11:14:42.754Z caller=dedupe.go:112 component=remote level=warn remote_name=db8f73 url=https://monitoring.{{ api-host }}/workspaces/monb1piptmdo916sceer/prometheus/api/v1/write msg="Failed to send batch, retrying" err="server returned HTTP status 503 Service Unavailable: {\"type\":\"UNAVAILABLE\",\"message\":\"Service Unavailable\",\"code\":503}"```

## Метрики {{ prometheus-name }} {#metrics}

| Имя метрики | Единицы измерения | Пояснения |
|----|----|----|
`prometheus_remote_storage_sent_batch_duration_seconds` | Секунды | Гистограмма времени выполнения запроса на запись.
`prometheus_remote_storage_bytes_total`  | Байты | Общее количество байтов данных (не метаданных), отправленных в удаленное хранилище после сжатия.
`prometheus_remote_storage_enqueue_retries_total`  | Штуки | Общее количество неудачных попыток добавления точки в очередь отправки.
`prometheus_remote_storage_max_samples_per_send`  | Штуки | Максимальное количество точек, отправленных в одном запросе на запись.
`prometheus_remote_storage_samples_dropped_total`  | Штуки | Общее количество точек, прочитанных из WAL, но не отправленных в удаленное хранилище.
`prometheus_remote_storage_samples_failed_total`  | Штуки | Общее количество точек, которые не удалось отправить в удаленное хранилище, неустранимые ошибки.
`prometheus_remote_storage_samples_pending`  | Штуки | Количество точек, ожидающих отправки в удаленное хранилище.
`prometheus_remote_storage_samples_retried_total`  | Штуки | Общее количество точек, которые не удалось отправить в удаленное хранилище, но для которых была предпринята повторная попытка, поскольку ошибка отправки является устранимой.
`prometheus_remote_storage_samples_total`  | Штуки | Общее количество точек, отправленных в удаленное хранилище.

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}

