---
title: Справочник {{ TF }} для {{ sf-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ sf-name }}.
---

# Справочник {{ TF }} для {{ sf-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ sf-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_function]({{ tf-provider-resources-link }}/function) | [Функция](./concepts/function.md) |
| [yandex_function_iam_binding]({{ tf-provider-resources-link }}/function_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к функции |
| [yandex_function_scaling_policy]({{ tf-provider-resources-link }}/function_scaling_policy) | [Настройки масштабирования функции](./concepts/function.md#scaling) |
| [yandex_function_trigger]({{ tf-provider-resources-link }}/function_trigger) | [Триггер](./concepts/trigger/index.md) |

## Источники данных {#data-sources}

Для {{ sf-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_function]({{ tf-provider-datasources-link }}/datasource_function) | Информация о [функции](./concepts/function.md) |
| [yandex_function_scaling_policy]({{ tf-provider-datasources-link }}/datasource_function_scaling_policy) | Информация о [настройках масштабирования функции](./concepts/function.md#scaling) |
| [yandex_function_trigger]({{ tf-provider-datasources-link }}/datasource_function_trigger) | Информация о [триггере](./concepts/trigger/index.md) |