---
title: '{{ TF }} reference for {{ org-full-name }}'
description: This page gives information about the {{ TF }} provider resources and data sources supported by {{ org-full-name }}.
---

# {{ TF }} reference for {{ org-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ org-full-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_organization_manager_organization_iam_policy_binding]({{ tf-provider-resources-link }}/organization_manager_organization_iam_policy_binding) | Assigning an [access policy](./operations/manage-access-policies.md) for an organization |
| [yandex_organizationmanager_group]({{ tf-provider-resources-link }}/organizationmanager_group) | [User group](./concepts/groups.md) |
| [yandex_organizationmanager_group_iam_member]({{ tf-provider-resources-link }}/organizationmanager_group_iam_member) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) user group access permissions |
| [yandex_organizationmanager_group_mapping]({{ tf-provider-resources-link }}/organizationmanager_group_mapping) | Setting up [user group mapping](./concepts/add-federation.md#group-mapping) |
| [yandex_organizationmanager_group_mapping_item]({{ tf-provider-resources-link }}/organizationmanager_group_mapping_item) | [User group mapping](./concepts/add-federation.md#group-mapping) element |
| [yandex_organizationmanager_group_membership]({{ tf-provider-resources-link }}/organizationmanager_group_membership) | Member of a [user group](./concepts/groups.md) |
| [yandex_organizationmanager_idp_application_oauth_application]({{ tf-provider-resources-link }}/organizationmanager_idp_application_oauth_application) | [OIDC app](./concepts/applications/oidc.md) |
| [yandex_organizationmanager_idp_application_oauth_application_assignment]({{ tf-provider-resources-link }}/organizationmanager_idp_application_oauth_application_assignment) | Assigning a user or user group to an [OIDC app](./concepts/applications/oidc.md) |
| [yandex_organizationmanager_idp_application_saml_application]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application) | [SAML app](./concepts/applications/saml.md) |
| [yandex_organizationmanager_idp_application_saml_application_assignment]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application_assignment) | Assigning a user or user group to a [SAML app](./concepts/applications/saml.md) |
| [yandex_organizationmanager_idp_application_saml_signature_certificate]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_signature_certificate) | [Digital signature verification key certificate](./concepts/applications/saml.md#saml-certificate) of an SAML app |
| [yandex_organizationmanager_idp_user]({{ tf-provider-resources-link }}/organizationmanager_idp_user) | [Local user](../iam/concepts/users/accounts.md#local) |
| [yandex_organizationmanager_idp_userpool]({{ tf-provider-resources-link }}/organizationmanager_idp_userpool) | [User pool](./concepts/user-pools.md) |
| [yandex_organizationmanager_idp_userpool_domain]({{ tf-provider-resources-link }}/organizationmanager_idp_userpool_domain) | User pool [domain](./operations/user-pools/add-domain.md) |
| [yandex_organizationmanager_mfa_enforcement]({{ tf-provider-resources-link }}/organizationmanager_mfa_enforcement) | [MFA policy](./concepts/mfa.md#mfa-policies) |
| [yandex_organizationmanager_mfa_enforcement_audience]({{ tf-provider-resources-link }}/organizationmanager_mfa_enforcement_audience) | [MFA policy](./concepts/mfa.md#mfa-policies) target group |
| [yandex_organizationmanager_mfa_enforcement_excluded_audience]({{ tf-provider-resources-link }}/organizationmanager_mfa_enforcement_excluded_audience) | User or user group [excluded from an MFA policy](./operations/mfa/excluded-audience.md) |
| [yandex_organizationmanager_organization_iam_binding]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for an organization. Limited to 1,000 bindings per resource. <br>We recommend using `yandex_organizationmanager_organization_iam_member` instead of `yandex_organizationmanager_organization_iam_binding`. |
| [yandex_organizationmanager_organization_iam_member]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_member) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for an organization. |
| [yandex_organizationmanager_os_login_settings]({{ tf-provider-resources-link }}/organizationmanager_os_login_settings) | [{{ oslogin }}](./concepts/os-login.md) access settings |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-resources-link }}/organizationmanager_saml_federation) | [SAML-compatible identity federation](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-resources-link }}/organizationmanager_saml_federation_user_account) | [Federated user](./concepts/add-federation.md#saml-authentication) |
| [yandex_organizationmanager_user_ssh_key]({{ tf-provider-resources-link }}/organizationmanager_user_ssh_key) | [SSH key](./concepts/os-login.md#ssh-keys) for access via {{ oslogin }} |


## Data sources {#data-sources}

{{ org-full-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_organizationmanager_group]({{ tf-provider-datasources-link }}/organizationmanager_group) | [User group](./concepts/groups.md) information |
| [yandex_organizationmanager_idp_application_oauth_application]({{ tf-provider-datasources-link }}/organizationmanager_idp_application_oauth_application) | Information about the [OIDC application](./concepts/applications/oidc.md) |
| [yandex_organizationmanager_idp_application_saml_application]({{ tf-provider-datasources-link }}/organizationmanager_idp_application_saml_application) | Information about the [SAML application](./concepts/applications/saml.md) |
| [yandex_organizationmanager_idp_application_saml_signature_certificate]({{ tf-provider-datasources-link }}/organizationmanager_idp_application_saml_signature_certificate) | Information about an SAML app's [digital signature verification key certificate](./concepts/applications/saml.md#saml-certificate) |
| [yandex_organizationmanager_idp_user]({{ tf-provider-datasources-link }}/organizationmanager_idp_user) | [Local user](../iam/concepts/users/accounts.md#local) information |
| [yandex_organizationmanager_idp_userpool]({{ tf-provider-datasources-link }}/organizationmanager_idp_userpool) | [User pool](./concepts/user-pools.md) information |
| [yandex_organizationmanager_mfa_enforcement]({{ tf-provider-datasources-link }}/organizationmanager_mfa_enforcement) | [MFA policy](./concepts/mfa.md#mfa-policies) information |
| [yandex_organizationmanager_os_login_settings]({{ tf-provider-datasources-link }}/organizationmanager_os_login_settings) | Information on [{{ oslogin }}](./concepts/os-login.md) access settings |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-datasources-link }}/organizationmanager_saml_federation) | Information about a [SAML-compatible identity federation](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-datasources-link }}/organizationmanager_saml_federation_user_account) | [Federated user](./concepts/add-federation.md#saml-authentication) information |
| [yandex_organizationmanager_user_ssh_key]({{ tf-provider-datasources-link }}/organizationmanager_user_ssh_key) | Information about a user [SSH key](./concepts/os-login.md#ssh-keys) |