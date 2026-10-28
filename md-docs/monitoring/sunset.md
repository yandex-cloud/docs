[Документация Yandex Cloud](../index.md) > [Yandex Monitoring](index.md) > Закрытие сервиса Yandex Monitoring

# Закрытие сервиса Yandex Monitoring

{% note warning %}

Сервис Yandex Monitoring закрыт. Все его возможности и метрики доступны на платформе [Monium](https://monium.yandex.cloud).

{% endnote %}

## Доступ к вашим метрикам {#data}

Метрики ресурсов Yandex Cloud и пользовательские метрики, загруженные в Monitoring через API, доступны в Monium. Переносить их вручную не требуется.

Метрики ресурсов Yandex Cloud поступают автоматически. Для работы с ними воспользуйтесь инструкцией [Начало работы с метриками ресурсов Yandex Cloud](../monium/metrics/quickstart.md), а для загрузки пользовательских метрик — [Начало работы с метриками приложений](../monium/metrics/quickstart-app.md).

## Как продолжить работу в Monium {#migration}

Чтобы найти свои метрики:

1. Откройте [Monium](https://monium.yandex.cloud).
1. Выберите проект каталога с нужными ресурсами или пользовательскими метриками.
1. Найдите метрики по меткам в [обзоре метрик](../monium/metrics/metric-explorer.md). Для метрик ресурсов также доступны [сервисные дашборды](../monium/visualization/index.md#service-dashboards).

## Новые возможности {#features}

[Yandex Monium](../monium/index.md) объединяет метрики, логи и трейсы в единой платформе [Observability](../glossary/observability.md) для диагностики сбоев и расследования инцидентов. В ней доступны:

* [Логи](../monium/logs/logs-explorer.md) — поиск и анализ событий, [вычисление метрик по логам](../monium/logs/aggregates.md).
* [Трейсы](../monium/traces/index.md) — анализ пути запросов и времени выполнения операций в распределенных приложениях, [переход к связанным логам](../monium/traces/operations/traces-logs.md).
* [SLO](../monium/slo/index.md) — отслеживание целевого уровня качества сервиса.
* [Сбор телеметрии через OpenTelemetry](../monium/collector/opentelemetry.md) — поставка метрик, логов и трейсов из приложений и инфраструктуры.

Подробнее в разделе [О платформе Monium](../monium/overview.md).

## Если у вас есть вопросы {#support}

Если нужна помощь, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.