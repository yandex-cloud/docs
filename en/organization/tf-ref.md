---
title: '{{ TF }} reference for {{ org-full-name }}'
description: This page gives information about the {{ TF }} provider resources and data sources supported by {{ org-name }}.
---

# {{ TF }} reference for {{ org-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ org-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_organizationmanager_group]({{ tf-provider-resources-link }}/organizationmanager_group) | [User group](./concepts/groups.md) |
| [yandex_organizationmanager_group_iam_member]({{ tf-provider-resources-link }}/organizationmanager_group_iam_member) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) user group access permissions |
| [yandex_organizationmanager_group_mapping]({{ tf-provider-resources-link }}/organizationmanager_group_mapping) | Setting up [user group mapping](./concepts/add-federation.md#group-mapping) |
| [yandex_organizationmanager_group_mapping_item]({{ tf-provider-resources-link }}/organizationmanager_group_mapping_item) | [User group mapping](./concepts/add-federation.md#group-mapping) element |
| [yandex_organizationmanager_group_membership]({{ tf-provider-resources-link }}/organizationmanager_group_membership) | Member of a [user group](./concepts/groups.md) |
| [yandex_organizationmanager_idp_application_oauth_application]({{ tf-provider-resources-link }}/organizationmanager_idp_application_oauth_application) | [OIDC app](./concepts/applications.md#oidc) |
| [yandex_organizationmanager_idp_application_saml_application]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application) | [SAML app](./concepts/applications.md#saml) |
| [yandex_organizationmanager_idp_user]({{ tf-provider-resources-link }}/organizationmanager_idp_user) | [Local user](../iam/concepts/users/accounts.md#local) |
| [yandex_organizationmanager_idp_userpool]({{ tf-provider-resources-link }}/organizationmanager_idp_userpool) | [User pool](./concepts/user-pools.md) |
| [yandex_organizationmanager_organization_iam_binding]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for an organization. It has a limit of 1,000 bindings per resource. <br>We recommend using `yandex_organizationmanager_organization_iam_binding` instead of `yandex_organizationmanager_organization_iam_member`. |
| [yandex_organizationmanager_organization_iam_member]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_member) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for an organization. |
| [yandex_organizationmanager_os_login_settings]({{ tf-provider-resources-link }}/organizationmanager_os_login_settings) | [{{ oslogin }}](./concepts/os-login.md) access settings |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-resources-link }}/organizationmanager_saml_federation) | [SAML-compatible identity federation](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-resources-link }}/organizationmanager_saml_federation_user_account) | [Federated user](./concepts/add-federation.md#saml-authentication) |
| [yandex_organizationmanager_user_ssh_key]({{ tf-provider-resources-link }}/organizationmanager_user_ssh_key) | [SSH key](./concepts/os-login.md#ssh-keys) for access via {{ oslogin }} |


## Data sources {#data-sources}

{{ org-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_organizationmanager_group]({{ tf-provider-datasources-link }}/organizationmanager_group) | [User group](./concepts/groups.md) information |
| [yandex_organizationmanager_idp_application_oauth_application]({{ tf-provider-datasources-link }}/organizationmanager_idp_application_oauth_application) | Information about the [OIDC application](./concepts/applications.md#oidc) |
| [yandex_organizationmanager_idp_application_saml_application]({{ tf-provider-datasources-link }}/organizationmanager_idp_application_saml_application) | Information about the [SAML application](./concepts/applications.md#saml) |
| [yandex_organizationmanager_idp_user]({{ tf-provider-datasources-link }}/organizationmanager_idp_user) | [Local user](../iam/concepts/users/accounts.md#local) information |
| [yandex_organizationmanager_idp_userpool]({{ tf-provider-datasources-link }}/organizationmanager_idp_userpool) | [User pool](./concepts/user-pools.md) information |
| [yandex_organizationmanager_os_login_settings]({{ tf-provider-datasources-link }}/organizationmanager_os_login_settings) | Information on configuring access via [{{ oslogin }}](./concepts/os-login.md) |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-datasources-link }}/organizationmanager_saml_federation) | Information about a [SAML-compatible identity federation](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-datasources-link }}/organizationmanager_saml_federation_user_account) | [Federated user](./concepts/add-federation.md#saml-authentication) information |
| [yandex_organizationmanager_user_ssh_key]({{ tf-provider-datasources-link }}/organizationmanager_user_ssh_key) | Information about a user [SSH key](./concepts/os-login.md#ssh-keys) |