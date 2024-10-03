---
title: Справочник {{ TF }} для {{ iot-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ iot-name }}.
---

# Справочник {{ TF }} для {{ iot-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ iot-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_iot_broker]({{ tf-provider-resources-link }}/iot_core_broker) | [Брокер](./concepts/index.md#broker) |
| [yandex_iot_device]({{ tf-provider-resources-link }}/iot_core_device) | [Устройство](./concepts/index.md#device) |
| [yandex_iot_registry]({{ tf-provider-resources-link }}/iot_core_registry) | [Реестр](./concepts/index.md#registry) |

## Источники данных {#data-sources}

Для {{ iot-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_iot_broker]({{ tf-provider-datasources-link }}/datasource_iot_core_broker) | Информация о [брокере](./concepts/index.md#broker) |
| [yandex_iot_device]({{ tf-provider-datasources-link }}/datasource_iot_core_device) | Информация об [устройстве](./concepts/index.md#device) |
| [yandex_iot_registry]({{ tf-provider-datasources-link }}/datasource_iot_core_registry) | Информация о [реестре](./concepts/index.md#registry) |