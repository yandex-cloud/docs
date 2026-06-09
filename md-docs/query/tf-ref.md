# Справочник {{ TF }} для {{ yq-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ yq-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_yq_ydb_connection]({{ tf-provider-resources-link }}/yq_ydb_connection) | [Соединение {{ ydb-name }}](concepts/glossary.md#connection) |
| [yandex_yq_yds_connection]({{ tf-provider-resources-link }}/yq_yds_connection) | [Соединение {{ yds-name }}](concepts/glossary.md#connection) |
| [yandex_yq_yds_binding]({{ tf-provider-resources-link }}/yq_yds_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к [соединению {{ yds-name }}](concepts/glossary.md#connection) |
| [yandex_yq_monitoring_connection]({{ tf-provider-resources-link }}/yq_monitoring_connection) | [Соединение {{ monitoring-full-name }}](concepts/glossary.md#connection) |
| [yandex_yq_object_storage_connection]({{ tf-provider-resources-link }}/yq_object_storage_connection) | [Соединение {{ objstorage-name }}](concepts/glossary.md#connection) |
| [yandex_yq_object_storage_binding]({{ tf-provider-resources-link }}/yq_object_storage_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к [соединению {{ objstorage-name }}](concepts/glossary.md#connection) |