---
title: '{{ TF }} reference for {{ iot-full-name }}'
description: This page lists {{ TF }} provider resources and data sources supported by {{ iot-name }}.
---

# {{ TF }} reference for {{ iot-full-name }}

{% include [iot-sunset-warning](../_includes/iot-core/sunset-warning.md) %}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ iot-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_iot_broker]({{ tf-provider-resources-link }}/iot_core_broker) | [Broker](./concepts/index.md#broker) |
| [yandex_iot_device]({{ tf-provider-resources-link }}/iot_core_device) | [Device](./concepts/index.md#device) |
| [yandex_iot_registry]({{ tf-provider-resources-link }}/iot_core_registry) | [Registry](./concepts/index.md#registry) |

## Data sources {#data-sources}

{{ iot-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_iot_broker]({{ tf-provider-datasources-link }}/iot_core_broker) | [Broker](./concepts/index.md#broker) information |
| [yandex_iot_device]({{ tf-provider-datasources-link }}/iot_core_device) | [Device](./concepts/index.md#device) information |
| [yandex_iot_registry]({{ tf-provider-datasources-link }}/iot_core_registry) | [Registry](./concepts/index.md#registry) information |