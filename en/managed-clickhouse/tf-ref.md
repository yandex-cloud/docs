---
title: "{{ TF }} reference for {{ mch-full-name }}"
description: "This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ mch-name }}."
---

# {{ TF }} reference for {{ mch-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ mch-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_mdb_clickhouse_cluster]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster) | [Cluster](concepts/index.md) |

## Data sources {#data-sources}

{{ mch-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_mdb_clickhouse_cluster]({{ tf-provider-datasources-link }}/datasource_mdb_clickhouse_cluster) | [Cluster](concepts/index.md) information |

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
