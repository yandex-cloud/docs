# Справочник {{ TF }} для {{ metastore-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ metastore-name }} поддерживается следующий ресурс провайдера {{ TF }}:

| **Ресурс {{ TF }}**                                                            | **Ресурс {{ yandex-cloud }}**                           |
|--------------------------------------------------------------------------------|---------------------------------------------------------|
| [yandex_metastore_cluster]({{ tf-provider-resources-link }}/metastore_cluster) | [Кластер {{ metastore-name }}](concepts/metastore.md) |
| [yandex_metastore_cluster_iam_binding]({{ tf-provider-resources-link }}/metastore_cluster_iam_binding) | [Настройка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру |

## Источники данных {#data-sources}

Для {{ metastore-name }} поддерживается следующий источник данных провайдера {{ TF }}:

| **Источник данных {{ TF }}**                                                     | **Описание**                                                          |
|----------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| [yandex_metastore_cluster]({{ tf-provider-datasources-link }}/metastore_cluster) | Информация о [кластере {{ metastore-name }}](concepts/metastore.md) |