# Чтение метрик через Remote API

{% include [note-preview](../../../../_includes/monitoring/prometheus-preview.md) %}

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хранятся данные.
1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) с ролью `{{ roles-monitoring-viewer }}` на выбранный каталог.
1. [Создайте API-ключ](../../../../iam/operations/api-key/create.md) для сервисного аккаунта.
1. В [конфигурацию Prometheus](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_read), в секцию `remote_read`, добавьте эндпоинт (`url`):
   ```yaml
   ...
   remote_read:
     ...
     - url: '<url>' # предоставляется по запросу
       bearer_token: '<api_key>'
       # Или через файл (рекомендуется):
       # bearer_token_file: '<имя файла с api_key>'

       # По умолчанию данные запрашиваются только для тех временных диапазонов,
       # которые отсутствуют в локальном хранилище Prometheus (старше чем Storage retention).
       # Если вы хотите запрашивать данные всегда, что имеет смысл, если чтение и запись
       # выполняются с разных экземпляров Prometheus, включите следующую опцию:
       # [ read_recent: true ]

       # Если вы хотите читать только часть метрик через Remote API, укажите их метки:
       # required_matchers:
       # [ <labelname>: <labelvalue> ... ]
   ```
5. Перезапустите {{ prometheus-name }} или перезагрузите конфигурацию.   

## Примеры ошибок {#errors}

* Превышен лимит запросов на чтение
  >```remote_read: remote server https://monitoring.{{ api-host }}/workspaces/monb1piptmdo916sceer/prometheus/api/v1/read returned HTTP status 429 Too Many Requests: {"type":"RESOURCE_EXHAUSTED","message":"too many read requests: monb1piptmdo916sceer","code":429}```

## Метрики {{ prometheus-name }} {#metrics}

| Имя метрики | Единицы измерения | Пояснения |
|----|----|----|
`prometheus_remote_storage_read_queries_total` | Вызовы | Общее количество запросов на чтение.
`prometheus_remote_storage_read_request_duration_seconds` | Секунды | Гистограмма времени выполнения запросов на чтение.

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
