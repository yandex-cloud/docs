---
title: '{{ TF }} reference for {{ mrd-full-name }}'
description: This page provides information about the {{ TF }} provider's resources and data sources that {{ mrd-name }} supports.
---

# {{ TF }} reference for {{ mrd-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ mrd-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_mdb_redis_cluster]({{ tf-provider-resources-link }}/mdb_redis_cluster) | [Cluster](./concepts/index.md) |
| [yandex_mdb_redis_user]({{ tf-provider-resources-link }}/mdb_redis_user) | {{ VLK }} user |

## Data sources {#data-sources}

{{ mrd-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_mdb_redis_cluster]({{ tf-provider-datasources-link }}/mdb_redis_cluster) | [Cluster](./concepts/index.md) details |