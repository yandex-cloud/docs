---
title: '{{ TF }} reference for {{ container-registry-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ container-registry-name }}.
---

# {{ TF }} reference for {{ container-registry-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ container-registry-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_container_registry]({{ tf-provider-resources-link }}/container_registry) | [Registry](./concepts/registry.md) |
| [yandex_container_registry_iam_binding]({{ tf-provider-resources-link }}/container_registry_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a registry |
| [yandex_container_registry_ip_permission]({{ tf-provider-resources-link }}/container_registry_ip_permission) | [Registry access](./operations/registry/registry-access.md) |
| [yandex_container_repository]({{ tf-provider-resources-link }}/container_repository) | [Repository](./concepts/repository.md) |
| [yandex_container_repository_iam_binding]({{ tf-provider-resources-link }}/container_repository_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a repository |
| [yandex_container_repository_lifecycle_policy]({{ tf-provider-resources-link }}/container_repository_lifecycle_policy) | [Docker image lifecycle policy](./concepts/lifecycle-policy.md) |

## Data sources {#data-sources}

{{ container-registry-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_container_registry]({{ tf-provider-datasources-link }}/container_registry) | [Registry](./concepts/registry.md) information |
| [yandex_container_registry_ip_permission]({{ tf-provider-datasources-link }}/container_registry_ip_permission) | [Registry access](./operations/registry/registry-access.md) information |