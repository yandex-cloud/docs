---
title: '{{ TF }} reference for {{ resmgr-full-name }}'
description: This page provides information about the {{ TF }} provider’s resources and data sources that {{ resmgr-name }} supports.
---

# {{ TF }} reference for {{ resmgr-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ resmgr-name }} supports the {{ TF }} provider’s following resources:

| **{{ TF }}** resource | **{{ yandex-cloud }}** resource |
| --- | --- |
| [yandex_resourcemanager_cloud]({{ tf-provider-resources-link }}/resourcemanager_cloud) | [Cloud](./concepts/resources-hierarchy.md#cloud) |
| [yandex_resourcemanager_cloud_iam_binding]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a cloud. It has a limit of 1,000 bindings per resource. <br>We recommend using `yandex_resourcemanager_cloud_iam_member` instead of `yandex_resourcemanager_cloud_iam_binding`. |
| [yandex_resourcemanager_cloud_iam_member]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_member) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a cloud |
| [yandex_resourcemanager_folder]({{ tf-provider-resources-link }}/resourcemanager_folder) | [Folder](./concepts/resources-hierarchy.md#folder) |
| [yandex_resourcemanager_folder_iam_binding]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a folder. It has a limit of 1,000 bindings per resource. <br>We recommend using `yandex_resourcemanager_cloud_iam_member` instead of `yandex_resourcemanager_cloud_iam_binding`. |
| [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a folder |
| [yandex_resourcemanager_folder_iam_policy]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_policy) | Sets the folder access policy and replaces any specified policy. |

## Data sources {#data-sources}

{{ resmgr-name }} supports the {{ TF }} provider’s following data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_resourcemanager_cloud]({{ tf-provider-datasources-link }}/resourcemanager_cloud) | [Cloud](./concepts/resources-hierarchy.md#cloud) information |
| [yandex_resourcemanager_folder]({{ tf-provider-datasources-link }}/resourcemanager_folder) | [Folder](./concepts/resources-hierarchy.md#folder) information |
