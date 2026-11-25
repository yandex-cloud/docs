---
title: Справочник метрик сервиса {{ cloud-registry-full-name }} в {{ metrics-name }}
description: На этой странице приведен справочник метрик сервиса {{ cloud-registry-name }}, поставляемых в {{ metrics-name }}.
---

# Справочник метрик {{ metrics-name }}

Метрики сервиса {{ cloud-registry-name }} автоматически передаются в [{{ metrics-name }}](../monium/metrics/overview.md) и доступны в проекте каталога с реестром.

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

{% include [cloud-registry](../_includes/monitoring/metrics-ref/cloud-registry.md) %}
