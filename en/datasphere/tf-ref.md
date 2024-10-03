---
title: '{{ TF }} reference for {{ ml-platform-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ ml-platform-name }}.
---

# {{ TF }} reference for {{ ml-platform-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ ml-platform-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_datasphere_community]({{ tf-provider-resources-link }}/datasphere_community) | [Community](concepts/community.md) |
| [yandex_datasphere_community_iam_binding]({{ tf-provider-resources-link }}/datasphere_community_iam_binding) | [Binding](../iam/concepts/access-control/index.md#access-bindings) access privileges to a community |
| [yandex_datasphere_project]({{ tf-provider-resources-link }}/datasphere_project) | [Project](concepts/project.md) |
| [yandex_datasphere_project_iam_binding]({{ tf-provider-resources-link }}/datasphere_project_iam_binding) | [Binding](../iam/concepts/access-control/index.md#access-bindings) access privileges to a project |

## Data sources {#data-sources}

{{ ml-platform-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_datasphere_community]({{ tf-provider-datasources-link }}/datasource_datasphere_community) | [Community](concepts/community.md) information |
| [yandex_datasphere_project]({{ tf-provider-datasources-link }}/datasource_datasphere_project) | [Project](concepts/project.md) information |