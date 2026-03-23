# Logging Stack

{{ stackland-name }} позволяет собирать логи кластера с помощью опенсорс-инструментов:

* [Loki](https://grafana.com/oss/loki/) — средство централизованного сбора и хранения логов.
* [Fluent Bit](https://fluentbit.io/) — средство поставки логов.
* [Grafana](https://grafana.com) — интерфейс для просмотра логов.

Вы можете управлять хранением и поставкой логов с помощью значений параметров [кастомного ресурса](#configuration) `LoggingConfig`.

## Просмотр логов в Grafana {#grafana}

Интерфейс Grafana доступен по адресу `https://grafana.sys.<домен кластера>`. Для входа используйте кнопку **Sign in with Stackland Auth**.

К интерфейсу по умолчанию подключены Loki и Fluent Bit. Чтобы начать просмотр логов в Grafana, создайте запрос на сбор логов в разделе **Explore**.

## Хранение логов {#storage}

В кастомном ресурсе можно [выбрать средство сбора логов, задать период хранения и подключить постоянный том для хранения](#storage-settings). Каждое средство сбора логов можно настроить дополнительно.

## Отправка логов {#shipment}

В кастомном ресурсе можно задать [интервал отправки логов и размер буфера](#shipment-settings). По умолчанию включена интеграция Fluent Bit с Loki в параметре `defaultOutput`.

## Конфигурация {#configuration}

Пример:

{% include notitle [YAML-файл](../../_includes/yamls/components/loggingconfig.md) %}

### Параметры хранения {#storage-settings}

Пример:

```yaml
logStorage:
  backend: loki
  replicas: 1
  resources:
    requests:
      memory: 512Mi
      cpu: 200m
    limits:
      memory: 1Gi
      cpu: 500m
  storage:
    enabled: true
    storageClass: ssd
    size: 50Gi
  retentionPeriod: 7d
  loki:
    limitsConfig:
      maxLabelNamesPerSeries: 20
    compactor:
      retentionEnabled: true
      retentionDeleteDelay: 24h
```

* `backend` — указывает тип используемого хранилища логов.
* `replicas` — задает количество реплик пода.
* `resources` — ограничивает ресурсы (CPU и память) для пода.
* `storage` — определяет настройки постоянного тома для хранения логов.
* `retentionPeriod` — задает период хранения логов.
* `loki` — определяет расширенные настройки для Loki.

### Параметры поставки логов {#shipment-settings}

Пример:

```yaml
logSender:
  backend: fluent-bit
  flushInterval: 5
  bufferSize: 64MB
  resources:
    requests:
      memory: 128Mi
      cpu: 50m
    limits:
      memory: 256Mi
      cpu: 100m
  fluentBit:
    logLevel: info
    tenantId: prod-team
    defaultOutput: true
```

* `backend` — указывает тип используемого агента для поставки логов.
* `flushInterval` — задает интервал в секундах, с которым Fluent Bit отправляет собранные логи в хранилище (например, Loki).
* `bufferSize` — определяет максимальный объем памяти, выделяемый Fluent Bit для буферизации логов перед отправкой.
* `resources` — ограничивает ресурсы (CPU и память) для пода.
* `fluentBit` — определяет расширенные настройки для Fluent Bit.
