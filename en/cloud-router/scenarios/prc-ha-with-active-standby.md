# Prioritizing on-prem traffic based on direction (Active-Standby)

To prioritize traffic by direction in {{ interconnect-name }}, you can use the following methods:

* [Longest Prefix Match (LPM)](#lpm1)
* [BGP AS path prepend](#prepend1)

The longest prefix match method has a higher priority than BGP AS path prepending when it comes to the algorithm for selecting the best route on routers.{#lpm1} We recommend that you only choose one of the suggested methods rather than use both at the same time.

## Longest prefix match (LPM) {#lpm1}

Below, you can see an example of prioritizing traffic through two private connections set up via two points of presence using the longest prefix match method.

The customer router (R2) uses the `NORD` PoP to announce the short prefix from the customer infrastructure, `10.0.0.0/8`, over BGP towards {{ yandex-cloud }}.

Another customer edge router (R1) uses the `M9` PoP to announce two long (more specific) prefixes from the customer infrastructure, `10.0.0.0/9` and `10.128.0.0/9`, over BGP towards {{ yandex-cloud }}.

![cic-routing-2](../../_assets/interconnect/cic-routing-2.svg)

{{ yandex-cloud }} will treat announcements via `M9` as more specific ones, i.e., of higher priority.

This way, all traffic from the `172.16.1.0/24`, `172.16.2.0/24`, and `172.16.3.0/24` cloud subnets to the customer infrastructure will be routed through the private connection towards `M9`. If this connection fails, the traffic will automatically failover to the private connection to `NORD`.


## BGP AS path prepend {#prepend1}

Below, you can see an example of prioritizing traffic through two private connections set up via two points of presence with the BGP AS path prepend method.

You can learn more about **BGP AS path prepending** [here](https://datatracker.ietf.org/doc/html/rfc4271#section-5.1.2).

The customer edge router (R1) uses the `M9` PoP to announce the `10.0.0.0/8` prefix from the customer infrastructure over BGP towards {{ yandex-cloud }}. The BGP `AS_PATH` attribute will default to `65001`, and the AS path length (count of autonomous system number values) will be 1.

Another customer edge router (R2) announces the same prefix (`10.0.0.0/8`) from the customer infrastructure over BGP through the `NORD` PoP towards {{ yandex-cloud }}.

Before announcing the prefix, the BGP routing policy on the R2 router adds the customer's autonomous system number (BGP ASN) to the `AS_PATH` attribute value so that it will be equal to `65001 65001` and the AS path length will be 2. This makes the prefix with such AS path length less preferable for external BGP routers.

![cic-routing-7](../../_assets/interconnect/cic-routing-7.svg)

This way, for the `10.0.0.0/8` traffic, {{ yandex-cloud }} will select the best route via the `M9` PoP, while the route via the `NORD` PoP will act as a failover due to its longer AS path.

All traffic from the `172.16.1.0/24`, `172.16.2.0/24`, and `172.16.3.0/24` cloud subnets to the customer infrastructure will be routed through the private connection to `M9`. If this connection fails, the traffic will automatically failover to the private connection to `NORD`.

