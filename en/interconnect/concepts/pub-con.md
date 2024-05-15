# Public connection

A public connection provides access to {{ yandex-cloud }} [services](#svc-list). A public connection is set up inside a [trunk](./trunk.md) and has its own unique **VLAN-ID**. A trunk can have one or more public connections that provide access to any combination of [services](#svc-list).

Maximum IP MTU size for a public connection is **1,500 bytes**. Changing IP MTU on the {{ yandex-cloud }} equipment is not allowed.


## List of {#svc-list} services

Each {{ yandex-cloud }} service has its own entry point: `API Endpoint`. You can see the list of entry points for {{ yandex-cloud }} services [here](https://{{ api-host }}/endpoints). Each entry point has its own ID and address that consists of the `API Endpoint FQDN` and the number of the port to which this service gets requests.

Below, you can see the list of {{ yandex-cloud }} services you can access through a public connection:

{% include [svc-list](../../_includes/interconnect/svc-list.md) %}

Technically, a public connection ensures connectivity between your infrastructure and the IP address to which the respective service's `API Endpoint FQDN` is converted. FQDN is converted to an IP address through DNS.

For example, if you want to get access from your infrastructure to [{{ objstorage-name }}](../../storage/) through a service connection, the {{ yandex-cloud }} equipment will announce the `{{ cic-pbc-svc1-ip }}` prefix to your router over BGP. This prefix refers to the `{{ s3-storage-host }}` API Endpoint FQDN of [{{ objstorage-name }}](../../storage/).

You need to set up traffic routing in your infrastructure so that the traffic directed to {{ yandex-cloud }} [services](#svc-list) is routed to devices that perform [NAT functions](#pub-nat) for your public connection.


## Point-to-point subnet {#pub-address}

A public connection is set up using public IPv4 addresses owned by the customer. In some cases, one may use IPv4 addresses from the {{ yandex-cloud }} [address pool](../../vpc/concepts/ips.md). When setting up a public connection with addresses from the {{ yandex-cloud }} address pool, you are allocated a `/31` **point-to-point subnet**.

{% note alert %}

[Services](#svc-list) that can be accessed via a public connection are hosted in your [own data centers](../../overview/concepts/geo-scope.md). Traffic within a public connection between your infrastructure and the [services](#svc-list) stays within {{ yandex-cloud }}.

{% endnote %}

{% include [bgp](../../_includes/interconnect/bgp.md) %}


## NAT functions {#pub-nat}

When setting up a public connection with IPv4 addresses provided by {{ yandex-cloud }}, you need to use the [NAT](https://en.wikipedia.org/wiki/Network_address_translation) technology on your equipment side to route your traffic correctly across {{ yandex-cloud }} services. You can implement NAT in the following ways:

* Running a NAT function on your equipment or router your public connection is linked to. All public connection traffic is routed from the IPv4 address to the router interface in the [point-to-point subnet](#pub-address). In this case, your router where the public connection terminates must announce a prefix of a point-to-point subnet to the {{ yandex-cloud }} equipment over BGP.

* Running a NAT function on your equipment that is not used for a public connection, e.g., on a server or firewall. In this case, {{ yandex-cloud }} additionally allocates an auxiliary IPv4 address (prefix /32), and your router to which the public connection goes will announce this prefix over BGP towards the {{ yandex-cloud }} equipment.
