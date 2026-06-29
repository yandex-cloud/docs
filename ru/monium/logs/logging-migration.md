# Миграция с {{ cloud-logging-name }} на {{ monium-name }}

{% include [deprecation-warning](../../_includes/logging/deprecation-warning.md) %}

## Сравнение {{ cloud-logging-name }} и {{ monium-name }} {#comparison}

{% include [migration-comparison](../../_pricing_examples/monium/migration-comparison.md) %}

## Тестирование {{ monium-name }} без миграции {#preview}

Логи из {{ cloud-logging-name }} уже доступны в {{ monium-name }}. Откройте их в [консоли управления]({{ link-console-main }}) одним из способов: 

* В сервисе {{ cloud-logging-name }} при просмотре логов нажмите кнопку **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}**.
* Откройте ссылку:

  ```
  {{ link-monium }}/projects/folder__<идентификатор_каталога>/logs
  ```

Для каждого каталога создан проект с идентификатором вида `folder__<идентификатор_каталога>`, логи каждой лог-группы доступны по ее имени.

Для поиска логов укажите запрос:

```
{project="folder__<идентификатор_каталога>", cluster="default", service="<имя_лог_группы>"}
```

## Порядок миграции {#migration-steps}

1. [Убедитесь](#preview), что данные доступны в {{ monium-name }} в проекте `folder__<идентификатор_каталога>`.

1. Обновите агент поставки данных (Unified Agent, Fluent Bit 4.0) или используйте [OTel Collector](../collector/opentelemetry.md) и [настройте поставку в OTel-формате](#agent-setup).

1. Укажите новый эндпоинт: `{{ api-host-monium }}:443`. Иначе логи продолжат поступать через {{ cloud-logging-name }} и тарифицироваться по его ценам.

1. Убедитесь, что логи поступают напрямую в {{ monium-name }}, а не через {{ cloud-logging-name }}.

   Для проверки [посмотрите детализацию использования сервисов](../../billing/operations/check-charges.md#products) по продуктам в {{ billing-name }}. После миграции должно появиться потребление для логов в {{ monium-name }}. Потребление в сервисе {{ cloud-logging-name }} должно снизиться или прекратиться.

   После миграции логи начнут тарифицироваться по ценам {{ monium-name }} и станут доступны все возможности платформы.

1. (Опционально) Переименуйте проекты, кластеры и сервисы. Можно оставить текущую структуру: `folder__<идентификатор_каталога>` → `default` → `имя лог-группы` или задать собственные имена. Подробнее в разделе [{#T}](../concepts/data-model.md#telemetry-common).

## Настройка агента для поставки в OTel {#agent-setup}

### Unified Agent {#unified-agent}

1. Замените секцию `output` в конфигурационном файле.

   **Было:**

   ```yaml
   channel:
     output:
       plugin: yc_logs
       config:
         url: "{{ logging-endpoint-ingester }}:443"
         log_group_id: "<идентификатор_лог_группы>"
         folder_id: "<идентификатор_каталога>"
         iam:
           cloud_meta:
   ```

   **Стало:**

   ```yaml
   channel:
     output:
       plugin: otel_logs
       config:
         url: "{{ api-host-monium }}:443"
         project: folder__<идентификатор_каталога>
         service: <имя_сервиса>
         iam:
           cloud_meta:
   ```

   Параметр `project` задайте произвольно — в {{ monium-name }} можно [создавать собственные проекты](../collector/project.md). В параметре `service` укажите имя лог-группы, чтобы сохранить структуру данных.

1. Чтобы указать кластер, добавьте параметр `cluster: <имя_кластера>`. По умолчанию используется значение `default`.

### Fluent Bit {#fluent-bit}

Вы можете продолжить использование Fluent Bit или настроить поставку через [OTel Collector](../collector/opentelemetry.md).

1. Проверьте, что установленная версия [Fluent Bit](https://fluentbit.io/) 4.0 или выше:

   ```bash
   apt show fluent-bit
   ```

1. Убедитесь, что конфигурационный файл в формате YAML. Поддержка классического INI-формата заканчивается в конце 2026 года.

1. Замените секцию `outputs`.

   **Было** (плагин `yc-logging`):

   ```yaml
   pipeline:
     outputs:
       - name: yc-logging
         ...
   ```

   **Стало** (плагин `opentelemetry`):

   ```yaml
   pipeline:
     outputs:
       - name: opentelemetry
         host: {{ api-host-monium }}
         port: 443
         logs_uri: /otlp/v1/logs
         tls: on
         tls.verify: off
         header:
           - Authorization Api-Key ${API_KEY}
           - x-monium-project folder__<идентификатор_каталога>
   ```

   Вместо API-ключа можно передавать IAM-токен: `Authorization Bearer ${IAM_TOKEN}`.

1. Если входной плагин не использует OpenTelemetry или в сообщениях не задан параметр `service`, добавьте процессор `opentelemetry_envelope` с атрибутами ресурса:

   ```yaml
   pipeline:
     inputs:
       - name: <входной_плагин>
         processors:
           logs:
             - name: opentelemetry_envelope
             - name: content_modifier
               context: otel_resource_attributes
               action: upsert
               key: service.name
               value: <имя_лог_группы>
             - name: content_modifier
               context: otel_resource_attributes
               action: upsert
               key: cluster
               value: default
   ```

   В параметре `service.name` укажите имя лог-группы, чтобы сохранить структуру данных. Параметр `cluster` необязателен, значение по умолчанию — `default`.

## Чтение логов по API {#api-reading}

[Чтение через API {{ cloud-logging-name }}](../../logging/api-ref/grpc/LogReading/read.md) будет поддерживаться до 1 марта 2027 года, если сохранена структура `folder__<идентификатор_каталога>` → `default` → `имя лог-группы`. Данные доступны в пределах срока хранения — 31 день.

Чтение данных через API {{ monium-name }} и документация к нему станут доступны в июле 2026 года. Переведите запросы на чтение на новый API до окончания поддержки старого API.