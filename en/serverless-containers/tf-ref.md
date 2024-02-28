# {{ TF }} provider's {{ serverless-containers-full-name }} resource reference

With [{{ TF }}](https://www.terraform.io/), you can quickly create a cloud infrastructure in {{ yandex-cloud }} and manage it using configuration files. The configuration files store the infrastructure description in the HashiCorp Configuration Language (HCL). {{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

If you change the configuration files, {{ TF }} automatically figures out which part of your configuration is already deployed and what should be added or removed.

For more information about {{ TF }}, [see the documentation](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

The following {{ TF }} provider resources are supported for {{ serverless-containers-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_serverless_container]({{ tf-provider-resources-link }}/serverless_container) | [Container](./concepts/container.md) |
| [yandex_serverless_container_iam_binding]({{ tf-provider-resources-link }}/serverless_container_iam_binding) | [Role](./security/index.md#roles-list) for a container |
| [yandex_function_trigger]({{ tf-provider-resources-link }}/function_trigger) | [Trigger](./concepts/trigger/index.md) |
