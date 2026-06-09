# Справочник {{ TF }} для {{ mspqr-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ mspqr-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}**                                                                                        | **Ресурс {{ yandex-cloud }}**                        |
|------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [yandex_mdb_sharded_postgresql_cluster]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster)   | [Кластер {{ SPQR }}](operations/cluster-create.md) |
| [yandex_mdb_sharded_postgresql_cluster_iam_binding]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_cluster_iam_binding) | [Настройка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру |
| [yandex_mdb_sharded_postgresql_database]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_database) | [База данных {{ SPQR }}](operations/connect.md)      |
| [yandex_mdb_sharded_postgresql_shard]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_shard)       | [Шард {{ SPQR }}](concepts/index.md#shard)         |
| [yandex_mdb_sharded_postgresql_user]({{ tf-provider-resources-link }}/mdb_sharded_postgresql_user)         | Пользователь {{ SPQR }}                              |