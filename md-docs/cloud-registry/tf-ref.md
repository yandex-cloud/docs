# Справочник {{ TF }} для {{ cloud-registry-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ cloud-registry-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_cloudregistry_registry]({{ tf-provider-resources-link }}/cloudregistry_registry) | [Реестр](concepts/registry.md) |
| [yandex_cloudregistry_registry_iam_binding]({{ tf-provider-resources-link }}/cloudregistry_registry_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к реестру |
| [yandex_cloudregistry_registry_ip_permission]({{ tf-provider-resources-link }}/cloudregistry_registry_ip_permission) | Политика доступа для IP-адресов |

## Источники данных {#data-sources}

Для {{ cloud-registry-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_cloudregistry_registry]({{ tf-provider-datasources-link }}/cloudregistry_registry) | Информация о [реестре](concepts/registry.md) |
| [yandex_cloudregistry_registry_ip_permission]({{ tf-provider-datasources-link }}/cloudregistry_registry_ip_permission) | Информация о политике доступа для IP-адресов |