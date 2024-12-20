---
title: '{{ TF }} reference for {{ si-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ si-full-name }}.
---

# {{ TF }} reference for {{ si-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ si-full-name }}:

| **{{ TF }}** resource | **{{ yandex-cloud }}** resource |
| --- | --- |
| [serverless_eventrouter_bus]({{ tf-provider-resources-link }}/serverless_eventrouter_bus) | [{{ er-name }} bus](./concepts/eventrouter/bus.md) |
| [serverless_eventrouter_connector]({{ tf-provider-resources-link }}/serverless_eventrouter_connector) | [{{ er-name }} connector](./concepts/eventrouter/connector.md) |
| [serverless_eventrouter_rule]({{ tf-provider-resources-link }}/serverless_eventrouter_rule) | [{{ er-name }} rule](./concepts/eventrouter/rule.md) |

## Data sources {#data-sources}

{{ si-full-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }}** data source | **Description** |
| --- | --- |
| [serverless_eventrouter_bus]({{ tf-provider-datasources-link }}/serverless_eventrouter_bus) | [{{ er-name }} bus](./concepts/eventrouter/bus.md) information |
| [serverless_eventrouter_connector]({{ tf-provider-datasources-link }}/serverless_eventrouter_connector) | [{{ er-name }} connector](./concepts/eventrouter/connector.md) information |
| [serverless_eventrouter_rule]({{ tf-provider-datasources-link }}/serverless_eventrouter_rule) | [{{ er-name }} rule](./concepts/eventrouter/rule.md) information |