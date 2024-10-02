---
title: "Как записать метрики через Remote API"
description: "Следуя данной инструкции, вы сможете записать метрики через Remote API."
---

# Запись метрик через Remote API

Чтобы настроить запись метрик через Remote API, используя Prometheus в качестве агента для сбора метрик:

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите хранить данные.
1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) с ролью `{{ roles-monitoring-editor }}` на выбранный каталог.
1. [Создайте API-ключ](../../../../iam/operations/api-key/create.md) для сервисного аккаунта.
1. В [конфигурацию Prometheus](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write), в секцию `remote_write`, добавьте эндпоинт (`url`):
   ```yaml
   ...
   remote_write:
     ...
     - url: 'https://{{ api-host-monitoring-1 }}/prometheus/workspaces/<Идентификатор_воркспейса>/api/v1/write'
       bearer_token_file: '<имя_файла_с_API-ключом>'
       # Или сам ключ (не рекомендуется):
       # bearer_token: '<API-ключ>'
       queue_config:
           max_samples_per_send: 2000 # 10000 в случае использования vmagent
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

| Код ошибки | Описание | Пример лога |
|----|----|----|
| `404` | Эндпоинт не найден. Убедитесь, что в конфигурации указан правильный `url`. | `ts=2024-04-04T09:59:15.973Z caller=dedupe.go:112 component=remote level=error remote_name=366d8d`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=105 exemplarCount=0 err="server returned HTTP status 404 Not Found:`<br/>`{\"status\":\"error\",\"errorType\":\"not_found\",\"error\":\"workspace not found: monb1piptmdo********\"}` |
| `401` | Сервисный аккаунт не найден. Убедитесь, что в конфигурации указан правильный [API-ключ](../../../../iam/concepts/authorization/api-key.md). | `ts=2024-04-12T12:55:10.124Z caller=dedupe.go:112 component=remote level=error remote_name=6b764c`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=1 exemplarCount=0 err="server returned HTTP status 401 Unauthorized:`<br/>`{\"error\":\"cannot authenticate by either token or api-key, cause: UNAUTHENTICATED: The token is invalid\",\"errorType\":\"\",\"status\":\"error\"}"` |
| `403` | Отсутствуют права на запись. Убедитесь, что сервисный аккаунт имеет роль `{{ roles-monitoring-editor }}` на выбранный каталог.| `ts=2024-04-05T17:10:47.706Z caller=dedupe.go:112 component=remote level=error remote_name=a9c26f`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=205 exemplarCount=0 err="server returned HTTP status 403 Forbidden:`<br/>`{\"error\":\"PERMISSION_DENIED: Permission denied\",\"errorType\":\"\",\"status\":\"error\"}"` |
| `413` | Превышена квота [Количество уникальных метрик](../index.md#limits). | `ts=2024-04-05T16:48:16.002Z caller=dedupe.go:112 component=remote level=error remote_name=37b6df`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=205 exemplarCount=0 err="server returned HTTP status 413 Request Entity Too Large:`<br/>`{\"status\":\"error\",\"errorType\":\"execution\",\"error\":\"more than 1000000 metrics in shard\"}`| 
| `413` | Превышена квота [Количество метрик в одном запросе на запись](../index.md#limits). | `ts=2024-04-05T17:39:29.102Z caller=dedupe.go:112 component=remote level=error remote_name=37b6df`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=10001 exemplarCount=0 err="server returned HTTP status 413 Request Entity Too Large:`<br/>`{\"status\":\"error\",\"errorType\":\"execution\",\"error\":\"more than 10000 metrics from one URL\"}` |
| `429` | Превышена квота [Максимальная скорость записи в формате Remote Write](../index.md#limits). Если включена опция `retry_on_http_429`, повторная отправка данных произойдет автоматически, а нагрузка распределится по времени. Если ошибка наблюдается продолжительное время, обратитесь в [техническую поддержку]({{ link-console-support }}). | `ts=2024-04-06T14:31:01.113Z caller=dedupe.go:112 component=remote level=error remote_name=37b6df`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="Failed to send batch, retrying" count=205 exemplarCount=0 err="server returned HTTP status 429 Too Many Requests:`<br/>`{\"status\":\"error\",\"errorType\":\"execution\",\"error\":\"too many requests (bytes/sec)\"}` |
| `400` | Невалидный формат данных Remote Write. | `ts=2024-04-07T13:42:10.543Z caller=dedupe.go:112 component=remote level=error remote_name=37b6df`<br/>`url=https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/write`<br/>`msg="non-recoverable error" count=499 exemplarCount=0 err="server returned HTTP status 400 Bad Request:`<br/>`{\"status\":\"error\",\"errorType\":\"bad_data\",\"error\":\"unrecognized remote write format (some headers are missing?): monb1piptmdo********\"}` |

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

