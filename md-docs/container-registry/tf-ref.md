# Справочник Terraform для Yandex Container Registry

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Container Registry поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_container_registry](../terraform/resources/container_registry.md) | [Реестр](concepts/registry.md) |
| [yandex_container_registry_iam_binding](../terraform/resources/container_registry_iam_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к реестру |
| [yandex_container_registry_ip_permission](../terraform/resources/container_registry_ip_permission.md) | [Доступ к реестру](operations/registry/registry-access.md) |
| [yandex_container_repository](../terraform/resources/container_repository.md) | [Репозиторий](concepts/repository.md) |
| [yandex_container_repository_iam_binding](../terraform/resources/container_repository_iam_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к репозиторию |
| [yandex_container_repository_lifecycle_policy](../terraform/resources/container_repository_lifecycle_policy.md) | [Политика автоматического удаления Docker-образов](concepts/lifecycle-policy.md) |

## Источники данных {#data-sources}

Для Container Registry поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_container_registry](../terraform/data-sources/container_registry.md) | Информация о [реестре](concepts/registry.md) |
| [yandex_container_registry_ip_permission](../terraform/data-sources/container_registry_ip_permission.md) | Информация о [доступе к реестру](operations/registry/registry-access.md) |