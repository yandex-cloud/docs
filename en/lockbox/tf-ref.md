# {{ TF }} provider's {{ lockbox-full-name }} resource reference

With [{{ TF }}](https://www.terraform.io/), you can quickly create a cloud infrastructure in {{ yandex-cloud }} and manage it using configuration files. The configuration files store the infrastructure description in the HashiCorp Configuration Language (HCL). {{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

If you change the configuration files, {{ TF }} automatically figures out which part of your configuration is already deployed and what should be added or removed.

For more information about {{ TF }}, [see the documentation](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

The following {{ TF }} provider resources are supported for {{ lockbox-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_lockbox_secret]({{ tf-provider-resources-link }}/lockbox_secret) | [Secret](./concepts/secret.md#secret) |
| [yandex_lockbox_secret_iam_binding]({{ tf-provider-resources-link }}/lockbox_secret_iam_binding) | [Role](./security/index.md#roles-list) for a secret |
| [yandex_lockbox_secret_version]({{ tf-provider-resources-link }}/lockbox_secret_version) | [Secret version](./concepts/secret.md#version) |
