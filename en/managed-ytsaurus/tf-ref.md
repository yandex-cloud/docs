# {{ TF }} reference for {{ myt-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ myt-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_ytsaurus_cluster]({{ tf-provider-resources-link }}/ytsaurus_cluster) | Cluster |

## Data sources {#data-sources}

{{ myt-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_ytsaurus_cluster]({{ tf-provider-datasources-link }}/ytsaurus_cluster) | {{ ytsaurus-name }} cluster information |