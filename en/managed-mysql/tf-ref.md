---
title: '{{ TF }} reference for {{ mmy-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ mmy-name }}.
---

# {{ TF }} reference for {{ mmy-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ mmy-name }}:

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
| [yandex_mdb_mysql_user]({{ tf-provider-datasources-link }}/mdb_mysql_user) | Database user information |