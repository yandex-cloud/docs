---
title: '{{ TF }} reference for {{ mmy-full-name }}'
description: This page gives information about the {{ TF }} provider resources and data sources supported by {{ mmy-name }}.
---

# {{ TF }} reference for {{ mmy-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ mmy-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_mdb_mysql_cluster]({{ tf-provider-resources-link }}/mdb_mysql_cluster) | [Cluster](concepts/index.md) |
| [yandex_mdb_mysql_database]({{ tf-provider-resources-link }}/mdb_mysql_database) | Database |
| [yandex_mdb_mysql_user]({{ tf-provider-resources-link }}/mdb_mysql_user) | Database user |

## Data sources {#data-sources}

{{ mmy-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_mdb_mysql_cluster]({{ tf-provider-datasources-link }}/mdb_mysql_cluster) | [Cluster](./concepts/index.md) information |
| [yandex_mdb_mysql_database]({{ tf-provider-datasources-link }}/mdb_mysql_database) | Database information |
| [yandex_mdb_mysql_user]({{ tf-provider-datasources-link }}/mdb_mysql_user) | Database user information |