---
title: '{{ TF }} reference for {{ load-testing-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ load-testing-name }}.
---

# {{ TF }} reference for {{ load-testing-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ load-testing-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_loadtesting_agent]({{ tf-provider-resources-link }}/loadtesting_agent) | [Agent](./concepts/agent.md) |

## Data sources {#data-sources}

{{ load-testing-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_loadtesting_agent]({{ tf-provider-datasources-link }}/datasource_loadtesting_agent) | [Agent](./concepts/agent.md) information |