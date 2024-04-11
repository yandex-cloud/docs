# {{ TF }} reference for {{ org-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ org-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_organizationmanager_group]({{ tf-provider-resources-link }}/organizationmanager_group) | [User group](./concepts/groups.md) |
| [yandex_organizationmanager_group_iam_member]({{ tf-provider-resources-link }}/organizationmanager_group_iam_member) | [Binding](../iam/concepts/access-control/index.md#access-bindings) access privileges to a user group |
| [yandex_organizationmanager_group_membership]({{ tf-provider-resources-link }}/organizationmanager_group_membership) | Member of a user group |
| [yandex_organizationmanager_organization_iam_binding]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding) | [Binding](../iam/concepts/access-control/index.md#access-bindings) access privileges to an organization |
| [yandex_organizationmanager_organization_iam_member]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_member) | [Binding](../iam/concepts/access-control/index.md#access-bindings) access privileges to an organization |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-resources-link }}/organizationmanager_saml_federation) | [SAML-compatible identity federation](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-resources-link }}/organizationmanager_saml_federation_user_account) | [Federated user](./concepts/add-federation.md#saml-authentication) |

## Data sources {#data-sources}

{{ org-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_organizationmanager_group]({{ tf-provider-datasources-link }}/datasource_organizationmanager_group) | [User group](./concepts/groups.md) information |
| [yandex_organizationmanager_os_login_settings]({{ tf-provider-datasources-link }}/datasource_organizationmanager_os_login_settings) | Information on configuring access via [OS Login](./concepts/os-login.md) |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-datasources-link }}/datasource_organizationmanager_saml_federation) | Information about a [SAML-compatible identity federation](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-datasources-link }}/datasource_organizationmanager_saml_federation_user_account) | [Federated user](./concepts/add-federation.md#saml-authentication) information |
| [yandex_organizationmanager_user_ssh_key]({{ tf-provider-datasources-link }}/datasource_organizationmanager_user_ssh_key) | Information about a user SSH key |