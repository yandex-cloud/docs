# Справочник ресурсов {{ container-registry-full-name }} провайдера {{ TF }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). {{ TF }} и его провайдеры распространяются под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

Для {{ container-registry-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_container_registry]({{ tf-provider-resources-link }}/container_registry) | [Реестр](./concepts/registry.md) |
| [yandex_container_registry_iam_binding]({{ tf-provider-resources-link }}/container_registry_iam_binding) | [Роль](./security/index.md#roles-list) на реестр |
| [yandex_container_registry_ip_permission]({{ tf-provider-resources-link }}/container_registry_ip_permission) | [Доступ к реестру](./operations/registry/registry-access.md) |
| [yandex_container_repository]({{ tf-provider-resources-link }}/container_repository) | [Репозиторий](./concepts/repository.md) |
| [yandex_container_repository_iam_binding]({{ tf-provider-resources-link }}/container_repository_iam_binding) | [Роль](./security/index.md#roles-list) на репозиторий |
| [yandex_container_repository_lifecycle_policy]({{ tf-provider-resources-link }}/container_repository_lifecycle_policy) | [Политика автоматического удаления Docker-образов](./concepts/lifecycle-policy.md) |