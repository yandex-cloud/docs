# Справочник Terraform для Yandex Managed Service for Trino

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Managed Service for Trino поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_trino_cluster](../terraform/resources/trino_cluster.md) | Кластер |
| [yandex_trino_cluster_iam_binding](../terraform/resources/trino_cluster_iam_binding.md) | [Настройка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру |
| [yandex_trino_catalog](../terraform/resources/trino_catalog.md) | Каталог |

## Источники данных {#data-sources}

Для Managed Service for Trino поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_trino_cluster](../terraform/data-sources/trino_cluster.md) | Информация о [кластере Trino](concepts/index.md#cluster-architecture) |
| [yandex_trino_catalog](../terraform/data-sources/trino_catalog.md) | Информация о [каталоге Trino](concepts/index.md#catalog) |