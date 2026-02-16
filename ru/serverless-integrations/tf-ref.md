---
title: Справочник {{ TF }} для {{ si-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для {{ si-full-name }}.
---

# Справочник {{ TF }} для {{ si-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ si-full-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [serverless_eventrouter_bus]({{ tf-provider-resources-link }}/serverless_eventrouter_bus) | [Шина {{ er-name }}](./concepts/eventrouter/bus.md) |
| [serverless_eventrouter_connector]({{ tf-provider-resources-link }}/serverless_eventrouter_connector) | [Коннектор {{ er-name }}](./concepts/eventrouter/connector.md) |
| [serverless_eventrouter_rule]({{ tf-provider-resources-link }}/serverless_eventrouter_rule) | [Правило {{ er-name }}](./concepts/eventrouter/rule.md) |

## Источники данных {#data-sources}

Для {{ si-full-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [serverless_eventrouter_bus]({{ tf-provider-datasources-link }}/serverless_eventrouter_bus) | Информация о [шине {{ er-name }}](./concepts/eventrouter/bus.md) |
| [serverless_eventrouter_connector]({{ tf-provider-datasources-link }}/serverless_eventrouter_connector) | Информация о [коннекторе {{ er-name }}](./concepts/eventrouter/connector.md) |
| [serverless_eventrouter_rule]({{ tf-provider-datasources-link }}/serverless_eventrouter_rule) | Информация о [правиле {{ er-name }}](./concepts/eventrouter/rule.md) |
