---
title: '{{ TF }} reference for {{ mrd-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ mrd-name }}.
---

# {{ TF }} reference for {{ mrd-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ mrd-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_mdb_redis_cluster]({{ tf-provider-resources-link }}/mdb_redis_cluster) | [Cluster](./concepts/index.md) |

## Data sources {#data-sources}

{{ mrd-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_mdb_redis_cluster]({{ tf-provider-datasources-link }}/datasource_mdb_redis_cluster) | [Cluster](./concepts/index.md) information |