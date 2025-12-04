---
title: '{{ TF }} reference for {{ metastore-name }}'
description: This page presents reference information on the {{ TF }} provider resources and data sources supported for {{ metastore-name }} in {{ metadata-hub-full-name }}.
---

# {{ TF }} reference for {{ metastore-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

For {{ metastore-name }}, the following {{ TF }} provider resource is supported:

| **{{ TF }} resource**                                                          | **{{ yandex-cloud }} resource**                         |
|--------------------------------------------------------------------------------|---------------------------------------------------------|
| [yandex_metastore_cluster]({{ tf-provider-resources-link }}/metastore_cluster) | [{{ metastore-name }}](./concepts/metastore.md) cluster |

## Data sources {#data-sources}

For {{ metastore-name }}, the following {{ TF }} data source is supported:

| **{{ TF }} data source**                                                     | **Description**                                                          |
|----------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| [yandex_metastore_cluster]({{ tf-provider-datasources-link }}/metastore_cluster) | [{{ metastore-name }}](./concepts/metastore.md) cluster information |