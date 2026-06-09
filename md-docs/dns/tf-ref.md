# Справочник {{ TF }} для {{ dns-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ dns-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset) | [Ресурсная запись](concepts/resource-record.md) |
| [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone) | [Зона DNS](concepts/dns-zone.md) |
| [yandex_dns_zone_iam_binding]({{ tf-provider-resources-link }}/dns_zone_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к зоне DNS |

## Источники данных {#data-sources}

Для {{ dns-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_dns_zone]({{ tf-provider-datasources-link }}/dns_zone) | Информация о [зоне DNS](concepts/dns-zone.md) |