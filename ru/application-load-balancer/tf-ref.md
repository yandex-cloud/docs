---
title: Справочник {{ TF }} для {{ alb-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ alb-name }}.
---

# Справочник {{ TF }} для {{ alb-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ alb-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group) | [Группа бэкендов](./concepts/backend-group.md) |
| [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router) | [HTTP-роутер](./concepts/http-router.md) |
| [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer) | [L7-балансировщик нагрузки](./concepts/application-load-balancer.md) |
| [yandex_alb_target_group]({{ tf-provider-resources-link }}/alb_target_group) | [Целевая группа](./concepts/target-group.md) |
| [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host) | [Виртуальный хост](./concepts/http-router.md#virtual-host) |

## Источники данных {#data-sources}

Для {{ alb-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_alb_backend_group]({{ tf-provider-datasources-link }}/alb_backend_group) | Информация о [группе бэкендов](./concepts/backend-group.md) |
| [yandex_alb_http_router]({{ tf-provider-datasources-link }}/alb_http_router) | Информация об [HTTP-роутере](./concepts/http-router.md) |
| [yandex_alb_load_balancer]({{ tf-provider-datasources-link }}/alb_load_balancer) | Информация об [L7-балансировщике нагрузки](./concepts/application-load-balancer.md) |
| [yandex_alb_target_group]({{ tf-provider-datasources-link }}/alb_target_group) | Информация о [целевой группе](./concepts/target-group.md) |
| [yandex_alb_virtual_host]({{ tf-provider-datasources-link }}/alb_virtual_host) | Информация о [виртуальном хосте](./concepts/http-router.md#virtual-host) |
