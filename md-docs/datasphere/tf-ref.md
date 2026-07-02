[Документация Yandex Cloud](../index.md) > [Yandex DataSphere](index.md) > Справочник Terraform

# Справочник Terraform для Yandex DataSphere

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для DataSphere поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_datasphere_community](../terraform/resources/datasphere_community.md) | [Сообщество](concepts/community.md) |
| [yandex_datasphere_community_iam_binding](../terraform/resources/datasphere_community_iam_binding.md) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к сообществу |
| [yandex_datasphere_project](../terraform/resources/datasphere_project.md) | [Проект](concepts/project.md) |
| [yandex_datasphere_project_iam_binding](../terraform/resources/datasphere_project_iam_binding.md) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к проекту |

## Источники данных {#data-sources}

Для DataSphere поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_datasphere_community](../terraform/data-sources/datasphere_community.md) | Информация о [сообществе](concepts/community.md) |
| [yandex_datasphere_project](../terraform/data-sources/datasphere_project.md) | Информация о [проекте](concepts/project.md) |