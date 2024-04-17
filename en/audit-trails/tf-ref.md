# {{ TF }} reference for {{ at-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ at-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_audit_trails_trail]({{ tf-provider-resources-link }}/audit_trails_trail) | [Trail](./concepts/trail.md) |


## Data sources {#data-sources}

{{ at-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_audit_trails_trail]({{ tf-provider-datasources-link }}/datasource_audit_trails_trail) | Information about a [trail](./concepts/trail.md) |