---
title: "{{ TF }} reference for {{ iot-full-name }}"
description: "This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ iot-name }}."
---

# {{ TF }} reference for {{ iot-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ iot-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_iot_broker]({{ tf-provider-resources-link }}/iot_core_broker) | [Broker](./concepts/index.md#broker) |
| [yandex_iot_device]({{ tf-provider-resources-link }}/iot_core_device) | [Device](./concepts/index.md#device) |
| [yandex_iot_registry]({{ tf-provider-resources-link }}/iot_core_registry) | [Registry](./concepts/index.md#registry) |

## Data sources {#data-sources}

{{ iot-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_iot_broker]({{ tf-provider-datasources-link }}/datasource_iot_core_broker) | [Broker](./concepts/index.md#broker) information |
| [yandex_iot_device]({{ tf-provider-datasources-link }}/datasource_iot_core_device) | [Device](./concepts/index.md#device) information |
| [yandex_iot_registry]({{ tf-provider-datasources-link }}/datasource_iot_core_registry) | [Registry](./concepts/index.md#registry) information |