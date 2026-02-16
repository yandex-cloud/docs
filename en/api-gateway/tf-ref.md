---
title: '{{ TF }} reference for {{ api-gw-full-name }}'
description: This guide provides information about {{ TF }} resources and data sources supported by {{ api-gw-name }}.
---

# {{ TF }} reference for {{ api-gw-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ api-gw-name }} supports the following {{ TF }} resources :

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_api_gateway]({{ tf-provider-resources-link }}/api_gateway) | [API gateway](./concepts/index.md) |

## Data sources {#data-sources}

{{ api-gw-name }} supports the following {{ TF }} data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_api_gateway]({{ tf-provider-datasources-link }}/api_gateway) | [API gateway](./concepts/index.md) information |