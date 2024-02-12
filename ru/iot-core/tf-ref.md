# Справочник ресурсов {{ iot-full-name }} провайдера {{ TF }}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). {{ TF }} и его провайдеры распространяются под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE). 

При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
Подробнее о {{ TF }} [читайте в документации](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

Для {{ iot-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_iot_core_broker]({{ tf-provider-resources-link }}/iot_core_broker) | [Брокер](./concepts/index.md#broker) |
| [yandex_iot_core_device]({{ tf-provider-resources-link }}/iot_core_device) | [Устройство](./concepts/index.md#device) |
| [yandex_iot_core_registry]({{ tf-provider-resources-link }}/iot_core_registry) | [Реестр](./concepts/index.md#registry) |
