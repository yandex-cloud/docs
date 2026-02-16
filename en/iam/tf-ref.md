---
title: '{{ TF }} reference for {{ iam-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ iam-name }}.
---

# {{ TF }} reference for {{ iam-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ iam-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account) | [Service account](./concepts/users/service-accounts.md) |
| [yandex_iam_service_account_api_key]({{ tf-provider-resources-link }}/iam_service_account_api_key) | [API key](./concepts/authorization/api-key.md) |
| [yandex_iam_service_account_iam_binding]({{ tf-provider-resources-link }}/iam_service_account_iam_binding) | [Assigning](./concepts/access-control/index.md#access-bindings) service account access permissions. It has a limit of 1,000 bindings per resource. <br>We recommend using `iam_service_account_iam_binding` instead of `iam_service_account_iam_member`. |
| [yandex_iam_service_account_iam_member]({{ tf-provider-resources-link }}/iam_service_account_iam_member) | [Assigning](./concepts/access-control/index.md#access-bindings) service account access permissions. |
| [yandex_iam_service_account_iam_policy]({{ tf-provider-resources-link }}/iam_service_account_iam_policy) | Sets the service account access policy and replaces any specified policy. |
| [yandex_iam_service_account_key]({{ tf-provider-resources-link }}/iam_service_account_key) | [Authorized key](./concepts/authorization/key.md) |
| [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key) | [Static key](./concepts/authorization/access-key.md) |

## Data sources {#data-sources}

{{ iam-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_iam_policy]({{ tf-provider-datasources-link }}/iam_policy) | Access policy information |
| [yandex_iam_role]({{ tf-provider-datasources-link }}/iam_role) | [Role](./concepts/access-control/roles.md) information |
| [yandex_iam_service_account]({{ tf-provider-datasources-link }}/iam_service_account) | [Service account](./concepts/users/service-accounts.md) information |
| [yandex_iam_user]({{ tf-provider-datasources-link }}/iam_user) | User information |