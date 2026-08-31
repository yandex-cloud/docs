---
title: DNS resolvers in {{ yandex-cloud }} networks
description: DNS resolvers are responsible for processing DNS requests from resources connected to subnets in {{ vpc-full-name }} cloud networks.
---

# DNS resolver

A _DNS resolver_ is a DNS server in the {{ yandex-cloud }} infrastructure responsible for processing DNS requests from resources connected to [subnets](../../vpc/concepts/network.md#subnet) in {{ vpc-full-name }} [cloud networks](../../vpc/concepts/network.md#network) and for resolving domain names in {{ yandex-cloud }} [internal DNS zones](./dns-zone.md#private-zones).

The DNS resolver always gets the second (from the beginning) IP address in a subnet’s address range (e.g., `x.x.x.2`).

When connecting a [VM](../../compute/concepts/vm.md) to a subnet, the DNS resolve's IP address is sent to the VM over DHCP together with other network interface parameters. This IP address is used by the VM internally as the DNS server address.

The IP connectivity between the VM and the DNS resolver is contributed by a special component called [VRouter-agent](../../vpc/concepts/network-overview.md#vrouter-agent) accessible only from within the VM and not from the outside.

## Integration with corporate DNS services {#on-premise-integration}

{% include [on-premise-integration-cic-notice](../../_includes/dns/on-premise-integration-cic-notice.md) %}

You can configure integration of your corporate DNS services with internal DNS zones in {{ yandex-cloud }}.

You can configure redirection of DNS requests from {{ yandex-cloud }} resources to corporate network resources by creating separate DNS forwarders in {{ vpc-name }} subnets. DNS requests from corporate network resources to resources in {{ vpc-name }} subnets are processed by [inbound DNS connections](./dns-connection.md#dns-inbound).

For more on integrating corporate DNS services with {{ yandex-cloud }} DNS services, see [{#T}](../tutorials/dns-integration.md).

#### Useful links {#see-also}

* [{#T}](./dns-connection.md)
* [{#T}](./dns-zone.md)
* [{#T}](../../interconnect/concepts/index.md)
* [{#T}](../tutorials/dns-integration.md)
