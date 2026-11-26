[Документация Yandex Cloud](../../index.md) > [Yandex Monitoring](../index.md) > [Справочник метрик](index.md) > Cloud Registry

# Метрики Yandex Cloud Registry

В этом разделе описаны метрики сервиса [Cloud Registry](../../cloud-registry/index.md), поставляемые в Monitoring.

Метрики сервиса Cloud Registry автоматически передаются в [Monium](../../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находится реестр.

Если вы просматриваете метрики в интерфейсе сервиса или переходите к графику из [сервисного дашборда](../../monium/operations/dashboard/service-dashboards.md), значение метки `service` используется без подчеркиваний.

Если вы создаете запрос в Monium в [разделе метрик](../../monium/metrics/metric-explorer.md#add-graph) или в редакторе алерта, укажите проект каталога с ресурсом (`project = folder__<идентификатор_каталога>`), `cluster = default` и `service = __<идентификатор_сервиса>__`.


Имя метрики пишется в метку `name`.

## Просмотр графиков {#view-metrics}

Графики можно посмотреть в консоли управления и в Monium.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится реестр.
  1. [Перейдите](https://console.yandex.cloud/link/cloud-registry) в сервис **Cloud Registry** и выберите реестр.
  1. На панели слева выберите **Monitoring**.

- Интерфейс Monium {#monium}

  1. В [Monium](https://monium.yandex.cloud) выберите проект каталога с реестром.
  1. На панели слева выберите **Дашборды** и перейдите на вкладку **Сервисные дашборды**.
  1. Откройте дашборд **Cloud Registry metrics**.

{% endlist %}

Для просмотра метрик конкретного реестра добавьте его идентификатор в метку `registry_id`.

Общие метки для всех метрик сервиса Cloud Registry:

Метка | Значение
----|----
service | Идентификатор сервиса: `cloud-registry`
registry_id | Идентификатор [реестра](../../cloud-registry/concepts/registry.md)

## Метрики сервиса {#cloud-registry-metrics}

Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`registry_artifacts_count`<br>`IGAUGE`, штуки | Текущее количество артефактов в реестре.
`registry_size_bytes`<br>`IGAUGE`, байты | Суммарный размер реестра.

[*monium-folder-project]: Проект Monium с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.