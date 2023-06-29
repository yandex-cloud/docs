# Public connection

A public connection provides access to [services](#svc-list) in {{ yandex-cloud }}. A public connection is set up inside a [trunk](./trunk.md) and has its own unique **VLAN-ID**. A trunk can have one or more public connections that provide access to any combination of [services](#svc-list).

Maximum IP MTU size for a public connection is **1,500 bytes**. Changing IP MTU on the {{ yandex-cloud }} equipment is not allowed.


## List of {#svc-list} services

Each {{ yandex-cloud }} service has its own entry point: `API Endpoint`. You can see a list of entry points for {{ yandex-cloud }} services [here](https://{{ api-host }}/endpoints). Each entry point has its own ID and address that consists of the `API Endpoint FQDN` and the number of the port this service receives requests to.

{{ yandex-cloud }} services that can be accessed via a public connection are listed below:

{% include [svc-list](../../_includes/interconnect/svc-list.md) %}

In fact, a public connection ensures connectivity between your infrastructure and the IP address the respective service's `API Endpoint FQDN` is converted to. FQDN is converted to IP through DNS.

For example, if you want to get access from your infrastructure to [{{ objstorage-name }}](../../storage/) via a service connection, the {{ yandex-cloud }} equipment will announce the `{{ cic-pbc-svc1-ip }}` prefix to your router over BGP. This prefix corresponds to the `{{ s3-storage-host }}` API Endpoint FQDN of the [{{ objstorage-name }}](../../storage/) service.

Set up traffic routing in your infrastructure so that the traffic directed to {{ yandex-cloud }} [services](#svc-list) is routed to devices that perform [NAT functions](#pub-nat) for your public connection.


## Point-to-point subnet {#pub-address}

A public connection is set up using public IPv4 addresses owned by the customer. In some cases, IPv4 addresses from the {{ yandex-cloud }} [address pool](../../vpc/concepts/ips.md) can be used. When setting up a public connection with addresses from the {{ yandex-cloud }} address pool, you are allocated a `/31` **point-to-point subnet**.

{% note alert %}

[Services](#svc-list) that can be accessed via a public connection are hosted in your [own data centers](../../overview/concepts/geo-scope.md). Traffic within a public connection between your infrastructure and the [services](#svc-list) stays within the {{ yandex-cloud }} perimeter.

{% endnote %}

{% include [bgp](../../_includes/interconnect/bgp.md) %}


## NAT functions {#pub-nat}

When setting up a public connection with IPv4 addresses provided by {{ yandex-cloud }}, use the [NAT](https://en.wikipedia.org/wiki/Network_address_translation) technology on your equipment side is to route your traffic correctly across {{ yandex-cloud }} services. Options for implementing NAT:

* A NAT function is executed on your equipment or the router your public connection connects to. All public connection traffic is routed from the IPv4 address to the router interface in the [point-to-point subnet](#pub-address). In this case, your where router the public connection terminates must announce a prefix of a point-to-point subnet to the {{ yandex-cloud }} equipment over BGP.

* A NAT function is executed on your equipment that is not used for a public connection, e.g., on a server or firewall. In this case, {{ yandex-cloud }} additionally allocates an auxiliary IPv4 address (prefix /32), and your router the trunk connects to will announce this prefix over BGP to the {{ yandex-cloud }} equipment.
