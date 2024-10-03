---
title: '{{ TF }} reference for {{ sf-full-name }}'
description: This page gives reference information about the {{ TF }} provider resources and data sources supported for {{ sf-name }}.
---

# {{ TF }} reference for {{ sf-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ sf-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_function]({{ tf-provider-resources-link }}/function) | [Function](./concepts/function.md) |
| [yandex_function_iam_binding]({{ tf-provider-resources-link }}/function_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a function |
| [yandex_function_scaling_policy]({{ tf-provider-resources-link }}/function_scaling_policy) | [Function scaling settings](./concepts/function.md#scaling) |
| [yandex_function_trigger]({{ tf-provider-resources-link }}/function_trigger) | [Trigger](./concepts/trigger/index.md) |

## Data sources {#data-sources}

{{ sf-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_function]({{ tf-provider-datasources-link }}/datasource_function) | Information about a [function](./concepts/function.md) |
| [yandex_function_scaling_policy]({{ tf-provider-datasources-link }}/datasource_function_scaling_policy) | Information about [function scaling settings](./concepts/function.md#scaling) |
| [yandex_function_trigger]({{ tf-provider-datasources-link }}/datasource_function_trigger) | Information about a [trigger](./concepts/trigger/index.md) |
