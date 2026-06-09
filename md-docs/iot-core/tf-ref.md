# Справочник {{ TF }} для {{ iot-full-name }}

{% note warning %}

Сервис {{ iot-full-name }} больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](sunset.md).

{% endnote %}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Ресурсы {#resources}

Для {{ iot-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_iot_broker]({{ tf-provider-resources-link }}/iot_core_broker) | [Брокер](concepts/index.md#broker) |
| [yandex_iot_device]({{ tf-provider-resources-link }}/iot_core_device) | [Устройство](concepts/index.md#device) |
| [yandex_iot_registry]({{ tf-provider-resources-link }}/iot_core_registry) | [Реестр](concepts/index.md#registry) |

## Источники данных {#data-sources}

Для {{ iot-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_iot_broker]({{ tf-provider-datasources-link }}/iot_core_broker) | Информация о [брокере](concepts/index.md#broker) |
| [yandex_iot_device]({{ tf-provider-datasources-link }}/iot_core_device) | Информация об [устройстве](concepts/index.md#device) |
| [yandex_iot_registry]({{ tf-provider-datasources-link }}/iot_core_registry) | Информация о [реестре](concepts/index.md#registry) |