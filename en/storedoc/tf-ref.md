---
title: '{{ TF }} reference for {{ mmg-full-name }}'
description: This page lists the {{ TF }} provider resources and data sources supported by {{ mmg-name }}.
---

# {{ TF }} reference for {{ mmg-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ mmg-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_mdb_mongodb_cluster]({{ tf-provider-resources-link }}/mdb_mongodb_cluster) | [Cluster](concepts/index.md) |
| [yandex_mdb_mongodb_cluster_iam_binding]({{ tf-provider-resources-link }}/mdb_mongodb_cluster_iam_binding) | [Configuring](../iam/concepts/access-control/index.md#access-bindings) cluster access permissions |

## Data sources {#data-sources}

{{ mmg-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_mdb_mongodb_cluster]({{ tf-provider-datasources-link }}/mdb_mongodb_cluster) | [Cluster](./concepts/index.md) information |
| [yandex_mdb_mongodb_database]({{ tf-provider-datasources-link }}/mdb_mongodb_database) | Database information |
| [yandex_mdb_mongodb_user]({{ tf-provider-datasources-link }}/mdb_mongodb_user) | Database user information |