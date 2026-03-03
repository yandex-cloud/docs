---
title: Справочник {{ TF }} для {{ monium-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ monium-name }}.
---

# Справочник {{ TF }} для {{ monium-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для метрик поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_monitoring_dashboard]({{ tf-provider-resources-link }}/monitoring_dashboard) | [Дашборд](concepts/visualization/dashboard.md) |


## Источники данных {#data-sources}

Для метрик поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_monitoring_dashboard]({{ tf-provider-datasources-link }}/monitoring_dashboard) | Информация о [дашборде](concepts/visualization/dashboard.md) |

