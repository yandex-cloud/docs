---
title: Закрытие сервиса {{ monitoring-full-name }}
description: Сервис {{ monitoring-name }} закрыт. Узнайте, как продолжить работу с метриками в {{ monium-name }} и использовать возможности единой платформы Observability.
---

# Закрытие сервиса {{ monitoring-full-name }}

{% note warning %}

Сервис {{ monitoring-full-name }} закрыт. Все его возможности и метрики доступны на платформе [{{ monium-name }}]({{ link-monium }}).

{% endnote %}

## Доступ к вашим метрикам {#data}

Метрики ресурсов {{ yandex-cloud }} и пользовательские метрики, загруженные в {{ monitoring-name }} через API, доступны в {{ monium-name }}. Переносить их вручную не требуется.

Метрики ресурсов {{ yandex-cloud }} поступают автоматически. Для работы с ними воспользуйтесь инструкцией [{#T}](../monium/metrics/quickstart.md), а для загрузки пользовательских метрик — [{#T}](../monium/metrics/quickstart-app.md).

## Как продолжить работу в {{ monium-name }} {#migration}

Чтобы найти свои метрики:

1. Откройте [{{ monium-name }}]({{ link-monium }}).
1. Выберите проект каталога с нужными ресурсами или пользовательскими метриками.
1. Найдите метрики по меткам в [обзоре метрик](../monium/metrics/metric-explorer.md). Для метрик ресурсов также доступны [сервисные дашборды](../monium/visualization/index.md#service-dashboards).

## Новые возможности {#features}

[{{ monium-full-name }}](../monium/) объединяет метрики, логи и трейсы в единой платформе [Observability](../glossary/observability.md) для диагностики сбоев и расследования инцидентов. В ней доступны:

* [Логи](../monium/logs/logs-explorer.md) — поиск и анализ событий, [вычисление метрик по логам](../monium/logs/aggregates.md).
* [Трейсы](../monium/traces/index.md) — анализ пути запросов и времени выполнения операций в распределенных приложениях, [переход к связанным логам](../monium/traces/operations/traces-logs.md).
* [SLO](../monium/slo/index.md) — отслеживание целевого уровня качества сервиса.
* [Сбор телеметрии через OpenTelemetry](../monium/collector/opentelemetry.md) — поставка метрик, логов и трейсов из приложений и инфраструктуры.

Подробнее в разделе [{#T}](../monium/overview.md).

## Если у вас есть вопросы {#support}

Если нужна помощь, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.
