---
title: "{{ TF }} reference for {{ dataproc-full-name }}"
description: "This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ dataproc-name }}."
---

# {{ TF }} reference for {{ dataproc-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ dataproc-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_dataproc_cluster]({{ tf-provider-resources-link }}/dataproc_cluster) | [{{ dataproc-name }} cluster](./concepts/index.md#resources) |

## Data sources {#data-sources}

{{ dataproc-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_dataproc_cluster]({{ tf-provider-datasources-link }}/datasource_dataproc_cluster) | [{{ dataproc-name }} cluster](./concepts/index.md#resources) information |