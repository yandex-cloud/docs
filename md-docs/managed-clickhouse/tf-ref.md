[Документация Yandex Cloud](../index.md) > [Yandex Managed Service for ClickHouse®](index.md) > Справочник Terraform

# Справочник Terraform для Yandex Managed Service for ClickHouse®

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Managed Service for ClickHouse® поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_mdb_clickhouse_cluster](../terraform/resources/mdb_clickhouse_cluster.md) | [Кластер](concepts/index.md) |
| [yandex_mdb_clickhouse_cluster_v2](../terraform/resources/mdb_clickhouse_cluster_v2.md) | Кластер |
| [yandex_mdb_clickhouse_cluster_iam_binding](../terraform/resources/mdb_clickhouse_cluster_iam_binding.md) | [Настройка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру |
| [yandex_mdb_clickhouse_database](../terraform/resources/mdb_clickhouse_database.md) | База данных |
| [yandex_mdb_clickhouse_user](../terraform/resources/mdb_clickhouse_user.md) | Пользователь Managed Service for ClickHouse® |

## Источники данных {#data-sources}

Для Managed Service for ClickHouse® поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_mdb_clickhouse_cluster](../terraform/data-sources/mdb_clickhouse_cluster.md) | Информация о [кластере](concepts/index.md) |
| [yandex_mdb_clickhouse_cluster_v2](../terraform/data-sources/mdb_clickhouse_cluster_v2.md) | Информация о кластере |
| [yandex_mdb_clickhouse_database](../terraform/data-sources/mdb_clickhouse_database.md) | Информация о базе данных |
| [yandex_mdb_clickhouse_user](../terraform/data-sources/mdb_clickhouse_user.md) | Информация о пользователе Managed Service for ClickHouse® |

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._