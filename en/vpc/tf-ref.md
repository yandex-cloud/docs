---
title: '{{ TF }} reference for {{ vpc-full-name }}'
description: This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ vpc-name }}.
---

# {{ TF }} reference for {{ vpc-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ vpc-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_vpc_address]({{ tf-provider-resources-link }}/vpc_address) | [Cloud resource address](./concepts/address.md) |
| [yandex_vpc_default_security_group]({{ tf-provider-resources-link }}/vpc_default_security_group) | Default [security group](./concepts/security-groups.md) |
| [yandex_vpc_gateway]({{ tf-provider-resources-link }}/vpc_gateway) | [Gateway](./concepts/gateways.md) |
| [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network) | [Cloud network](./concepts/network.md#network) |
| [yandex_vpc_route_table]({{ tf-provider-resources-link }}/vpc_route_table) | [Route table](./concepts/routing.md#rt-vpc) |
| [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group) | [Security group](./concepts/security-groups.md) |
| [yandex_vpc_security_group_rule]({{ tf-provider-resources-link }}/vpc_security_group_rule) | [Security group rule](./concepts/security-groups.md#security-groups-rules) |
| [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet) | [Subnet](./concepts/network.md#subnet) |

## Data sources {#data-sources}

{{ vpc-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_vpc_address]({{ tf-provider-datasources-link }}/vpc_address) | Information on a [cloud resource address](./concepts/address.md) |
| [yandex_vpc_gateway]({{ tf-provider-datasources-link }}/vpc_gateway) | [Gateway](./concepts/gateways.md) information |
| [yandex_vpc_network]({{ tf-provider-datasources-link }}/vpc_network) | [Cloud network](./concepts/network.md#network) information |
| [yandex_vpc_route_table]({{ tf-provider-datasources-link }}/vpc_route_table) | [Route table](./concepts/routing.md#rt-vpc) information |
| [yandex_vpc_security_group]({{ tf-provider-datasources-link }}/vpc_security_group) | [Security group](./concepts/security-groups.md) information |
| [yandex_vpc_security_group_rule]({{ tf-provider-datasources-link }}/vpc_security_group_rule) | Information on a [security group rule](./concepts/security-groups.md#security-groups-rules) |
| [yandex_vpc_subnet]({{ tf-provider-datasources-link }}/vpc_subnet) | [Subnet](./concepts/network.md#subnet) information |