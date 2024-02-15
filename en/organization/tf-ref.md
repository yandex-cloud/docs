# {{ TF }} provider's {{ org-full-name }} resource reference

With [{{ TF }}](https://www.terraform.io/), you can quickly create a cloud infrastructure in {{ yandex-cloud }} and manage it using configuration files. The configuration files store the infrastructure description in the HashiCorp Configuration Language (HCL). {{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

If you change the configuration files, {{ TF }} automatically figures out which part of your configuration is already deployed and what should be added or removed.

For more information about {{ TF }}, [see the documentation](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

The following {{ TF }} provider resources are supported for {{ org-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_organizationmanager_group]({{ tf-provider-resources-link }}/organizationmanager_group) | [User group](./concepts/groups.md) |
| [yandex_organizationmanager_group_iam_member]({{ tf-provider-resources-link }}/organizationmanager_group_iam_member) | [Role](./security/index.md#roles-list) for a user group |
| [yandex_organizationmanager_group_membership]({{ tf-provider-resources-link }}/organizationmanager_group_membership) | Member of a user group |
| [yandex_organizationmanager_organization_iam_binding]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding) | [Role](./security/index.md#roles-list) for an organization |
| [yandex_organizationmanager_organization_iam_member]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_member) | [Role](./security/index.md#roles-list) for an organization |
| [yandex_organizationmanager_saml_federation]({{ tf-provider-resources-link }}/organizationmanager_saml_federation) | [SAML-compatible identity federation](./concepts/add-federation.md) |
| [yandex_organizationmanager_saml_federation_user_account]({{ tf-provider-resources-link }}/organizationmanager_saml_federation_user_account) | [Federated user](./concepts/add-federation.md#saml-authentication) |
