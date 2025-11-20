---
title: '{{ TF }} reference for {{ connection-manager-name }}'
description: This page presents reference information on the {{ TF }} provider resources and data sources supported for {{ connection-manager-name }} in {{ metadata-hub-full-name }}.
---

# {{ TF }} reference for {{ connection-manager-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

For {{ connection-manager-name }}, the following {{ TF }} provider resource is supported:

| **{{ TF }} resource**                                       | **{{ yandex-cloud }} resource**                   |
|-----------------------------------------------------------|-------------------------------------------------|
| [yandex_connectionmanager_connection]({{ tf-provider-resources-link }}/connectionmanager_connection) | [Connection](./concepts/connection-manager.md) |

## Data sources {#data-sources}

For {{ connection-manager-name }}, the following {{ TF }} data source is supported:

| **{{ TF }} data source** | **Description**                                    |
| --- |-------------------------------------------------|
| [yandex_connectionmanager_connection]({{ tf-provider-datasources-link }}/connectionmanager_connection) | [Connection](./concepts/connection-manager.md) information |