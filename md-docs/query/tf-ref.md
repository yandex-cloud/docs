# Справочник Terraform для Yandex Query

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Query поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_yq_ydb_connection](../terraform/resources/yq_ydb_connection.md) | [Соединение Managed Service for YDB](concepts/glossary.md#connection) |
| [yandex_yq_yds_connection](../terraform/resources/yq_yds_connection.md) | [Соединение Data Streams](concepts/glossary.md#connection) |
| [yandex_yq_yds_binding](../terraform/resources/yq_yds_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к [соединению Data Streams](concepts/glossary.md#connection) |
| [yandex_yq_monitoring_connection](../terraform/resources/yq_monitoring_connection.md) | [Соединение Yandex Monitoring](concepts/glossary.md#connection) |
| [yandex_yq_object_storage_connection](../terraform/resources/yq_object_storage_connection.md) | [Соединение Object Storage](concepts/glossary.md#connection) |
| [yandex_yq_object_storage_binding](../terraform/resources/yq_object_storage_binding.md) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к [соединению Object Storage](concepts/glossary.md#connection) |