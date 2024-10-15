---
title: Справочник {{ TF }} для {{ vpc-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ vpc-name }}.
---

# Справочник {{ TF }} для {{ vpc-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ vpc-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_vpc_address]({{ tf-provider-resources-link }}/vpc_address) | [Адрес облачного ресурса](./concepts/address.md) |
| [yandex_vpc_default_security_group]({{ tf-provider-resources-link }}/vpc_default_security_group) | [Группа безопасности](./concepts/security-groups.md) по умолчанию |
| [yandex_vpc_gateway]({{ tf-provider-resources-link }}/vpc_gateway) | [Шлюз](./concepts/gateways.md) |
| [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network) | [Облачная сеть](./concepts/network.md#network) |
| [yandex_vpc_route_table]({{ tf-provider-resources-link }}/vpc_route_table) | [Таблица маршрутизации](./concepts/routing.md#rt-vpc) |
| [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group) | [Группа безопасности](./concepts/security-groups.md) |
| [yandex_vpc_security_group_rule]({{ tf-provider-resources-link }}/vpc_security_group_rule) | [Правило группы безопасности](./concepts/security-groups.md#security-groups-rules) |
| [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet) | [Подсеть](./concepts/network.md#subnet) |

## Источники данных {#data-sources}

Для {{ vpc-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_vpc_address]({{ tf-provider-datasources-link }}/vpc_address) | Информация об [адресе облачного ресурса](./concepts/address.md) |
| [yandex_vpc_gateway]({{ tf-provider-datasources-link }}/vpc_gateway) | Информация о [шлюзе](./concepts/gateways.md) |
| [yandex_vpc_network]({{ tf-provider-datasources-link }}/vpc_network) | Информация об [облачной сети](./concepts/network.md#network) |
| [yandex_vpc_route_table]({{ tf-provider-datasources-link }}/vpc_route_table) | Информация о [таблице маршрутизации](./concepts/routing.md#rt-vpc) |
| [yandex_vpc_security_group]({{ tf-provider-datasources-link }}/vpc_security_group) | Информация о [группе безопасности](./concepts/security-groups.md) |
| [yandex_vpc_security_group_rule]({{ tf-provider-datasources-link }}/vpc_security_group_rule) | Информация о [правиле группы безопасности](./concepts/security-groups.md#security-groups-rules) |
| [yandex_vpc_subnet]({{ tf-provider-datasources-link }}/vpc_subnet) | Информация о [подсети](./concepts/network.md#subnet) |
