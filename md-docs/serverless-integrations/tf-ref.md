# Справочник {{ TF }} для {{ si-full-name }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ si-full-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [serverless_eventrouter_bus]({{ tf-provider-resources-link }}/serverless_eventrouter_bus) | [Шина {{ er-name }}](concepts/eventrouter/bus.md) |
| [serverless_eventrouter_connector]({{ tf-provider-resources-link }}/serverless_eventrouter_connector) | [Коннектор {{ er-name }}](concepts/eventrouter/connector.md) |
| [serverless_eventrouter_rule]({{ tf-provider-resources-link }}/serverless_eventrouter_rule) | [Правило {{ er-name }}](concepts/eventrouter/rule.md) |

## Источники данных {#data-sources}

Для {{ si-full-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [serverless_eventrouter_bus]({{ tf-provider-datasources-link }}/serverless_eventrouter_bus) | Информация о [шине {{ er-name }}](concepts/eventrouter/bus.md) |
| [serverless_eventrouter_connector]({{ tf-provider-datasources-link }}/serverless_eventrouter_connector) | Информация о [коннекторе {{ er-name }}](concepts/eventrouter/connector.md) |
| [serverless_eventrouter_rule]({{ tf-provider-datasources-link }}/serverless_eventrouter_rule) | Информация о [правиле {{ er-name }}](concepts/eventrouter/rule.md) |