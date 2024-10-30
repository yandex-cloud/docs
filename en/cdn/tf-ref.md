---
title: '{{ TF }} reference for {{ cdn-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ cdn-name }}.
---

# {{ TF }} reference for {{ cdn-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ cdn-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_cdn_origin_group]({{ tf-provider-resources-link }}/cdn_origin_group) | [Origin group](./concepts/origins.md#groups) |
| [yandex_cdn_resource]({{ tf-provider-resources-link }}/cdn_resource) | [CDN resource](./concepts/resource.md) |

## {#data-sources} data sources

{{ cdn-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_cdn_origin_group]({{ tf-provider-datasources-link }}/datasource_cdn_origin_group) | Information about an [origin group](./concepts/origins.md#groups) |
| [yandex_cdn_resource]({{ tf-provider-datasources-link }}/datasource_cdn_resource) | Information about a [CDN resource](./concepts/resource.md) |