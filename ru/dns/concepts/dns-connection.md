---
title: DNS-подключения в облачных сетях {{ yandex-cloud }}
description: DNS-подключения позволяют настроить интеграцию корпоративных (on-premise) DNS-сервисов с внутренними DNS-зонами в {{ yandex-cloud }}.
---

# DNS-подключения

Для разрешения [FQDN](../../glossary/fqdn.md) в [облачных сетях](../../vpc/concepts/network.md#network) {{ vpc-full-name }} обычно используется облачный [DNS-резолвер](./dns-resolver.md), который обрабатывает DNS-запросы, поступающие от облачных ресурсов. DNS-резолвер доступен для использования только изнутри виртуальных машин и его нельзя использовать за пределами ВМ.

При этом вы можете настроить интеграцию ваших корпоративных DNS-сервисов с [внутренними DNS-зонами](./dns-zone.md#private-zones) в {{ yandex-cloud }} с помощью DNS-подключений. В настоящее время доступен только один тип DNS-подключений — [входящие DNS-подключения](#dns-inbound) (Inbound DNS endpoints).

{% include [on-premise-integration-cic-notice](../../_includes/dns/on-premise-integration-cic-notice.md) %}

## Входящее DNS-подключение {#dns-inbound}

_Входящее DNS-подключение_ — это специальный ресурс {{ dns-full-name }}, создаваемый в облачной сети и позволяющий использовать облачный DNS-резолвер для разрешения доменных имен в облачной сети и ее подсетях извне {{ yandex-cloud }}. Для этого корпоративные DNS-серверы должны отправлять DNS-запросы к [внутренним DNS-зонам](./dns-zone.md#private-zones) {{ yandex-cloud }} на IP-адрес входящего DNS-подключения.

Для приема DNS-запросов входящее подключение использует [внутренний](../../vpc/concepts/address.md#internal-addresses) IP-адрес, [зарезервированный](../../vpc/operations/private-ip-reserve.md) в любой из подсетей облачной сети.

{% include [inb-endpoint-1-per-netw-notice](../../_includes/dns/inb-endpoint-1-per-netw-notice.md) %}

#### Полезные ссылки {#see-also}

* [{#T}](./dns-resolver.md)
* [{#T}](./dns-zone.md)
* [{#T}](../operations/connection-inbound-create.md)
* [{#T}](../../interconnect/concepts/index.md)
* [{#T}](../tutorials/dns-integration.md)
* [Запустили {{ cr-full-name }}, обновили {{ vpc-full-name }} и {{ dns-full-name }}](https://yandex.cloud/ru/blog/yandex-cloud-router)
