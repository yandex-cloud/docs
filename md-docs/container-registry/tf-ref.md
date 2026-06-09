# Справочник {{ TF }} для {{ container-registry-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ container-registry-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_container_registry]({{ tf-provider-resources-link }}/container_registry) | [Реестр](concepts/registry.md) |
| [yandex_container_registry_iam_binding]({{ tf-provider-resources-link }}/container_registry_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к реестру |
| [yandex_container_registry_ip_permission]({{ tf-provider-resources-link }}/container_registry_ip_permission) | [Доступ к реестру](operations/registry/registry-access.md) |
| [yandex_container_repository]({{ tf-provider-resources-link }}/container_repository) | [Репозиторий](concepts/repository.md) |
| [yandex_container_repository_iam_binding]({{ tf-provider-resources-link }}/container_repository_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к репозиторию |
| [yandex_container_repository_lifecycle_policy]({{ tf-provider-resources-link }}/container_repository_lifecycle_policy) | [Политика автоматического удаления Docker-образов](concepts/lifecycle-policy.md) |

## Источники данных {#data-sources}

Для {{ container-registry-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_container_registry]({{ tf-provider-datasources-link }}/container_registry) | Информация о [реестре](concepts/registry.md) |
| [yandex_container_registry_ip_permission]({{ tf-provider-datasources-link }}/container_registry_ip_permission) | Информация о [доступе к реестру](operations/registry/registry-access.md) |