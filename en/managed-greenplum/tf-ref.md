---
title: '{{ TF }} reference for {{ mgp-full-name }}'
description: This page provides information about the {{ TF }} provider resources and data sources that {{ mgp-name }} supports.
---

# {{ TF }} reference for {{ mgp-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ mgp-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_mdb_greenplum_cluster]({{ tf-provider-resources-link }}/mdb_greenplum_cluster) | [Cluster](./concepts/index.md) |

## Data sources {#data-sources}

{{ mgp-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_mdb_greenplum_cluster]({{ tf-provider-datasources-link }}/mdb_greenplum_cluster) | [Cluster](./concepts/index.md) details |

{% include [greenplum-trademark](../_includes/mdb/mgp/trademark.md) %}
