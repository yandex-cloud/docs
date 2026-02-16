---
title: '{{ TF }} reference for {{ mch-full-name }}'
description: This page gives information about the {{ TF }} provider resources and data sources supported by {{ mch-name }}.
---

# {{ TF }} reference for {{ mch-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ mch-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_mdb_clickhouse_cluster]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster) | [Cluster](concepts/index.md) |
| [yandex_mdb_clickhouse_database]({{ tf-provider-resources-link }}/mdb_clickhouse_database) | Database |
| [yandex_mdb_clickhouse_user]({{ tf-provider-resources-link }}/mdb_clickhouse_user) | {{ mch-name }} user |

## Data sources {#data-sources}

{{ mch-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_mdb_clickhouse_cluster]({{ tf-provider-datasources-link }}/mdb_clickhouse_cluster) | [Cluster](concepts/index.md) information |
| [yandex_mdb_clickhouse_database]({{ tf-provider-datasources-link }}/mdb_clickhouse_database) | Database information |
| [yandex_mdb_clickhouse_user]({{ tf-provider-datasources-link }}/mdb_clickhouse_user) | {{ mch-name }} user information |

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
