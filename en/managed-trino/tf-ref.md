# {{ TF }} reference for {{ mtr-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ mtr-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_trino_cluster]({{ tf-provider-resources-link }}/trino_cluster) | Cluster |
| [yandex_trino_catalog]({{ tf-provider-resources-link }}/trino_catalog) | Catalog |

## Data sources {#data-sources}

{{ mtr-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }}** data source | **Description** |
| --- | --- |
| [yandex_trino_cluster]({{ tf-provider-datasources-link }}/trino_cluster) | [{{ TR }} cluster](./concepts/index.md#cluster-architecture) information |
| [yandex_trino_catalog]({{ tf-provider-datasources-link }}/trino_catalog) | [{{ TR }} catalog](./concepts/index.md#catalog) information |