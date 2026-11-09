---
title: '{{ dns-full-name }} overview'
description: '{{ dns-name }} enables managing DNS zones and resource records, filtering DNS requests, and allowing cloud domain names from corporate networks and from {{ baremetal-name }} servers.'
---

# Concepts {{ dns-name }}

{{ dns-full-name }} is a service that handles DNS requests and facilitates Domain Name System (DNS) administration.

With {{ dns-name }}, you can:

* Create [DNS zones](dns-zone.md) in the DNS hierarchy. Public zones enable the use of domain names for websites and online services. Private zones assist in organizing a namespace of cloud resources in selected networks, e.g., for the production and test environments.

* Manage [resource records](resource-record.md) in the created zones. Records associate domain names with resource IP addresses and specify other domain parameters. For example, you can associate a domain with a server IP address, set up an alias, or specify the domain’s mail servers.

* Configure [filtering of DNS requests](dns-filter.md) from cloud resources. You can use allowing and restricting lists to control domain name resolution via the cloud DNS resolver. This helps you block DNS requests to phishing and malicious websites or limit requests in an isolated environment to trusted domains only.

* Configure [DNS connections](dns-connection.md) for your corporate network and [{{ baremetal-full-name }}](../../baremetal/) servers. This helps applications access cloud resources in private DNS zones, such as VMs and managed database clusters, by their name. To enable this, the corporate network or private {{ baremetal-name }} subnet must be linked to the cloud network via [{{ interconnect-full-name }}](../../interconnect/).

## How {{ dns-name }} works {#how-it-works}

{{ dns-name }} processes two types of DNS requests: to [public](dns-zone.md#public-zones) and [private](dns-zone.md#private-zones) domain zones.

1. You create a public or private DNS zone. In a public zone, domain names are available from the internet. In a private zone, names are available from associated [{{ vpc-full-name }}](../../vpc/) networks, and when an [inbound DNS connection](dns-connection.md#dns-inbound) is configured, from the corporate network and {{ baremetal-name }} servers linked to the cloud network via {{ interconnect-name }}.
1. You add [resource records](resource-record.md) to the zone you created. Records associate domain names with IP addresses, aliases, or other resources.
1. Servers process a DNS request to a domain name from your zone:

   1. For public zones, the {{ yandex-cloud }} name servers (`ns1.{{ dns-ns-host-sld }}.` and `ns2.{{ dns-ns-host-sld }}.`) process the request. To give these servers an authority over your domain, delegate it. To do this, specify the addresses of the {{ yandex-cloud }} name servers in your registrar’s NS records.
   1. For private zones, the requests are processed by a cloud [DNS resolver](dns-resolver.md). The second IP address from the [subnet](*subnet) range is reserved for it, e.g., `x.x.x.2`. This address is by default provided to the [VM](*vm) over DHCP.

If the cloud does not have custom zones, except for service zones, {{ dns-name }} still processes public DNS requests from cloud resources, e.g., from a VM to external domains.

To reduce the number of public DNS requests and lower the costs, use [caching resolvers](../tutorials/local-dns-cache.md), such as `systemd-resolved`, `dnsmasq`, or `unbound`.

## Integration with {{ compute-name }} {#compute-integration}

When creating VM instances in [{{ compute-full-name }}](../../compute/), you can assign them domain names ([FQDNs](*hostname)) and automatically add VMs to DNS zones.

If you specify a zone and domain name in DNS settings when creating a VM, the relevant resource record will appear in this zone. If you do not specify a zone explicitly when an FQDN is specified, it will be [selected automatically](compute-integration.md#zone-selection).

For details, see [{#T}](compute-integration.md).

## Basic concepts of the service {#service-concepts}

{{ dns-name }} uses the following basic terms:

* A [DNS zone](./dns-zone.md) is a logical space that combines the domain names of resources and stores the resource records. DNS zones can be public, private, or reverse.
* A [resource record](./resource-record.md) is the main unit of information in a DNS. Using resource records, you determine where to route requests that come to specific domain names.
* A [DNS filter](./dns-filter.md) is a tool for controlling and filtering outbound DNS requests from cloud resources using FQDN lists.
* A [DNS resolver](./dns-resolver.md) is a DNS server in the {{ yandex-cloud }} infrastructure that processes DNS requests from resources in {{ vpc-name }} cloud networks and resolves domain names in private DNS zones.
* A [DNS connection](./dns-connection.md) is a resource that resolves domain names in private {{ yandex-cloud }} DNS zones from a corporate network and {{ baremetal-name }} servers.
* [Quotas and limits](./limits.md) are service use limitations.

See also the {{ yandex-cloud }} [general resource hierarchy](../../resource-manager/concepts/resources-hierarchy.md).

## Use cases {#examples}

* [{#T}](../tutorials/local-dns-cache.md)
* [{#T}](../tutorials/dns-integration.md)
* [{#T}](../../baremetal/tutorials/bm-vpc-dns-forwarder.md)
* [{#T}](../tutorials/bind-domain-vm/index.md)


[*vm]: {% include notitle [vm](../../_popups/compute/vm.md#vm) %}

[*subnet]: {% include notitle [subnet](../../_popups/vpc/routing-terms.md#subnet) %}

[*hostname]: {% include notitle [hostname](../../_popups/compute/vm-routing.md#hostname) %}
