---
title: Справочник {{ TF }} для {{ network-load-balancer-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ network-load-balancer-name }}.
---

# Справочник {{ TF }} для {{ network-load-balancer-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ network-load-balancer-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_lb_network_load_balancer]({{ tf-provider-resources-link }}/lb_network_load_balancer) | [Сетевой балансировщик нагрузки](./concepts/index.md) |
| [yandex_lb_target_group]({{ tf-provider-resources-link }}/lb_target_group) | [Целевая группа](./concepts/target-resources.md) |

## Источники данных {#data-sources}

Для {{ network-load-balancer-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_lb_network_load_balancer]({{ tf-provider-datasources-link }}/lb_network_load_balancer) | Информация о [сетевом балансировщике нагрузки](./concepts/index.md) |
| [yandex_lb_target_group]({{ tf-provider-datasources-link }}/lb_target_group) | Информация о [целевой группе](./concepts/target-resources.md) |