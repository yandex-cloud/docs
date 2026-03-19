---
title: '{{ TF }} reference for {{ mpg-full-name }}'
description: This page lists the {{ TF }} provider resources and data sources supported by {{ mpg-name }}.
---

# {{ TF }} reference for {{ mpg-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ mpg-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_mdb_postgresql_cluster]({{ tf-provider-resources-link }}/mdb_postgresql_cluster) | [{{ PG }} cluster](./concepts/index.md) |
| [yandex_mdb_postgresql_cluster_iam_binding]({{ tf-provider-resources-link }}/mdb_postgresql_cluster_iam_binding) | [Configuring](../iam/concepts/access-control/index.md#access-bindings) cluster access permissions |
| [yandex_mdb_postgresql_database]({{ tf-provider-resources-link }}/mdb_postgresql_database) | {{ PG }} database |
| [yandex_mdb_postgresql_user]({{ tf-provider-resources-link }}/mdb_postgresql_user) | {{ PG }} user |

## Data sources {#data-sources}

{{ mpg-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_mdb_postgresql_cluster]({{ tf-provider-datasources-link }}/mdb_postgresql_cluster) | [{{ PG }} cluster](./concepts/index.md) information |
| [yandex_mdb_postgresql_database]({{ tf-provider-datasources-link }}/mdb_postgresql_database) | {{ PG }} database information |
| [yandex_mdb_postgresql_user]({{ tf-provider-datasources-link }}/mdb_postgresql_user) | {{ PG }} user information |