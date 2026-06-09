# Справочник {{ TF }} для {{ cdn-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ cdn-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_cdn_origin_group]({{ tf-provider-resources-link }}/cdn_origin_group) | [Группа источников](concepts/origins.md#groups) |
| [yandex_cdn_resource]({{ tf-provider-resources-link }}/cdn_resource) | [CDN-ресурс](concepts/resource.md) |

## Источники данных {#data-sources}

Для {{ cdn-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_cdn_origin_group]({{ tf-provider-datasources-link }}/cdn_origin_group) | Информация о [группе источников](concepts/origins.md#groups) |
| [yandex_cdn_resource]({{ tf-provider-datasources-link }}/cdn_resource) | Информация о [CDN-ресурсе](concepts/resource.md) |