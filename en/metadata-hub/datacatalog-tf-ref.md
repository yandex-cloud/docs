---
title: '{{ TF }} reference for {{ data-catalog-name }}'
description: This page presents reference information on the {{ TF }} provider resources and data sources supported for {{ data-catalog-name }} in {{ metadata-hub-full-name }}.
---

# {{ TF }} reference for {{ data-catalog-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

For {{ metadata-hub-full-name }}, the following {{ TF }} provider resource is supported:

| **{{ TF }} resource**                                                                | **{{ yandex-cloud }} resource**                    |
|------------------------------------------------------------------------------------|--------------------------------------------------|
| [yandex_datacatalog_catalog]({{ tf-provider-resources-link }}/datacatalog_catalog) | [Metadata catalog](./concepts/data-catalog.md) |

## Data sources {#data-sources}

For {{ metadata-hub-full-name }}, the following {{ TF }} data source is supported:

| **{{ TF }} data source**                                                         | **Description**                                                   |
|--------------------------------------------------------------------------------------|----------------------------------------------------------------|
| [yandex_datacatalog_catalog]({{ tf-provider-datasources-link }}/datacatalog_catalog) | [Metadata catalog](./concepts/data-catalog.md) details |