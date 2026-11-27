[Документация Yandex Cloud](../../index.md) > [Yandex Monitoring](../index.md) > [Справочник метрик](index.md) > Container Registry

# Метрики Yandex Container Registry

В этом разделе описаны метрики сервиса [Container Registry](../../container-registry/index.md), поставляемые в Monium.

Метрики сервиса Container Registry автоматически передаются в [Monium](../../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находится реестр.

Если вы просматриваете метрики в интерфейсе сервиса или переходите к графику из [сервисного дашборда](../../monium/operations/dashboard/service-dashboards.md), значение метки `service` используется без подчеркиваний.

Если вы вводите запрос в Monium в [разделе метрик](../../monium/metrics/metric-explorer.md#add-graph) или при создании алерта, укажите проект каталога с ресурсом (`project = folder__<идентификатор_каталога>`), `cluster = default` и `service = __<идентификатор_сервиса>__`.

Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса Container Registry:

Метка | Значение
----|----
service | Идентификатор сервиса: `container-registry`
registry | Идентификатор [реестра](../../container-registry/concepts/registry.md)

## Метрики сервиса {#container-registry-metrics}

Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`registry.images_count`<br>`IGAUGE`, штуки | Текущее количество Docker-образов в реестре.
`registry.size_bytes`<br>`IGAUGE`, байты | Суммарный размер Docker-образов в реестре.

[*monium-folder-project]: Проект Monium с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.