# {{ TF }} reference for {{ mos-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ mos-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_mdb_opensearch_cluster]({{ tf-provider-resources-link }}/mdb_opensearch_cluster) | [Cluster](./concepts/index.md) |

## Data sources {#data-sources}

{{ mos-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_mdb_opensearch_cluster]({{ tf-provider-datasources-link }}/datasource_mdb_opensearch_cluster) | [Cluster](./concepts/index.md) information |