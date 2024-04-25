---
title: "Как читать метрики через Remote API"
description: "Следуя данной инструкции, вы сможете прочитать метрики через Remote API."
---

# Чтение метрик через Remote API

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хранятся данные.
1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) с ролью `{{ roles-monitoring-viewer }}` на выбранный каталог.
1. [Создайте API-ключ](../../../../iam/operations/api-key/create.md) для сервисного аккаунта.
1. В [конфигурацию Prometheus](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_read), в секцию `remote_read`, добавьте эндпоинт (`url`):
   ```yaml
   ...
   remote_read:
     ...
     - url: '<URL>' # предоставляется по запросу
       bearer_token: '<API-ключ>'
       # Или через файл (рекомендуется):
       # bearer_token_file: '<имя_файла_с_API-ключом>'

       # Рекомендуется добавить пользовательский заголовок X-Lookback-Delta.
       # Если вы не меняли параметр lookback-delta в конфигурации
       # вашего экземпляра Prometheus, укажите значение по умолчанию 5m.
       # Эта информация необходима для оптимизированного прореживания.
       headers:
         X-Lookback-Delta: 5m

       # По умолчанию данные запрашиваются только для тех временных диапазонов,
       # которые отсутствуют в локальном хранилище Prometheus (старше чем Storage retention).
       # Если вы хотите запрашивать данные всегда, что имеет смысл, если чтение и запись
       # выполняются с разных экземпляров Prometheus, включите следующую опцию:
       # [ read_recent: true ]

       # Если вы хотите читать только часть метрик через Remote API, укажите их метки:
       # required_matchers:
       # [ <label_name>: <label_value> ... ]
   ```
1. Перезапустите {{ prometheus-name }} или перезагрузите конфигурацию. 

## Примеры ошибок {#errors}

| Код ошибки | Текст ошибки | Описание |
|----|----|----|
| `404` | Эндпоинт не найден. Убедитесь, что в конфигурации указан правильный `url`. | `remote_read: remote server https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/read returned`<br/>`HTTP status 404 Not Found: {"status":"error","errorType":"not_found","error":"workspace not found: monb1piptmdo********"}` |
| `401` | Сервисный аккаунт не найден. Убедитесь, что в конфигурации указан правильный [API-ключ](../../../../iam/concepts/authorization/api-key.md). | `remote_read: remote server https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/read returned`<br/>`HTTP status 401 Unauthorized: {"status":"error","errorType":"","error":"cannot authenticate by either token or api-key, cause: UNAUTHENTICATED: The token is invalid"}` |
| `403` | Отсутствуют права на чтение. Убедитесь, что сервисный аккаунт имеет роль `{{ roles-monitoring-viewer }}` на выбранный каталог. | `remote_read: remote server https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/read returned`<br/>`HTTP status 403 Forbidden: {"status":"error","errorType":"","error":"PERMISSION_DENIED: Permission denied"}` |
| `429` | Превышена квота [Количество запросов в секунду на чтение через Remote Read API](../index.md#limits). | `remote_read: remote server https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/read returned`<br/>`HTTP status 429 Too Many Requests: {"status":"error","errorType":"execution","error":"too many read requests: monb1piptmdo********"}` |
| `400` | Запрос вернул слишком много линий. Попробуйте уточнить запрос. | `remote_read: remote server https://monitoring.{{ api-host }}/prometheus/workspaces/monb1piptmdo********/api/v1/read returned`<br/>`HTTP status 400 Bad Request: {"status":"error","errorType":"bad_data","error":"Too many metrics are loaded by selectors {job=='grafana'}, expected not more than: 10000"}` |

## Метрики {{ prometheus-name }} {#metrics}

| Имя метрики | Единицы измерения | Пояснения |
|----|----|----|
`prometheus_remote_storage_read_queries_total` | Вызовы | Общее количество запросов на чтение.
`prometheus_remote_storage_read_request_duration_seconds` | Секунды | Гистограмма времени выполнения запросов на чтение.

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
