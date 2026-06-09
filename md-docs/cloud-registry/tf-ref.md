# Справочник Terraform для Yandex Cloud Registry

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Cloud Registry поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_cloudregistry_registry](../terraform/resources/cloudregistry_registry.md) | [Реестр](concepts/registry.md) |
| [yandex_cloudregistry_registry_iam_binding](../terraform/resources/cloudregistry_registry_iam_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к реестру |
| [yandex_cloudregistry_registry_ip_permission](../terraform/resources/cloudregistry_registry_ip_permission.md) | Политика доступа для IP-адресов |

## Источники данных {#data-sources}

Для Cloud Registry поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_cloudregistry_registry](../terraform/data-sources/cloudregistry_registry.md) | Информация о [реестре](concepts/registry.md) |
| [yandex_cloudregistry_registry_ip_permission](../terraform/data-sources/cloudregistry_registry_ip_permission.md) | Информация о политике доступа для IP-адресов |