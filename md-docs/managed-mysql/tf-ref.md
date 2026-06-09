# Справочник {{ TF }} для {{ mmy-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ mmy-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_mdb_mysql_cluster]({{ tf-provider-resources-link }}/mdb_mysql_cluster) | [Кластер](concepts/index.md) |
| [yandex_mdb_mysql_cluster_iam_binding]({{ tf-provider-resources-link }}/mdb_mysql_cluster_iam_binding) | [Настройка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру |
| [yandex_mdb_mysql_database]({{ tf-provider-resources-link }}/mdb_mysql_database) | База данных |
| [yandex_mdb_mysql_user]({{ tf-provider-resources-link }}/mdb_mysql_user) | Пользователь базы данных |

## Источники данных {#data-sources}

Для {{ mmy-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_mdb_mysql_cluster]({{ tf-provider-datasources-link }}/mdb_mysql_cluster) | Информация о [кластере](concepts/index.md) |
| [yandex_mdb_mysql_database]({{ tf-provider-datasources-link }}/mdb_mysql_database) | Информация о базе данных |
| [yandex_mdb_mysql_user]({{ tf-provider-datasources-link }}/mdb_mysql_user) | Информация о пользователе базы данных |