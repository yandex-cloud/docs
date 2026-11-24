---
title: Справочник метрик сервиса {{ baremetal-full-name }} в {{ metrics-name }}
description: На этой странице приведен справочник метрик сервиса {{ baremetal-name }}, поставляемых в {{ metrics-name }}.
---

# Справочник метрик {{ metrics-name }}

Метрики сервиса {{ baremetal-name }} автоматически передаются в [{{ metrics-name }}](../monium/metrics/overview.md) и доступны в проекте каталога с сервером.

Чтобы посмотреть графики в консоли управления, [откройте страницу сервера](./operations/servers/get-info.md) и перейдите на вкладку **{{ ui-key.yacloud.baremetal.label_server-monitoring }}**.

Чтобы открыть готовый дашборд, в [{{ monium-name }}]({{ link-monium }}) выберите проект каталога с сервером. Откройте раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**. На вкладке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** найдите дашборд по названию сервиса {{ baremetal-name }}.

{% include [baremetal](../_includes/monitoring/metrics-ref/baremetal.md) %}