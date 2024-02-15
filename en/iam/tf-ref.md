# {{ TF }} provider's {{ iam-full-name }} resource reference

With [{{ TF }}](https://www.terraform.io/), you can quickly create a cloud infrastructure in {{ yandex-cloud }} and manage it using configuration files. The configuration files store the infrastructure description in the HashiCorp Configuration Language (HCL). {{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

If you change the configuration files, {{ TF }} automatically figures out which part of your configuration is already deployed and what should be added or removed.

For more information about {{ TF }}, [see the documentation](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

The following {{ TF }} provider resources are supported for {{ iam-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account) | [Service account](./concepts/users/service-accounts.md) |
| [yandex_iam_service_account_api_key]({{ tf-provider-resources-link }}/iam_service_account_api_key) | [API key](./concepts/authorization/api-key.md) |
| [yandex_iam_service_account_iam_binding]({{ tf-provider-resources-link }}/iam_service_account_iam_binding) | [Role](./security/index.md#roles-list) for a service account |
| [yandex_iam_service_account_iam_member]({{ tf-provider-resources-link }}/iam_service_account_iam_member) | [Role](./security/index.md#roles-list) for a service account |
| [yandex_iam_service_account_iam_policy]({{ tf-provider-resources-link }}/iam_service_account_iam_policy) | Service account access policy |
| [yandex_iam_service_account_key]({{ tf-provider-resources-link }}/iam_service_account_key) | [Authorized key](./concepts/authorization/key.md) |
| [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key) | [Static key](./concepts/authorization/access-key.md) |