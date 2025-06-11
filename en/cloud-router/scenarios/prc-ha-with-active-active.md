# Even redistribution of on-prem traffic (Active-Active)

The example below shows load balancing using two private connections set up through two points of presence.

Customer edge routers announce the `10.0.0.0/8` prefix from the customer infrastructure over BGP through two points of presence towards {{ yandex-cloud }}. {{ yandex-cloud }} will then use ECMP load balancing to distribute traffic between those points of presence.

![cic-routing-1](../../_assets/interconnect/cic-routing-1.svg)

Note that this balancing mode can create traffic asymmetry. For example, a request originating from the customer infrastructure to cloud resources could arrive through the `M9` point of presence, while the response will be sent through `NORD`.

While {{ yandex-cloud }} hardware allows and correctly handles traffic asymmetry, specific types of equipment within the customer infrastructure, such as firewalls, may experience issues with asymmetric traffic patterns.

To allow asymmetric traffic from {{ yandex-cloud }}, disable [RPF](https://en.wikipedia.org/wiki/Reverse-path_forwarding) on the network elements handling traffic in the customer infrastructure. This will enable you to use all active {{ interconnect-name }} links with a redundant connectivity through two or more points of presence.

