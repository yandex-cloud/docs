---
title: '{{ TF }} reference for {{ mgl-full-name }}'
description: This page describes the {{ TF }} provider’s resources and data sources supported by {{ mgl-name }}.
---

# {{ TF }} reference for {{ mgl-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ mgl-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_gitlab_instance]({{ tf-provider-resources-link }}/gitlab_instance) | [{{ GL }} instance](./concepts/index.md#instance) |

## Data sources {#data-sources}

{{ mgl-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_gitlab_instance]({{ tf-provider-datasources-link }}/gitlab_instance) | Information about the [{{ GL }} instance](./concepts/index.md#instance) |