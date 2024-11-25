---
title: '{{ TF }} reference for {{ org-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ org-name }}.
---

# {{ TF }} reference for {{ org-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ org-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_organizationmanager_group]({{ tf-provider-resources-link }}/organizationmanager_group) | [User group](./concepts/groups.md) |
| [yandex_organizationmanager_group_iam_member]({{ tf-provider-resources-link }}/organizationmanager_group_iam_member) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) user group access permissions |
| [yandex_organizationmanager_group_membership]({{ tf-provider-resources-link }}/organizationmanager_group_membership) | Member of a user group |
| [yandex_organizationmanager_organization_iam_binding]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for an organization. It has a limit of 1,000 bindings per resource. <br>We recommend using `yandex_organizationmanager_organization_iam_binding` instead of `yandex_organizationmanager_organization_iam_member`. |
| [yandex_organizationmanager_organization_iam_member]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_member) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for an organization. |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-resources-link }}/organizationmanager_saml_federation) | [SAML-compatible identity federation](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-resources-link }}/organizationmanager_saml_federation_user_account) | [Federated user](./concepts/add-federation.md#saml-authentication) |

## Data sources {#data-sources}

{{ org-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_organizationmanager_group]({{ tf-provider-datasources-link }}/organizationmanager_group) | [User group](./concepts/groups.md) information |
| [yandex_organizationmanager_os_login_settings]({{ tf-provider-datasources-link }}/organizationmanager_os_login_settings) | Information on configuring access via [{{ oslogin }}](./concepts/os-login.md) |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-datasources-link }}/organizationmanager_saml_federation) | Information about a [SAML-compatible identity federation](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-datasources-link }}/organizationmanager_saml_federation_user_account) | [Federated user](./concepts/add-federation.md#saml-authentication) information |
| [yandex_organizationmanager_user_ssh_key]({{ tf-provider-datasources-link }}/organizationmanager_user_ssh_key) | Information about a user SSH key |