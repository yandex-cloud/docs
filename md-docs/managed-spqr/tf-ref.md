# Справочник Terraform для Yandex Managed Service for Sharded PostgreSQL

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Managed Service for Sharded PostgreSQL поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform**                                                                                        | **Ресурс Yandex Cloud**                        |
|------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [yandex_mdb_sharded_postgresql_cluster](../terraform/resources/mdb_sharded_postgresql_cluster.md)   | [Кластер Sharded PostgreSQL](operations/cluster-create.md) |
| [yandex_mdb_sharded_postgresql_cluster_iam_binding](../terraform/resources/mdb_sharded_postgresql_cluster_iam_binding.md) | [Настройка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру |
| [yandex_mdb_sharded_postgresql_database](../terraform/resources/mdb_sharded_postgresql_database.md) | [База данных Sharded PostgreSQL](operations/connect.md)      |
| [yandex_mdb_sharded_postgresql_shard](../terraform/resources/mdb_sharded_postgresql_shard.md)       | [Шард Sharded PostgreSQL](concepts/index.md#shard)         |
| [yandex_mdb_sharded_postgresql_user](../terraform/resources/mdb_sharded_postgresql_user.md)         | Пользователь Sharded PostgreSQL                              |