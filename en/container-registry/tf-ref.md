# {{ TF }} provider's {{ container-registry-full-name }} resource reference

With [{{ TF }}](https://www.terraform.io/), you can quickly create a cloud infrastructure in {{ yandex-cloud }} and manage it using configuration files. The configuration files store the infrastructure description in the HashiCorp Configuration Language (HCL). {{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

If you change the configuration files, {{ TF }} automatically figures out which part of your configuration is already deployed and what should be added or removed.

For more information about {{ TF }}, [see the documentation](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

The following {{ TF }} provider resources are supported for {{ container-registry-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_container_registry]({{ tf-provider-resources-link }}/container_registry) | [Registry](./concepts/registry.md) |
| [yandex_container_registry_iam_binding]({{ tf-provider-resources-link }}/container_registry_iam_binding) | [Role](./security/index.md#roles-list) for a registry |
| [yandex_container_registry_ip_permission]({{ tf-provider-resources-link }}/container_registry_ip_permission) | [Registry access](./operations/registry/registry-access.md) |
| [yandex_container_repository]({{ tf-provider-resources-link }}/container_repository) | [Repository](./concepts/repository.md) |
| [yandex_container_repository_iam_binding]({{ tf-provider-resources-link }}/container_repository_iam_binding) | [Role](./security/index.md#roles-list) for a repository |
| [yandex_container_repository_lifecycle_policy]({{ tf-provider-resources-link }}/container_repository_lifecycle_policy) | [Docker image lifecycle policy](./concepts/lifecycle-policy.md) |