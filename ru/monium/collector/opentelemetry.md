# Передача данных через OpenTelemetry Collector

OpenTelemetry Collector (OTel Collector) — агент для сбора, обработки и экспорта телеметрических данных по стандарту [OpenTelemetry](https://opentelemetry.io/docs/). Вы можете использовать OTel Collector для передачи данных из вашего приложения в {{ monium-name }}.

Преимущества отправки телеметрии через OTel Collector перед отправкой из OpenTelemetry SDK:

* Модификация произвольных атрибутов OpenTelemetry.
* Эффективное сжатие данных с помощью алгоритма zstd, недоступного в SDK.
* Расширенные возможности отладки поставки данных.
* Меньшие накладные расходы для приложения при отправке телеметрии в локальный агент.
* Объединение телеметрии из разных источников в режимах push (агент принимает метрики в формате OpenTelemetry, {{ prometheus-name }} Remote Write, Graphite, Datadog) и pull (агент по расписанию проверяет метрики в формате {{ prometheus-name }}, собирает телеметрию nginx, Docker, Postgres, MongoDB, {{ k8s }} и других приложений).
* Отправка телеметрии одновременно в несколько систем мониторинга.

## Настройка передачи телеметрии из приложения {#configure-metrics-transfer}

1. [Установите](https://opentelemetry.io/docs/collector/installation/) OTel Collector рядом с вашим приложением. Приложение может находиться в инфраструктуре {{ yandex-cloud }}, в облаке другого провайдера или в вашей инфраструктуре.

1. Добавьте [OpenTelemetry SDK](https://opentelemetry.io/docs/languages/) в ваше приложение.

1. Создайте файл конфигурации `otel-collector.yaml`.

    Ниже приведена конфигурация `otel-collector.yaml` для поставки всех видов телеметрии, вы можете удалить ненужное.

    {% include [otel-collector-config](../../_includes/monium/otel-collector-config.md) %}

1. Проверьте конфигурацию `otel-collector.yaml`:

    ```bash
    otelcol validate --config=otel-collector.yaml
    ```

1. Установите переменные окружения:
     
     * `MONIUM_PROJECT` — имя проекта {{ monium-name }}. Имя проекта может быть `folder__<идентификатор_каталога>`, например, `folder__{{ folder-id-example }}`.
     * `MONIUM_API_KEY` — API-ключ.
     * `OTEL_SERVICE_NAME` — имя вашего приложения или сервиса для распределения данных по шардам.

1. Запустите приложение и начните поставлять телеметрию.

1. Посмотрите данные телеметрии в [{{ monium-name }}]({{ link-monium }}).