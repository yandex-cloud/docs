[Документация Yandex Cloud](../index.md) > [Yandex MetaData Hub](index.md) > Data Catalog > Справочник Terraform

# Справочник Terraform для Data Catalog

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Yandex MetaData Hub поддерживается следующий ресурс провайдера Terraform:

| **Ресурс Terraform**                                                                | **Ресурс Yandex Cloud**                    |
|------------------------------------------------------------------------------------|--------------------------------------------------|
| [yandex_datacatalog_catalog](../terraform/resources/datacatalog_catalog.md) | [Каталог метаданных](concepts/data-catalog.md) |

## Источники данных {#data-sources}

Для Yandex MetaData Hub поддерживается следующий источник данных провайдера Terraform:

| **Источник данных Terraform**                                                         | **Описание**                                                   |
|--------------------------------------------------------------------------------------|----------------------------------------------------------------|
| [yandex_datacatalog_catalog](../terraform/data-sources/datacatalog_catalog.md) | Информация о [каталоге метаданных](concepts/data-catalog.md) |