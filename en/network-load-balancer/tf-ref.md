---
title: '{{ TF }} reference for {{ network-load-balancer-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ network-load-balancer-name }}.
---

# {{ TF }} reference for {{ network-load-balancer-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ network-load-balancer-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_lb_network_load_balancer]({{ tf-provider-resources-link }}/lb_network_load_balancer) | [Network load balancer](./concepts/index.md) |
| [yandex_lb_target_group]({{ tf-provider-resources-link }}/lb_target_group) | [Target group](./concepts/target-resources.md) |

## Data sources {#data-sources}

{{ network-load-balancer-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_lb_network_load_balancer]({{ tf-provider-datasources-link }}/lb_network_load_balancer) | Information about a [network load balancer](./concepts/index.md) |
| [yandex_lb_target_group]({{ tf-provider-datasources-link }}/lb_target_group) | Information about a [target group](./concepts/target-resources.md) |