[Документация Yandex Cloud](../index.md) > [Yandex MPP Analytics for PostgreSQL](index.md) > Справочник Terraform

# Справочник Terraform для Yandex MPP Analytics for PostgreSQL

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Yandex MPP Analytics for PostgreSQL поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_mdb_greenplum_cluster](../terraform/resources/mdb_greenplum_cluster.md) | [Кластер](concepts/index.md) |
| [yandex_mdb_greenplum_cluster_iam_binding](../terraform/resources/mdb_greenplum_cluster_iam_binding.md) | [Настройка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру |

## Источники данных {#data-sources}

Для Yandex MPP Analytics for PostgreSQL поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_mdb_greenplum_cluster](../terraform/data-sources/mdb_greenplum_cluster.md) | Информация о [кластере](concepts/index.md) |