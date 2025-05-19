---
title: '{{ TF }} reference for {{ alb-full-name }}'
description: This page provides information about {{ TF }} resources and data sources supported by {{ alb-name }}.
---

# {{ TF }} reference for {{ alb-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ alb-name }} supports the following {{ TF }} resources :

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group) | [Backend group](./concepts/backend-group.md) |
| [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router) | [HTTP router](./concepts/http-router.md) |
| [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer) | [L7 load balancer](./concepts/application-load-balancer.md) |
| [yandex_alb_target_group]({{ tf-provider-resources-link }}/alb_target_group) | [Target group](./concepts/target-group.md) |
| [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host) | [Virtual host](./concepts/http-router.md#virtual-host) |

## Data sources {#data-sources}

{{ alb-name }} supports the following {{ TF }} data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_alb_backend_group]({{ tf-provider-datasources-link }}/alb_backend_group) | [Backend group](./concepts/backend-group.md) information |
| [yandex_alb_http_router]({{ tf-provider-datasources-link }}/alb_http_router) | [HTTP router](./concepts/http-router.md) information |
| [yandex_alb_load_balancer]({{ tf-provider-datasources-link }}/alb_load_balancer) | [L7 load balancer](./concepts/application-load-balancer.md) information |
| [yandex_alb_target_group]({{ tf-provider-datasources-link }}/alb_target_group) | [Target group](./concepts/target-group.md) information |
| [yandex_alb_virtual_host]({{ tf-provider-datasources-link }}/alb_virtual_host) | [Virtual host](./concepts/http-router.md#virtual-host) information |