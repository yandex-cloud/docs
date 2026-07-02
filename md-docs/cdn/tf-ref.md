[Документация Yandex Cloud](../index.md) > [Yandex Cloud CDN](index.md) > Справочник Terraform

# Справочник Terraform для Yandex Cloud CDN

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Cloud CDN поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_cdn_origin_group](../terraform/resources/cdn_origin_group.md) | [Группа источников](concepts/origins.md#groups) |
| [yandex_cdn_resource](../terraform/resources/cdn_resource.md) | [CDN-ресурс](concepts/resource.md) |

## Источники данных {#data-sources}

Для Cloud CDN поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_cdn_origin_group](../terraform/data-sources/cdn_origin_group.md) | Информация о [группе источников](concepts/origins.md#groups) |
| [yandex_cdn_resource](../terraform/data-sources/cdn_resource.md) | Информация о [CDN-ресурсе](concepts/resource.md) |