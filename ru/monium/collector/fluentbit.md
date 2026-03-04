# Передача данных через Fluent Bit

Fluent Bit — агент для сбора, обработки и экспорта логов и метрик. Вы можете использовать Fluent Bit для передачи телеметрии в {{ monium-name }} в формате [OpenTelemetry (OTLP)](https://opentelemetry.io/docs/).

Fluent Bit оптимально подходит в следующих случаях:

* Много разных форматов логов и нужны гибкие парсеры.
* Приложение работает в кластере {{ k8s }}.
* Требуется собирать логи централизованно с одного хоста (файлы, Docker, системные логи).
* Логи уже поставляются через файлы или стандартные выходы приложений.

В остальных случаях рекомендуется использовать [OTel Collector](opentelemetry.md).

## Требования к версии {#version}

{% include [fluentbit-version](../../_includes/monium/fluentbit-version.md) %}

## Ограничения при передаче метрик {#metrics-limitations}

Fluent Bit отрезает поле `startTimestampNanos` у метрик. Не используйте Fluent Bit для передачи метрик, если в приложении сконфигурирована дельта темпоральность (задана переменная `OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="delta"`) — дельта-метрики без времени начала периода обрабатываются некорректно.

## Настройка передачи телеметрии {#configure}

1. [Установите](https://docs.fluentbit.io/fluent-bit/v/4.0/installation/getting-started-with-fluent-bit) Fluent Bit рядом с источником телеметрии (на сервере, в контейнере или в кластере {{ k8s }}).

1. Создайте файл конфигурации (например, `fluent-bit.yaml`).

    Ниже приведён минимальный пример конфигурации для отправки логов, метрик, трейсов в {{ monium-name }}. Настройте вход (inputs) под ваш источник данных.

    {% include [fluentbit-config](../../_includes/monium/fluentbit-config.md) %}

1. Установите переменные окружения:
   * `MONIUM_PROJECT` — идентификатор проекта {{ monium-name }}.
   * `MONIUM_API_KEY` — API-ключ с правом записи телеметрии.

1. Запустите Fluent Bit с указанием конфигурации.

1. Проверьте поступление логов в [{{ monium-name }}]({{ link-monium }}).

Простейший вариант использования Fluent Bit для отправки всех видов телеметрии из Java приложения в {{ monium-name }} см. в разделе [Пример для демо-приложения Java с Fluent Bit](otel-clinic-fluentbit-example.md).

Подробные примеры конфигурации (Docker, {{ k8s }}, парсеры) см. в разделе [Отправка логов через Fluent Bit](../logs/write/fluent-bit.md).
