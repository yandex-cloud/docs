---
title: '{{ TF }} reference for {{ network-load-balancer-full-name }}'
description: This page provides information about {{ TF }} resources and data sources supported by {{ network-load-balancer-name }}.
---

# {{ TF }} reference for {{ network-load-balancer-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ network-load-balancer-name }} supports the following {{ TF }} resources :

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_lb_network_load_balancer]({{ tf-provider-resources-link }}/lb_network_load_balancer) | [Network load balancer](./concepts/index.md) |
| [yandex_lb_target_group]({{ tf-provider-resources-link }}/lb_target_group) | [Target group](./concepts/target-resources.md) |

## Data sources {#data-sources}

{{ network-load-balancer-name }} supports the following {{ TF }} data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_lb_network_load_balancer]({{ tf-provider-datasources-link }}/lb_network_load_balancer) | [Network load balancer](./concepts/index.md) information |
| [yandex_lb_target_group]({{ tf-provider-datasources-link }}/lb_target_group) | [Target group](./concepts/target-resources.md) information |