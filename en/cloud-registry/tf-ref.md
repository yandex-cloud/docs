---
title: '{{ TF }} reference for {{ cloud-registry-full-name }}'
description: This page gives information about the {{ TF }} provider resources and data sources supported by {{ cloud-registry-full-name }}.
---

# {{ TF }} reference for {{ cloud-registry-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ cloud-registry-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_cloudregistry_registry]({{ tf-provider-resources-link }}/cloudregistry_registry) | [Registry](./concepts/registry.md) |
| [yandex_cloudregistry_registry_iam_binding]({{ tf-provider-resources-link }}/cloudregistry_registry_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a registry |
| [yandex_cloudregistry_registry_ip_permission]({{ tf-provider-resources-link }}/cloudregistry_registry_ip_permission) | IP address access policy |

## Data sources {#data-sources}

{{ cloud-registry-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_cloudregistry_registry]({{ tf-provider-datasources-link }}/cloudregistry_registry) | [Registry](./concepts/registry.md) information |
| [yandex_cloudregistry_registry_ip_permission]({{ tf-provider-datasources-link }}/cloudregistry_registry_ip_permission) | IP address access policy info |