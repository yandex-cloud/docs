# Справочник Terraform для Yandex IoT Core

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для Yandex IoT Core поддерживаются следующие ресурсы провайдера Terraform:

| **Ресурс Terraform** | **Ресурс Yandex Cloud** |
| --- | --- |
| [yandex_iot_broker](../terraform/resources/iot_core_broker.md) | [Брокер](concepts/index.md#broker) |
| [yandex_iot_device](../terraform/resources/iot_core_device.md) | [Устройство](concepts/index.md#device) |
| [yandex_iot_registry](../terraform/resources/iot_core_registry.md) | [Реестр](concepts/index.md#registry) |

## Источники данных {#data-sources}

Для Yandex IoT Core поддерживаются следующие источники данных провайдера Terraform:

| **Источник данных Terraform** | **Описание** |
| --- | --- |
| [yandex_iot_broker](../terraform/data-sources/iot_core_broker.md) | Информация о [брокере](concepts/index.md#broker) |
| [yandex_iot_device](../terraform/data-sources/iot_core_device.md) | Информация об [устройстве](concepts/index.md#device) |
| [yandex_iot_registry](../terraform/data-sources/iot_core_registry.md) | Информация о [реестре](concepts/index.md#registry) |