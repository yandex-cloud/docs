---
title: "{{ TF }} reference for {{ alb-full-name }}"
description: "This page provides reference information about the {{ TF }} provider resources and data sources supported for {{ alb-name }}."
---

# {{ TF }} reference for {{ alb-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ alb-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group) | [Backend group](./concepts/backend-group.md) |
| [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router) | [HTTP router](./concepts/http-router.md) |
| [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer) | [L7 load balancer](./concepts/application-load-balancer.md) |
| [yandex_alb_target_group]({{ tf-provider-resources-link }}/alb_target_group) | [Target group](./concepts/target-group.md) |
| [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host) | [Virtual host](./concepts/http-router.md#virtual-host) |

## Data sources {#data-sources}

{{ alb-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_alb_backend_group]({{ tf-provider-datasources-link }}/datasource_alb_backend_group) | Information about a [backend group](./concepts/backend-group.md) |
| [yandex_alb_http_router]({{ tf-provider-datasources-link }}/datasource_alb_http_router) | Information about an [HTTP router](./concepts/http-router.md) |
| [yandex_alb_load_balancer]({{ tf-provider-datasources-link }}/datasource_alb_load_balancer) | Information about an [L7 load balancer](./concepts/application-load-balancer.md) |
| [yandex_alb_target_group]({{ tf-provider-datasources-link }}/datasource_alb_target_group) | Information about a [target group](./concepts/target-group.md) |
| [yandex_alb_virtual_host]({{ tf-provider-datasources-link }}/datasource_alb_virtual_host) | Information about a [virtual host](./concepts/http-router.md#virtual-host) |