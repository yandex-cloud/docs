[Документация Yandex Cloud](../index.md) > [Yandex Resource Manager](index.md) > Справочник Terraform

# Справочник Terraform для Yandex Resource Manager

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Resource Manager поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_resourcemanager_cloud](../terraform/resources/resourcemanager_cloud.md) | [Облако](concepts/resources-hierarchy.md#cloud) |
| [yandex_resourcemanager_cloud_iam_binding](../terraform/resources/resourcemanager_cloud_iam_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к облаку. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `yandex_resourcemanager_cloud_iam_binding` рекомендуется использовать `yandex_resourcemanager_cloud_iam_member` |
| [yandex_resourcemanager_cloud_iam_member](../terraform/resources/resourcemanager_cloud_iam_member.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к облаку |
| [yandex_resourcemanager_folder](../terraform/resources/resourcemanager_folder.md) | [Каталог](concepts/resources-hierarchy.md#folder) |
| [yandex_resourcemanager_folder_iam_binding](../terraform/resources/resourcemanager_folder_iam_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к каталогу. Имеет ограничение в 1000 привязок на ресурс. <br>Вместо `yandex_resourcemanager_folder_iam_binding` рекомендуется использовать `yandex_resourcemanager_folder_iam_member` |
| [yandex_resourcemanager_folder_iam_member](../terraform/resources/resourcemanager_folder_iam_member.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к каталогу |
| [yandex_resourcemanager_folder_iam_policy](../terraform/resources/resourcemanager_folder_iam_policy.md) | Устанавливает политику доступа к каталогу и заменяет любую заданную политику |

## Источники данных {#data-sources}

Для Resource Manager поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_resourcemanager_cloud](../terraform/data-sources/resourcemanager_cloud.md) | Информация об [облаке](concepts/resources-hierarchy.md#cloud) |
| [yandex_resourcemanager_folder](../terraform/data-sources/resourcemanager_folder.md) | Информация о [каталоге](concepts/resources-hierarchy.md#folder) |