---
title: '{{ TF }} reference for {{ dataproc-full-name }}'
description: This page lists the {{ TF }} provider resources and data sources supported by {{ dataproc-name }}.
---

# {{ TF }} reference for {{ dataproc-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ dataproc-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_dataproc_cluster]({{ tf-provider-resources-link }}/dataproc_cluster) | [{{ dataproc-name }}](./concepts/index.md#resources) cluster |
| [yandex_dataproc_cluster_iam_binding]({{ tf-provider-resources-link }}/dataproc_cluster_iam_binding) | [Configuring](../iam/concepts/access-control/index.md#access-bindings) cluster access permissions |

## Data sources {#data-sources}

{{ dataproc-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_dataproc_cluster]({{ tf-provider-datasources-link }}/dataproc_cluster) | [{{ dataproc-name }} cluster](./concepts/index.md#resources) information |