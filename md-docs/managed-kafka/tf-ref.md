[Документация Yandex Cloud](../index.md) > [Yandex Managed Service for Apache Kafka®](index.md) > Справочник Terraform

# Справочник Terraform для Yandex Managed Service for Apache Kafka®

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Managed Service for Apache Kafka® поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_mdb_kafka_cluster](../terraform/resources/mdb_kafka_cluster.md) | [Кластер Apache Kafka®](concepts/index.md) |
| [yandex_mdb_kafka_cluster_iam_binding](../terraform/resources/mdb_kafka_cluster_iam_binding.md) | [Настройка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру |
| [yandex_mdb_kafka_connect](../terraform/resources/mdb_kafka_connector.md) | [Коннектор](concepts/connectors.md) |
| [yandex_mdb_kafka_topic](../terraform/resources/mdb_kafka_topic.md) | [Топик](concepts/topics.md) |
| [yandex_mdb_kafka_user](../terraform/resources/mdb_kafka_user.md) | [Пользователь](concepts/managed-schema-registry.md#msr-auth) |

## Источники данных {#data-sources}

Для Managed Service for Apache Kafka® поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_mdb_kafka_cluster](../terraform/data-sources/mdb_kafka_cluster.md) | Информация о [кластере Apache Kafka®](concepts/index.md) |
| [yandex_mdb_kafka_connector](../terraform/data-sources/mdb_kafka_connector.md) | Информация о [коннекторе](concepts/connectors.md) |
| [yandex_mdb_kafka_topic](../terraform/data-sources/mdb_kafka_topic.md) | Информация о [топике](concepts/topics.md) |
| [yandex_mdb_kafka_user](../terraform/data-sources/mdb_kafka_user.md) | Информация о [пользователе](concepts/managed-schema-registry.md#msr-auth) |