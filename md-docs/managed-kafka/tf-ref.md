# Справочник {{ TF }} для {{ mkf-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ mkf-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_mdb_kafka_cluster]({{ tf-provider-resources-link }}/mdb_kafka_cluster) | [Кластер {{ KF }}](concepts/index.md) |
| [yandex_mdb_kafka_cluster_iam_binding]({{ tf-provider-resources-link }}/mdb_kafka_cluster_iam_binding) | [Настройка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру |
| [yandex_mdb_kafka_connect]({{ tf-provider-resources-link }}/mdb_kafka_connector) | [Коннектор](concepts/connectors.md) |
| [yandex_mdb_kafka_topic]({{ tf-provider-resources-link }}/mdb_kafka_topic) | [Топик](concepts/topics.md) |
| [yandex_mdb_kafka_user]({{ tf-provider-resources-link }}/mdb_kafka_user) | [Пользователь](concepts/managed-schema-registry.md#msr-auth) |

## Источники данных {#data-sources}

Для {{ mkf-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_mdb_kafka_cluster]({{ tf-provider-datasources-link }}/mdb_kafka_cluster) | Информация о [кластере {{ KF }}](concepts/index.md) |
| [yandex_mdb_kafka_connector]({{ tf-provider-datasources-link }}/mdb_kafka_connector) | Информация о [коннекторе](concepts/connectors.md) |
| [yandex_mdb_kafka_topic]({{ tf-provider-datasources-link }}/mdb_kafka_topic) | Информация о [топике](concepts/topics.md) |
| [yandex_mdb_kafka_user]({{ tf-provider-datasources-link }}/mdb_kafka_user) | Информация о [пользователе](concepts/managed-schema-registry.md#msr-auth) |