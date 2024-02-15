# Справочник ресурсов {{ mkf-full-name }} провайдера {{ TF }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). {{ TF }} и его провайдеры распространяются под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE). 

При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


Для {{ mkf-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_mdb_kafka_cluster]({{ tf-provider-resources-link }}/mdb_kafka_cluster) | [Кластер {{ KF }}](./concepts/index.md) |
| [yandex_mdb_kafka_connect]({{ tf-provider-resources-link }}/mdb_kafka_connect) | [Коннектор](./concepts/connectors.md) |
| [yandex_mdb_kafka_topic]({{ tf-provider-resources-link }}/mdb_kafka_topic) | [Топик](./concepts/topics.md) |
| [yandex_mdb_kafka_user]({{ tf-provider-resources-link }}/mdb_kafka_user) | [Пользователь](./concepts/managed-schema-registry.md#msr-auth) |