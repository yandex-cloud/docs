# DNS connections

Resolving FQDNs in [cloud networks (VPC)](../../vpc/concepts/network.md#network) usually employs a cloud [DNS resolver](./dns-resolver.md) that handles DNS queries from cloud resources. The resolver is only accessible from within virtual machines and cannot be used outside of VMs.

Currently, only one type of DNS connection is supported: inbound DNS connections (DNS Inbound).


## Inbound DNS connection {#dns-inbound}

An *inbound DNS connection* allows you to use the cloud DNS resolver at the level of a cloud network or subnet.

Creating an inbound DNS connection in a cloud network enables corporate DNS servers to send queries for [{{ yandex-cloud }} internal zones](./dns-zone.md#private-zones). To do this, corporate DNS servers must be configured to forward DNS queries for [{{ yandex-cloud }} internal zones](./dns-zone.md#private-zones) to the IP address of the inbound DNS connection created in the VPC.

