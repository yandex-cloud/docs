# {{ TF }} reference for {{ api-gw-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ api-gw-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_api_gateway]({{ tf-provider-resources-link }}/api_gateway) | [API gateway](./concepts/index.md) |

## Data sources {#data-sources}

{{ api-gw-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_api_gateway]({{ tf-provider-datasources-link }}/datasource_api_gateway) | [API gateway](./concepts/index.md) information |