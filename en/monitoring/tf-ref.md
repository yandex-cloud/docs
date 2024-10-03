---
title: '{{ TF }} reference for {{ monitoring-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ monitoring-name }}.
---

# {{ TF }} reference for {{ monitoring-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ monitoring-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_monitoring_dashboard]({{ tf-provider-resources-link }}/monitoring_dashboard) | [Dashboard](./concepts/visualization/dashboard.md) |

## Data sources {#data-sources}

{{ monitoring-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_monitoring_dashboard]({{ tf-provider-datasources-link }}/datasource_monitoring_dashboard) | [Dashboard](./concepts/visualization/dashboard.md) information |