---
title: '{{ TF }} reference for {{ iam-full-name }}'
description: This page gives information about the {{ TF }} provider resources and data sources supported by {{ iam-name }}.
---

# {{ TF }} reference for {{ iam-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ iam-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_iam_oauth_client]({{ tf-provider-resources-link }}/iam_oauth_client) | [OAuth_client](../organization/concepts/applications/oidc.md) |
| [yandex_iam_oauth_client_secret]({{ tf-provider-resources-link }}/iam_oauth_client_secret) | [OAuth_client_secret](../organization/concepts/applications/oidc.md#oidc-secret) |
| [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account) | [Service account](./concepts/users/service-accounts.md) |
| [yandex_iam_service_account_api_key]({{ tf-provider-resources-link }}/iam_service_account_api_key) | [API key](./concepts/authorization/api-key.md) |
| [yandex_iam_service_account_iam_binding]({{ tf-provider-resources-link }}/iam_service_account_iam_binding) | [Assigning](./concepts/access-control/index.md#access-bindings) service account access permissions. Limited to 1,000 bindings per resource. <br>We recommend using `iam_service_account_iam_member` rather than `iam_service_account_iam_binding`. |
| [yandex_iam_service_account_iam_member]({{ tf-provider-resources-link }}/iam_service_account_iam_member) | [Assigning](./concepts/access-control/index.md#access-bindings) service account access permissions. |
| [yandex_iam_service_account_iam_policy]({{ tf-provider-resources-link }}/iam_service_account_iam_policy) | Sets the service account access policy and replaces any specified policy. |
| [yandex_iam_service_account_key]({{ tf-provider-resources-link }}/iam_service_account_key) | [Authorized key](./concepts/authorization/key.md) |
| [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key) | [Static key](./concepts/authorization/access-key.md) |
| [yandex_iam_workload_identity_federated_credential]({{ tf-provider-resources-link }}/iam_workload_identity_federated_credential) | [Federated credentials in a workload identity federation](./concepts/workload-identity.md#federated-credentials) |
| [yandex_iam_workload_identity_oidc_federation]({{ tf-provider-resources-link }}/iam_workload_identity_oidc_federation) | [Workload identity federation](./concepts/workload-identity.md) |
| [yandex_iam_workload_identity_oidc_federation_iam_binding]({{ tf-provider-resources-link }}/iam_workload_identity_oidc_federation_iam_binding) | Assigning a [role](./concepts/access-control/roles.md) for a [workload identity federation](./concepts/workload-identity.md) |

## Data sources {#data-sources}

{{ iam-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_iam_oauth_client]({{ tf-provider-datasources-link }}/iam_oauth_client) | [OAuth client](../organization/concepts/applications/oidc.md) information |
| [yandex_iam_policy]({{ tf-provider-datasources-link }}/iam_policy) | Access policy information |
| [yandex_iam_role]({{ tf-provider-datasources-link }}/iam_role) | [Role](./concepts/access-control/roles.md) information |
| [yandex_iam_service_account]({{ tf-provider-datasources-link }}/iam_service_account) | [Service account](./concepts/users/service-accounts.md) information |
| [yandex_iam_service_agent]({{ tf-provider-datasources-link }}/iam_service_agent) | [Service agent](./concepts/service-control.md#service-agent) information |
| [yandex_iam_user]({{ tf-provider-datasources-link }}/iam_user) | User information |
| [yandex_iam_workload_identity_federated_credential]({{ tf-provider-datasources-link }}/iam_workload_identity_federated_credential) | Information about [federated credentials in a workload identity federation](./concepts/workload-identity.md#federated-credentials) |
| [yandex_iam_workload_identity_oidc_federation]({{ tf-provider-datasources-link }}/iam_workload_identity_oidc_federation) | Information about a [workload identity federation](./concepts/workload-identity.md) |