# Справочник Terraform для Yandex Serverless Integrations

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Yandex Serverless Integrations поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [serverless_eventrouter_bus](../terraform/resources/serverless_eventrouter_bus.md) | [Шина EventRouter](concepts/eventrouter/bus.md) |
| [serverless_eventrouter_connector](../terraform/resources/serverless_eventrouter_connector.md) | [Коннектор EventRouter](concepts/eventrouter/connector.md) |
| [serverless_eventrouter_rule](../terraform/resources/serverless_eventrouter_rule.md) | [Правило EventRouter](concepts/eventrouter/rule.md) |

## Источники данных {#data-sources}

Для Yandex Serverless Integrations поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [serverless_eventrouter_bus](../terraform/data-sources/serverless_eventrouter_bus.md) | Информация о [шине EventRouter](concepts/eventrouter/bus.md) |
| [serverless_eventrouter_connector](../terraform/data-sources/serverless_eventrouter_connector.md) | Информация о [коннекторе EventRouter](concepts/eventrouter/connector.md) |
| [serverless_eventrouter_rule](../terraform/data-sources/serverless_eventrouter_rule.md) | Информация о [правиле EventRouter](concepts/eventrouter/rule.md) |