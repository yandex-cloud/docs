---
title: '{{ TF }} reference for {{ cloud-logging-full-name }}'
description: This page provides information about the {{ TF }} provider’s resources and data sources that {{ cloud-logging-name }} supports.
---

# {{ TF }} reference for {{ cloud-logging-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ cloud-logging-name }} supports the {{ TF }} provider’s following resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_logging_group]({{ tf-provider-resources-link }}/logging_group) | [Log group](./concepts/log-group.md) |

## Data sources {#data-sources}

{{ cloud-logging-name }} supports the {{ TF }} provider’s following data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_logging_group]({{ tf-provider-datasources-link }}/logging_group) | [Log group](./concepts/log-group.md) information |