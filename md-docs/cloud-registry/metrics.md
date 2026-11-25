[Документация Yandex Cloud](../index.md) > [Yandex Cloud Registry](index.md) > Метрики Monium Metrics

# Справочник метрик Monium Metrics

Метрики сервиса Cloud Registry автоматически передаются в [Monium Metrics](../monium/metrics/overview.md) и доступны в проекте каталога с реестром.

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

Имя метрики пишется в метку `name`.

При переходе к графику из сервисного дашборда значение метки `service` используется без подчеркиваний — `cloud-registry`.

Если вы создаете запрос в Monium через **Обзор** → **Метрики**, укажите проект каталога с реестром (`project = folder__<идентификатор_каталога>`), `cluster = default` и `service = __cloud-registry__`. Для просмотра метрик конкретного реестра добавьте его идентификатор в метку `registry_id`.

Общие метки для всех метрик сервиса Cloud Registry:

Метка | Значение
----|----
service | Идентификатор сервиса: `cloud-registry`
registry_id | Идентификатор [реестра](concepts/registry.md)

## Метрики сервиса {#cloud-registry-metrics}

Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`registry_artifacts_count`<br>`IGAUGE`, штуки | Текущее количество артефактов в реестре.
`registry_size_bytes`<br>`IGAUGE`, байты | Суммарный размер реестра.