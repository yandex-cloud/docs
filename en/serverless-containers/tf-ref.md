---
title: "{{ TF }} reference for {{ serverless-containers-full-name }}"
description: "This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ serverless-containers-name }}."
---

# {{ TF }} reference for {{ serverless-containers-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ serverless-containers-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_serverless_container]({{ tf-provider-resources-link }}/serverless_container) | [Container](./concepts/container.md) |
| [yandex_serverless_container_iam_binding]({{ tf-provider-resources-link }}/serverless_container_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a container |
| [yandex_function_trigger]({{ tf-provider-resources-link }}/function_trigger) | [Trigger](./concepts/trigger/index.md) |

## Data sources {#data-sources}

{{ serverless-containers-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_serverless_container]({{ tf-provider-datasources-link }}/datasource_serverless_container) | [Container](./concepts/container.md) information |
