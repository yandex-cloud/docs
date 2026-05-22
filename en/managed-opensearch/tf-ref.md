---
title: '{{ TF }} reference for {{ mos-full-name }}'
description: This page lists the {{ TF }} provider resources and data sources supported by {{ mos-name }}.
---

# {{ TF }} reference for {{ mos-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ mos-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_mdb_opensearch_cluster]({{ tf-provider-resources-link }}/mdb_opensearch_cluster) | [Cluster](./concepts/index.md) |
| [yandex_mdb_opensearch_cluster_iam_binding]({{ tf-provider-resources-link }}/mdb_opensearch_cluster_iam_binding) | [Configuring](../iam/concepts/access-control/index.md#access-bindings) cluster access permissions |

## Data sources {#data-sources}

{{ mos-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_mdb_opensearch_cluster]({{ tf-provider-datasources-link }}/mdb_opensearch_cluster) | [Cluster](./concepts/index.md) information |