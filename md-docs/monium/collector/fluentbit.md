[Документация Yandex Cloud](../../index.md) > [Monium](../index.md) > [Поставка данных](index.md) > Fluent Bit > Настройка Fluent Bit

# Передача данных через Fluent Bit

Fluent Bit — агент для сбора, обработки и экспорта логов, метрик и трейсов. Вы можете использовать Fluent Bit для передачи телеметрии в Monium по протоколу [OTLP](https://opentelemetry.io/docs/specs/otlp/) (OpenTelemetry Protocol).

Fluent Bit можно использовать в следующих случаях:

* Требуется разбирать логи разных форматов.
* Нужно собирать логи контейнеров в кластере Kubernetes.
* Нужно собирать разные логи с одного хоста: из файлов, Docker, системных журналов или стандартного вывода приложений.
* Нужен легкий агент для приема и отправки метрик и трейсов по OTLP. При передаче метрик учитывайте [ограничения](#metrics-limitations).

В остальных случаях рекомендуется использовать [OTel Collector](opentelemetry.md).

## Требования к версии {#version}

Для работы примеров используйте [Fluent Bit](https://github.com/fluent/fluent-bit/security) версии 4.0 и выше с выходным плагином `opentelemetry`.

## Ограничения при передаче метрик {#metrics-limitations}

Fluent Bit не сохраняет время начала периода метрик (`startTimeUnixNano`). Без него изменение (дельта) метрики обрабатываются некорректно. Не используйте Fluent Bit для передачи метрик, если в приложении настроена переменная `OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="delta"`.

## Настройка передачи телеметрии {#configure}

1. [Установите](https://docs.fluentbit.io/manual/installation/downloads) Fluent Bit рядом с источником телеметрии (на сервере, в контейнере или в кластере Kubernetes).

1. Создайте файл конфигурации (например, `fluent-bit.yaml`).

    Ниже приведены примеры конфигурации для отправки логов, метрик и трейсов в Monium по gRPC или HTTP. Настройте входной плагин под ваш источник данных.

    Для передачи трейсов используются [входной](https://docs.fluentbit.io/manual/data-pipeline/inputs/opentelemetry) и [выходной](https://docs.fluentbit.io/manual/data-pipeline/outputs/opentelemetry) плагины `opentelemetry`. Агент принимает трейсы по OTLP, буферизует их и отправляет в Monium по тому же протоколу.

    **По gRPC**
    
    ```yaml
    pipeline:
      inputs:
        - name: opentelemetry
          listen: 127.0.0.1
          port: 4318
    
      outputs:
        - name: opentelemetry
          match: "*"
          host: ingest.monium.yandex.cloud
          port: 443
          tls: on
          compress: zstd
          grpc: on
          header:
            - Authorization Api-Key ${MONIUM_API_KEY}
            - x-monium-project ${MONIUM_PROJECT}
    ```
    
    **По HTTP**
    
    ```yaml
    pipeline:
      inputs:
        - name: opentelemetry
          listen: 127.0.0.1
          port: 4318
    
      outputs:
        - name: opentelemetry
          match: "*"
          host: ingest.monium.yandex.cloud
          port: 443
          tls: on
          compress: zstd
          logs_uri: /otlp/v1/logs
          traces_uri: /otlp/v1/traces
          metrics_uri: /otlp/v1/metrics
          header:
            - Authorization Api-Key ${MONIUM_API_KEY}
            - x-monium-project ${MONIUM_PROJECT}
    ```

1. Установите переменные окружения:

   * `MONIUM_PROJECT` — проект Monium, например `folder__<идентификатор_каталога>`.
   * `MONIUM_API_KEY` — API-ключ с [правом записи телеметрии](otlp-protocol.md#authorization).

1. Запустите Fluent Bit с указанием конфигурации.

1. Настройте приложение на отправку телеметрии во Fluent Bit по OTLP/HTTP в формате Protobuf. Например, для OpenTelemetry SDK с поддержкой [переменных окружения](https://opentelemetry.io/docs/languages/sdk-configuration/otlp-exporter/) задайте в окружении приложения:

   ```bash
   export OTEL_EXPORTER_OTLP_ENDPOINT="http://127.0.0.1:4318"
   export OTEL_EXPORTER_OTLP_PROTOCOL="http/protobuf"
   ```

   Адрес `127.0.0.1` подходит, если приложение и агент используют общее сетевое пространство, например работают на одном сервере без изоляции сети или в одном поде Kubernetes. В остальных случаях измените параметр `listen` входного плагина и укажите в приложении адрес агента, доступный по сети.

1. Запустите приложение с этими настройками и начните отправлять телеметрию.

1. Проверьте поступление данных в [Monium](https://monium.yandex.cloud).

   Подробнее о просмотре данных читайте в разделах [Посмотреть метрики в Monium Metrics](../metrics/metric-explorer.md), [Поиск и анализ логов](../logs/logs-explorer.md) и [Поиск трейсов и спанов](../traces/operations/traces-explorer.md).

Простейший вариант использования Fluent Bit для отправки всех видов телеметрии из Java-приложения в Monium описан в разделе [Пример для демо-приложения Java с Fluent Bit](otel-clinic-fluentbit-example.md).

Подробные примеры конфигурации (Docker, Kubernetes, парсеры) приведены в разделе [Отправка логов через Fluent Bit](../logs/write/fluent-bit.md).