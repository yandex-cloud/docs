Метрики сервиса {{ cloud-registry-name }} автоматически передаются в [{{ monium-name }}](../../../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находится реестр.

{% include [metrics-search-labels](../../monium/metrics-search-labels.md) %}

## Просмотр графиков {#view-metrics}

Графики можно посмотреть в консоли управления и в {{ monium-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится реестр.
  1. [Перейдите]({{ link-console-main }}/link/cloud-registry) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}** и выберите реестр.
  1. На панели слева выберите **{{ ui-key.yacloud.component.navigation-menu.label_monitoring }}**.

- Интерфейс {{ monium-name }} {#monium}

  1. В [{{ monium-name }}]({{ link-monium }}) выберите проект каталога с реестром.
  1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** и перейдите на вкладку **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**.
  1. Откройте дашборд **Cloud Registry metrics**.

{% endlist %}

Для просмотра метрик конкретного реестра добавьте его идентификатор в метку `registry_id`.

Общие метки для всех метрик сервиса {{ cloud-registry-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `cloud-registry`
registry_id | Идентификатор [реестра](../../../cloud-registry/concepts/registry.md)

## Метрики сервиса {#cloud-registry-metrics}

Имя метрики<br>Тип, единицы измерения | Описание
--- | ---
`registry_artifacts_count`<br>`IGAUGE`, штуки | Текущее количество артефактов в реестре.
`registry_size_bytes`<br>`IGAUGE`, байты | Суммарный размер реестра.

[*monium-folder-project]: {% include [folder-project](../../monium/folder-project.md) %}
