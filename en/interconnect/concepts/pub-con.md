# Public connection

A public connection provides access to [public services](#pub-svc-list) in {{ yandex-cloud }}. A public connection is set up inside a [trunk](./trunk.md) and has its own unique **VLAN-ID**. A trunk may only have one public connection to provide access to any combination of [services](#pub-svc-list) through.

## List of public services {#pub-svc-list}

Each {{ yandex-cloud }} service has its own entry point: `API Endpoint`. You can see a list of entry points for {{ yandex-cloud }} services [here](https://api.cloud.yandex.net/endpoints). Each entry point has its own ID and address that consists of the `API Endpoint FQDN` and the number of the port this service receives requests to.

{{ yandex-cloud }} services that can be accessed via a public connection are listed below:

{% include [pub-svc-list](../../_includes/interconnect/pub-svc-list.md) %}

In fact, a public connection ensures connectivity between your infrastructure and the IP address the respective service's `API Endpoint FQDN` is converted to. FQDN is converted to IP through DNS.

For example, if you want to get access from your infrastructure to [{{ objstorage-name }}](../../storage/) via a public connection, the `213.180.193.243/32` prefix will be announced over BGP on the side of the {{ yandex-cloud }} equipment to your router. This prefix corresponds to the API Endpoint FQDN `storage.yandexcloud.net` of the [{{ objstorage-name }}](../../storage/) service.

Set up traffic routing in your infrastructure so that the traffic to {{ yandex-cloud }} [public services](#pub-svc-list) is routed to devices that perform [NAT functions](#pub-nat) for a public connection.


## Point-to-point subnet {#pub-address}

A public connection is set up using public IPv4 addresses from the {{ yandex-cloud }} [address pool](../../vpc/concepts/ips.md), which are routed to the internet. When setting up a public connection, you are allocated a `/31` **point-to-point** subnet.

{% note alert %}

[Services](#pub-svc-list) that can be accessed via a public connection are hosted in your [own data centers](../../overview/concepts/geo-scope.md). Traffic within a public connection between your infrastructure and [public services](#pub-svc-list) stays within the {{ yandex-cloud }} perimeter, although public IPs are used.

{% endnote %}

{% include [bgp](../../_includes/interconnect/bgp.md) %}

## NAT functions {#pub-nat}

For a public connection, use the [NAT]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/NAT){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Network_address_translation){% endif %} technology on your equipment side. Options for implementing NAT:

* A NAT function is executed on your equipment or router a [trunk](./trunk.md) connects to. All public connection traffic is routed from the IPv4 address to the router interface in the [point-to-point subnet](#pub-address). In this case, no prefix announcements over BGP are required.

* A NAT function is executed on your equipment that is not used for a [trunk](./trunk.md) connection, for example, on the server or firewall. In this case, you are allocated an additional `/30` public IPv4 subnet and your router the [trunk](./trunk.md) connects to must announce this additional subnet prefix over BGP to the {{ yandex-cloud }} equipment.


