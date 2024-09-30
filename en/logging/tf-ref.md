---
title: "{{ TF }} reference for {{ cloud-logging-full-name }}"
description: "This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ cloud-logging-name }}."
---

# {{ TF }} reference for {{ cloud-logging-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ cloud-logging-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_logging_group]({{ tf-provider-resources-link }}/logging_group) | [Log group](./concepts/log-group.md) |

## Data sources {#data-sources}

{{ cloud-logging-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_logging_group]({{ tf-provider-datasources-link }}/datasource_logging_group) | [Log group](./concepts/log-group.md) information |