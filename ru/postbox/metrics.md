---
title: Справочник метрик сервиса {{ postbox-full-name }} в {{ metrics-name }}
description: На этой странице приведен справочник метрик сервиса {{ postbox-name }}, поставляемых в {{ metrics-name }}.
---

# Справочник метрик {{ metrics-name }}

Метрики сервиса {{ postbox-name }} автоматически передаются в [{{ metrics-name }}](../monium/metrics/overview.md) и доступны в проекте каталога с адресом отправителя.

Чтобы открыть сервисный дашборд, в [{{ monium-name }}]({{ link-monium }}) выберите проект каталога с адресом отправителя. Откройте раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** и на вкладке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите **Postbox - Overview**.

Статистика доставки и действий получателей, включая открытия писем и переходы по ссылкам, доступна на [странице статистики {{ postbox-name }}](./concepts/statistics.md#viewing) в консоли управления.

{% include [postbox](../_includes/monitoring/metrics-ref/postbox.md) %}
