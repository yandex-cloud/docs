---
title: '{{ TF }} reference for {{ monium-name }}'
description: This page gives information about the {{ TF }} provider resources and data sources supported by {{ monium-name }}.
alternate:
  - href: en/monium/tf-ref.md
    type: text/markdown
    title: Markdown version
---

# {{ TF }} reference for {{ monium-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

Metrics support the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_monitoring_dashboard]({{ tf-provider-resources-link }}/monitoring_dashboard) | [Dashboard](concepts/visualization/dashboard.md) |


## Data sources {#data-sources}

Metrics support the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_monitoring_dashboard]({{ tf-provider-datasources-link }}/monitoring_dashboard) | [Dashboard](concepts/visualization/dashboard.md) information |

