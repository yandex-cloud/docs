---
title: '{{ TF }} reference for {{ mch-full-name }}'
description: This page provides information about the {{ TF }} provider’s resources and data sources that {{ mch-name }} supports.
---

# {{ TF }} reference for {{ mch-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ mch-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_mdb_clickhouse_cluster]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster) | [Cluster](concepts/index.md) |

## Data sources {#data-sources}

{{ mch-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_mdb_clickhouse_cluster]({{ tf-provider-datasources-link }}/mdb_clickhouse_cluster) | [Cluster](concepts/index.md) information |

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
