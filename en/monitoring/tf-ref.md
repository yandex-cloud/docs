---
title: '{{ TF }} reference for {{ monitoring-full-name }}'
description: This guide provides information about {{ TF }} resources and data sources supported by {{ monitoring-name }}.
---

# {{ TF }} reference for {{ monitoring-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ monitoring-name }} supports the following {{ TF }} resources :

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_monitoring_dashboard]({{ tf-provider-resources-link }}/monitoring_dashboard) | [Dashboard](./concepts/visualization/dashboard.md) |

## Data sources {#data-sources}

{{ monitoring-name }} supports the following {{ TF }} data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_monitoring_dashboard]({{ tf-provider-datasources-link }}/monitoring_dashboard) | [Dashboard](./concepts/visualization/dashboard.md) information |