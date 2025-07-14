---
title: '{{ TF }} reference for {{ dataproc-full-name }}'
description: This page describes the {{ TF }} provider’s resources and data sources supported by {{ dataproc-name }}.
---

# {{ TF }} reference for {{ dataproc-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ dataproc-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_dataproc_cluster]({{ tf-provider-resources-link }}/dataproc_cluster) | [{{ dataproc-name }} cluster](./concepts/index.md#resources) |

## Data sources {#data-sources}

{{ dataproc-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_dataproc_cluster]({{ tf-provider-datasources-link }}/datasource_dataproc_cluster) | [{{ dataproc-name }} cluster](./concepts/index.md#resources) information |