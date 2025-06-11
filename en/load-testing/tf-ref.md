---
title: '{{ TF }} reference for {{ load-testing-full-name }}'
description: This page provides information about the {{ TF }} provider’s resources and data sources that {{ load-testing-name }} supports.
---

# {{ TF }} reference for {{ load-testing-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ load-testing-name }} supports the {{ TF }} provider’s following resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_loadtesting_agent]({{ tf-provider-resources-link }}/loadtesting_agent) | [Agent](./concepts/agent.md) |

## Data sources {#data-sources}

{{ load-testing-name }} supports the {{ TF }} provider’s following data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_loadtesting_agent]({{ tf-provider-datasources-link }}/loadtesting_agent) | [Agent](./concepts/agent.md) details |