---
title: DNS connections in {{ yandex-cloud }} networks
description: DNS connections allow you to configure the integration of corporate (on-premise) DNS services with internal DNS zones in {{ yandex-cloud }}.
---

# DNS connections

To resolve FQDNs in {{ vpc-full-name }} [networks](../../vpc/concepts/network.md#network), you normally need a cloud [DNS resolver](./dns-resolver.md) to handle DNS queries from cloud resources. The DNS resolver is only accessible from within virtual machines and cannot be used outside of VMs.

At the same time, you can use DNS connections to set up the integration of your corporate DNS services with [internal DNS zones](./dns-zone.md#private-zones) in {{ yandex-cloud }}. Currently, only one DNS connection type is supported: [inbound DNS endpoints](#dns-inbound).

{% include [on-premise-integration-cic-notice](../../_includes/dns/on-premise-integration-cic-notice.md) %}

## Inbound DNS connection {#dns-inbound}

An _incoming DNS connection_ is a special {{ dns-full-name }} resource created in the cloud network that allows you to use the cloud DNS resolver to resolve domain names in the cloud network and its subnets from outside the {{ yandex-cloud }} network. To do this, corporate DNS servers must send DNS queries addressed to {{ yandex-cloud }} [internal DNS zones](./dns-zone.md#private-zones) to the IP address of the incoming DNS connection.

To receive DNS queries, the incoming connection uses a [private](../../vpc/concepts/address.md#internal-addresses) IP address [reserved](../../vpc/operations/private-ip-reserve.md) in any of the cloud network subnets.

{% include [inb-endpoint-1-per-netw-notice](../../_includes/dns/inb-endpoint-1-per-netw-notice.md) %}

#### Useful links {#see-also}

* [{#T}](./dns-resolver.md)
* [{#T}](./dns-zone.md)
* [{#T}](../operations/connection-inbound-create.md)
* [{#T}](../../interconnect/concepts/index.md)
* [{#T}](../tutorials/dns-integration.md)
